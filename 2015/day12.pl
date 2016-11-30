#!/usr/bin/perl

use JSON::Parse 'parse_json';
use File::Slurp;

my $text = read_file("day12-input.txt");

# Part 1: answer: 191164
#my @list = $text =~ /(-?[0-9]+)/g;
#foreach $l (@list) {
#	$sum += $l;
#}
#print $sum;
#exit;

#my $text = read_file("day12-sample.txt");
my $json = parse_json($text);

#my $json = parse_json("[1,{\"c\":\"red\",\"b\":2},3]");
#my $json = parse_json("{\"d\":\"red\",\"e\":[1,2,3,4],\"f\":5}");
#my $json = parse_json("[]");

sub add_numbers {
	my $in = shift;
	my $level = shift;
	my $sum = 0;

#	print "$in, ref = " . ref($in) . "\n";

	if (ref($in) eq "") {
#		print "[$level] value $in\n";
		if($in =~ /^\"?-?[0-9]+\"?$/) {
			print "[$level] adding $in\n";
			return int($in) ;
		}
#		print "ignoring $in\n";
		return 0;
	}

	if(ref($in) eq "SCALAR") {
		print "[$level] SCALAR $in\n";
		return int($$in);
	}

	if(ref($in) eq "ARRAY") {
		my @in = @$in;
		print "[$level] ARRAY $in, size " . scalar(@in) . "\n";
		for(my $i = 0; $i < scalar(@in); $i++) {
#			print " - index $i\n";
			$sum += add_numbers($in[$i], $level + 1);
		}
		print "[$level] end ARRAY $in, sum $sum\n";
		return $sum;
	}

	if(ref($in) eq "HASH") {
		print "[$level] HASH $in\n";
		my %in = %$in;
		my $skip = 0;
		foreach $key (keys(%in)) {
			if ($key eq "red" || $in{$key} eq "red") {
				print "Skipping $key, $in{$key}\n";
				$skip = 1;
			}
		}
		if (! $skip) {
			foreach $key (keys(%in)) {
				print "[$level] $key = $in{$key}\n";
				$sum += add_numbers($key, $level + 1);
				$sum += add_numbers($in{$key}, $level + 1);
			}
		} else {
			print "[$level] Skipping...\n";
		}
		print "[$level] end HASH $in, sum $sum\n";
		return $sum;
	}
	print "[$level] unknown $in\n";
	return 0;
}

print "Total: " . add_numbers($json, 0) . "\n";
