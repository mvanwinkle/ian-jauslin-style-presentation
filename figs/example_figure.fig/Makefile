MAKEFILE_PATH = $(strip $(dir $(firstword $(MAKEFILE_LIST))))

all: example_figure.pdf example_figure2.pdf
%.pdf : %.tikz.tex
	pdflatex -jobname $(basename $@) --file-line-error $<

%.tikz.tex : %.gnuplot %.dat
	gnuplot $< > $@

%.gnuplot : ;

example_figure.dat:
	$(MAKEFILE_PATH)/generate.sh > $@

example_figure2.dat:
	$(MAKEFILE_PATH)/generate.sh > $@

install: $(PDFS)
	cp $^ $(INSTALLDIR)/

clean-aux:
	-rm -f *.aux
clean-pdf:
	-rm -f *.pdf
clean-tikz-tex:
	-rm -f *.tikz.tex
clean-log:
	rm -f *.log

clean: clean-aux clean-pdf clean-tikz-tex clean-log
