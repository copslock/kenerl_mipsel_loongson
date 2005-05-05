Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 16:58:05 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:54013 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225002AbVEEP5k>;
	Thu, 5 May 2005 16:57:40 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j45FvZUu011027;
	Thu, 5 May 2005 17:57:35 +0200 (MEST)
Date:	Thu, 5 May 2005 17:57:33 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Alex Gonzalez <linux-mips@packetvision.com>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	TheNop@gmx.net
Subject: Re:
In-Reply-To: <20050505145508.GJ17119@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0505051757070.23697@numbat.sonytel.be>
References: <20050428191608Z8225923-1340+6320@linux-mips.org>
 <1115214949.13387.13.camel@euskadi.packetvision> <20050505145508.GJ17119@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 5 May 2005, Ralf Baechle wrote:
> On Wed, May 04, 2005 at 02:55:49PM +0100, Alex Gonzalez wrote:
> 
> > Do you need AGP support? My kernel is configured without it.
> 
> I'm not aware of any AGP bridge for MIPS systems.

And you cannot even select it, since it depends on ALPHA || IA64 || PPC || X86.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
