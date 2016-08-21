#------------------------------------------------------------------------------
# This is a makefile tailored to work on the latex documents for the
# Licentiate and PhD thesis (MechThesis).
#------------------------------------------------------------------------------


# Variables:
#
main = thesis

TEX = pdflatex
TEX_FLAGS =

BIB = bibtex
BIB_FLAGS =


# Dependencies:
#
SRCS = jfm.bst              \
       MechThesis.cls       \
       packages.tex         \
       commands.tex         \
       frontmatter.tex      \
       acknowledgements.tex \
       overview.tex         \
       $(main).tex          \
       $(main).bib          \
       $(subst /,/paper.tex,$(wildcard paper*/))

AUXS = overview.aux \
       $(main).aux  \
       $(main).toc  \
       $(main).pls  \
       $(main).psm  \
       $(subst /,/paper.aux,$(wildcard paper*/))

BBLS = overview.bbl \
       $(subst /,/paper.bbl,$(wildcard paper*/))

# Rules:
#
default: all

all: $(main)
#
$(main): $(SRCS) $(AUXS) $(BBLS)
	@echo building $(main) with $(TEX)
	@$(TEX) $(TEX_FLAGS) -draftmode $(main) #> /dev/null
	@sed -i -e 's/toPaper/Paper/g' thesis.out	
	@$(TEX) $(TEX_FLAGS) $(main) #> /dev/null

$(AUXS): $(SRCS)
	@echo building $(main) with $(TEX) [for $@]
	@$(TEX) $(TEX_FLAGS) -draftmode $(main) #> /dev/null

%.bbl: %.aux $(main).bib
	@echo building $@ with $(BIB)
	@$(BIB) $(BIB_FLAGS) $(basename $@) #> /dev/null
#
clean: clean_papers clean_thesis

clean_thesis:
	@echo cleaning thesis
	@rm -f *.ps *.dvi *.aux *.toc *.log *.out *.bbl *.blg *.pls *.psm *~ *.syntex.gz

clean_papers:
	@echo cleaning papers
	@rm -f paper*/*.aux paper*/*.bbl paper*/*.blg
