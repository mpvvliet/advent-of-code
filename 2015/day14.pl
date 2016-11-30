#!/usr/bin/perl

%deer = ();

while(<>) {
	if ($_ =~ /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds/) {
		print "Registering $1\n";
		$deer{$1}{"speed"} = $2;
		$deer{$1}{"endurance"} = $3;
		$deer{$1}{"rest"} = $4;
		$deer{$1}{"state"} = "READY";
		$deer{$1}{"distance"} = 0;
		$deer{$1}{"duration"} = 0;
		$deer{$1}{"score"} = 0;
	}
}

$runlength = 2503;
#$runlength = 1000;

for ($sec = 1; $sec <= $runlength; $sec++) {
	my $max = 0;
	foreach $d (keys %deer) {
		if ($deer{$d}{"state"} eq "READY") {
			$deer{$d}{"state"} = "FLYING";
			$deer{$d}{"distance"} += $deer{$d}{"speed"};
			$deer{$d}{"duration"} = 1;
		} elsif ($deer{$d}{"state"} eq "FLYING") {
			$deer{$d}{"duration"} += 1;
			$deer{$d}{"distance"} += $deer{$d}{"speed"};

			if ($deer{$d}{"duration"} == $deer{$d}{"endurance"}) {
				$deer{$d}{"state"} = "RESTING";
				$deer{$d}{"duration"} = 0;
			}
		} elsif ($deer{$d}{"state"} eq "RESTING") {
			$deer{$d}{"duration"} += 1;

			if ($deer{$d}{"duration"} == $deer{$d}{"rest"}) {
				$deer{$d}{"state"} = "READY";
				$deer{$d}{"duration"} = 0;
			}
		}

		$max = $deer{$d}{"distance"} if($deer{$d}{"distance"} > $max);
	}

	foreach $d (keys %deer) {
		if ($deer{$d}{"distance"} == $max) {
			$deer{$d}{"score"} += 1;
		}
	}

}

foreach $d (keys %deer) {
	print "$d: distance: " . $deer{$d}{"distance"} . ", score: " . $deer{$d}{"score"} . "\n";
}
