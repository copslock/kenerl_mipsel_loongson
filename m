Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:18:34 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11674 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025229AbZETWS2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:18:28 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1481a10000>; Wed, 20 May 2009 18:18:09 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 May 2009 15:18:13 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 May 2009 15:18:13 -0700
Message-ID: <4A1481A4.9060708@caviumnetworks.com>
Date:	Wed, 20 May 2009 15:18:12 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com, Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v1 23/27] Alsa memory maps fixup on mips systems
References: <cover.1242855716.git.wuzhangjin@gmail.com> <323881882e108383c0360bd6a1138801d9d47679.1242855716.git.wuzhangjin@gmail.com>
In-Reply-To: <323881882e108383c0360bd6a1138801d9d47679.1242855716.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2009 22:18:13.0285 (UTC) FILETIME=[DD997D50:01C9D998]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

wuzhangjin@gmail.com wrote:
[...]
> @@ -3099,7 +3099,11 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
>  			return VM_FAULT_SIGBUS;
>  	} else {
>  		vaddr = runtime->dma_area + offset;
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +		page = virt_to_page(CAC_ADDR(vaddr));
> +#else
>  		page = virt_to_page(vaddr);
> +#endif

That is a bit ugly.  It would be better to either  wrap the fix up in 
mips specific code so there don't have to be #ifdef __mips__ through out 
the generic driver code, or fix the driver in some other way if it is 
making x86 specific assumptions that don't hold in the general case.

The same applies for the remaining #ifdef __mips__ in the patch.




>  	}
>  	get_page(page);
>  	vmf->page = page;
> @@ -3214,6 +3218,11 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
>  	if (PCM_RUNTIME_CHECK(substream))
>  		return -ENXIO;
>  
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +	/* all mmap using uncached mode */
> +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
> +	area->vm_flags |= (VM_RESERVED | VM_IO);
> +#endif
>  	offset = area->vm_pgoff << PAGE_SHIFT;
>  	switch (offset) {
>  	case SNDRV_PCM_MMAP_OFFSET_STATUS:
> diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
> index 4e7ec2b..c0fcf0d 100644
> --- a/sound/core/sgbuf.c
> +++ b/sound/core/sgbuf.c
> @@ -114,7 +114,11 @@ void *snd_malloc_sgbuf_pages(struct device *device,
>  			if (!i)
>  				table->addr |= chunk; /* mark head */
>  			table++;
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +			*pgtable++ = virt_to_page(CAC_ADDR(tmpb.area));
> +#else
>  			*pgtable++ = virt_to_page(tmpb.area);
> +#endif
>  			tmpb.area += PAGE_SIZE;
>  			tmpb.addr += PAGE_SIZE;
>  		}
> @@ -125,7 +129,12 @@ void *snd_malloc_sgbuf_pages(struct device *device,
>  	}
>  
>  	sgbuf->size = size;
> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> +	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, \
> +			VM_MAP | VM_IO, pgprot_noncached(PAGE_KERNEL));
> +#else
>  	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
> +#endif
>  	if (! dmab->area)
>  		goto _failed;
>  	if (res_size)
> diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> index 82b9bdd..4ccfae0 100644
> --- a/sound/pci/Kconfig
> +++ b/sound/pci/Kconfig
> @@ -259,7 +259,6 @@ config SND_CS5530
>  
>  config SND_CS5535AUDIO
>  	tristate "CS5535/CS5536 Audio"
> -	depends on X86 && !X86_64
>  	select SND_PCM
>  	select SND_AC97_CODEC
>  	help
