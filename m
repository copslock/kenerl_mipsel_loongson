Received:  by oss.sgi.com id <S553951AbRAaHPq>;
	Tue, 30 Jan 2001 23:15:46 -0800
Received: from mail.sonytel.be ([193.74.243.200]:42651 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553743AbRAaHPh>;
	Tue, 30 Jan 2001 23:15:37 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA03102;
	Wed, 31 Jan 2001 08:15:13 +0100 (MET)
Date:   Wed, 31 Jan 2001 08:15:13 +0100 (MET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux/MIPS Development <linux-mips@oss.sgi.com>
cc:     Sam Creasey <sammy@oh.verio.com>
Subject: sonic driver for 2.4.0-test10-pre5 (fwd)
Message-ID: <Pine.GSO.4.10.10101310812580.27884-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


When cleaning up my patchqueue I noticed this patch also contains some fixes
(e.g. netif_*() updates) for the Olivetti M700-10 Risc PC sonic driver
(sonic.c). Probably this driver is in bad shape anyway, since it's not
mentioned in drivers/net/Makefile?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

---------- Forwarded message ----------
Date: Tue, 31 Oct 2000 21:39:26 -0500 (EST)
From: Creasey <sammy@oh.verio.com>
To: linux-m68k@lists.linux-m68k.org
Subject: sonic driver for 2.4.0-test10-pre5
Resent-Date: Wed, 1 Nov 2000 03:38:19 +0100 (MET)
Resent-From: linux-m68k@phil.uni-sb.de




I've got the onboard sonic in my Centris 610 working in geert's kernel...

This patch is only known to work for machines with 32bit dma transfer, and
it definatlely won't work on machines which had the sonic registers at an
offset.

ftp://sammy.net/pub/m68k/patches/linux-2.4.0-test10-pre5-sonic.diff.gz

Enjoy.




"UN-altered REPRODUCTION and DISSEMINATION of this IMPORTANT
Information is ENCOURAGED, ESPECIALLY to COMPUTER BULLETIN BOARDS."
	-- Robert E. McElwaine
