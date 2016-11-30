#!/usr/bin/perl

%locations = ();
%cities = ();
@routes = ();

sub gen_route {
	my $start = shift;
	print "Generating routes starting in $start\n";
	return gen_routes($start, "$start")
}

sub calc_route {
	my $route = shift;
	my @stops = split(" -> ", $route);

#	print "calc_route: $route\n";
	
	$length = 0;
	$here = shift(@stops);
#	print "calc_route: $start, @stops\n";
	foreach $stop (@stops) {
#		print "$here, stop: $stop, dist $here{$stop}\n";
		$length += $locations{$here}{$stop};
		$here = $stop;
	}
	return $length;
}

sub gen_routes {
	my $current = shift;
	my $route = shift;
	
#	print "gen_routes: $route\n";

	foreach $outbound (keys(%{$locations{$current}})) {
#		print "$current -> $outbound\n";
		if ($route =~ /$outbound/) {
#			print "Skipping $outbound from $current in route $route\n";
		} else {
#			print "Travelling from $current -> $outbound\n";
			gen_routes($outbound, $route . " -> " . $outbound)
		}
	}

	my @c = $route =~ /->/g;
	my $count = @c;
	if ($count == $route_length) {
		print "* Found route: $route\n";
		push @routes, $route;
	}
}

while (<>) {
	if (/([a-zA-Z]+) to ([a-zA-Z]+) = ([0-9]+)/) {
		$locations{$1}{$2} = $3;
		$locations{$2}{$1} = $3;
		$locations{$1}{$1} = 0; # easy for length calc
		$locations{$2}{$2} = 0; # easy for length calc
		$cities{$1} = 1;
		$cities{$2} = 1;
	}
}

$route_length = keys(%cities) - 1;
print "Looking for routes of length $route_length\n";

print $locations{"Dublin"}{"London"} . "\n";

foreach $city (keys(%cities)) {
	gen_route($city);
}

print "*****\n";
$max = 0;
$maxroute = "";
foreach $route (@routes) {
	$length = calc_route($route);
	print "$route = " . $length . "\n";	
	if($length > $max) {
		$max = $length;
		$maxroute = $route;
	}
}

print "Max lenght: $max, route: $maxroute\n";
