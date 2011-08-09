package HTML::EasyForm;
# ABSTRACT: Using the demon core to deliver a HTML orientated form management concept

use Moose;
extends 'Form::DemonCore';

use File::Spec;
use File::ShareDir::ProjectDistDir;

sub template_tt_dir { File::Spec->rel2abs( File::Spec->catfile( dist_dir('HTML-EasyForm'), 'templates_tt' ) ) };

sub easy {
	my $class = shift;
	my %args;
	%args = %{$_[0]} if (@_ == 1);
	%args = @_ if (@_ > 1);
	die __PACKAGE__." needs params" if !defined $args{params};
	
}

has submit_label => (
	is => 'rw',
	lazy => 1,
	default => sub { 'Submit' },
);

has label => (
	is => 'rw',
	lazy => 1,
	default => sub { shift->name },
);

has class => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_class',
);

has style => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_style',
);

has action => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_action',
);

has method => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_method',
);

has enctype => (
	isa => 'Str',
	is => 'rw',
	predicate => 'has_enctype',
);

has id => (
	isa => 'Str',
	is => 'ro',
	lazy => 1,
	default => sub { shift->name },
);

sub _build_default_field_class { 'HTML::EasyForm::Field' }

has '+field_namespace' => (
	default => sub { 'HTML::EasyForm::Field' },
);

1;

=encoding utf8

=head1 SYNOPSIS

In your L<Template::Toolkit> configuration:

  use HTML::EasyForm;

  ...
  INCLUDE_PATH => [
    MyApp->path_to('templates'),
    HTML::EasyForm->template_tt_dir,
  ],
  ...

In your favorite web framework:

  $c->stash->{form} = HTML::EasyForm->easy({
    name => 'testform',
    fields => [
      {
        name => 'testfield',
        notempty => 1,
      },
    ],
    input_values => {
      testform => 1,
      testform_testfield => "test",
    },
	session => $c->session,
  });
  if (my $result = $c->stash->{form}->result) {
    ... do stuff with $result ...
  }

In your template (suggesting the form is assigned as B<form>):

  <@ PROCESS form.tt @>

or:

  <@ PROCESS form.tt form=other_form @>  

=head1 SUPPORT

IRC

  Join #demoncore on irc.perl.org.

Repository

  http://github.com/Getty/p5-html-easyform
  Pull request and additional contributors are welcome
 
Issue Tracker

  http://github.com/Getty/p5-html-easyform/issues

=cut