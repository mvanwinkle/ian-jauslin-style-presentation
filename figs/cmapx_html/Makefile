# This allows you to reference files relative to 
# this particular file.
MAKEFILE_PATH = $(strip $(dir $(firstword $(MAKEFILE_LIST))))

all: example.cmapx.html

# Example for how data files are generated:
example.dot: ;

# Chances are the .gnuplot files are going to be static / generic
# but if you want to generate them, this is what you'd replace:

# If you require special cleanup for this directory
# put it here:
clean-misc: ;

# This is where you include the rules to do the pipeline
include $(MAKEFILE_PATH)/../make_includes/cmapx_html_pipeline.gmk
