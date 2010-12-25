FTDETECT=$(HOME)/.vim/ftdetect
SYNTAX=$(HOME)/.vim/syntax

default:
	@echo There is no default target.
	@echo Some handle targets: test, install

dirs:
	mkdir -p $(FTDETECT) $(SYNTAX)

install: dirs
	cp ftdetect/epl.vim  $(FTDETECT)
	cp syntax/epl.vim    $(SYNTAX)
	cp syntax/MojoliciousTemplate.vim    $(SYNTAX)

symlinks: dirs
	ln -sf $(PWD)/ftdetect/epl.vim  $(FTPLUGIN)
	ln -sf $(PWD)/syntax/epl.vim    $(SYNTAX)
	ln -sf $(PWD)/syntax/MojoliciousTemplate.vim    $(SYNTAX)

test:
	prove -rv t
