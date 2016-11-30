#!/usr/bin/perl

%ingredients = ();

sub partition {
	my $in = shift;
	return partition2($in, $in, "");
}

sub partition2 {
	my $n = shift;
	my $max = shift;
	my $prefix = shift;	

	print "$n, $max, $prefix\n";

	if($n == 0) {
		print $prefix;
		return;
	}

	my $start = ($max < $n ? $max : $n);
	for($i = $start; $i >= 1; $i--) {
		partition2($n - $i, $prefix . " " . $i);
	}
}

while(<>) {
	if ($_ =~ /(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/) {
		$ingredients{$1}{"capacity"} = $2;
		$ingredients{$1}{"durability"} = $3;
		$ingredients{$1}{"flavor"} = $4;
		$ingredients{$1}{"texture"} = $5;
		$ingredients{$1}{"calories"} = $6;
		$ingredients{$1}{"spoons"} = 0;
	}
}

partition(10);
