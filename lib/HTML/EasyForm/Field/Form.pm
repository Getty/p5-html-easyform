package HTML::EasyForm::Field::Form;
# ABSTRACT: Subform field implementation WORK IN PROGRESS DON'T USE

use Moose;
extends 'Form::DemonCore::Field::Form';

with qw(
	HTML::EasyForm::FieldRole
);

has '+full' => (
	default => sub { 1 },
);

has '+widget' => (
	default => sub { 'form' },
);

1;