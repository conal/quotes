default: quotes.html

POPTS+=--standalone
POPTS+=--smart
#POPTS+=--css=style.css
#POPTS+=--latexmathml

.PRECIOUS: %.html

%.tex: %.md Makefile
	pandoc $(POPTS) -o $@ $<

%.html: %.md Makefile
	pandoc $(POPTS) --include-in-header=header.html -o $@ $<

%.pdf: %.tex Makefile
	pdflatex $*.tex

%.see: %
	open $<

push: web
web: web-token

web-token: quotes.html
	scp quotes.html conal@conal.net:/home/conal/web/quotes.htm
	touch web-token
