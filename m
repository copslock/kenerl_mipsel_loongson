Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA90675 for <linux-archive@neteng.engr.sgi.com>; Thu, 21 Jan 1999 11:02:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA70299
	for linux-list;
	Thu, 21 Jan 1999 11:01:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA70345;
	Thu, 21 Jan 1999 11:01:51 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id LAA48236; Thu, 21 Jan 1999 11:01:50 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199901211901.LAA48236@oz.engr.sgi.com>
Subject: Re: mezzanine board
To: richard@infopact.nl (Richard Hartensveld)
Date: Thu, 21 Jan 1999 11:01:50 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <36A75138.3C924284@infopact.nl> from "Richard Hartensveld" at Jan 21, 99 08:09:29 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:
:Well, no hinv since i'm not running irix on the machine anymore (i boot  it
:over the network)
:

Here's an 'hinv' for linux written in perl

---- cut here ----

#!/usr/bin/perl -w

#
# hinv v 1.2
# Changes:
#	1.0 - 1.1
#	---------
#		Fri Nov 28 14:28:31 IST 1997
#	Added support for IDE disks -- Paul Danset (paul@oz.net), 
#		Fri Nov 28 14:39:30 IST 1997
#	Changed eth scanning routine to explicitely check for an
#	ethernet-style address in the line. -- Raju Mathur (raju@sgi.com)
#		Fri Nov 28 19:02:22 IST 1997
#	1.1-1.1a
#	--------
#	Small screw-up in the eth code fixed. Thanks, Thomas Gebhardt!
#	1.1a-1.2
#	--------
#		Mon Dec  1 12:06:55 IST 1997
#	Added support for sound devices. I've only checked this out on
#	a commercial OSS system, not with the built-in OSS/Linux/Free.
#	I'm no hotshot Perl programmer, so if the code looks ugly it's
#	your aesthetics which are to blame :-)
#					-- Raju Mathur (raju@sgi.com)
#
# Interim maintainer:	Raju Mathur (raju@sgi.com)
#
# Author:		Larry Mcvoy (Where art thou, Larry?) as per last
#			information received
#
# Try and emulate SGI's hinv command
# We want to figure out the following:
# CPU type, mhz, memory, busses, floppies, disks, tapes, cdroms, ttys,
# networks, graphics.

# indy ~ hinv
# Iris Audio Processor: version A2 revision 4.1.0
# 1 175 MHZ IP22 Processor
# FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
# CPU: MIPS R4400 Processor Chip Revision: 6.0
# On-board serial ports: 2
# On-board bi-directional parallel port
# Data cache size: 16 Kbytes
# Instruction cache size: 16 Kbytes
# Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
# Main memory size: 64 Mbytes
# Vino video: unit 0, revision 0
# Integral ISDN: Basic Rate Interface unit 0, revision 1.0
# XPI FDDI controller: xpi0, firmware version 9601221233, SAS
# Integral Ethernet: ec0, version 1
# Integral SCSI controller 0: Version WD33C93B, revision D
#  Disk drive: unit 2 on SCSI controller 0
#  Disk drive: unit 1 on SCSI controller 0
# Graphics board: Indy 24-bit

# i586 ~ hinv
# Main memory size: 24 Mbytes
# 1 GenuineIntel 586 processor
# 1 16450 serial port
# 2 16550A serial ports
# 1 post-1991 82077 floppy controller
# 1 1.44M floppy drive
# 1 vga+ graphics device
# 1 keyboard
# 2 ethernet interfaces
#   eth0: 3Com 3c595 Vortex 100baseTX
#   eth2: 3c509
# 1 SCSI tape 1 SCSI cdrom 2 SCSI disks
#   QUANTUM  EMPIRE_1080S
#   HP       C3725S
#   ARCHIVE  VIPER 150  21531
#   TOSHIBA  CD-ROM XM-3501TA
# Sound devices:
#   1 Audio device
#     Sound Blaster 16 (4.13)
#   1 Synth device
#     Yamaha OPL-3
#   1 Timer
#     System clock
#   1 Mixer
#     Sound Blaster
# PCI bus devices:
#    SCSI storage controller: NCR 53c810 (rev 2).
#    Ethernet controller: 3Com 3C595 100bTX (rev 0).
#    VGA compatible device: S3 Inc. Vision 964-P (rev 0).
#    IDE interface: Intel 82371 Triton PIIX (rev 2).
#    ISA bridge: Intel 82371 Triton PIIX (rev 2).
#    Host bridge: Intel 82437 (rev 2).

