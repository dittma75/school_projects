# Sample Makefile for Web Programming students
#
# by Darren Provine, 14 September 2002
# modified by Kevin Dittmar, 28 January 2014

# These lines should be the only ones you have to change for many
# projects.

DESTDIR = /export/home/dittma75/public_html/db/SCRIPTS/DATA_MANAGEMENT
TARGETS = view.cgi delete.cgi create_new.cgi add_author.cgi add_genre.cgi \
		  update.cgi upload.cgi file_upload.html
SOURCES = view.cgi delete.cgi create_new.cgi add_author.cgi add_genre.cgi \
		  update.cgi upload.cgi file_upload.html

# This target is just here to be the top target in the Makefile.
# There's nothing to compile for this one.
all: $(TARGETS)

# You might want to look up mkdir(1) to see about that -p flag.
install: $(TARGETS)
	@if [ ! -d $(DESTDIR) ] ; then mkdir -p $(DESTDIR); fi
	@for f in $(TARGETS)                 ; \
	do                                     \
		/usr/bin/install -v -t $(DESTDIR) -m 555 $$f ; \
	done

# Note that here we don't blow away the directory, and so we
# be sure and tell the user.  The reason not to delete the
# directory is that it may have other files in it.  Checking
# for, and deleting, any such files will have to be done manually.
# (How could this be improved?)
#
# Note also that the @ sign keeps the echo lines from being echoed
# before they are run.  (That could be confusing.)  This little
# trick (and many more) can be discovered by consulting make(1).
deinstall:
	cd $(DESTDIR) ; /bin/rm -f $(TARGETS)
	@echo "   ==>   removed file(s): $(TARGETS)"
	@echo "   ==>   left directory : $(DESTDIR)"

redo: deinstall install

clean:
	/bin/rm -f core $(TARGETS)
