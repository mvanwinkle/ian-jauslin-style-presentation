set ylabel "Random Value 2nd set"
set xlabel "Trial Number 2nd set"
# You can include math symbols in labels like this:
# set ylabel "$\\eta$" norotate
# set xlabel "$\\rho$"

set yrange [0:60]
set ytics 10
set mytics 5

set xrange [1:10]
set xtics 1
unset mxtics

# default output canvas size: 12.5cm x 8.75cm
set term lua tikz size 8,6 standalone

set key off

# set linestyle
set style line 1 linetype rgbcolor "#4169E1" linewidth 2

set pointsize 0.6

# set label "Random Numbers 0-59" textcolor "#32CD32"

plot "example_figure2.dat" using 1:2 w l ls 1
