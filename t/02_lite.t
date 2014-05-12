use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;
use File::Temp;

plan tests => 3;

use FindBin;

my $hl = Text::VimColor->new(
    html_full_page         => 1,
    html_inline_stylesheet => 0,
    filetype               => 'perl',
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
    "print 1;\n__DATA__\n@@ index.html\n<html><%= print 1; %></html>",
    [   ['statement',  'print'],
        ['constant',   '1'],
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

syntax_ok(
    "__DATA__\n@@ index.html\n<%= %> test <br /> <% %>",
    [
        ['special',    '@@'],
        ['constant',   ' index.html'],
        ['type',       '<%='],
        ['type',       '%>'],
        ['identifier', '<'],
        ['statement',  'br'],
        ['identifier', ' />'],
        ['type',       '<%'],
        ['type',       '%>']
    ],
    'Simple html'
);

syntax_ok(
    "__DATA__\n@@ index.html\n<%= %>\n__END__\n=head1 NAME\nTest name\n=cut",
    [
        ['special'   => '@@'],
        ['constant'  => ' index.html'],
        ['type'      => '<%='],
        ['type'      => '%>']
    ],
    'Simple html'
);
