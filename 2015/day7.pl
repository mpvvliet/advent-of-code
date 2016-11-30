#!/usr/bin/perl

%wires = ();

while (<>) {
	if (/^([a-z0-9]+) -> ([a-z]+)$/) {
		my ($x, $y) = ($1, $2);
		$wires{$y} = $x;
	} elsif (/(([a-z0-9]+) (AND|OR|RSHIFT|LSHIFT) ([a-z0-9]+)) -> ([a-z]+)/) {
		my ($exp, $wire) = ($1, $5);
		$wires{$wire} = $exp;
	} elsif (/(NOT ([a-z]+)) -> ([a-z]+)/) {
#		print $_;
		$wires{$3} = $1;
	} else {
		print "??? $_\n";
	}
}

#print $wires{"h"};

sub eval2 {
	my $exp = shift;

	if ($exp =~ /^([0-9]+)$/) {
		return int($exp);
	}
	
	print "eval2: $exp\n";

	if ($exp =~ /^([a-z]+)$/) {
		return eval2($wires{$1});
	}

	if ($exp =~ /NOT ([a-z0-9]+)/) {
		# $lh = eval2($1);
		# print "* ~ $lh$rh\n";
		# print "* output = " . (65535 - $lh) . "\n";
		return eval2(65535 - eval2($1));
	}

	if ($exp =~ /([a-z0-9]+) AND ([a-z0-9]+)/) {
		return eval2(eval2($1) & eval2($2));
	}

	if ($exp =~ /([a-z0-9]+) OR ([a-z0-9]+)/) {
		return eval2(eval2($1) | eval2($2));
	}

	if ($exp =~ /([a-z0-9]+) LSHIFT ([a-z0-9]+)/) {
		return 0xFFFF & (eval2(eval2($1) << eval2($2)));
	}

	if ($exp =~ /([a-z0-9]+) RSHIFT ([a-z0-9]+)/) {
		# $lh = eval2($1);
		# $rh = eval2($2);
		# print "* $lh >> $rh\n";
		# print "* output = " . ($lh >> $rh) . "\n";
		return 0xFFFF & (eval2(eval2($1) >> eval2($2)));
	}

	print "Unknown exp: $exp\n";
}

#foreach $i ("x","y","d","e","f","g","h","i") {
foreach $i ("a") {
	print "$i = " . eval2($i) . "\n";
}
