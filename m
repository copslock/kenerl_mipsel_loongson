Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 15:13:50 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:57313 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021865AbXDRONs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2007 15:13:48 +0100
Received: (qmail 19814 invoked by uid 507); 18 Apr 2007 22:17:06 +0800
Received: from unknown (HELO ?192.168.1.7?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 18 Apr 2007 22:17:06 +0800
Message-ID: <4626276E.3000303@ict.ac.cn>
Date:	Wed, 18 Apr 2007 22:13:02 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	tiansm@lemote.com, perex@suse.cz, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 16/16] alsa sound support for mips
References: <11766507661684-git-send-email-tiansm@lemote.com> <117665076617-git-send-email-tiansm@lemote.com> <1176650766907-git-send-email-tiansm@lemote.com> <11766507663301-git-send-email-tiansm@lemote.com> <11766507663039-git-send-email-tiansm@lemote.com> <1176650766685-git-send-email-tiansm@lemote.com> <11766507661790-git-send-email-tiansm@lemote.com> <11766507672298-git-send-email-tiansm@lemote.com> <11766507672043-git-send-email-tiansm@lemote.com> <11766507674145-git-send-email-tiansm@lemote.com> <20070418135412.GG3938@linux-mips.org>
In-Reply-To: <20070418135412.GG3938@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips


>>  		vaddr = runtime->dma_area + offset;
>> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
>>     
>
> Please use CONFIG_MIPS instead of __mips__ in #if / #ifdefs.
>
> The question if #ifdefing is the right approach to solve this problem is
> something else but I think no, ....
>   
I would agree that it is quite ugly, but changing virt_to_page for it 
does not seem right either.
>   
>> +		page = virt_to_page(CAC_ADDR(vaddr));
>> +#else
>>  		page = virt_to_page(vaddr);
>> +#endif
>>     
>
> So this is needed because the MIPS virt_to_page is returning a unsuitable
> value if vaddress is not a KSEG0 (64-bit: cached XKPHYS) address which is
> what GFP allocations and the slab will return.  So now we have to deciede
> if
>
>  a) the MIPS __pa() should be changed to handle uncached addresses.
>  b) the sound code here is simply broken.
>
> Some drivers seem to allocate runtime->dma_area from vmalloc, so this
> whole area in the sound code is looking like built on quicksand ...
>   
>> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
>> +	/* all mmap using uncached mode */
>> +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
>> +	area->vm_flags |= ( VM_RESERVED | VM_IO);
>>     
>
> VM_RESERVED will prevent the buffer from being freed.  I assume that is
> another workaround for some kernel subsystem blowing up when being fed a
> pointer to an uncached RAM address?  This smells like a memory leak.
>
>   
Oh, VM_RESERVED should be a memory leak problem, we can remove it.
I don't remember any case of other subsystem's problem, just did not 
think much
to add those flags.
>> +#endif
>> +
>>  	offset = area->vm_pgoff << PAGE_SHIFT;
>>  	switch (offset) {
>>  	case SNDRV_PCM_MMAP_OFFSET_STATUS:
>> diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
>> index cefd228..535f0bc 100644
>> --- a/sound/core/sgbuf.c
>> +++ b/sound/core/sgbuf.c
>> @@ -91,12 +91,21 @@ void *snd_malloc_sgbuf_pages(struct device *device,
>>  		}
>>  		sgbuf->table[i].buf = tmpb.area;
>>  		sgbuf->table[i].addr = tmpb.addr;
>> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
>> +		sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));
>>     
>
> VM_RESERVED will prevent the buffer from being freed.  I assume that is
> another workaround for some kernel subsystem blowing up when being fed a
> pointer to an uncached RAM address?  This smells like a memory leak.
>
>   
>> +#else
>>  		sgbuf->page_table[i] = virt_to_page(tmpb.area);
>> +#endif
>>  		sgbuf->pages++;
>>  	}
>>  
>>  	sgbuf->size = size;
>> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
>> +	/* maybe we should use uncached accelerated mode */
>> +	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP | VM_IO, pgprot_noncached(PAGE_KERNEL));
>> +#else
>>  	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
>> +#endif
>>     
>
> I would suggest to get rid of this ifdef with a new arch-specific function
> like vmap_io_buffer which will do whatever a platform seems fit for this
> case?
>   
I think arch-specific function is the correct way, but don't know what 
the alsa gods think.
>   
>>  	if (! dmab->area)
>>  		goto _failed;
>>  	return dmab->area;
>>     
>
>   Ralf
>
>
>
>
>   
