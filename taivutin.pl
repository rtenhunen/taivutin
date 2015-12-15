# ! usr/bin/env perl
# Rainer, 2014-06-06

# Kiitokset J.Korpelalle http://www.cs.tut.fi/~jkorpela/kielenopas/8.3.html

use warnings;
use strict;
use Getopt::Long;

my $VOKAALI = "aeiouyäö";
my $KONSONANTTI = "bcdfghjklmnpqrstvwxz";

my ($sana, $help);
GetOptions (
	's|sana=s'	=> \$sana,

	'h|help|?'		=> \$help,
) or die "Use -?, -h or --help for instructions.\n";

$sana = "satu";

unless ($sana) {
	die "You need to feed a word! $!\n";
}



print genetiivi($sana)."\n";


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# TO-DO
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# t -> d 	lahti -> lahden
# i -> e + logiikka tiili -> tiilen, tuppi -> tupen, lumi -> lumen, onni -> onnen, nuoli -> nuolen, kivi -> kiven, veri -> veren, suvi -> suven
#		Mutta ei: tuoli -> tuolin, muumi -> muumin, mummi -> mummin, passi -> passin, timjami -> timjamin, 
#
# astevaihtelu:
# h -> hk	pyyhe -> pyyhkeen, nahka -> nahan
# hk -> h 	uhka -> uhan, 
# urgh:
# 	impi -> immen
# 	into -> innon
# 	mies -> miehen, paras -> parhaan
#	parta -> parran, kanta -> kannan
#	kaavin -> kaapimen
# 	Klaus -> Klausin, MUTTA Justus -> Justuksen

# VOWEL HARMONY / vokaaliharmonia
# If the word does not have any of the vowels a, o or u the ending or the suffix cannot have those vowels either.






sub genetiivi {
	my $__sana__ = $_[0];
	#my @_vokaali = ["a", "e", "i", "o", "u", "y", "ä", "ö"];
	#my @_konsonantti = ["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","z"];
	my @_sana = split("",$__sana__);
	my $VSSA = quotemeta "$VOKAALI";
	my $KSSA = quotemeta "$KONSONANTTI";

	my ($_sanani, $_vokaaliPaate, $_erisnimi, $_erikoissana);

	my %_erikoissanat = (
		"mies" => "miehen",
		"olut" => "oluen",
		"ruis" => "rukiin",
		"tuhat" => "tuhannen",
		"veli" => "veljen",
	);

	if (exists $_erikoissanat{$__sana__}) {
		$_erikoissana = 1;
		$_sanani = $_erikoissanat{$__sana__};

	} elsif ($_sana[-1] =~ m/[$VSSA]/) {
		$_vokaaliPaate	= 1;

	}

	if ($_sana[0] =~ m{[A-Z]}) {
		# Jos ensimmäinen kirjain on iso kirjain niin sana on erisnimi
		$_erisnimi = 1;
	}
	
	if ($_vokaaliPaate) {

		if ($__sana__ =~ m/nk.$/) {
			# velaarinen nasaali "äng"
			# nk -> ng
			$_sana[-2] = "g";

		}

		if (!($_erisnimi) && ($_sana[-1] eq "i") && ($_sana[-2] !~ m/[kprs]/)) {
			# i -> e
			$_sana[-1] = "e";
		}

		if (join("",@_sana) =~ m/nto$/) {
			# -nto => -nnon

			splice(@_sana,-2,2);
			push(@_sana, "no");

		} elsif (($_sana[-2] =~ m/[$KSSA]/) && ($_sana[-3] =~ m/[$KSSA]/) && ($_sana[-3] eq $_sana[-2]) && ($_sana[-3] !~ /[lnrs]/i)) {
			# kaksois-konsonantti yhdeksi, paitsi jos l,n,r,s,  	esim, reppu -> repun
			splice(@_sana,-2,1);

		} elsif (($_sana[-2] eq "t") && ($_sana[-2] ne $_sana[-3]) && !($_erisnimi)) {
			# t -> d vaihtelu
			$_sana[-2] = "d";

		}

		$_sanani = join("",@_sana)."n";
		

	} elsif (!$_erikoissana) {
		if ($__sana__ =~ m/as$/) {
			# -as => -aan, 	uljas, armas, avulias

			splice(@_sana,-1,1);
			push(@_sana, "an");
			$_sanani = join("",@_sana);

		} elsif ($__sana__ =~ m/is$/) {
			# -is -> -iin, 	aulis, 
			splice(@_sana,-1,1);
			push(@_sana, "in");
			$_sanani = join("",@_sana);

		} elsif (($_sana[-1] eq "s") && ($_sana[-2] =~ m/[$VSSA]/)) {
			# S-pääte, 	-s => -ksen

			splice(@_sana,-1,1);
			push(@_sana, "ksen");
			$_sanani = join("",@_sana);

		} elsif ($__sana__ =~ m{nen$}) {
			# -nen => -sen

			splice(@_sana,-3,3);
			push(@_sana, "sen");
			$_sanani = join("",@_sana);

		} elsif ($__sana__ =~ /in$/) {
			# -in -> -imen, esim. avain -> avaimen

			splice(@_sana, -2, 2);
			
			if ($_sana[-1] =~ /[kpt]/) { # kahdenna kovat konsonantit
				push(@_sana,$_sana[-1]);
			} elsif ($_sana[-1] =~ /[h]/) { # astevaihtelu
				push(@_sana,"k");
			} elsif ($_sana[-1] =~ /[d]/) { # astevaihtelu'
				splice(@_sana, -1, 1);
				push(@_sana,"t");
			}

			
			push(@_sana, "imen");
			$_sanani = join("",@_sana);



		} else {
			# yleisarvaus konsonanttipäätteisille 	=> -in 
			$_sanani = join("",@_sana)."in";

		}


	}
	return $_sanani;

}