package Test::VimSyntax;
use strict;
use warnings;
use Text::VimColor;
use Mojo::DOM;
use Test::More;

die "Test::Builder 0.94 or higher required!" if $Test::More::VERSION <= 0.94;

use base 'Test::Builder::Module';

our @EXPORT = qw(plan syntax_ok highlighter);

my $hl;

sub highlighter {
    return $hl ||= Text::VimColor->new unless @_;

    $hl = shift;
}

sub syntax_ok {
    my ($string, $elem, $name) = @_;

    highlighter->syntax_mark_string($string);
    my $out = '';
    subtest $name => sub {
        plan tests => 3 + scalar(@$elem) * 2;
        isa_ok(my $dom = Mojo::DOM->new->parse(highlighter->xml),
            'Mojo::DOM', 'Output parsed');
        isa_ok(my $code = $dom->at('syntax'),
            'Mojo::DOM', 'Code found in output');

        my $children = $code->children;

        my $matched =
          is(scalar(@$children), scalar(@$elem),
            "Elements matched test array");

      SKIP: {
            unless ($matched) {
                skip "Returned elements "
                  . scalar(@$children)
                  . " did not matched passed array "
                  . scalar(@$elem) => (scalar(@$elem) * 2);
            }

            foreach my $el (@$elem) {
                my $c = shift @$children;
                is( $c->tree->[1],
                    'syn:' . $el->[0],
                    'Syntax name "' . $el->[0] . '"'
                );
                is($c->text, $el->[1], 'Text matched');
            }
        }

    };
}

1;
