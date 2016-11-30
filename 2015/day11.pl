#!/usr/bin/perl

$input = "hxbxxyzz";
#$input = "ghijklmn";

sub next_password {
	my $input = shift;
	my @in = split("", $input);

	for ($i = length($input) - 1; $i >= 0; $i--) {
#		print "next_password: character $i\n";
		if (ord($in[$i]) >= 122) {
			$in[$i] = "a";
			next;
		} else {
			$in[$i] = chr(ord($in[$i])+1);
			last;
		}
	}
	return join("", @in);
}

sub ok {
	my $in = shift;

	return 0 if ($in =~ /[iol]/);
#	print "input $in, checking pairs\n";
	return 0 unless ($in =~ /([a-z])\g1.*([^\g1])\g2/);

#	print "pairs: $1 $2\n";

	my @letters = split("", $in);
	for ($i = 0; $i<length($in); $i++) {
#		print "straight start: $letters[$i]\n";
		next if(ord($letters[$i]) >= 121);

		$look = $letters[$i] . chr(ord($letters[$i])+1) . chr(ord($letters[$i])+2);
#		print "straight: $look\n";
		return 1 if ($in =~ /$look/g);
	}

	return 0;
}

$next = next_password($input);
while(! ok($next)) {
	$next = next_password($next);
	print "next_password: $next\n";
}

print "$next\n";
