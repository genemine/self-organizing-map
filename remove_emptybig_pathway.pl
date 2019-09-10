$goeadir=$ARGV[0];  # GOEA data
$dim=$ARGV[1];  # dimension of SOM map


@all=glob "$goeadir/*txt";
foreach $file (@all){
	open FILE,$file or die "cannot open the GOEA file";
	@nline=<FILE>;
	if (scalar @nline>=1){
		open TMP,">tmp.tmp" or die "cannot create a new file";
		open FILE,$file;
		while ($line=<FILE>){
			@t=split '\t',$line;
			if ($t[6] < 500){
				print TMP $line;
			}	

		}
		close FILE;
		close TMP;
		 	
		open TMP,"tmp.tmp";
		@lines=<TMP>;
		print scalar @lines," enriched GO terms with size < 500\n";
		if (scalar @lines>=1){
			system "mv tmp.tmp $file";
		}else{
			system "rm $file";
		}	
		
	}else{
		system "rm $file"
	}


}
