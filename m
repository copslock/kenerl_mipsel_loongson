Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ONcRwJ001782
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 16:38:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ONcRrJ001781
	for linux-mips-outgoing; Wed, 24 Apr 2002 16:38:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ONcDwJ001778
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 16:38:14 -0700
Received: (qmail 16664 invoked from network); 24 Apr 2002 23:38:39 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 24 Apr 2002 23:38:39 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 30E6D3000BA; Thu, 25 Apr 2002 09:38:37 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 183CF94; Thu, 25 Apr 2002 09:38:37 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Updates for RedHat 7.1/mips 
In-reply-to: Your message of "Wed, 24 Apr 2002 13:53:39 MST."
             <20020424135339.A24558@idiom.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Apr 2002 09:38:31 +1000
Message-ID: <30555.1019691511@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Apr 2002 13:53:39 -0700, 
Geoffrey Espin <espin@idiom.com> wrote:
>drivers/char/char.o(.data+0x3990): undefined reference to `local symbols in discarded section .text.exit'

Assuming that your kernel is up to date, it is likely to be a MIPS only
char driver that has not been converted to __devexit_p.  Run this
script to find the offending driver and correct the source code.

#!/usr/bin/perl -w
#
# reference_discarded.pl (C) Keith Owens 2001 <kaos@ocs.com.au>
#
# List dangling references to vmlinux discarded sections.

use strict;
die($0 . " takes no arguments\n") if($#ARGV >= 0);

my %object;
my $object;
my $line;
my $ignore;

$| = 1;

printf("Finding objects, ");
open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
while (defined($line = <OBJDUMP_LIST>)) {
	chomp($line);
	if ($line =~ /:\s+file format/) {
		($object = $line) =~ s/:.*//;
		$object{$object}->{'module'} = 0;
		$object{$object}->{'size'} = 0;
		$object{$object}->{'off'} = 0;
	}
	if ($line =~ /^\s*\d+\s+\.modinfo\s+/) {
		$object{$object}->{'module'} = 1;
	}
	if ($line =~ /^\s*\d+\s+\.comment\s+/) {
		($object{$object}->{'size'}, $object{$object}->{'off'}) = (split(' ', $line))[2,5]; 
	}
}
close(OBJDUMP_LIST);
printf("%d objects, ", scalar keys(%object));
$ignore = 0;
foreach $object (keys(%object)) {
	if ($object{$object}->{'module'}) {
		++$ignore;
		delete($object{$object});
	}
}
printf("ignoring %d module(s)\n", $ignore);

# Ignore conglomerate objects, they have been built from multiple objects and we
# only care about the individual objects.  If an object has more than one GCC:
# string in the comment section then it is conglomerate.  This does not filter
# out conglomerates that consist of exactly one object, can't be helped.

printf("Finding conglomerates, ");
$ignore = 0;
foreach $object (keys(%object)) {
	if (exists($object{$object}->{'off'})) {
		my ($off, $size, $comment, $l);
		$off = hex($object{$object}->{'off'});
		$size = hex($object{$object}->{'size'});
		open(OBJECT, "<$object") || die "cannot read $object";
		seek(OBJECT, $off, 0) || die "seek to $off in $object failed";
		$l = read(OBJECT, $comment, $size);
		die "read $size bytes from $object .comment failed" if ($l != $size);
		close(OBJECT);
		if ($comment =~ /GCC\:.*GCC\:/m) {
			++$ignore;
			delete($object{$object});
		}
	}
}
printf("ignoring %d conglomerate(s)\n", $ignore);

printf("Scanning objects\n");
foreach $object (keys(%object)) {
	my $from;
	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
	while (defined($line = <OBJDUMP>)) {
		chomp($line);
		if ($line =~ /RELOCATION RECORDS FOR /) {
			($from = $line) =~ s/.*\[([^]]*).*/$1/;
		}
		if (($line =~ /\.text\.exit$/ ||
		     $line =~ /\.data\.exit$/ ||
		     $line =~ /\.exitcall\.exit$/) &&
		    ($from !~ /\.text\.exit$/ &&
		     $from !~ /\.data\.exit$/ &&
		     $from !~ /\.exitcall\.exit$/)) {
			printf("Error: %s %s refers to %s\n", $object, $from, $line);
		}
	}
	close(OBJDUMP);
}
printf("Done\n");
