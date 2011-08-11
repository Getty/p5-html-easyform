package HTML::EasyForm::Field::Select;
# ABSTRACT: Select field

use Moose;
extends 'HTML::EasyForm::Field';

has '+widget' => (
	default => sub { 'select' },
);

has options => (
	isa => 'ArrayRef[HashRef]',
	is => 'ro',
	required => 1,
);

has multiple => (
	isa => 'Bool',
	is => 'ro',
	default => sub { 0 },
);

has size => (
	isa => 'Bool',
	is => 'ro',
	predicate => 'has_size',
);

1;