Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 09:46:25 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:39673 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225464AbUGHIqV>;
	Thu, 8 Jul 2004 09:46:21 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i688kJXK023575;
	Thu, 8 Jul 2004 10:46:19 +0200 (MEST)
Date: Thu, 8 Jul 2004 10:46:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS getdomainname() off by 1;
In-Reply-To: <20040708004951.GA17045@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0407081045470.12221@waterleaf.sonytel.be>
References: <20040531202101.4ace5e95.rddunlap@osdl.org>
 <20040708004951.GA17045@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 Jul 2004, Ralf Baechle wrote:
> On Mon, May 31, 2004 at 08:21:01PM -0700, Randy.Dunlap wrote:
> > irix_getdomainname() max size appears to be off by 1;
> > other similar code in kernel uses __NEW_UTS_LEN as the max size,
> > and <domainname> includes an extra byte for the terminating
> > null character.
> >
> > Does sysirix.c need to limit <len> to 63 instead of 64 for some
> > reason?
>
> I would know why - and it has other bugs also, so I removed it by the
> normal Linux getdomainname(2) for SysV flavour syscalls, too.

I saw you even removed it from 2.0. Woow! ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
