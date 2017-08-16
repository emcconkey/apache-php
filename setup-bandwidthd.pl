#!/usr/bin/perl

# Update the bandwidthd config file with the correct IP subnets on startup
$subnets=`ip route show | grep -v ^default`;

$subnet_list = "";
foreach(split(/\n/,$subnets)) {
	@line = split(/ /, $_);
	$subnet_list = $subnet_list . "subnet @line[0] \n";
}

$file = "/etc/bandwidthd/bandwidthd.conf.orig";

open my $input, '<', $file or die "can't open $file: $!";
$filedata = "";
while (<$input>) {
    $filedata = $filedata . $_;
}
close $input or die "can't close $file: $!";

$filedata =~ s/IP_SUBNET/$subnet_list/g;
print $filedata;
