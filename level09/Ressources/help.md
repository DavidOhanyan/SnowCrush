Level09 - Custom Cipher Decryption

Overview
This level involves reverse-engineering a custom encryption algorithm and decrypting a token file. The executable implements a simple substitution cipher where each character is shifted by its position in the string.

Solution Steps
Step 1: Enumerate Files
List files in the level09 directory:

```sh
level09@SnowCrash:~$ ls -l
```

**Output:**
```
-rwsr-sr-x+ 1 flag09 level09 7640 Mar  5  2016 level09
----r--r--  1 flag09 level09   26 Mar  5  2016 token
```

Examine the token file:
```sh
level09@SnowCrash:~$ cat token
f4kmm6p|=pnDBDu{
```
The token appears encrypted and doesn't work as a password for flag09.

Step 2: Analyze the Encryption Algorithm
Test the level09 executable with various inputs:

```sh
level09@SnowCrash:~$ ./level09
You need to provied only one arg.

level09@SnowCrash:~$ ./level09 a
a

level09@SnowCrash:~$ ./level09 b
b

level09@SnowCrash:~$ ./level09 c
c

level09@SnowCrash:~$ ./level09 abc
ace
```

**Pattern analysis:**
- Single character: `a` → `a` (no change at position 0)
- `abc` → `ace`
  - `a` at index 0: `a + 0 = a`
  - `b` at index 1: `b + 1 = c`
  - `c` at index 2: `c + 2 = e`

**Algorithm identified:**
```
encrypted_char = original_char + position_index
```
Each character is shifted forward in ASCII by its zero-based position in the string.

Step 3: Verify the Encryption
Test with the encrypted token to see if double encryption reveals anything:

```sh
level09@SnowCrash:~$ ./level09 'f4kmm6p|=pnDBDu{'
f5mpq;vEyxONQ
```

This confirms the token is already encrypted. We need to **decrypt** it.

### Step 4: Create a Decryption Script

The decryption algorithm reverses the process:
```
decrypted_char = encrypted_char - position_index
```

Create decrypt.py:

Step 5: Decrypt the Token
Option 1: Upload the script to the VM
```sh
~/Snow-Crash/level09/Ressources$ scp -P 4242 decrypt.py level09@ip-address:/tmp/.
level09@SnowCrash:~$ python /tmp/decrypt.py `cat token`
f3iji1ju5yuevaus41q1afiuq
level09@SnowCrash:~$ su flag09
Password:
Don't forget to launch getflag !
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
flag09@SnowCrash:~$ su level10
Password:
level10@SnowCrash:~$
``