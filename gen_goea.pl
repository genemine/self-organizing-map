#!/usr/bin/perl

$somsize=7;
$genesetfile="geneset.tsv";
$outputdir="goea";system "mkdir -p $outputdir";

# construct gene list clustered in each cell of the SOM map;
open FILE,$genesetfile or die "cannot open the geneset file";
$line=<FILE>;
%som=();
while ($line=<FILE>){
	chomp $line;
	@t=split '\t',$line;
	$cell=shift @t;
	foreach $gene (@t){
		if (exists $som{$cell}){
			$som{$cell}.=",$gene";
		}else{
			$som{$cell}=$gene;
		}
	}
}
close FILE;

# Perform GOEA 
@ksom=keys %som;
foreach (@ksom){
	$genelist=$som{$_};
	$html="$outputdir/$_"."_goea.txt";
	system "java -cp /Users/hdl/apps/GoTermFinder  edu.princeton.cs.function.GoTermFinder.GoClient 15000 .05 $genelist>$html"
}

# remove GO terms with >1000 annotated genes
system "perl remove_emptybig_pathway.pl $outputdir $somsize";


