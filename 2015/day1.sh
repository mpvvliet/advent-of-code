cat day1-input.txt | awk '{ floor = 0; split($1,a,""); for (i=0; i<length(a); i++) { if (a[i] == "(") { floor++; } else if (a[i] == ")") { floor--; if (floor == -1) { print "entering basesment: ", i; } } } print floor; }'

