Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 09:19:58 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:64948 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225201AbTA0JT5>;
	Mon, 27 Jan 2003 09:19:57 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA09196;
	Mon, 27 Jan 2003 10:19:25 +0100 (MET)
Date: Mon, 27 Jan 2003 10:19:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vivien Chappelier <vivienc@nerim.net>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sigset_t32 broken?
In-Reply-To: <Pine.LNX.4.21.0301270135210.3253-100000@melkor>
Message-ID: <Pine.GSO.4.21.0301271019030.6130-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Jan 2003, Vivien Chappelier wrote:

> On Fri, 24 Jan 2003, Ralf Baechle wrote:
> > Most of what your patch does is undoing an accidental commit of a signal
> > rework that wasn't yet supposed to go out.
> 
> Maybe.. but current version is still wrong :) The type of the sig
> array in the 32-bit compatibility struct sigset_t32 must be 32bit long,
> i.e. unsigned int not unsigned long.
> And I think unsigned describes the data better than signed, but that's a
> matter of taste :) (coherent with the choice in asm-mips/signal.h).

Why not make it u32?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
