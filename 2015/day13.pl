#!/usr/bin/perl

use Algorithm::Permute;


%happiness = ();
%people = ();
@arrangements = ();

sub calc {
	my @perm = @_;
	my $sum = 0;

	for ($i=0;$i<$#perm;$i++) {
		my $single = 0;
	   	#print "$perm[$i] <-> $perm[$i+1]: ";
		$single += $happiness{$perm[$i]}{$perm[$i+1]};
		$single += $happiness{$perm[$i+1]}{$perm[$i]};
		#print $single . "\n";
		$sum += $single;
	}
	$sum += $happiness{$perm[0]}{$perm[$#perm]};
	$sum += $happiness{$perm[$#perm]}{$perm[0]};
	return $sum;
}

while(<>) {
	if (/(\w+) would (gain|lose) ([0-9]+) happiness units by sitting next to (\w+)/) {
		$happiness{$1}{$4} = ($2 eq "gain" ? $3 : -$3);
		$people{$1} = $people{$4} = 1;
	}
}

#print keys(%people);

# Add myself
$people{"me"} = 1;
@people = keys %people;
foreach $p (@people) {
	$happiness{$p}{"me"} = 0;
	$happiness{"me"}{$p} = 0;
}

my $p_iterator = Algorithm::Permute->new ( \@people );
 
my $max = 0;
my @winner = ();
while (my @perm = $p_iterator->next) {
	my $score = calc(@perm);
	$max = $score, @winner = @perm if($score > $max);
}
print "Winner: @winner, score: $max\n";
