Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OI5fwJ002466
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 11:05:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OI5f9P002465
	for linux-mips-outgoing; Wed, 24 Apr 2002 11:05:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OI5ZwJ002462
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 11:05:36 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA25301;
	Wed, 24 Apr 2002 20:06:21 +0200 (MET DST)
Date: Wed, 24 Apr 2002 20:06:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Pruznick <michael_pruznick@mvista.com>
cc: linux-mips@oss.sgi.com
Subject: Re: ps2 keyboard -- no key down events
In-Reply-To: <3CC6CC21.45E7ABB1@mvista.com>
Message-ID: <Pine.GSO.3.96.1020424194125.23744D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Apr 2002, Michael Pruznick wrote:

> I'm working on this mips board with a smsc 90e66 south bridge and
> fdc37m812 super io.  I'm using the standard pc_keyb.c driver.  I only
> see keyboard interrupts and KBD_STAT_OBF set in response to "key up"
> events.  I never see them in response to "key down" events.  Thus, the
> shell running on the vga console never gets my input (since it is the
> "key down" events that pass the character typed to the shell).
> 
> At this point, I'm thinking that the standard driver needs some mods
> to work with the super io's ps2 controller.  The smsc doc only covers
> programming the plug and play registers and doesn't give any info about
> programming the ps2 controller.

 An 8042-compatible microcontroller (actually the firmware it runs) may
need to be programmed to a PC/AT-compatible mode.  On an i386 it is
typically done by the BIOS.  Try dumping configuration data from your chip
and compare it with what is set up in an i386 system.  You can dump 32
bytes of configuration data with the 0x20 command of the 8042 (5 low-order
bits of a command byte specify an address).  Writing can be performed
using the 0x60 command (the same semantics). 

 Some data is available in the Ralf Brown's interrupt list (look for
"inter60*.zip" files on a SimTel DOS collection's mirror).  I have an old
Intel hardcopy document somewhere that describes to some extent the
IBM-defined locations of the configuration data -- I may try to dig it out
and see if I could help you.  Anyway, you should probably contact the
chip's manufacturer.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
