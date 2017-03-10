#!/usr/bin/perl

my $DELTA = 2;

while (my $url = <DATA>) {

	chomp($url);
	my $id = '';
	if ($url =~ m/\?v=([\d\w]+)/g) {
		$id = "$1";
	}
	
	print("Downloading $id...\n");
	system("youtube-dl -q --id -x --audio-format \"wav\" \"$url\"");
	my $name = "$id.wav";
	my $length = `soxi -D $name`;

	my $chunk = 0;
	print("Splitting $name...\n");
	for (my $place = 0; $place <= ($length - $DELTA);) {
		my $next = $place + $DELTA;
		system("sox $name $id-$chunk.wav trim $place $DELTA");
		$chunk++;
		$place = $next;
		print("*");
	}
	print("\n");

	system("rm $name");
	
}

__DATA__
https://www.youtube.com/watch?v=8H5PPAENMKI
https://www.youtube.com/watch?v=mrGm7yLUUNo
https://www.youtube.com/watch?v=Opf44zF1REQ
https://www.youtube.com/watch?v=HoQYI5KW84c
https://www.youtube.com/watch?v=0oA4tbp2VpA
https://www.youtube.com/watch?v=lPF-gbB-Atk
