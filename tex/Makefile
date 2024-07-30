.PHONY: all

all: main.pdf

main.pdf: main.tex
	latexmk -shell-escape -pdf -interaction=nonstopmode -latex=pdflatex "$<"

