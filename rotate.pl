#!/usr/local/bin/perl -w

# Test Tk::PhotoRotate and Tk::PhotoRotateSimple.

use Tk;
use Tk::PhotoRotate;
use strict;

my $angle = 45;
my $sample = "Icon.gif";
my $update = 0;

my $mw = MainWindow->new;

my $im = $mw->Photo(-file => $sample);
my $im2 = $mw->Photo;
$im2->copy($im);

my $c = $mw->Canvas(qw/-bg white -height 160 -width 350/)->pack(qw/-fill both -expand 1/);
$c->createImage(qw/50  90 -image/ => $im);
$c->createImage(qw/170 90 -image/ => $im2);

my $e = $c->Entry(-textvariable => \$angle, -width => 4);
$c->createWindow(5, 5, -window => $e, -anchor => 'nw');

my $cb = $c->Checkbutton(-text => 'Update', -variable => \$update);
$c->createWindow(40, 5, -window => $cb, -anchor => 'nw');

$e->bind('<Return>' => sub {
    $im2->configure(-width => $im->width, -height => $im->height);
    $im2->copy($im);
    my $t0 = Tk::timeofday;

    $im2->rotate($angle, $update);

    my $t  = Tk::timeofday;
    $mw->title(sprintf("%f seconds", $t - $t0));
});

MainLoop;
