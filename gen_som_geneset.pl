
######################
# input data/parameter
$somsize=7;
$expression_datafile="SRP010262.som";
$genesetfile="geneset.tsv";
$somdir="demo_result";


##############################################
#####   No change below   ####################
##############################################
##############################################

open FILE,"$expression_datafile" or die "no data file exists...";   # data file
%ref=();
$line=<FILE>;
while ($line=<FILE>){
	chomp $line;
	@t=split '\t',$line;
	$ref{$t[0]}=$t[1];
}
close FILE;

###
open FILE,"$somdir/bmus.txt";
%geneset=();
while ($line=<FILE>){
	chomp $line;
	@t=split '\t',$line;
	$cell="$t[1]"."_$t[2]";
	$gene=$ref{$t[0]};
	if (exists $geneset{$cell}){
		$geneset{$cell}.="\t$gene";
	}else{
		$geneset{$cell}="$gene";
	}
}
close FILE;

# print out
open NEW,"> $genesetfile" or "die";
foreach $i (1..$somsize){
	foreach $j (1..$somsize){
		$cell="$i"."_$j";
		print NEW "$i"."_$j\t$geneset{$cell}\n";
	}

}

