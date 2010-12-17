use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;

plan tests => 6;

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

TODO: {
    local $Test::VimSyntax::TODO = "Don't match indent";
    syntax_ok(
        "  \%=  print(1);\n<b>",
        [   ['type',       '%='],
            ['statement',  'print'],
            ['constant',   '1'],
            ['identifier', '<'],
            ['statement',  'b'],
            ['identifier', '>']
        ],
        'Intdented perl code'
    );
};
