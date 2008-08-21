Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 11:21:13 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:64489
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20029407AbYHUKVD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Aug 2008 11:21:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7LAKs9D031107;
	Thu, 21 Aug 2008 11:20:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7LAKqxt031106;
	Thu, 21 Aug 2008 11:20:52 +0100
Date:	Thu, 21 Aug 2008 11:20:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:	Takashi Iwai <tiwai@suse.de>, linux-mips@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
Message-ID: <20080821102052.GA31001@linux-mips.org>
References: <s5hk5eezcfe.wl%tiwai@suse.de> <1219249633.3258.18.camel@localhost.localdomain> <s5hzln7vd9d.wl%tiwai@suse.de> <1219255088.3258.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1219255088.3258.45.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 20, 2008 at 12:58:08PM -0500, James Bottomley wrote:

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

Same applied on MIPS.  Some platforms have the additional requirement that
the buffer must not be mapped by the TLB during the DMA operation or bad
things could happen.

  Ralf
