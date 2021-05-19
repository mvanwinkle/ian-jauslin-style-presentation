PROJECTNAME=$(basename $(wildcard *.tex))
LIBS=$(notdir $(wildcard libs/*))
FIGS=$(notdir $(wildcard figs/*.fig))
JPGS=$(notdir $(wildcard figs/*.jpg))

PDFS=$(addsuffix .pdf, $(PROJECTNAME))
SYNCTEXS=$(addsuffix .synctex.gz, $(PROJECTNAME))

all: $(PROJECTNAME)

$(PROJECTNAME): $(LIBS) $(FIGS) $(JPGS)
	pdflatex -file-line-error $@.tex
	pdflatex -synctex=1 $@.tex

$(SYNCTEXS): $(LIBS) $(FIGS) $(JPGS)
	pdflatex -synctex=1 $(patsubst %.synctex.gz, %.tex, $@)


$(LIBS):
	ln -fs libs/$@ ./


$(FIGS):
	make -C figs/$@
	for pdf in $$(find figs/$@/ -name '*.pdf'); do ln -fs "$$pdf" ./ ; done

$(JPGS):
	ln -fs figs/$@ ./


clean-aux: clean-figs-aux
	rm -f $(addsuffix .aux, $(PROJECTNAME))
	rm -f $(addsuffix .log, $(PROJECTNAME))
	rm -f $(addsuffix .out, $(PROJECTNAME))

clean-libs:
	rm -f $(LIBS)

clean-figs:
	$(foreach fig,$(addprefix figs/, $(FIGS)), make -C $(fig) clean; )
	rm -f $(notdir $(wildcard figs/*.fig/*.pdf))

clean-figs-aux:
	$(foreach fig,$(addprefix figs/, $(FIGS)), make -C $(fig) clean-aux; )


clean-tex:
	rm -f $(PDFS) $(SYNCTEXS)

clean: clean-aux clean-tex clean-libs clean-figs
