package Test::VimSyntax;
use strict;
use warnings;
use Test::More;
use Mojo::DOM;
eval 'use Text::VimColor';
if ($@) {
    plan skip_all => 'Text::VimColor required for this test';
}

plan skip_all => "Test::Simple 0.94 or higher required for this test"
  if $Test::More::VERSION < 0.94;

use base 'Test::Builder::Module';

our @EXPORT = qw(plan syntax_ok highlighter);

my $hl;

sub highlighter {
    return $hl ||= Text::VimColor->new unless @_;

    $hl = shift;
}

sub syntax_ok {
    my ($string, $elem, $name) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

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
                diag "Output was " . highlighter->xml;
                skip "Returned elements "
                  . scalar(@$children)
                  . " did not matched passed array "
                  . scalar(@$elem) => (scalar(@$elem) * 2);
            }

            foreach my $el (@$elem) {
                my $c = shift @$children;
                is( $c->tree->[1],
                    'syn:' . $el->[0],
                    'Syntax name "'
                      . $el->[0]
                      . '" for string "'
                      . $c->text(0) . '"'
                );
                is($c->text(0), $el->[1], 'Text "' . $c->text(0) . '" matched');
            }
        }

    };
}

1;
