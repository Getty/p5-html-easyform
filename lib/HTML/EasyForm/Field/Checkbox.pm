package HTML::EasyForm::Field::Checkbox;
# ABSTRACT: Checkbox

use Moose;
extends 'HTML::EasyForm::Field';

has '+widget' => (
	default => sub { 'checkbox' },
);

has checkbox_value => (
	isa => 'Str',
	is => 'ro',
	default => sub { 'checkbox_is_checked_and_selected' },
);

1;