open(FD, "dmesg|") || die "no dmesg";
while (<FD>) {
        @_ = split;
        if (/^Memory:/) {
                $_[1] =~ s|.*/||;
                $_[1] =~ s|k$||;
                $_[1] /= 1024;
                $mem = "Main memory size: $_[1] Mbytes\n";
        } elsif (/^tty/) {
                $ttys{$_[$#_]}++;
        } elsif (/^Floppy/) {
                $floppy{$_[$#_]}++;
        } elsif (/^FDC /) {
                s/.*is a //;
                chop;
                $fdc{$_}++;
        } elsif (/^scsi : detected/) {
                $scsi = $_;
        } elsif (/^eth\d.* at .*:..:..:..:..:.*/) {
                s/\s*at .*//;
                push(@eth, $_);
        } elsif (/^hd[a-z].*, /) {
                s/\s*, .*//;
                push(@ide, $_);
        } 
}
open(FD, "/proc/cpuinfo");
while (<FD>) {
        @_ = split;
        if (/cpu/) {
                $cpu = $_[$#_];
        }
        if (/vendor/) {
                $cpus{"$_[$#_] $cpu"}++;
        }
}
open(FD, "/proc/ioports");
while (<FD>) {
        if (/kbd/) {
                $kbd++;
        } elsif (/vga/) {
                @_ = split;
                $graphics{$_[$#_]}++;
        }
}

print $mem if (defined $mem);
foreach $key (keys %cpus) {
        print "$cpus{$key} $key processor";
        print $cpus{$key} > 1 ? "s\n" : "\n";
}
foreach $key (keys %ttys) {
        print "$ttys{$key} $key serial port";
        print $ttys{$key} > 1 ? "s\n" : "\n";
}
foreach $key (keys %fdc) {
        print "$fdc{$key} $key floppy controller";
        print $fdc{$key} > 1 ? "s\n" : "\n";
}
foreach $key (keys %floppy) {
        print "$floppy{$key} $key floppy drive";
        print $floppy{$key} > 1 ? "s\n" : "\n";
}
foreach $key (keys %graphics) {
        print "$graphics{$key} $key graphics device";
        print $graphics{$key} > 1 ? "s\n" : "\n";
}
if (defined $kbd) {
        print "$kbd keyboard";
        print $kbd > 1 ? "s\n" : "\n";
}
if ($#ide > -1) {
        $n = $#ide + 1;
        print "$n IDE device";
        print $n > 1 ? "s\n" : "\n";
        foreach $ide (@ide) {
                print "  $ide";
        }
}
if ($#eth > -1) {
        $n = $#eth + 1;
        print "$n ethernet interface";
        print $n > 1 ? "s\n" : "\n";
        foreach $eth (@eth) {
                print "  $eth";
        }
}
if (defined $scsi) {
        $scsi =~ s/.*detected //;
        $scsi =~ s/ total.//;
        print $scsi;
        open(FD, "/proc/scsi/scsi");
        $_ = <FD>;
        while (<FD>) {
                next unless /Vendor/;
                s/.*Vendor:\s*//;
                s/\s*Rev:.*//;
                s/Model:\s*//;
                print "  $_";
        }
}
#
# Sound code added by Raju Mathur (raju@sgi.com)
#
if ( open ( FD , "/dev/sndstat" ) )
{
    $done = 0 ;
    while ( <FD> )
    {
	if ( ! $done )
	{
	    print "Sound devices:\n" ;
	    $nAudiodev = 0 ;
	    $nSynthdev = 0 ;
	    $nMIDIdev = 0 ;
	    $nTimer = 0 ;
	    $nMixer = 0 ;
	    $done = 1 ;
	}
	if ( /^Audio devices:/ )
	{
	    while ( <FD> )
	    {
		if ( /^$/ )
		{
		    goto break1 ;
		}
		s/^[0-9]*:\s*// ;
		push @Audiodev , $_ ;
		$nAudiodev++ ;
	    }
	  break1:
	}
	if ( /^Synth devices:/ )
	{
	    while ( <FD> )
	    {
		if ( /^$/ )
		{
		    goto break2 ;
		}
		s/^[0-9]*:\s*// ;
		push @Synthdev , $_ ;
		$nSynthdev++ ;
	    }
	  break2:
	}
	if ( /^Midi devices:/ )
	{
	    while ( <FD> )
	    {
		if ( /^$/ )
		{
		    goto break3 ;
		}
		s/^[0-9]*:\s*// ;
		push @MIDIdev , $_ ;
		$nMIDIdev++ ;
	    }
	  break3:
	}
	if ( /^Timers:/ )
	{
	    while ( <FD> )
	    {
		if ( /^$/ )
		{
		    goto break4 ;
		}
		s/^[0-9]*:\s*// ;
		push @Timer , $_ ;
		$nTimer++ ;
	    }
	  break4:
	}
	if ( /^Mixers:/ )
	{
	    while ( <FD> )
	    {
		if ( /^$/ )
		{
		    goto break5 ;
		}
		s/^[0-9]*:\s*// ;
		push @Mixer , $_ ;
		$nMixer++ ;
	    }
	  break5:
	}
    }
    if ( $nAudiodev )
    {
	printf "  %d Audio device%s\n" , $nAudiodev ,
		$nAudiodev > 1 ? "s" : "" ;
	while ( $val = shift @Audiodev )
	{
	    print "    $val" ;
	}
    }
    if ( $nSynthdev )
    {
	printf "  %d Synth device%s\n" , $nSynthdev ,
		$nSynthdev > 1 ? "s" : "" ;
	while ( $val = shift @Synthdev )
	{
	    print "    $val" ;
	}
    }
    if ( $nMIDIdev )
    {
	printf "  %d MIDI device%s\n" , $nMIDIdev ,
		$nMIDIdev > 1 ? "s" : "" ;
	while ( $val = shift @MIDIdev )
	{
	    print "    $val" ;
	}
    }
    if ( $nTimer )
    {
	printf ( "  %d Timer%s\n" , $nTimer , $nTimer > 1 ? "s" : "" ) ;
	while ( $val = shift @Timer )
	{
	    print "    $val" ;
	}
    }
    if ( $nMixer )
    {
	printf "  %d Mixer%s\n" , $nMixer , $nMixer > 1 ? "s" : "" ;
	while ( $val = shift @Mixer )
	{
	    print "    $val" ;
	}
    }
}

open(FD, "/proc/pci");
$done = 0;
while (<FD>) {
        if (/^\s*Bus/) {
                if ($done == 0) {
                        print "PCI bus devices:\n";
                        $done++;
                }
                $_ = <FD>;
                print;
        }
}
