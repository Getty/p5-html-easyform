package HTML::EasyForm::Field::Textarea;
# ABSTRACT: Textarea field

use Moose;
extends 'HTML::EasyForm::Field';

has '+widget' => (
	default => sub { 'textarea' },
);

has cols => (
	isa => 'Int',
	is => 'rw',
	predicate => 'has_cols',
);

has rows => (
	isa => 'Int',
	is => 'rw',
	predicate => 'has_rows',
);

1;