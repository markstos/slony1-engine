#----------------------------------------------------------------------------
#
# PostgreSQL documentation makefile
#
# 
#
#----------------------------------------------------------------------------

subdir = doc/adminguide
slony_top_builddir = ../..

include $(slony_top_builddir)/Makefile.global

.SECONDARY:
.NOTPARALLEL:


GENERATED_SGML = bookindex.sgml version.sgml schemadoc.sgml
GENERATED_XML = schemadoc.xml

ALLSGML = $(wildcard $(srcdir)/*.sgml) $(GENERATED_SGML) $(GENERATED_XML)
DISTFILES = $(ALLSGML) $(GENERATED_SGML)

ifdef DOCBOOKSTYLE
CATALOG = -c $(DOCBOOKSTYLE)/catalog
endif

# Enable draft mode during development
ifneq (,$(findstring devel, $(VERSION)))
override JADEFLAGS += -V draft-mode
endif

# docbook2man generates man pages from docbook refentry source code.
ifdef D2MDIR
D2MSCRIPT=$(D2MDIR)/docbook2man-spec.pl
endif

# Enable some extra warnings
override SPFLAGS += -wall -wno-unused-param -wno-empty

##
## Man pages
##

.PHONY: man


man: man.sgml $(ALLSGML)
ifdef NSGMLS
ifdef SGMLSPL
ifdef D2MSCRIPT
	$(NSGMLS) $(NSGMLS_FLAGS) $< | $(SGMLSPL) $(D2MSCRIPT) --lowercase --date "`date '+%Y-%m-%d'`"
# One more time, to resolve cross-references
	$(NSGMLS) $(NSGMLS_FLAGS) $< | $(SGMLSPL) $(D2MSCRIPT) --lowercase --date "`date '+%Y-%m-%d'`"
	mkdir -p man1 man7
	mv *.1 man1/
	mv *.7 man7/
endif
endif
endif

##
## HTML
##

all: html man

installdirs:
ifdef docdir
	$(mkinstalldirs) $(DESTDIR)$(docdir)/sgml
	$(mkinstalldirs) $(DESTDIR)$(docdir)/html
	$(mkinstalldirs) $(DESTDIR)$(mandir)/man1
	$(mkinstalldirs) $(DESTDIR)$(mandir)/man7
endif

install: installdirs
ifdef D2MSCRIPT
ifdef docdir
	for file in man1/*.1; do \
	   $(INSTALL_DATA) $$file $(DESTDIR)$(mandir)/$$file || exit;\
	done
	for file in man7/*.7; do \
	   echo $$file; \
	   $(INSTALL_DATA) "$$file" $(DESTDIR)$(mandir)/$$file || exit;\
	done
	for file in $(wildcard *.html) stylesheet.css ; do \
	  $(INSTALL_DATA) $$file $(DESTDIR)$(docdir)/html || exit;\
	done
endif
endif

.PHONY: html

ifndef JADE
html:
	@echo "You must have jade installed to build the documentation." && exit;
else
html: slony.sgml $(ALLSGML) stylesheet.dsl
	@rm -f *.html ;\
	$(JADE) $(JADEFLAGS) $(SGMLINCLUDE) $(CATALOG) -d stylesheet.dsl -ioutput-html -t sgml $<
ifeq ($(vpath_build), yes)
	@cp $(srcdir)/stylesheet.css .
endif
endif

COLLATEINDEX := LC_ALL=C $(PERL) $(COLLATEINDEX) -f -g

ifdef JADE
ifeq (,$(wildcard HTML.index))
bookindex.sgml:
	$(COLLATEINDEX) -o $@ -N
else
bookindex.sgml: HTML.index
	$(COLLATEINDEX) -i 'bookindex' -o $@ $<
endif
else
bookindex.sgml:
	@echo "You must have jade to build the documentation" && exit
endif

##
## Print
##

# RTF to allow minor editing for hardcopy

%.rtf: %.sgml $(ALLSGML) stylesheet.dsl
	$(JADE) $(JADEFLAGS) $(SGMLINCLUDE) $(CATALOG) -d stylesheet.dsl -t rtf -V rtf-backend -ioutput-print $<

# TeX
# Regular TeX and pdfTeX have slightly differing requirements, so we
# need to distinguish the path we're taking.

%.tex-ps: %.sgml $(ALLSGML) stylesheet.dsl
	$(JADE) $(JADEFLAGS) $(SGMLINCLUDE) $(CATALOG) -d stylesheet.dsl -t tex -V tex-backend -ioutput-print -V texdvi-output -o $@ $<

%.tex-pdf: %.sgml $(ALLSGML) stylesheet.dsl
	$(JADE) $(JADEFLAGS) $(SGMLINCLUDE) $(CATALOG) -d stylesheet.dsl -t tex -V tex-backend -ioutput-print -V texpdf-output -o $@ $<

%.dvi: %.tex-ps
	@rm -f $*.aux $*.log
	jadetex $<
	jadetex $<
	jadetex $<

# Postscript from TeX
%.ps: %.dvi
	dvips -o $@ $<

%.pdf: %.tex-pdf
	@rm -f $*.aux $*.log $*.out
	pdfjadetex $<
	pdfjadetex $<
	pdfjadetex $<


# This generates an XML version of the flow-object tree.  It's useful
# for debugging DSSSL code, and possibly to interface to some other
# tools that can make use of this.
%.fot: %.sgml $(ALLSGML) stylesheet.dsl
	$(JADE) $(JADEFLAGS) $(SGMLINCLUDE) $(CATALOG) -d stylesheet.dsl -t fot -i output-print -o $@ $<


# Graphics

%.gif:
	cp $(srcdir)/../graphics/$@ .

%.eps: %.gif
	$(CONVERT) $< eps:$@

%.pdf: %.eps
	$(EPSTOPDF) $<


##
## Semi-automatic generation of some text files.
##

JADE.text = $(JADE) $(JADEFLAGS) $(SGMLINCLUDE) $(CATALOG) -d stylesheet.dsl -i output-text -t sgml
LYNX = lynx

INSTALL HISTORY regress_README: % : %.html
	$(PERL) -p -e 's/<H(1|2)$$/<H\1 align=center/g' $< | $(LYNX) -force_html -dump -nolist -stdin >$@

INSTALL.html: standalone-install.sgml installation.sgml 
	$(JADE.text) -V nochunks standalone-install.sgml installation.sgml >$@

HISTORY.html: release.sgml
	( echo '<!doctype appendix PUBLIC "-//OASIS//DTD DocBook V4.2//EN">'; \
	  cat $< ) >tempfile_HISTORY.sgml
	$(JADE.text) -V nochunks tempfile_HISTORY.sgml >$@
	rm tempfile_HISTORY.sgml

regress_README.html: regress.sgml
	( echo '<!doctype chapter PUBLIC "-//OASIS//DTD DocBook V4.2//EN" ['; \
	  echo '<!entity % standalone-ignore "IGNORE"> ]>'; \
	  cat $< ) >tempfile_regress_README.sgml
	$(JADE.text) -V nochunks tempfile_regress_README.sgml >$@
	rm tempfile_regress_README.sgml


##
## Experimental XML stuff
##

OSX = osx # (may be called sx or sgml2xml on some systems)
XSLTPROC = xsltproc

slony.xml: slony.sgml $(GENERATED_SGML)
	$(OSX) -x lower $< | \
	  sed -e 's/\[\(lt\|gt\|amp\|nbsp\|copy\|quot\|ouml\|uuml\|egrave\) *\]/\&\1;/g' \
	      -e '1a\' -e '<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN" "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">' \
	  >$@

testxml: stylesheet.xsl slony.xml
	$(XSLTPROC) $(XSLTPROCFLAGS) --stringparam pg.version '$(VERSION)' $^

htmlhelp: stylesheet-hh.xsl slony.xml
	$(XSLTPROC) $(XSLTPROCFLAGS) --stringparam pg.version '$(VERSION)' $^


##
## Check
##

# Quick syntax check without style processing
check: slony.sgml $(ALLSGML) $(GENERATED_SGML)
	$(NSGMLS) $(SPFLAGS) $(SGMLINCLUDE) -s $<


##
## Clean
##

clean distclean maintainer-clean:
# HTML
	rm -f HTML.manifest *.html *.gif
# man
	rm -rf *.1 *.7 man1 man7 manpage.refs manpage.links manpage.log
# print
	rm -f *.rtf *.tex-ps *.tex-pdf *.dvi *.aux *.log *.ps *.pdf *.out *.eps *.fot
# index
	rm -f HTML.index $(GENERATED_SGML)
# text
	rm -f INSTALL HISTORY
# xml
	rm -f schemadoc.xml

BASEDIR=$(slony_top_builddir)/src/backend
BASESQL=$(BASEDIR)/slony1_base.sql
BASEFUNS=$(BASEDIR)/slony1_funcs.sql
XIDSQL=localxid.sql
TEMPDB=schemadoc
TEMPSCHEMA=schemadoc
CREATELANG=$(pgbindir)/createlang   # That's how it is for me...

schemadoc.sgml: schemadoc.xml
	sed 's,/>,>,g' $< >$@

schemadoc.xml: $(BASESQL) $(BASEFUNS) $(XIDDIR)
	@$(pgbindir)/createdb $(TEMPDB) && ( \
	$(CREATELANG) plpgsql $(TEMPDB) 2>/dev/null ; \
	echo "drop schema $(TEMPSCHEMA);create schema $(TEMPSCHEMA);" | $(pgbindir)/psql $(TEMPDB) && \
	cat $(XIDSQL) $(BASEFUNS) $(BASESQL) |  sed -e "s/@NAMESPACE@/$(TEMPSCHEMA)/g"  -e "s/@CLUSTERNAME@/$(TEMPSCHEMA)/g" | $(pgbindir)/psql $(TEMPDB) && \
	$(PGAUTODOC) -d $(TEMPDB) -s $(TEMPSCHEMA) -t xml -f schemadoc ;\
	sed -i.bak -e "s/$(TEMPSCHEMA)\.//g" -e "s@<book.*>@@g" -e "s@</book.*>@@g" schemadoc.xml ;\
	rm  schemadoc.xml.bak ;\
	$(pgbindir)/dropdb $(TEMPDB) >/dev/null 2>&1 \
	) || echo "unable to createdb $(TEMPDB)"

version.sgml:	$(slony_top_builddir)/Makefile.global
	{ \
	echo "<!entity version \"$(VERSION)\">"; \
	echo "<!entity majorversion \"`expr $(VERSION) : '\([0-9][0-9]*\.[0-9][0-9]*\)'`\">"; \
	} >$@

distdir:	$(DISTFILES)
	mkdir -p $(distdir)/$(subdir)
	-chmod 777 $(distdir)/$(subdir)
	@for file in $(DISTFILES) ; do \
		cp $$file $(distdir)/$(subdir)/$$file || exit; \
	done

