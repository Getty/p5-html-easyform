package HTML::EasyForm::Trait::Field;
# ABSTRACT: Trait for all Fields for the wrapping of HTML::FormHandler

use Moose::Role;

has template => (
	isa => 'Str',
	is => 'rw',
	lazy => 1,
	default => sub {
		my $self = shift;
		return 'form/widget/'.($self->widget).'.tt'
	},
);

has addlabel => (
	isa => 'Str',
	is => 'rw',
);

has full => (
	isa => 'Bool',
	is => 'rw',
	lazy => 1,
	default => sub {
		my $self = shift;
		return 1 if $self->can('is_compound') && $self->is_compound;
		return 1 if $self->widget eq 'hidden';
		return 0;
	},
);

1;