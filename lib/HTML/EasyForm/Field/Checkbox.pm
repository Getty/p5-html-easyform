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

sub input_to_value {
	my ( $self ) = @_;
	$self->value($self->input_value eq $self->checkbox_value ? 1 : 0);
}

sub value_to_output {
	my ( $self ) = @_;
	$self->output_value($self->value);
}

sub notempty { 0 }
sub required { 0 }

1;