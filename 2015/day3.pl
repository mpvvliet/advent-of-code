#!/usr/bin/perl

my %visited = ( "0-0" => 2 );
$x=0;
$y=0;
$xr=0;
$yr=0;
$moves = 0;
sub move {
	my $c = shift;
	my $xref; $yref;

	if ($moves % 2 == 0) {
		$xref = \$x;
		$yref = \$y;
	} else {
		$xref = \$xr;
		$yref = \$yr;
	}
	$moves++;

	if ($c eq ">") {
		$$xref += 1;
	} elsif($c eq '<') {
		$$xref -= 1;
	} elsif($c eq '^') {
		$$yref += 1;
	} elsif($c eq 'v') {
		$$yref -= 1;
	}

	return "$$xref-$$yref";
}

while (<STDIN>) {
	@chars = split(//);
	foreach $c (@chars) {
		$key = move($c);
		$visited{$key} = $visited{$key} + 1;
		print "$key => " . $visited{$key} . "\n";
	}
}

print "Number of houses with at least one present: " . scalar keys(%visited) . "\n";
