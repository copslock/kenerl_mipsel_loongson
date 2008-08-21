Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 11:19:50 +0100 (BST)
Received: from ns2.suse.de ([195.135.220.15]:8088 "EHLO mx2.suse.de")
	by ftp.linux-mips.org with ESMTP id S20029719AbYHUKTl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Aug 2008 11:19:41 +0100
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7C8D745E68;
	Thu, 21 Aug 2008 12:19:40 +0200 (CEST)
Date:	Thu, 21 Aug 2008 12:19:40 +0200
Message-ID: <s5hr68ivfer.wl%tiwai@suse.de>
From:	Takashi Iwai <tiwai@suse.de>
To:	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
In-Reply-To: <1219255088.3258.45.camel@localhost.localdomain>
References: <s5hk5eezcfe.wl%tiwai@suse.de>
	<1219249633.3258.18.camel@localhost.localdomain>
	<s5hzln7vd9d.wl%tiwai@suse.de>
	<1219255088.3258.45.camel@localhost.localdomain>
User-Agent: Wanderlust/2.12.0 (Your Wildest Dreams) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.7 (=?ISO-8859-4?Q?Sanj=F2?=) APEL/10.6 Emacs/22.2
 (x86_64-suse-linux-gnu) MULE/5.0 (SAKAKI)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

At Wed, 20 Aug 2008 12:58:08 -0500,
James Bottomley wrote:
> 
> On Wed, 2008-08-20 at 18:53 +0200, Takashi Iwai wrote:
> > > I'm afraid there are several problems.  The first is that it doesn't do
> > > what you want.  You can't map a coherent page to userspace (which is at
> > > a non congruent address on parisc) and still expect it to be
> > > coherent ... there's going to have to be fiddling with the page table
> > > caches to make sure coherency isn't destroyed by aliasing effects
> > 
> > Hmm...  how bad would be the coherency with such a simple mmap method?
> > In most cases, we don't need the "perfect" coherency.  Usually one
> > process mmaps the whole buffer and keep reading/writing.  There is
> > another use case (sharing the mmapped buffer by multiple processes),
> > but this can be disabled if we know it's not feasible beforehand.
> 
> Unfortunately, the incoherency is between the user and the kernel.
> That's where the aliasing effects occur, so realistically, even though
> you've mapped coherent memory to the user, the coherency of that memory
> is only device <-> kernel.  When the any single user space process
> writes to it, the device won't see the write unless the user issues a
> flush.

I see.  In the case of ALSA mmap mode, a user issues an ioctl to
notify after the read/write access, so it'd be relatively easy to add
a sync operation.

Does the call of dma_sync_*_for_device() suffice for that purpose?

(BTW, how does the fb driver work on this?)


Thanks!

Takashi
