package HTML::EasyForm::Field::Hidden;
# ABSTRACT: Hidden field

use Moose;
extends 'HTML::EasyForm::Field';

has '+widget' => (
	default => sub { 'hidden' },
);

has '+full' => (
	default => sub { 1 },
);

1;