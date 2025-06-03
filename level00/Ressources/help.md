# Level00 Walkthrough

Welcome! This guide will help you complete **level00** and retrieve the password for the next level (`level01`).

---

## 🎯 Goal

- Find the password for the user `flag00`
- Log in as `flag00`
- Use the `getflag` command to get the flag (which will be the password for `level01`)

---

## 🔍 Step 1: Find Files Belonging to `flag00`

Run the following command to search the entire filesystem for files owned by the user `flag00`:

```bash
find / -user flag00 2>/dev/null

This command searches from the root / and suppresses error messages using 2>/dev/null.

Expected output:
/usr/sbin/john
/rofs/usr/sbin/john

📄 Step 2: Read the File
Now let's look at the content of /usr/sbin/john:

cat /usr/sbin/john

Output:
cdiiddwpgswtgt

🔐 Step 3: Decode the String
This string is encoded using a Caesar cipher with a shift of 15 letters backwards.

You can decode it manually or use a Caesar cipher tool.

decoding of cdiiddwpgswtgt with shift 15: nottoohardhere

su flag00
Password: nottoohardhere

🏁 Step 5: Get the Flag
getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias

this is our flag00 x24ti5gi3x0ol2eh4esiuxias and a password of level01