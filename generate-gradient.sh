perl -ne chomp; my @a = split(/\|/); print "CDEF:shading$a[0]=t,$a[0],LT,t,$a[0],IF AREA:shading$a[0]#$a[1] \\\n"; grad3.txt
