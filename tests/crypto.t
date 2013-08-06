#!/usr/bin/env php
<?php
include __DIR__ . '/../autoload.php';

use Wukka\Test as T;
use Wukka\Crypto;

if( ! function_exists('mcrypt_encrypt')) {
    T::plan('skip_all', 'php5-mcrypt extension not installed');
}

T::plan(3);

$input = rtrim(file_get_contents( __DIR__ . '/sample/i_can_eat_glass.txt'));

$secret =  sha1(mt_rand(0, 10000000000), TRUE);

$crypto = new Crypto( $secret );

$encrypted = $crypto->encrypt( $input );

T::ok( strlen( $encrypted ) > 0, 'encrypt returns a string');
T::ok( $encrypted != $input, 'the encrypted string doesnt match the input');

$output = trim($crypto->decrypt( $encrypted ));

T::is( $output, $input, 'decrypted the encrypted string and got back my original input');

