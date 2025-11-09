Level02 - Network Packet Analysis
Overview
This level involves analyzing network traffic captured in a .pcap file to extract a password that has been transmitted over the network.
Solution Steps
Step 1: Retrieve the Packet Capture File
Copy the level02.pcap file from the remote server to your local machine:

```sh
scp -P 4242 username@ip_address:/home/user/level02/level02.pcap .
```

After downloading, ensure you have read permissions:

chmod 777 level02.pcap

```sh
### Step 2: Analyze the Packet Capture

1. **Install Wireshark** (if not already installed)
2. **Open the file** in Wireshark
3. **Follow the TCP stream**:
   - Right-click on any transferred packet
   - Select "Follow" → "TCP Stream"

### Step 3: Extract the Password

In the TCP Stream window, you'll find:
```

Password: ft_wandr...NDRel.L0L

```sh

This appears to be corrupted. To see the actual data:

1. Change the "Show as" dropdown from **ASCII** to **Hex Dump**
2. You'll see the hexadecimal representation:
```

```sh
66 74 5f 77 61 6e 64 72 7f 7f 7f 4e 44 52 65 6c 7f 4c 30 4c
f  t  _  w  a  n  d  r  .  .  .  N  D  R  e  l  .  L  0  L
```

### Step 4: Decode the Password

In the ASCII table, `7f` represents the **DEL** (delete) character. Each `7f` deletes the previous character:

**Original hex:**

```sh
66 74 5f 77 61 6e 64 72 7f 7f 7f 4e 44 52 65 6c 7f 4c 30 4c
```

**After removing DEL operations:**

```sh
66 74 5f 77 61 4e 44 52 65 4c 30 4c
f  t  _  w  a  N  D  R  e  L  O  L
```

Final password: ft_waNDReL0L

Step 5: Get the Flag

level02@SnowCrash:~$ su flag02
Password: ft_waNDReL0L

flag02@SnowCrash:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq

```sh

## Key Concepts

- **Network packet analysis** using Wireshark
- **TCP stream reconstruction** to view session data
- **Hexadecimal decoding** and ASCII character interpretation
- **Control characters**: Understanding that `0x7F` (DEL) removes the previous character in terminal input

## Token
```

kooda2puivaav1idi4f57q8iq