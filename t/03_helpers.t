use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;
use File::Temp;

plan tests => 14;

use FindBin;

my $hl = Text::VimColor->new(
    html_full_page         => 1,
    html_inline_stylesheet => 0,
    filetype               => 'html.epl',
    vim_let                => {mojo_highlight_data => "1"},
    vim_options            => [
        qw(-RXZ -i NONE -u NONE -U NONE -N -n),     # for performance
        '+set nomodeline',                          # for performance
        "+set runtimepath+=$FindBin::Bin/../after", # Append test 'after' to runtime
        "+set runtimepath^=$FindBin::Bin/..",       # Prepend test to runtime
    ],
);

highlighter($hl);

syntax_ok(
    "<%= app %>",
    [   ['type',       '<%='],
        ['statement',  'app'],
        ['type',       '%>'],
    ],
    'helper "app"'
);

syntax_ok(
    "<%= content 'foo bar' %>",
    [   ['type',      '<%='],
        ['statement', 'content'],
        ['constant',  "'foo bar'"],
        ['type',      '%>'],
    ],
    'helper "content"'
);

syntax_ok(
    "<%= content_for 'foo bar' %>",
    [   ['type',      '<%='],
        ['statement', 'content_for'],
        ['constant',  "'foo bar'"],
        ['type',      '%>'],
    ],
    'helper "content_for"'
);

syntax_ok(
    "<%= dumper { foo => 'bar' } %>",
    [   ['type',      '<%='],
        ['statement', 'dumper'],
        ['constant',  'foo'],
        ['constant',  "'bar'"],
        ['type',      '%>'],
    ],
    'helper "content_for"'
);

syntax_ok(
    "<%= extends 'foo' %>",
    [   ['type',      '<%='],
        ['statement', 'extends'],
        ['constant',  "'foo'"],
        ['type',      '%>'],
    ],
    'helper "extends"'
);

syntax_ok(
    "<%= flash %>",
    [   ['type',      '<%='],
        ['statement', 'flash'],
        ['type',      '%>'],
    ],
    'helper "flash"'
);

syntax_ok(
    "<%= include 'foo' %>",
    [   ['type',      '<%='],
        ['statement', 'include'],
        ['constant', "'foo'"],
        ['type',      '%>'],
    ],
    'helper "include"'
);

syntax_ok(
    "<%= layout 'default' %>",
    [   ['type',      '<%='],
        ['statement', 'layout'],
        ['constant', "'default'"],
        ['type',      '%>'],
    ],
    'helper "layout"'
);

syntax_ok(
    "<%= memorize begin %>Foo bar<% end %>",
    [   ['type',      '<%='],
        ['statement', 'memorize'],
        ['preproc', "begin"],
        ['type',      '%>'],
        ['type',      '<%'],
        ['preproc', "end"],
        ['type',      '%>'],
    ],
    'helper "memorize"'
);

syntax_ok(
    "<%= param('foo') %>",
    [   ['type',      '<%='],
        ['statement', 'param'],
        ['constant', "'foo'"],
        ['type',      '%>'],
    ],
    'helper "param"'
);

syntax_ok(
    "<%= session->{'foo'} %>",
    [   ['type',      '<%='],
        ['statement', 'session'],
        ['constant', "'foo'"],
        ['type',      '%>'],
    ],
    'helper "session"'
);

syntax_ok(
    "<%= url_for 'foo' %>",
    [   ['type',      '<%='],
        ['statement', 'url_for'],
        ['constant', "'foo'"],
        ['type',      '%>'],
    ],
    'helper "url_for"'
);

syntax_ok(
    "<%= title 'foo' %>",
    [   ['type',      '<%='],
        ['statement', 'title'],
        ['constant',  "'foo'"],
        ['type',      '%>'],
    ],
    'helper "title"'
);

highlighter->vim_let('mojo_no_helpers' => 1);

syntax_ok(
    "<%= url_for 'foo' %>",
    [   ['type',     '<%='],
        ['constant', "'foo'"],
        ['type',     '%>'],
    ],
    'disabled tags'
);
