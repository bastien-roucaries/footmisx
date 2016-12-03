PKG=footmisx

all:
	pdflatex $(PKG).ins
	pdflatex $(PKG).dtx
	makeindex -s $(PKG).idx $(PKG)
	makeindex -s $(PKG).glo -o $(PKG).glx $(PKG)
	pdflatex $(PKG).dtx
	pdflatex $(PKG).dtx
	(set -e; cd tests;  find . -name '*.tex'  -exec pdflatex {} \;find . -name '*.tex'  -exec pdflatex {} \;)