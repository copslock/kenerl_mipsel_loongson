Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3UI3XwJ025548
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Apr 2002 11:03:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3UI3Xeh025547
	for linux-mips-outgoing; Tue, 30 Apr 2002 11:03:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3UI3QwJ025544
	for <linux-mips@oss.sgi.com>; Tue, 30 Apr 2002 11:03:27 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA32743;
	Tue, 30 Apr 2002 11:03:03 -0700
Message-ID: <3CCEDC94.B668649E@mvista.com>
Date: Tue, 30 Apr 2002 12:04:04 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: ps2 keyboard -- no key down events
References: <Pine.GSO.3.96.1020424194125.23744D-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Wed, 24 Apr 2002, Michael Pruznick wrote:
> 
> > I'm working on this mips board with a smsc 90e66 south bridge and
> > fdc37m812 super io.  I'm using the standard pc_keyb.c driver.  I only
> > see keyboard interrupts and KBD_STAT_OBF set in response to "key up"
> > events.  I never see them in response to "key down" events.  Thus, the
> > shell running on the vga console never gets my input (since it is the
> > "key down" events that pass the character typed to the shell).
> >
> > At this point, I'm thinking that the standard driver needs some mods
> > to work with the super io's ps2 controller.  The smsc doc only covers
> > programming the plug and play registers and doesn't give any info about
> > programming the ps2 controller.
> 
>  An 8042-compatible microcontroller (actually the firmware it runs) may
> need to be programmed to a PC/AT-compatible mode.  On an i386 it is
> typically done by the BIOS.  Try dumping configuration data from your chip
> and compare it with what is set up in an i386 system.  You can dump 32
> bytes of configuration data with the 0x20 command of the 8042 (5 low-order
> bits of a command byte specify an address).  Writing can be performed
> using the 0x60 command (the same semantics).
> 
>  Some data is available in the Ralf Brown's interrupt list (look for
> "inter60*.zip" files on a SimTel DOS collection's mirror).  I have an old
> Intel hardcopy document somewhere that describes to some extent the
> IBM-defined locations of the configuration data -- I may try to dig it out
> and see if I could help you.  Anyway, you should probably contact the
> chip's manufacturer.
Thanks, that seams to be the issue or at least part of it.  I dumped
offset 0x20-0x3f on several systems.  All gave different results.
Some helped, some did not.  In the case of the ones that helped, all
the keys I tried (alpha,num,symbol) worked, until I pressed a shift,
control, or alt key, in which case the keyboard was stuck sending
the shifted value of all keys.  I sent a message to the chip
manufacturer, waiting for their response.  In all cases, the mouse
doesn't work and enabling the mouse via "gpm -t ps2 -m /dev/mouse"
or "od -tx1 -w1 /dev/mouse" causes the keyboard to stop sending
scancodes (on key up or key down).


-- 
Michael Pruznick, michael_pruznick@mvista.com, www.mvista.com
MontaVista Software, 1237 East Arques Ave, Sunnyvale, CA 94085
direct voice/fax:970-266-1108, main office:408-328-9200
