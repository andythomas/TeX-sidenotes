# Initial version of the makefile: Andy Thomas 2020/04/01
# for new versions please see https://github.com/andythomas/TeX-sidenotes

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
