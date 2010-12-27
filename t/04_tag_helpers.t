use strict;
use warnings;
use lib 't/lib';
use File::Spec::Functions qw<catfile catdir>;

use Test::VimSyntax;
use File::Temp;

plan tests => 16;

use FindBin;

my $hl = Text::VimColor->new(
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
    "<%= base_tag %>",
    [   ['type',       '<%='],
        ['statement',  'base_tag'],
        ['type',       '%>'],
    ],
    'helper "base_tag"'
);

syntax_ok(
    "<%= check_box employed => 1 %>",
    [   ['type',      '<%='],
        ['statement', 'check_box'],
        ['constant',  "employed"],
        ['constant',  "1"],
        ['type',      '%>'],
    ],
    'helper "check_box"'
);

syntax_ok(
    "<%= file_field 'avatar' %>",
    [   ['type',      '<%='],
        ['statement', 'file_field'],
        ['constant',  "'avatar'"],
        ['type',      '%>'],
    ],
    'helper "file_field"'
);

syntax_ok(
    "<%= form_for login => (method => 'post') => begin %>foo<% end %>",
    [   ['type',      '<%='],
        ['statement', 'form_for'],
        ['constant',  'login'],
        ['constant',  'method'],
        ['constant',  "'post'"],
        ['preproc', "begin"],
        ['type',      '%>'],
        ['type',      '<%'],
        ['preproc', "end"],
        ['type',      '%>'],
    ],
    'helper "form_for"'
);

syntax_ok(
    "<%= hidden_field foo => 'bar' %>",
    [   ['type',      '<%='],
        ['statement', 'hidden_field'],
        ['constant',  "foo"],
        ['constant',  "'bar'"],
        ['type',      '%>'],
    ],
    'helper "hidden_field"'
);

syntax_ok(
    "<%= input_tag 'first_name' %>",
    [   ['type',      '<%='],
        ['statement', 'input_tag'],
        ['constant', "'first_name'"],
        ['type',      '%>'],
    ],
    'helper "input_tag"'
);

syntax_ok(
    "<%= javascript 'script.js' %>",
    [   ['type',      '<%='],
        ['statement', 'javascript'],
        ['constant', "'script.js'"],
        ['type',      '%>'],
    ],
    'helper "javascript"'
);

syntax_ok(
    "<%= link_to Home => 'index' %>",
    [   ['type',      '<%='],
        ['statement', 'link_to'],
        ['constant', "Home"],
        ['constant', "'index'"],
        ['type',      '%>'],
    ],
    'helper "link_to"'
);

syntax_ok(
    "<%= password_field 'pass' %>",
    [   ['type',      '<%='],
        ['statement', 'password_field'],
        ['constant', "'pass'"],
        ['type',      '%>'],
    ],
    'helper "password_field"'
);

syntax_ok(
    "<%= radio_button country => 'ukraine' %>",
    [   ['type',      '<%='],
        ['statement', 'radio_button'],
        ['constant', "country"],
        ['constant', "'ukraine'"],
        ['type',      '%>'],
    ],
    'helper "radio_button"'
);

syntax_ok(
    "<%= select_field language => [qw/de en/] %>",
    [   ['type',      '<%='],
        ['statement', 'select_field'],
        ['constant', "language"],
        ['constant', "qw/de en/"],
        ['type',      '%>'],
    ],
    'helper "select_field"'
);

syntax_ok(
    "<%= stylesheet 'foo.css' %>",
    [   ['type',      '<%='],
        ['statement', 'stylesheet'],
        ['constant', "'foo.css'"],
        ['type',      '%>'],
    ],
    'helper "stylesheet"'
);

syntax_ok(
    "<%= submit_button %>",
    [   ['type',      '<%='],
        ['statement', 'submit_button'],
        ['type',      '%>'],
    ],
    'helper "submit_button"'
);

syntax_ok(
    "<%= tag 'div' %>",
    [   ['type',      '<%='],
        ['statement', 'tag'],
        ['constant', "'div'"],
        ['type',      '%>'],
    ],
    'helper "tag"'
);

syntax_ok(
    "<%= text_field 'first_name' %>",
    [   ['type',      '<%='],
        ['statement', 'text_field'],
        ['constant', "'first_name'"],
        ['type',      '%>'],
    ],
    'helper "text_field"'
);

syntax_ok(
    "<%= text_area 'foo' %>",
    [   ['type',      '<%='],
        ['statement', 'text_area'],
        ['constant', "'foo'"],
        ['type',      '%>'],
    ],
    'helper "text_area"'
);
