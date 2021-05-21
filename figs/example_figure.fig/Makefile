MAKEFILE_PATH = $(strip $(dir $(firstword $(MAKEFILE_LIST))))

all: example_figure.pdf example_figure2.pdf

# Example for how data files are generated:
example_figure.dat:
	$(MAKEFILE_PATH)/generate.sh > $@

example_figure2.dat:
	$(MAKEFILE_PATH)/generate.sh > $@

# Chances are the .gnuplot files are going to be static / generic
# but if you want to generate them, this is what you'd replace:

%.gnuplot : ;

include $(MAKEFILE_PATH)/../make_includes/tikz_tex_pdf_pipeline.gmk
