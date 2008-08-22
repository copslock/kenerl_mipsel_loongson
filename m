Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 10:42:15 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:62688 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20035387AbYHVJmH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 10:42:07 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KWT9h-0005yg-00; Fri, 22 Aug 2008 11:42:05 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 52C12C3F15; Fri, 22 Aug 2008 11:41:31 +0200 (CEST)
Date:	Fri, 22 Aug 2008 11:41:31 +0200
To:	Takashi Iwai <tiwai@suse.de>
Cc:	ralf@linux-mips.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-mips@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
Message-ID: <20080822094131.GA6717@alpha.franken.de>
References: <s5hk5eezcfe.wl%tiwai@suse.de> <1219249633.3258.18.camel@localhost.localdomain> <s5hzln7vd9d.wl%tiwai@suse.de> <1219255088.3258.45.camel@localhost.localdomain> <s5hr68ivfer.wl%tiwai@suse.de> <1219326912.3265.2.camel@localhost.localdomain> <s5hhc9enyqa.wl%tiwai@suse.de> <s5hfxoynyn4.wl%tiwai@suse.de> <20080821214118.GA12516@alpha.franken.de> <s5hbpzl8tvz.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbpzl8tvz.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Aug 22, 2008 at 08:07:44AM +0200, Takashi Iwai wrote:
> I don't think that this must work for *every* platform, too, and it's
> not expected from the driver.  The systems without uncached memory
> access can simply return an error from  dma_mmap_coherent() call, so
> that the driver can disable the mmap.  That'd be enough.

true, I've used snd_pcm_indirect for HAL2 driver, which works even on
SGI IP28 machines.

> Now, how to handle these exceptions: a question comes into my mind
> again -- how does the framebuffer handle these as well?

most framebuffers have a dedicated set of video memory and this memory is
just mmaped uncached either via TLB/MMU (MIPS) or rules inside
the system (PARISC uses IO space memory, which is always uncached). 
The code which does this mmaping is in drivers/video/fbmem.c plus
fb_pgprotect out of an include/asm header file. 

For framebuffers without dedicated video memory the memory is mmaped
write through or uncached. A driver, which uses this, is 
drivers/video/gbefb.c.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
