.PHONY: all

all: main.pdf

main.pdf: main.tex
	pdflatex -shell-escape $<
	pdflatex -shell-escape $<

