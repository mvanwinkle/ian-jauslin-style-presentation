PROJECTNAME=example_figure
MAKEFILE_PATH = $(strip $(dir $(firstword $(MAKEFILE_LIST))))

PDFS=$(addsuffix .pdf, $(PROJECTNAME))

DATS= example_figure.dat

all: $(PDFS)

$(PDFS): $(DATS)
	gnuplot $(patsubst %.pdf, %.gnuplot, $@) > $(patsubst %.pdf, %.tikz.tex, $@)
	pdflatex -jobname $(basename $@) -file-line-error $(patsubst %.pdf, %.tikz.tex, $@)

example_figure.dat:
	$(MAKEFILE_PATH)/generate.sh > $@

install: $(PDFS)
	cp $^ $(INSTALLDIR)/

$(LIBS):
	ln -fs libs/$@ ./

clean-libs:
	-rm -f $(LIBS)

clean-aux:
	-rm -f $(addsuffix .aux, $(PROJECTNAME))
	-rm -f $(addsuffix .log, $(PROJECTNAME))
	-rm -f $(addsuffix .tikz.tex, $(PROJECTNAME))

clean-tex:
	-rm -f $(PDFS)

clean: clean-libs clean-aux clean-tex
