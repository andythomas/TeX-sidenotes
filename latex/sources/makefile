# Initial version of the makefile: Andy Thomas 2020/04/01
# for new versions please see https://github.com/andythomas/TeX-sidenotes

#
# generate the sidenotes style file plus documentation
#
sidenotes:
	pdflatex sidenotes.ins
	pdflatex sidenotes.dtx
	makeindex -s gind.ist -o sidenotes.ind sidenotes.idx
	makeindex -s gglo.ist -o sidenotes.gls sidenotes.glo
	pdflatex sidenotes.dtx
	rm sidenotes.glo sidenotes.gls sidenotes.ind sidenotes.idx
	rm sidenotes.ilg sidenotes.toc sidenotes.log sidenotes.aux

#
# generate the caesar style file plus documentation
#
caesar:
	pdflatex caesar.ins
	pdflatex caesar.dtx
	makeindex -s gind.ist -o caesar.ind caesar.idx
	makeindex -s gglo.ist -o caesar.gls caesar.glo
	pdflatex caesar.dtx
	rm caesar.glo caesar.gls caesar.ind caesar.idx
	rm caesar.ilg caesar.toc caesar.log caesar.aux

#
# compile the example file
#
example: sidenotes
	pdflatex caesar_example
	biber caesar_example
	pdflatex caesar_example
	pdflatex caesar_example
	pdflatex caesar_example
	rm caesar_example.aux caesar_example.bbl caesar_example.bcf
	rm caesar_example.bib caesar_example.blg caesar_example.log
	rm caesar_example.run.xml caesar_example.toc

#
# update the ctan directory to upload new files
#
ctan: sidenotes example
	cp README ../ctan
	cp caesar_book.cls ../ctan
	cp caesar_example.tex ../ctan
	cp caesar_example.pdf ../ctan
	cp sidenotes.dtx ../ctan
	cp sidenotes.ins ../ctan
	cp sidenotes.pdf ../ctan

#
# update the targets directory
#
targets: sidenotes caesar example
	mv sidenotes.sty ../targets
	mv sidenotes.pdf ../targets
	mv caesar_example.pdf ../targets
	mv caesar.sty ../targets
	mv caesar.pdf ../targets
