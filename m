Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 15:15:31 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:11427 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWOP2>;
	Fri, 23 May 2003 15:15:28 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NEEtLT009020;
	Fri, 23 May 2003 16:14:57 +0200 (MEST)
Date: Fri, 23 May 2003 16:15:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Vojtech Pavlik <vojtech@suse.cz>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <Pine.GSO.3.96.1030523155904.14542E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0305231609021.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 May 2003, Maciej W. Rozycki wrote:
> On Fri, 23 May 2003, Geert Uytterhoeven wrote:
> > This patch fixes the arrow keys (and all other keys that generate E0/E1
> > scancode prefixes on AT keyboards) by adding support for E0/E1 scancode
> > prefixes to the dummy keyboard driver if CONFIG_INPUT=y.
> > 
> > Rationale: When using the new input layer (i.e. with a USB keyboard or a custom
> > input device), the input layer relies on kbd_translate() in the low-level
> > keyboard driver to convert from AT-style scancodes to keycodes. If you don't
> > have a PS/2 keyboard interface and don't compile in the PS/2 keyboard driver,
> > you have to enable the dummy keyboard driver, which naively assumes that
> > keycodes and scancodes are interchangeable. This is correct if you do not have
> > a keyboard, but fails for prefixed scancodes if you do have a keyboard which
> > uses the new input layer.
> 
>  Hmm, if the PC/AT keyboard translation is needed by other devices beside
> pc_keyb.c, then why isn't the common part put into a separate file to be
> used by all devices depending on this translation as needed?  I think
> dummy_keyb.c should be kept plain and simple as it is now. 

In 2.5.x it's (probably) that way. In 2.4.x the input layer is more like a hack
to get USB working. On PCs, you always compile in both PS/2 keyboard and USB
keyboard support, so it always works. The dummy_keyb.c is used on MIPS only.
BTW, I forgot to mention: I just copied what the PPC guys do on PowerMac, cfr.
drivers/macintosh/mac_hid.c.

But it indeed makes sense to move kbd_translate() into the input layer itself.
Vojtech, what do you think?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
