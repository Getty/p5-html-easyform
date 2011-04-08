package HTML::EasyForm;
# ABSTRACT: A wrapper for HTML::FormHandler, trying to be a different default handling

use Moose;
extends 'HTML::FormHandler';

use File::Spec;
use File::ShareDir::ProjectDistDir;

sub template_dir { File::Spec->rel2abs( File::Spec->catfile( dist_dir('HTML-EasyForm'), 'templates' ) ) };

sub easy {
	my $class = shift;
	my %args;
	%args = %{$_[0]} if (@_ == 1);
	%args = @_ if (@_ > 1);
	die __PACKAGE__." needs params" if !defined $args{params};
	# my %process;
	# my $params = delete $args{params};
	# $process{params} = $params if $params;
	# my $action = delete $args{action};
	# $process{action} = $action if $action;
	# my $item = delete $args{item};
	# $process{item} = $item if $item;
	# my $item_id = delete $args{item_id};
	# $process{item_id} = $item_id if $item_id;
	my $form = $class->new(\%args);
	$form->is_submitted($args{params}->{$form->name} ? 1 : 0);
	if (!$form->is_submitted && $form->has_params) {
		$_->check_params for ($form->all_fields);
	}
	$form->process;
	return $form;
}

sub validated {
	my $self = shift;
	return $self->next::method(@_) if ($self->is_submitted);
	return 0;
}

has vertical_cell => (
	isa => 'Bool',
	is => 'rw',
	default => sub { 0 },
);

has is_submitted => (
	isa => 'Bool',
	is => 'rw',
	default => sub { 0 },
);

has template => (
	isa => 'Str',
	is => 'rw',
	lazy => 1,
	default => sub { 'form.tt' },
);

has '+name' => (
	default => sub {
		my $self = shift;
		my $name = lc(ref $self);
		$name =~ s!::!_!g;
		my $form_id = $self->fid;
		return $name.$form_id;
	},
);

has fid => (
	isa => 'Str',
	is => 'ro',
	lazy => 1,
	default => sub {''},
);

has '+html_prefix' => (
	default => sub { 1 },
);

has '+widget_name_space' => (
	default => sub {[qw(
		HTML::EasyForm::Widget
	)]},
);

has '+field_name_space' => (
	default => sub {[qw(
		HTML::EasyForm::Field
	)]},
);

has '+field_traits' => (
	default => sub {[qw(
		HTML::EasyForm::Trait::Field
	)]},
);

1;

=encoding utf8

=head1 SYNOPSIS

In your L<Template::Toolkit> configuration:

  use HTML::EasyForm;

  ...
  INCLUDE_PATH => [
    MyApp->path_to('templates'),
    HTML::EasyForm->template_dir,
  ],
  ...

Your formclass:

  package MyApp::Form::Mini;

  use HTML::FormHandler::Moose;
  extends 'HTML::EasyForm';

  has_field 'name' => ( type => 'Text', required => 1 );

  1;

In your favorite web framework:

  my $form = MyApp::Form::Mini->easy({
    action => $c->uri_for($c->action,$c->req->captures),
    params => $c->req->parameters,
  });

  if ($form->validated) {
    ... do stuff with $form->value ...
  }

  my $other_form = HTML::EasyForm->easy({
    name => 'my_custom_form',
    fid => $some_id_per_usage,
    action => $c->uri_for($c->action,$c->req->captures),
    params => $c->req->parameters,
    item => \%values,
    field_list => [
      field_one => {
        type => 'Text',
        required => 1
      },
      field_two => 'Text',
    ],
  });

In your template (suggesting the form is assigned as B<form>):

  <@ PROCESS form.tt @>

or:

  <@ PROCESS form.tt form=other_form @>  

=cut
