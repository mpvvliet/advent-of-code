#!/usr/bin/perl

my @lights;
$lit  = 0;
for ($i=0; $i<1000; $i++) {
	for ($j=0; $j<1000; $j++) {
		$lights[$i][$j] = 0;
	}
}

while (<>) {
	if (/(turn on|turn off|toggle) ([0-9]+,[0-9]+) through ([0-9]+,[0-9]+)$/) {
		print "match: $1, $2, $3\n";
		($cmd, $from, $to) = ($1, $2, $3);

		$from =~ /([0-9]+),([0-9]+)/;
		($fromx, $fromy) = ($1, $2);
		print "$fromx, $fromy\n";

		$to =~ /([0-9]+),([0-9]+)/;
		($tox, $toy) = ($1, $2);
		print "$tox, $toy\n";

		if ($cmd eq "turn on") {
			for ($i=$fromx; $i<=$tox; $i++) {
				for ($j=$fromy; $j<=$toy; $j++) {
					$lights[$i][$j] = $lights[$i][$j] + 1;
				}
			}
		} elsif ($cmd eq "turn off") {
			for ($i=$fromx; $i<=$tox; $i++) {
				for ($j=$fromy; $j<=$toy; $j++) {
					$lights[$i][$j] = ($lights[$i][$j] > 0 ? $lights[$i][$j]-1 : 0);
				}
			}
		} elsif ($cmd eq "toggle") {
			for ($i=$fromx; $i<=$tox; $i++) {
				for ($j=$fromy; $j<=$toy; $j++) {
					$lights[$i][$j] = $lights[$i][$j] + 2;
				}
			}
		}
	}
}

for ($i=0; $i<1000; $i++) {
	for ($j=0; $j<1000; $j++) {
		$lit += $lights[$i][$j];
	}
}

print "Light: $lit\n";
