Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 18:24:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:3023 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021941AbXD1RY2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 18:24:28 +0100
Received: from localhost (p7147-ipad204funabasi.chiba.ocn.ne.jp [222.146.94.147])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2C8B5B5E5; Sun, 29 Apr 2007 02:24:25 +0900 (JST)
Date:	Sun, 29 Apr 2007 02:24:28 +0900 (JST)
Message-Id: <20070429.022428.71103613.anemo@mba.ocn.ne.jp>
To:	jeff@garzik.org
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] ne: MIPS: Use platform_driver for ne on RBTX49XX
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <463363ED.3050307@garzik.org>
References: <20070425.015549.108742168.anemo@mba.ocn.ne.jp>
	<463363ED.3050307@garzik.org>
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
X-archive-position: 14943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 28 Apr 2007 11:10:37 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> >  static unsigned int netcard_portlist[] __initdata = {
> > -	0x300, 0x280, 0x320, 0x340, 0x360, 0x380, 0
> > +#if defined(CONFIG_ISA) || defined(CONFIG_M32R)
> > +	0x300, 0x280, 0x320, 0x340, 0x360, 0x380,
> > +#endif
> > +	0
> 
> This looks a bit strange, and perhaps more difficult to maintain long term.
> 
> I would suggest creating a NEEDS_PORTLIST cpp macro at the top of ne.c, 
> to be defined or undefined based on CONFIG_xxx symbols.  Then, down in 
> the code itself, conditionally include or exclude all portlist related 
> data tables and code.
> 
> Sound sane?

Sure.  Do you mean something like this?


#if !defined(MODULE) && (defined(CONFIG_ISA) || defined(CONFIG_M32R))
#define NEEDS_PORTLIST
#endif
...
#ifdef NEEDS_PORTLIST
static unsigned int netcard_portlist[] __initdata = {
	0x300, 0x280, 0x320, 0x340, 0x360, 0x380, 0
};
#endif
...
#ifdef NEEDS_PORTLIST
	int orig_irq = dev->irq;
#endif
...
#ifdef NEEDS_PORTLIST
	/* Last resort. The semi-risky ISA auto-probe. */
	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
		int ioaddr = netcard_portlist[base_addr];
		dev->irq = orig_irq;
		if (ne_probe1(dev, ioaddr) == 0)
			return 0;
	}
#endif

---
Atsushi Nemoto
