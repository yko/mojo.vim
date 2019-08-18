use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;

plan tests => 1;

use FindBin;

my $hl = Text::VimColor->new(
    html_full_page         => 1,
    html_inline_stylesheet => 0,
    filetype               => 'html.epl',
    vim_options            => [
        qw(-RXZ -i NONE -u NONE -U NONE -N -n),       # for performance
        '+set nomodeline',                            # for performance
        "+set runtimepath+=$FindBin::Bin/../after", # Append test 'after' to runtime
        "+set runtimepath^=$FindBin::Bin/..",       # Prepend test to runtime
    ],
);

highlighter($hl);

my $template = <<EOF;
__DATA__
@@ index.ep.html
<html>
% for (1..2) {
    <p>Test</p>
% }
</html>
EOF

syntax_ok(
    $template,
    [   ['identifier', '<'],
        ['statement',  'html'],
        ['identifier', '>'],
        ['type',       '%'],
        ['statement',  'for'],
        ['constant',   '1..2'],
        ['identifier', '<'],
        ['statement',  'p'],
        ['identifier', '>'],
        ['identifier', '</'],
        ['statement',  'p'],
        ['identifier', '>'],
        ['type',       '%'],
        ['identifier', '</'],
        ['statement',  'html'],
        ['identifier', '>'],
    ],
    'code blocks'
);
