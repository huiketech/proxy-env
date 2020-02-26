#!/usr/bin/env php
<?php
exec('ping -c1 ' . $argv[1], $output);
$output = implode("\n", $output);
echo $output . "\n";

preg_match('/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/', $output, $matches);
//var_dump($matches);
//var_dump($argv);
if ($matches && $matches[0] == $argv[2]) {
    exit(0);
}
exit(1);
