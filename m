Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 14:30:08 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:59381 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225073AbTE0NaG>;
	Tue, 27 May 2003 14:30:06 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4RDTrLT024409;
	Tue, 27 May 2003 15:29:53 +0200 (MEST)
Date: Tue, 27 May 2003 15:29:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <Pine.GSO.3.96.1030527150418.24408B-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0305271521210.29405-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 May 2003, Maciej W. Rozycki wrote:
> On Tue, 27 May 2003, Ralf Baechle wrote:
> > >  Hmm, if the PC/AT keyboard translation is needed by other devices beside
> > > pc_keyb.c, then why isn't the common part put into a separate file to be
> > > used by all devices depending on this translation as needed?  I think
> > > dummy_keyb.c should be kept plain and simple as it is now. 
> > 
> > You're right but for 2.4 this looks like an acceptable solution for now so
> > I'm going to apply this until somebody comes up with a better solution.
> 
>  Hmm, as I've understood that's a 2.4-only problem as 2.5 has it solved
> differently.  And I do think the translation really belong to the drivers
> that use it -- why can't it be included with the USB keyboard driver or as
> a library file?  Why an unrelated driver has to be cluttered? 

It's not really used by a driver, but by the input subsystem itself. You could
add the translation to drivers/char/keyboard.c, but then it will break if you
use both the input subsystem (e.g. USB keyboard) and some other non-PS/2
keyboard driver.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
