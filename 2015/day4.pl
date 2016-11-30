#!/usr/bin/perl

use Digest::MD5 qw(md5 md5_hex md5_base64);

$key = "ckczppom";

for ($i = 0; $i < 10000000; $i++) {
	$hash = md5_hex("$key" . "$i");
	if (substr($hash,0, 6) eq "000000") {
		print $i . " - " . $hash . "\n";
	}
}
