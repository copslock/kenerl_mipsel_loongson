Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 14:24:02 +0100 (CET)
Received: from [195.0.45.172] ([195.0.45.172]:60412 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S1122123AbSKUNYB>;
	Thu, 21 Nov 2002 14:24:01 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA04697;
	Thu, 21 Nov 2002 14:23:12 +0100 (MET)
Date: Thu, 21 Nov 2002 14:23:13 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [RFT] DEC SCSI driver clean-up
In-Reply-To: <Pine.GSO.3.96.1021121134955.24541B-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0211211422360.18129-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 21 Nov 2002, Maciej W. Rozycki wrote:
>  Following is a patch that removes SCp.have_data_in references -- the
> member is initialized by the NCR53C9x.c core and by the dec_esp.c
> front-end, but used by neither.  I believe it's some leftover cruft from
> the days there were no front-ends -- it's actually used by esp.c.  There
> are a few less significant clean-ups here and there as well. 

BTW, it's also used by jazz_esp, oktagon_esp, and sun3_exp (the last 2 are
m68k).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
