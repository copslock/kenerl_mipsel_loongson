Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 14:55:30 +0100 (BST)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:21951 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S28585679AbYHUNzX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 14:55:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 7089280BA;
	Thu, 21 Aug 2008 08:55:15 -0500 (CDT)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7BGwt0RW3UE; Thu, 21 Aug 2008 08:55:14 -0500 (CDT)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id A5C4F806E;
	Thu, 21 Aug 2008 08:55:13 -0500 (CDT)
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
In-Reply-To: <s5hr68ivfer.wl%tiwai@suse.de>
References: <s5hk5eezcfe.wl%tiwai@suse.de>
	 <1219249633.3258.18.camel@localhost.localdomain>
	 <s5hzln7vd9d.wl%tiwai@suse.de>
	 <1219255088.3258.45.camel@localhost.localdomain>
	 <s5hr68ivfer.wl%tiwai@suse.de>
Content-Type: text/plain
Date:	Thu, 21 Aug 2008 08:55:12 -0500
Message-Id: <1219326912.3265.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Thu, 2008-08-21 at 12:19 +0200, Takashi Iwai wrote:
> At Wed, 20 Aug 2008 12:58:08 -0500,
> James Bottomley wrote:
> > 
> > On Wed, 2008-08-20 at 18:53 +0200, Takashi Iwai wrote:
> > > > I'm afraid there are several problems.  The first is that it doesn't do
> > > > what you want.  You can't map a coherent page to userspace (which is at
> > > > a non congruent address on parisc) and still expect it to be
> > > > coherent ... there's going to have to be fiddling with the page table
> > > > caches to make sure coherency isn't destroyed by aliasing effects
> > > 
> > > Hmm...  how bad would be the coherency with such a simple mmap method?
> > > In most cases, we don't need the "perfect" coherency.  Usually one
> > > process mmaps the whole buffer and keep reading/writing.  There is
> > > another use case (sharing the mmapped buffer by multiple processes),
> > > but this can be disabled if we know it's not feasible beforehand.
> > 
> > Unfortunately, the incoherency is between the user and the kernel.
> > That's where the aliasing effects occur, so realistically, even though
> > you've mapped coherent memory to the user, the coherency of that memory
> > is only device <-> kernel.  When the any single user space process
> > writes to it, the device won't see the write unless the user issues a
> > flush.
> 
> I see.  In the case of ALSA mmap mode, a user issues an ioctl to
> notify after the read/write access, so it'd be relatively easy to add
> a sync operation.
> 
> Does the call of dma_sync_*_for_device() suffice for that purpose?

No ... dma_sync_* sync's from the kernel to the device ... you don't
need that if the memory is already coherent.

The problem is that the data you want the device to see is held in a
cache above the user space mapping ... it's that cache that has to be
flushed (i.e. you need to flush through the user mappings, not through
the kernel ones).

> (BTW, how does the fb driver work on this?)

It sets the shared page to uncached on all its mappings.  Turning off
caching (assuming the platform can do it ... not all can) is a good way
to eliminate aliasing issues.

James
