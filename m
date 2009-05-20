Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 00:36:58 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:43774 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024656AbZETXgv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2009 00:36:51 +0100
Received: by pzk40 with SMTP id 40so661765pzk.22
        for <multiple recipients>; Wed, 20 May 2009 16:36:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=sc3YjqsU8VqHgyoVyTaC5fXXIcOqaR9odw2NhLp50yg=;
        b=ViVkQRjFgI0Tpz8tx5h5KLkTMmGWJri0cBSq73bkA6h+Hxv6jrNTH1xukBVNfhbHMz
         IkhhV1ScBwd9BCyFg5vQKwSIXWGTzVXVfh/HjIH4HDmAm5P7avfVr22uf1Hy69MTloWp
         bpbB7gb7RKZ9x/WCSK5T9yr19a1yGiEKRyIIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=nd0xG9Nbfq21XpkKYqRDvosiO/jIxkQLKmRub8rMNP/HypoBOfjEjKlLrwhhzuUQuL
         VbtihXmm56NmoYHyEAWf75p8QgjOVWtAAtOo8/SY9DC1fH370XLxVmoYf8N0a5GIANZv
         c+NbGTHJAEzT9qnPH5uDCLzIvpp+hT/RbmWyc=
Received: by 10.114.177.1 with SMTP id z1mr3750847wae.68.1242862603935;
        Wed, 20 May 2009 16:36:43 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id c26sm4066189waa.15.2009.05.20.16.36.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 16:36:43 -0700 (PDT)
Subject: Re: [loongson-PATCH-v1 23/27] Alsa memory maps fixup on mips
 systems
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <4A1481A4.9060708@caviumnetworks.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <323881882e108383c0360bd6a1138801d9d47679.1242855716.git.wuzhangjin@gmail.com>
	 <4A1481A4.9060708@caviumnetworks.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 21 May 2009 07:36:28 +0800
Message-Id: <1242862588.21692.583.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-05-20 at 15:18 -0700, David Daney wrote:
> wuzhangjin@gmail.com wrote:
> [...]
> > @@ -3099,7 +3099,11 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
> >  			return VM_FAULT_SIGBUS;
> >  	} else {
> >  		vaddr = runtime->dma_area + offset;
> > +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> > +		page = virt_to_page(CAC_ADDR(vaddr));
> > +#else
> >  		page = virt_to_page(vaddr);
> > +#endif
> 
> That is a bit ugly.  It would be better to either  wrap the fix up in 
> mips specific code so there don't have to be #ifdef __mips__ through out 
> the generic driver code, or fix the driver in some other way if it is 
> making x86 specific assumptions that don't hold in the general case.
> 
> The same applies for the remaining #ifdef __mips__ in the patch.
> 
> 

nod, will be tuned later. 

thanks,
Wu Zhangjin

> 
> 
> >  	}
> >  	get_page(page);
> >  	vmf->page = page;
> > @@ -3214,6 +3218,11 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
> >  	if (PCM_RUNTIME_CHECK(substream))
> >  		return -ENXIO;
> >  
> > +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> > +	/* all mmap using uncached mode */
> > +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
> > +	area->vm_flags |= (VM_RESERVED | VM_IO);
> > +#endif
> >  	offset = area->vm_pgoff << PAGE_SHIFT;
> >  	switch (offset) {
> >  	case SNDRV_PCM_MMAP_OFFSET_STATUS:
> > diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
> > index 4e7ec2b..c0fcf0d 100644
> > --- a/sound/core/sgbuf.c
> > +++ b/sound/core/sgbuf.c
> > @@ -114,7 +114,11 @@ void *snd_malloc_sgbuf_pages(struct device *device,
> >  			if (!i)
> >  				table->addr |= chunk; /* mark head */
> >  			table++;
> > +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> > +			*pgtable++ = virt_to_page(CAC_ADDR(tmpb.area));
> > +#else
> >  			*pgtable++ = virt_to_page(tmpb.area);
> > +#endif
> >  			tmpb.area += PAGE_SIZE;
> >  			tmpb.addr += PAGE_SIZE;
> >  		}
> > @@ -125,7 +129,12 @@ void *snd_malloc_sgbuf_pages(struct device *device,
> >  	}
> >  
> >  	sgbuf->size = size;
> > +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> > +	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, \
> > +			VM_MAP | VM_IO, pgprot_noncached(PAGE_KERNEL));
> > +#else
> >  	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
> > +#endif
> >  	if (! dmab->area)
> >  		goto _failed;
> >  	if (res_size)
> > diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> > index 82b9bdd..4ccfae0 100644
> > --- a/sound/pci/Kconfig
> > +++ b/sound/pci/Kconfig
> > @@ -259,7 +259,6 @@ config SND_CS5530
> >  
> >  config SND_CS5535AUDIO
> >  	tristate "CS5535/CS5536 Audio"
> > -	depends on X86 && !X86_64
> >  	select SND_PCM
> >  	select SND_AC97_CODEC
> >  	help
> 
