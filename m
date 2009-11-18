Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 15:21:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59950 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493498AbZKROV1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Nov 2009 15:21:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAIELOnZ017394;
	Wed, 18 Nov 2009 15:21:25 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAIEKuEB017374;
	Wed, 18 Nov 2009 15:20:56 +0100
Date:	Wed, 18 Nov 2009 15:20:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Wu Zhangjin <wuzj@lemote.com>
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
Message-ID: <20091118142056.GB6615@linux-mips.org>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com> <s5hd43iiebt.wl%tiwai@suse.de> <20091116174324.GA17748@linux-mips.org> <s5hhbst4hzt.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hhbst4hzt.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 10:29:10AM +0100, Takashi Iwai wrote:

> > > Actually, this has been a looong-standing problem.
> > > I have a series of patches to fix these issues, but it's more
> > > intensively involved with dma_*() functions.
> > > 
> > > The patches can be found in test/dma-fix branch of sound GIT tree.
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git test/dma-fix
> > > 
> > > This basically adds dma_mmap_coherent() function to feasible
> > > architectures, which is already implemented for ARM, so far.
> > 
> > Cool - but needs a little further tweaking to work right.  That's a
> > solution which will use uncached accesses on all MIPS systems.
> > 
> > IP27/IP35-family machines will explode when you try that.  Eventually the
> > cache coherency logic will notice that cache, directory caches and memory
> > have become inconsistent and bombard the CPU with a bunch of nasty
> > exceptions.
> 
> OK, that's really bad.

Hardware designers do such things to you.  Often even for a reason.

> > For cache-coherent machines otoh it's a big waste of performance.
> > 
> > int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> >                       void *cpu_addr, dma_addr_t handle, size_t size)
> > {
> >         struct page *pg;
> > 
> > 	if (!plat_device_is_coherent(dev))
> > 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >         cpu_addr = (void *)dma_addr_to_virt(handle);
> >         pg = virt_to_page(cpu_addr);
> > 
> >         return remap_pfn_range(vma, vma->vm_start,
> >                                page_to_pfn(pg) + vma->vm_pgoff,
> >                                size, vma->vm_page_prot);
> > }
> > EXPORT_SYMBOL(dma_mmap_coherent);
> > 
> > Thomas - you're the IP28 specialist.  Would the plat_device_is_coherent()
> > above have to become a cpu_is_noncoherent_r10000() call?  Any further
> > nasties?
> 
> Thanks for checking!

You're welcome!

So basically I'd not mind putting this into the Linux/MIPS tree; we still
can iron out the kinks from there on and probably much better than by
having arch stuff in the ALSA tree.

I recall this new API having been posted for discussion to linux-arch.
What was the outcome?  I'd only like to add a new API if the other arch
maintainers see it fit their needs also.

  Ralf
