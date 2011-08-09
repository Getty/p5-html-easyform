package HTML::EasyForm::Field::Password;
# ABSTRACT: Hidden field

use Moose;
extends 'HTML::EasyForm::Field';

has '+widget' => (
	default => sub { 'password' },
);

1;