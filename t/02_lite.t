use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;
use File::Temp;

plan tests => 1;

use FindBin;

my $hl = Text::VimColor->new(
    html_full_page         => 1,
    html_inline_stylesheet => 0,
    filetype               => 'perl',
    vim_let                => {mojo_highlight_data => "1"},
    vim_options            => [
        qw(-RXZ -i NONE -u NONE -U NONE -N -n),    # for performance
        '+set nomodeline',                         # for performance
        "+set runtimepath^=$FindBin::Bin/..",      # Prepend test to runtime
    ],
);

highlighter($hl);

syntax_ok(
    "print 1;\n__DATA__\n@@ index.html\n<html><%= print 1; %></html>",
    [   ['statement',  'print'],
        ['constant',   '1'],
        ['comment',    '__DATA__'],
        ['special',    '@@'],
        ['constant',   ' index.html'],
        ['identifier', '<'],
        ['statement',  'html'],
        ['identifier', '>'],
        ['type',       '<%='],
        ['statement',  'print'],
        ['constant',   '1'],
        ['type',       '%>'],
        ['identifier', '</'],
        ['statement',  'html'],
        ['identifier', '>'],
    ],
    'Simple html'
);
