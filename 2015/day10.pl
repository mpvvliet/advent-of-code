#!/usr/bin/perl

$input = "1321131112";
#$input = "1";

sub translate {
	my $group = shift;
	return "" . length($group) . substr($group,0,1);
}

sub look_and_say {
	my $input = shift;
	my $output = "";

	@numbers = split("", $input);
#	print @numbers . "\n";
	$group = "";
	while($number = shift @numbers) {
#		print "$number\n";
		$group .= $number;
		if (length(@numbers>0)) {
			if ($numbers[0] eq $number) {
				next;
			} else {
				$output .= translate($group);
				$group = "";
			}
		} else {
			$output .= translate($group);
			$group = "";
		}
	}
	return $output;
}

for ($i = 0; $i < 50; $i++) {
	$output = look_and_say($input);
	print "$output\n";
	$input = $output;
}

print "Answer: " . length($output) . "\n";
