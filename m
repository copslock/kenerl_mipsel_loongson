Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 15:59:14 +0100 (CET)
Received: from mail2.sonytel.be ([195.0.45.172]:46756 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S1122123AbSKUO7O>;
	Thu, 21 Nov 2002 15:59:14 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA13666;
	Thu, 21 Nov 2002 15:59:03 +0100 (MET)
Date: Thu, 21 Nov 2002 15:59:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	tsbogend@alpha.franken.de
Subject: Re: [RFT] DEC SCSI driver clean-up
In-Reply-To: <20021121153748.C26919@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0211211557560.18129-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 21 Nov 2002, Ralf Baechle wrote:
> On Thu, Nov 21, 2002 at 02:23:13PM +0100, Geert Uytterhoeven wrote:
> > BTW, it's also used by jazz_esp, oktagon_esp, and sun3_exp (the last 2 are
> > m68k).
> 
> Thomas has unfortunately stopped maintaining the Jazz support so this is
> probably pretty broken by now.  Nobody left who cares about Jazz, that's

Yes, it definitely doesn't work, since SCSI_JAZZ_ESP isn't used at all in
jazz_esp.c (noticed while moving the SCSI host template initializers from the
header files to the source files).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
