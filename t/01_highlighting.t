use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;

plan tests => 8;

use FindBin;

my $hl = Text::VimColor->new(
    html_full_page         => 1,
    html_inline_stylesheet => 0,
    filetype               => 'html.epl',
    vim_options            => [
        qw(-RXZ -i NONE -u NONE -U NONE -N -n),       # for performance
        '+set nomodeline',                            # for performance
        '+set runtimepath^=' . $FindBin::Bin . '/..', # Prepend test to runtime
        "+source syntax/epl.vim",
    ],
);

highlighter($hl);

syntax_ok(
    '<html><%=  1 %></html>',
    [   ['identifier', '<'],
        ['statement',  'html'],
        ['identifier', '>'],
        ['type',       '<%='],
        ['constant',   '1'],
        ['type',       '%>'],
        ['identifier', '</'],
        ['statement',  'html'],
        ['identifier', '>'],
    ],
    'Simple html'
);

syntax_ok(
    '<a href="<%= 1 %>"></a>',
    [   ['identifier',   '<'],
        ['statement',    'a'],
        ['identifier',    ''],
        ['type',      'href'],
        ['identifier',   '='],
        ['constant',     '"'],
        ['type',       '<%='],
        ['constant',     '1'],
        ['type',        '%>'],
        ['constant',     '"'],
        ['identifier', '></'],
        ['statement',   'a'],
        ['identifier',  '>'],
    ],
    'Perl inside of attribute value'
);

syntax_ok(
    "\%=  print(1);\n<b>",
    [   ['type', '%='],
        ['statement',  'print'],
        ['constant', '1'],
        ['identifier','<'],
        ['statement',   'b'],
        ['identifier','>']
    ],
    'Start line'
);

syntax_ok(
    "\%==  print(1);\n<b>",
    [   ['type', '%=='],
        ['statement',  'print'],
        ['constant', '1'],
        ['identifier','<'],
        ['statement',   'b'],
        ['identifier','>']
    ],
    'Start line unquoted'
);

syntax_ok(
    "\%===  print(1);\n<b>",
    [   ['type', '%=='],
        ['statement',  'print'],
        ['constant', '1'],
        ['identifier','<'],
        ['statement',   'b'],
        ['identifier','>']
    ],
    'Start line unquoted with one more equal'
);

syntax_ok(
    "\% print;\n<b>",
    [   ['type', '%'],
        ['statement',  'print'],
        ['identifier','<'],
        ['statement',   'b'],
        ['identifier','>']
    ],
    'Just a perl code'
);

syntax_ok(
    "  \%=  print(1);\n<b>",
    [   ['type',       '  %='],
        ['statement',  'print'],
        ['constant',   '1'],
        ['identifier', '<'],
        ['statement',  'b'],
        ['identifier', '>']
    ],
    'Intdented perl code'
);

syntax_ok(
    "\%= if (1) { print 1 };",
    [   ['type',       '%='],
        ['statement',  'if'],
        ['constant',   '1'],
        ['statement',  'print'],
        ['constant',   '1'],
    ],
    'Conditional block'
);
