package HTML::EasyForm::Field::Datetime;
# ABSTRACT: DateTime field

use Moose;
extends 'HTML::EasyForm::Field';

use DateTime::Format::RFC3339;

has '+widget' => (
	default => sub { 'datetime' },
);

sub input_to_value {
	my ( $self ) = @_;
	$self->value(DateTime::Format::RFC3339->new->parse_datetime($self->input_value));
}

sub value_to_output {
	my ( $self ) = @_;
	$self->output_value(DateTime::Format::RFC3339->new->format_datetime($self->value));
}

1;