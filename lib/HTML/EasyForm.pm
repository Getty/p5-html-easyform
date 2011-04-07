package HTML::EasyForm;
# ABSTRACT: A wrapper for HTML::FormHandler, trying to be a different default handling

use Moose;
extends 'HTML::FormHandler';

use File::Spec;
use File::ShareDir;

sub template_dir {
	my $class = shift;
	my ($volume, $directory, $file) = File::Spec->splitpath( File::Spec->rel2abs(__FILE__) );
	my $devdir = File::Spec->catfile( $volume, $directory, File::Spec->updir(), File::Spec->updir(), 'share', 'templates' );
	return $devdir if -d $devdir;
	my $dir = File::ShareDir::dist_dir('HTML-EasyForm');
	return File::Spec->catfile( $dir, 'templates' ) if $dir;
}

has '+name' => (
	default => sub {
		my $self = shift;
		my $name = lc(ref $self);
		$name =~ s!::!_!g;
		my $form_id = $self->form_id;
		return $name.$form_id;
	},
);

has form_id => (
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

In your template (suggesting the form is assigned as B<form>):

  <@ PROCESS form.tt @>

or:

  <@ PROCESS form.tt form=myform @>  

=cut
