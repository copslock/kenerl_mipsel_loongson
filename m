Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2CAI6g06339
	for linux-mips-outgoing; Tue, 12 Mar 2002 02:18:06 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2CAI0906336
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 02:18:00 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA10928;
	Tue, 12 Mar 2002 10:17:39 +0100 (MET)
Date: Tue, 12 Mar 2002 10:17:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Gerald Champagne <gerald.champagne@esstech.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: pci config cycles on VRC-5477
In-Reply-To: <3C8D2E89.10001@mvista.com>
Message-ID: <Pine.GSO.4.21.0203121013530.23527-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Mar 2002, Jun Sun wrote:
> Gerald Champagne wrote:
> > I'm studying the VRC-5477 code and I'm trying to understand how pci config
> > cycles can work reliably with the current code.  It looks like the pci
> > config code must execute with interrupts disabled, but I can't find code
> > that disables interrupts.  Can someone offer a few pointers?  Here's why
> > I ask...
> > 
> > All pci io, memory, and config accesses on the 5477 are performed through
> > two windows in the cpu address space.  Normally these two windows are 
> > configured
> > to perform pci memory and io accesses, and any driver can access pci io and
> > memory at any time.  In order to perform a pci config access, one of the 
> > two
> > windows must be remapped to perform pci config cycles.  The code in
> > read_config_dword() looks something like this:
> > 
> > - Call ddb_access_config_base() to reconfigure the window into pci 
> > memory space
> >   to access pci config space instead.
> > 
> > - Read from pci config space by reading from an offset into the window.
> > 
> > - Call ddb_close_config_base to restore the registers to the original 
> > values.
> > 
> > It looks like anything can interrupt this an try to perform a pci memory
> > access while the window is programmed to perfom config cycles.
> > 
> > Did I miss something, or is this a bug?
> 
> Your understanding is correct.  I think this is a bug.
> 
> Do you actually see the bug happening?  So far it has never hit me, but maybe 
> due to the drivers that are loaded on my configuration.

(IIRC) When I wrote the Vrc-5074 support, I thought about this as well.
But then I noticed that this was already done by the upper PCI layer. Is this
still true?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
