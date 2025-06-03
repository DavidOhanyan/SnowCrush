# Level01 Walkthrough

This guide shows how to retrieve the password for `level02` by cracking the password of the user `flag01` using John the Ripper.

---

## Step 1: Check `/etc/passwd`

Run the command:

```bash
cat /etc/passwd

You will find the following relevant line:
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash


Step 2: Crack the Password Using John the Ripper
Install John the Ripper local or anywhere where u have a prmission
If you're using Debian/Ubuntu/Kali Linux:

sudo apt update
sudo apt install john -y

Prepare the hash for cracking
Create a file pass.txt containing the hash:
echo "42hDRfypTqqnw" > pass.txt

Run John the Ripper:
john pass.txt

Expected output:
Loaded 1 password hash (descrypt, traditional crypt(3) [DES 128/128 SSE2])
Will run 2 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
abcdefg          (?)
1g 0:00:00:00 100% ...
Session completed

John successfully found the password: abcdefg

Step 3: Switch User and Get the Flag
Switch to the flag01 user:

su flag01
Password: abcdefg

Run the command:
getflag

Output:
Check flag.Here is your token : f2av5il02puano7naaf6adaaf

Result
Password for user flag01: abcdefg

Flag for this level (password for level02):
f2av5il02puano7naaf6adaaf