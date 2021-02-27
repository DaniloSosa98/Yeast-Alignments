#This code goes through a directory of Yeast Alignments and counts the
#CG bases in every Scer, Spar, Smik and Sbay in each file.
mkdir 'ProcessedGenes';     #make new directory to store the results
$dir = "YeastAlignments";   #the directory where the alignments are
opendir(DIR,$dir)or die "can't open directory $dir:$!";   #open directory
print"\n";
#These variables are to store the CG count in the current file
$scerCG = 0;
$sparCG = 0;
$smikCG = 0;
$sbayCG = 0;
#To use a one-liner regex we need to store the char to find it in a var.
$charC = "C";
$charG = "G";
#This while loop goes on as long as there are unopened files in the dir
while ($filename = readdir DIR){
  $ORFname = substr($filename, 0, 7);   #this stores the first 7 chars from the filename
  print "\nORF name: "."$ORFname\n";    #print the ORF name to console
  $filelocation = "./YeastAlignments/"."$filename";   #store the location of the current file
  if (length $ORFname == 7){
    open(INFILE, $filelocation) or die "Cannot open file";    #open file, if not open next
  }else {next;}
    open (OUTFILE, ">>"."./ProcessedGenes/".$ORFname) || die " could not open output file\n"; #open outfile to write
  #Since these vars store CG count of the current file, with every new
  #file we initialize them to 0
  $scerCG = 0;
  $sparCG = 0;
  $smikCG = 0;
  $sbayCG = 0;
  #This while loop goes through each line of the file
  while(<INFILE>){
    my $line = $_;                #store current line
    my @arr = split / /, $line;   #split the line with space deilimiter
    #This if statements check what is the first word of the line.
    #If it is one of the our headers, we use regex to count the ocurrences of
    #C and G in each sequence. Due to unknown issues with split, instead of the
    #sequence being in positin arr[1], the sequence is in postion arr[12].
    #Note that the /ig at the end of each regex means the search is case
    #insensitive and global.
    if($arr[0] eq "Scer"){
      $scerCG += () = $arr[12] =~ /$charC/ig;
      $scerCG += () = $arr[12] =~ /$charG/ig;
    } elsif($arr[0] eq "Spar") {
      $sparCG += () = $arr[12] =~ /$charC/ig;
      $sparCG += () = $arr[12] =~ /$charG/ig;
    } elsif($arr[0] eq "Smik") {
      $smikCG += () = $arr[12] =~ /$charC/ig;
      $smikCG += () = $arr[12] =~ /$charG/ig;
    } elsif($arr[0] eq "Sbay") {
      $sbayCG += () = $arr[12] =~ /$charC/ig;
      $sbayCG += () = $arr[12] =~ /$charG/ig;
    }
  }
  #Print results from currrent file to console and to the OUTFILE
  print "Scer CG count in "."$ORFname".":\t"."$scerCG\n";
  print "Spar CG count in "."$ORFname".":\t"."$sparCG\n";
  print "Smik CG count in "."$ORFname".":\t"."$smikCG\n";
  print "Sbay CG count in "."$ORFname".":\t"."$sbayCG\n";
  print OUTFILE "\nORF name: "."$ORFname\n";
  print OUTFILE "Scer CG count in "."$ORFname".":\t"."$scerCG\n";
  print OUTFILE "Spar CG count in "."$ORFname".":\t"."$sparCG\n";
  print OUTFILE "Smik CG count in "."$ORFname".":\t"."$smikCG\n";
  print OUTFILE "Sbay CG count in "."$ORFname".":\t"."$sbayCG\n";
  close OUTFILE;
  close INFILE;
  sleep(0.5);
}
print "\n\n";
exit;