use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;
use File::Temp;

plan tests => 1;

use FindBin;

my $hl = Text::VimColor->new(
    filetype               => 'html.epl',
    vim_options            => [
        qw(-RXZ -i NONE -u NONE -U NONE -N -n),     # for performance
        '+set nomodeline',                          # for performance
        "+set runtimepath+=$FindBin::Bin/../after", # Append test 'after' to runtime
        "+set runtimepath^=$FindBin::Bin/..",       # Prepend test to runtime
    ],
);

highlighter($hl);

syntax_ok(
    "<%= javascript begin %>var x = y;<% end %>",
    [   ['type',       '<%='],
        ['statement',  'javascript'],
        ['preproc',    'begin '],
        ['type',       '%>'],
        ['identifier', 'var'],
        ['type',       '<%'],
        ['preproc',    'end '],
        ['type',       '%>'],
    ],
    'simple syntax'
);
