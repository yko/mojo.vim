FTDETECT=$(HOME)/.vim/ftdetect
SYNTAX=$(HOME)/.vim/syntax
SNIPPETS=$(HOME)/.vim/snippets
AFTER=$(HOME)/.vim/after/syntax/perl

default:
	@echo There is no default target.
	@echo Some handle targets: test, install, symlinks

dirs:
	mkdir -p $(FTDETECT) $(SYNTAX) ${AFTER} ${SNIPPETS}

install: dirs
	cp ftdetect/epl.vim  $(FTDETECT)
	cp syntax/epl.vim    $(SYNTAX)
	cp after/syntax/perl/MojoliciousLite.vim    $(AFTER)
	cp snippets/epl.snippets    $(SNIPPETS)

symlinks: dirs
	ln -sf $(PWD)/ftdetect/epl.vim  $(FTPLUGIN)
	ln -sf $(PWD)/syntax/epl.vim    $(SYNTAX)
	ln -sf $(PWD)/after/syntax/perl/MojoliciousLite.vim    $(AFTER)
	ln -sf $(PWD)/snippets/epl.snippets    $(SNIPPETS)

test:
	prove -rl t
