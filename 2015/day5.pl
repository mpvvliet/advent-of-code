#!/usr/bin/perl

$nice  = 0;
while (<>) {
# 	if (/ab/ || /cd/ || /pq/ || /xy/) {
# 		next;
# 	}

# 	if (/[aeiou].*[aeiou].*[aeiou]/) {
# #		print "match 1\n";
# 	} else {
# 		next;
# 	}

# 	if (/([a-z])\g1/) {
# 		$nice++;
# 		print "nice: " . $_;
# 	}

	if (/([a-z][a-z]).*\g1/) {
		print "match 1\n";
	} else {
		next;
	}

	if (/([a-z]).\g1/) {
		$nice++;
		print "nice: " . $_;
	}

}
print "Nice: $nice\n";
