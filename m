Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 20:36:10 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:8607 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225395AbTJ1UgI>;
	Tue, 28 Oct 2003 20:36:08 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h9SKa5QG003571;
	Tue, 28 Oct 2003 21:36:05 +0100 (MET)
Date: Tue, 28 Oct 2003 21:36:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Unresolved symbols
In-Reply-To: <Pine.GSO.4.44.0310281308450.20592-100000@ares.mmc.atmel.com>
Message-ID: <Pine.GSO.4.21.0310282135290.10351-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2003, David Kesselring wrote:
> I've been unabled to track down these errors. I think it's because I don't
> understand how some of the linux h files are used by an independently
> compiled kernel module. Why is "extern __inline__" used in a file like
> atomic.h.

`extern inline' is wrong, and should be replaced by `static inline', which is
work-in-progress.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
