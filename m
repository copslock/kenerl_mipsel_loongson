Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 14:54:18 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:65229 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021840AbXDRNyR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 14:54:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3IDsE5F023189;
	Wed, 18 Apr 2007 14:54:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3IDsCN8023188;
	Wed, 18 Apr 2007 14:54:12 +0100
Date:	Wed, 18 Apr 2007 14:54:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com, perex@suse.cz, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 16/16] alsa sound support for mips
Message-ID: <20070418135412.GG3938@linux-mips.org>
References: <11766507661684-git-send-email-tiansm@lemote.com> <117665076617-git-send-email-tiansm@lemote.com> <1176650766907-git-send-email-tiansm@lemote.com> <11766507663301-git-send-email-tiansm@lemote.com> <11766507663039-git-send-email-tiansm@lemote.com> <1176650766685-git-send-email-tiansm@lemote.com> <11766507661790-git-send-email-tiansm@lemote.com> <11766507672298-git-send-email-tiansm@lemote.com> <11766507672043-git-send-email-tiansm@lemote.com> <11766507674145-git-send-email-tiansm@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11766507674145-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 15, 2007 at 11:26:05PM +0800, tiansm@lemote.com wrote:

(Adding a few more people to the cc'list)

>  sound/core/pcm_native.c |   10 ++++++++++
>  sound/core/sgbuf.c      |    9 +++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 3e276fc..9005bac 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3145,7 +3145,11 @@ static struct page *snd_pcm_mmap_data_nopage(struct vm_area_struct *area,
>  			return NOPAGE_OOM; /* XXX: is this really due to OOM? */
>  	} else {
>  		vaddr = runtime->dma_area + offset;
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)

Please use CONFIG_MIPS instead of __mips__ in #if / #ifdefs.

The question if #ifdefing is the right approach to solve this problem is
something else but I think no, ....

> +		page = virt_to_page(CAC_ADDR(vaddr));
> +#else
>  		page = virt_to_page(vaddr);
> +#endif

So this is needed because the MIPS virt_to_page is returning a unsuitable
value if vaddress is not a KSEG0 (64-bit: cached XKPHYS) address which is
what GFP allocations and the slab will return.  So now we have to deciede
if

 a) the MIPS __pa() should be changed to handle uncached addresses.
 b) the sound code here is simply broken.

Some drivers seem to allocate runtime->dma_area from vmalloc, so this
whole area in the sound code is looking like built on quicksand ...

>  	}
>  	get_page(page);
>  	if (type)
> @@ -3261,6 +3265,12 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
>  	substream = pcm_file->substream;
>  	snd_assert(substream != NULL, return -ENXIO);
>  
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +	/* all mmap using uncached mode */
> +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
> +	area->vm_flags |= ( VM_RESERVED | VM_IO);

VM_RESERVED will prevent the buffer from being freed.  I assume that is
another workaround for some kernel subsystem blowing up when being fed a
pointer to an uncached RAM address?  This smells like a memory leak.

> +#endif
> +
>  	offset = area->vm_pgoff << PAGE_SHIFT;
>  	switch (offset) {
>  	case SNDRV_PCM_MMAP_OFFSET_STATUS:
> diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
> index cefd228..535f0bc 100644
> --- a/sound/core/sgbuf.c
> +++ b/sound/core/sgbuf.c
> @@ -91,12 +91,21 @@ void *snd_malloc_sgbuf_pages(struct device *device,
>  		}
>  		sgbuf->table[i].buf = tmpb.area;
>  		sgbuf->table[i].addr = tmpb.addr;
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +		sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));

VM_RESERVED will prevent the buffer from being freed.  I assume that is
another workaround for some kernel subsystem blowing up when being fed a
pointer to an uncached RAM address?  This smells like a memory leak.

> +#else
>  		sgbuf->page_table[i] = virt_to_page(tmpb.area);
> +#endif
>  		sgbuf->pages++;
>  	}
>  
>  	sgbuf->size = size;
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +	/* maybe we should use uncached accelerated mode */
> +	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP | VM_IO, pgprot_noncached(PAGE_KERNEL));
> +#else
>  	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
> +#endif

I would suggest to get rid of this ifdef with a new arch-specific function
like vmap_io_buffer which will do whatever a platform seems fit for this
case?

>  	if (! dmab->area)
>  		goto _failed;
>  	return dmab->area;

  Ralf
