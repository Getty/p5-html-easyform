package HTML::EasyForm::FieldRole;

use Moose::Role;

has full => (
	isa => 'Bool',
	is => 'rw',
	default => sub { 0 },
);

has class => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_html_class',
);

has id => (
	isa => 'Str',
	lazy => 1,
	is => 'ro',
	default => sub { shift->param_name },
);

has label => (
	is => 'rw',
	lazy => 1,
	default => sub { shift->name },
);

has widget => (
	is => 'rw',
	lazy => 1,
	default => sub { 'text' },
);

has style => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_style',
);

has template => (
	is => 'ro',
	isa => 'Str',
	lazy => 1,
	default => sub { 'form/widget/'.shift->widget },
);

has template_tt => (
	is => 'ro',
	isa => 'Str',
	lazy => 1,
	default => sub { shift->template.'.tt' },
);

1;