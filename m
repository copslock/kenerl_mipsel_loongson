Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 13:09:50 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:7138 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225203AbUF2MJq>;
	Tue, 29 Jun 2004 13:09:46 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i5TC9bXK016761;
	Tue, 29 Jun 2004 14:09:37 +0200 (MEST)
Date: Tue, 29 Jun 2004 14:09:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 29 Jun 2004, Maciej W. Rozycki wrote:
>  That's a bit troublesome for the Malta board which has both a pair of
> PC-compatible serial ports which are expected to be lines 0 and 1 and an
> Atlas serial port, which is expected to be line 2.  The Atlas port on the
> Malta board isn't handled by Linux right now, but I plan to fix it.  Are
> there systems that have both PC-compatible ports and system-specific ones
> and expect them to be mapped in the reverse order?

The NEC DDB Vrc-5074 (and probably the other DDB variants as well) has one
serial port in the Nile 4 host bridge, and 2 serial ports in the Super I/O.

To me it sounds the most logical if the one in the Nile 4 is ttyS0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
