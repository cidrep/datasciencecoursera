# /usr/bin/perl -w
# Author and Developer - Michael W. Craige
# September 19, 2006
# File Name: multifasta2phylip.pl (fasta2phylip)
#
# ********************************************************************************
# Bio-Perl Script to convert aligned Multi-Fasta Sequences to Phylip File Formats
# Based on the BIO::SeqIO::fasta and the Bio::AlighIO objects/modules
# ********************************************************************************
#
$VERSION='1.00';
# USAGE: Execute in directory containing folders with multi-fasta files
($dirs.phylogeny_multi_fasta.out)
#
# Input Files:
# Multi_Fasta Sequence - ".phylogeny_multi_fasta.out" data in fasta format.
#
# Output Files:
# Sequence data files in Phylip format - "$firs.phylogeny_multi_fasta.phy"
#
# *********************************************************************************
# Define variables and Environment
# *********************************************************************************
#
use strict;
use warnings;
use Bio::AlignIO;
use Bio::SeqIO;
my ($count);
my ($dir);
my $file = shift;
my (@fasta_file, $fasta_file_loop, @data_directories, $data_dir_number, $dirname);
#
# ********************************************************************************
# Print Working Directory
# ********************************************************************************
#
print ("\n");
print "Working Directory: "; system ("pwd");
print ("\n");
#
# ********************************************************************************
# Count the number of folders containing multi fast files
# ********************************************************************************
@data_directories = glob("[0-9]*");
$data_dir_number = ($#data_directories + 1);
if ($data_dir_number == 0)
{
die "WARNING: $data_dir_number data directories found!
Please check folders. Closing this program. \n\n"; 
}
print "Detected $data_dir_number data folders\n\n";
#
# *******************************************************************************
# Check for files in folder above with suffix ".out"
# *******************************************************************************
#
print ("starting to process $data_dir_numnber folders\n\n");
#
# Loop over and move into all working directories
foreach my $dirs (@data_directories) {
chdir ("$dirs");
print "Processing Folders: "; system ("pwd");
opendir (DIR, ".") || die "Could not open directory";
my @files = grep (/\.out$/, readdir(DIR));
$count = @files;
closedir(DIR);
if ($count == 0) {
print "\n$count ", "", "multi fasta file found in working directory\n";
print "Was not able to find '*.out' file(s)in data folder\n\n";

	exit;
	}
		else
	{
print " \n$count ", "", " fasta files foind in working folder\n";
	}

# ******************************************************************************
# Converting multi-fasta files to Phylip format (.out files)
# ******************************************************************************
#
print "\nConverting Multi FASTA Files to PHYLIP File Format.......please wait.\n\n";

my #in = Bio::AlignIO->new('-file' => "$dirs.phylogeny_multi_fasta.out",
			'-format' => 'fasta'
	) || die "Software aborted, unable to find target file.\n";

my $out = Bio::AlignIO->new('-file' => ">" . "$dirs" . ".phylogeny.phy",
			'-format' => 'phylip'
	) || die "Software stopped, unable to create PHYLIP file. \n";

while ( my $aln = $in->next_aln()) {
$out->write_aln($aln); system ("sleep 5"); print "\......nDONE!\n\n"; chdir ("..");}
}
system ("clear");
print "\nAll Multi-Fasta Files Converted Successfully. Please Check Working Directory For Phylip Files (*.phy)\n";
#
# *******************************************************************************
#	Version 1.0 (september 19, 2006)
#	- initial release date
#	- Michael Craige
# *******************************************************************************
