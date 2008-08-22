Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 15:43:59 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:46720 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28588341AbYHVOnw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 15:43:52 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KWXrh-0007dg-00; Fri, 22 Aug 2008 16:43:49 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 50DCEC3F6F; Fri, 22 Aug 2008 16:36:22 +0200 (CEST)
Date:	Fri, 22 Aug 2008 16:36:22 +0200
To:	Takashi Iwai <tiwai@suse.de>
Cc:	ralf@linux-mips.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-mips@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
Message-ID: <20080822143622.GA8413@alpha.franken.de>
References: <s5hzln7vd9d.wl%tiwai@suse.de> <1219255088.3258.45.camel@localhost.localdomain> <s5hr68ivfer.wl%tiwai@suse.de> <1219326912.3265.2.camel@localhost.localdomain> <s5hhc9enyqa.wl%tiwai@suse.de> <s5hfxoynyn4.wl%tiwai@suse.de> <20080821214118.GA12516@alpha.franken.de> <s5hbpzl8tvz.wl%tiwai@suse.de> <20080822094131.GA6717@alpha.franken.de> <s5h7ia9nya3.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7ia9nya3.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Aug 22, 2008 at 12:23:48PM +0200, Takashi Iwai wrote:
> 	unsigned long prot = pgprot_val(_prot) & ~_CACHE_MASK;
> #ifdef CONFIG_SGI_IP32
> #ifdef CONFIG_CPU_R10000
> 	prot = prot | _CACHE_UNCACHED_ACCELERATED;
> #else
> 	prot = prot | _CACHE_CACHABLE_NO_WA;
> #endif
> #else
> 	prot = prot | _CACHE_UNCACHED;
> #endif
> 	return __pgprot(prot);

this won't work for recording channels on IP32, because the write trough
mapping will hide updates done via DMA.

I'd start with just

prot |= _CACHE_UNCACHED

and if some MIPS system needs more specific treatment, we just add
that later.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
