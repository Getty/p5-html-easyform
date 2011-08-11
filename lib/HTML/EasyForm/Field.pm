package HTML::EasyForm::Field;
# ABSTRACT: Base field implementation

use Moose;
extends 'Form::DemonCore::Field';

with qw(
	HTML::EasyForm::FieldRole
);

1;