cat day2-input.txt | awk '{ split($1,a,"x"); lw = a[1]*a[2]; wh = a[2]*a[3]; hl = a[1]*a[3]; present = 2*lw + 2*wh + 2*hl; min = lw<wh?lw:wh; min = min<hl?min:hl; present += min; totalwrap += present; ribbon = 2 * a[1] + 2 * a[2] + 2*a[3] + a[1]*a[2]*a[3]; max = a[1]>a[2]?a[1]:a[2]; max = max>a[3]?max:a[3]; ribbon -= 2*max; totalribbon += ribbon; } END { print "wrapping: ", totalwrap, ", ribbon: ", totalribbon; }'

