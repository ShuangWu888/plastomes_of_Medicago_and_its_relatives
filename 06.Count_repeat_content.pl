#!usr/bin/perl -w
use warnings;
use strict;
use Bio::SeqIO;

my ($file,$out)=@ARGV;

open (W,"<$file") || die($!);
my $len=0; my $n=0;
my $all=Bio::SeqIO->new(-file=>$file,-format=>'fasta');
while(my $seq=$all->next_seq){
    my $id=$seq->id;
    my $seq=$seq->seq;
    my $length=length($seq);
    my @tem=split(//,$seq);
    foreach my $i (@tem){
          $n++ if ("$i"eq"N");
      }
    $len +=$length;
}
close W;

my $prop=($n/$len)*100;

open (Y,">$out") || die($!);
$file=~/(.*)\.merged.fa/;
my $key=$1;
print Y "$key\t$len\t$n\t$prop\n";
close Y;
