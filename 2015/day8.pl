#!/usr/bin/perl

$stringlength = 0;
$memorylength = 0;
$recodelength = 0;

while (<>) {
#	print $_;
	$stringlength += length($_) - 1;

	$original = $_;

	$string = $_;
	$string =~ s/^\"//g;
	$string =~ s/\"$//g;
	$string =~ s/\\\\/\\/g;
	$string =~ s/\\\"/\"/g;
	$string =~ s/\\x([0-9A-Fa-f][0-9A-Fa-f])/x/g;

#	print "$string";
	$memorylength += length($string) - 1;

	$recode = $original;
	$recode =~ s/\\/\\\\/g;
	$recode =~ s/\"/\\\"/g;

#	print length($recode) . " - $recode";
	$recodelength += length($recode) + 1;
}

print "# stringcode: ${stringlength}, # characters: ${memorylength}\n";
print "Answer 1: " . (${stringlength} - ${memorylength}) . "\n";
print "Answer 2: " . (${recodelength} - ${stringlength}) . "\n";
