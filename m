Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 15:39:01 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:61107 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTFQOi6>;
	Tue, 17 Jun 2003 15:38:58 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5HEcepI023224;
	Tue, 17 Jun 2003 16:38:40 +0200 (MEST)
Date: Tue, 17 Jun 2003 16:38:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ladislav Michl <ladis@linux-mips.org>,
	Juan Quintela <quintela@trasno.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <Pine.GSO.3.96.1030617155734.22214I-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0306171637390.17930-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Maciej W. Rozycki wrote:
> On Tue, 17 Jun 2003, Ladislav Michl wrote:
> > >  There is also that minor implementation problem -- how to pass varargs
> > > from printk() to ROM's printf()?  At least the firmware of the DECstation
> > > implements a full-featured printf() as in the C library.
> > 
> > you are implementing early console not printf (sorry again for confusion),
> > so there is no need to pass varargs anywhere. btw, early_printk() as known
> > from other archs is supposed to die in future. printk() should be used
> > everywhere.
> 
>  Hmm, calling the firmware for each character separately will certainly be
> terribly slow, though it may be negligible as normally few messages will
> be output this way.  And since the call to prom_printf() is so cheap for
> the DECstation, I'm going to retain the function for real low-level
> debugging, whether otherwise used or not. 

kernel/printk.c doesn't call the low-level output routine for each character
separately, but passes complete strings of characters.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
