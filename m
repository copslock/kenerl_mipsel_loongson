Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2007 17:14:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:41723 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021544AbXFXQOz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 24 Jun 2007 17:14:55 +0100
Received: from localhost (p5214-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.214])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 99582A725; Mon, 25 Jun 2007 01:14:50 +0900 (JST)
Date:	Mon, 25 Jun 2007 01:15:33 +0900 (JST)
Message-Id: <20070625.011533.108738339.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, david-b@pacbell.net,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH] TXx9 SPI controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200706221103.19761.david-b@pacbell.net>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
	<200706221103.19761.david-b@pacbell.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 22 Jun 2007 11:03:18 -0700, David Brownell <david-b@pacbell.net> wrote:
> > +	if (res->start >= TXX9_DIRECTMAP_BASE)
> > +		c->membase = (void __iomem *)(unsigned long)(int)res->start;
> > +	else {
> > +		c->membase = ioremap(res->start, res->end - res->start + 1);
> > +		c->mapped = 1;
> > +	}
> 
> That looks plain wrong.  Maybe it reflects a platform-level bug,
> but ioremap(res->start) should Just Work even when it performs
> an identity mapping on a given system.  Remove this ugly code.
> Always map.

Ralf, (as I said some time ago) TX39XX and TX49XX have "reserved"
segment in CKSEG3 area.  0xff000000-0xff3fffff on TX49XX and
0xff000000-0xfffeffff on TX39XX are reserved (unmapped, uncached).
Controllers on these SoCs are placed in this segment.

If ioremap()/iounmap() could handle these special case, I can remove
this hack in this driver.

Is something like this acceptable?

include/asm-mips/io.h:
static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
	unsigned long flags)
{
	void __iomem *addr = plat_ioremap(offset, size, flags);
	if (addr)
		return addr;
	...
}

static inline void iounmap(const volatile void __iomem *addr)
{
	if (plat_iounmap(addr))
		returnl
	...
}

include/asm-mips/mach-generic/ioremap.h:
static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
	unsigned long flags)
{
	return NULL;
}

static inline int plat_iounmap(const volatile void __iomem *addr)
{
	return 0;
}

---
Atsushi Nemoto
