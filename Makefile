FTDETECT=$(HOME)/.vim/ftdetect
SYNTAX=$(HOME)/.vim/syntax
AFTER=$(HOME)/.vim/after/syntax/perl/

default:
	@echo There is no default target.
	@echo Some handle targets: test, install

dirs:
	mkdir -p $(FTDETECT) $(SYNTAX) ${AFTER}

install: dirs
	cp ftdetect/epl.vim  $(FTDETECT)
	cp syntax/epl.vim    $(SYNTAX)
	cp after/syntax/perl/MojoliciousLite.vim    $(AFTER)

symlinks: dirs
	ln -sf $(PWD)/ftdetect/epl.vim  $(FTPLUGIN)
	ln -sf $(PWD)/syntax/epl.vim    $(SYNTAX)
	ln -sf $(PWD)/after/syntax/perl/MojoliciousLite.vim    $(AFTER)

test:
	prove -rv t
