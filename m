Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 21:34:42 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:27122 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225074AbUGWUei>;
	Fri, 23 Jul 2004 21:34:38 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i6NKYZXK023323;
	Fri, 23 Jul 2004 22:34:35 +0200 (MEST)
Date: Fri, 23 Jul 2004 22:34:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Srinivas Kommu <kommu@hotmail.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: mips32 kernel memory mapping
In-Reply-To: <20040723202439.GA3711@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0407232233430.13094@waterleaf.sonytel.be>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com>
 <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl> <20040723202439.GA3711@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 Jul 2004, Ralf Baechle wrote:
> There are still improvments to be made for BCM1250 support.  Somebody
> thought scattering the first 1GB of memory through the lowest 4GB of
> physical address space like a three year old his toys over the floor
> was a good thing ...  The resulting holes in the memory map are wasting
> significant amounts of memory for unused memory; the worst case number
> that is reached for 64-bit kernel on a system with > 1GB of RAM is 96MB!

Perhaps you want to start using virtually mapped zones, like m68k?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
