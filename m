Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 14:57:12 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:42652 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225073AbTE0N5K>;
	Tue, 27 May 2003 14:57:10 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4RDv0LT028158;
	Tue, 27 May 2003 15:57:01 +0200 (MEST)
Date: Tue, 27 May 2003 15:57:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <Pine.GSO.3.96.1030527154004.24408D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0305271552430.29405-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 May 2003, Maciej W. Rozycki wrote:
> On Tue, 27 May 2003, Geert Uytterhoeven wrote:
> > >  Hmm, as I've understood that's a 2.4-only problem as 2.5 has it solved
> > > differently.  And I do think the translation really belong to the drivers
> > > that use it -- why can't it be included with the USB keyboard driver or as
> > > a library file?  Why an unrelated driver has to be cluttered? 
> > 
> > It's not really used by a driver, but by the input subsystem itself. You could
> > add the translation to drivers/char/keyboard.c, but then it will break if you
> > use both the input subsystem (e.g. USB keyboard) and some other non-PS/2
> > keyboard driver.
> 
>  I don't understand -- the scancode mapping is specific to a keyboard
> type.  Both PC/AT and USB keyboards may use the same scancodes by chance,
> but others have different ones.  So how can the input subsystem need a
> PC/AT specific mapping?  Adding the table to drivers/char/keyboard.c
> certainly makes no sense as the file is meant to be generic. 

Scancode mapping is indeed specific to the keyboard type.

However, the input subsystem converts Linux input keycodes (cfr.
<linux/input.h>) to PC/AT scancodes, and feeds them to handle_scancode() in
drivers/char/keyboard.c. handle_scancode() calls kbd_translate() to translate
scancodes to keycodes, which is keyboard driver specific.

Since the input subsystem feeds PC/AT scancodes to handle_scancode(),
kbd_translate() needs to know about PC/AT scancodes. For the PS/2 keyboard
driver this is OK, for the dummy keyboard driver this is OK after my patch, but
for any other keyboard driver this will not work.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
