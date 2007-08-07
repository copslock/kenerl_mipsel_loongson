Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 06:53:37 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.177]:59590 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023803AbXHGFxf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 06:53:35 +0100
Received: by wa-out-1112.google.com with SMTP id m16so2046610waf
        for <linux-mips@linux-mips.org>; Mon, 06 Aug 2007 22:53:16 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AL7247v1gUxRwD11+v5tJe7PUzB0xzXxyyHGdlOba4BaByOsxgBtohqhqn0ijB+7RueWRoXpwmJTglmlolWFUwz1xcaEEv7HnA2BYMh6nERDO0LgZY5U222Mxc8BDzsmx9YcxjIGrh/OWWHEY9EwXVtSfv4sDqlJLFcXEgnqqms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqO5vRHKldKh3v+OtVG1LwpieofuJyifwJw58BdLwzgYbWKQ8UneP9z957jLyn4X/EH+G5uwa09eyFlmJjgM7KszHSDPPf/s7pG2ki20MoOoldCb0VumLeF9ACSj78YTYi6wfn+xQdccgpIuWvqe1uCrSrXXTY/MeOBmM/7CYJI=
Received: by 10.115.111.1 with SMTP id o1mr6385865wam.1186465995988;
        Mon, 06 Aug 2007 22:53:15 -0700 (PDT)
Received: by 10.115.111.14 with HTTP; Mon, 6 Aug 2007 22:53:15 -0700 (PDT)
Message-ID: <5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>
Date:	Tue, 7 Aug 2007 09:53:15 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	"Songmao Tian" <tiansm@lemote.com>
Subject: Re: ALSA on MIPS platform
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	Ralf <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>,
	"Takashi Iwai" <tiwai@suse.de>, greg@kroah.com
In-Reply-To: <46B332AC.8020403@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46B03CC0.3090000@lemote.com>
	 <20070802.235606.122255120.anemo@mba.ocn.ne.jp>
	 <46B332AC.8020403@lemote.com>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

I think this problem can be solved by revising the __pa macro like this:

--- a/include/asm-mips/page.h      2007-08-07 09:45:00.000000000 +0800
+++ b/include/asm-mips/page.h     2007-08-07 09:46:59.000000000 +0800
@@ -150,7 +150,7 @@
 })
 #else
 #define __pa(x)
         \
-    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
+    (((unsigned long)(x) & 0x1fffffff) + PHYS_OFFSET)
 #endif

So, the virt_to_page can accept all cached or uncached address.


Tan

2007/8/3, Songmao Tian <tiansm@lemote.com>:
> Atsushi Nemoto wrote:
> > On Wed, 01 Aug 2007 15:56:48 +0800, Songmao Tian <tiansm@lemote.com> wrote:
> >
> >>     The problem is clear:
> >> 1. dma_alloc_noncoherent() return a non-cached address, and
> >> virt_to_page() need a cached logical addr (Have I named it right?)
> >> 2. mmaped dam buffer should be non-cached.
> >>
> >> We have a ugly patch, but we want to solve the problem cleanly, so can
> >> anyone show me the way?
> >>
> >
> > virt_to_page() is used in many place in mm so making it robust might
> > affect performance.  IMHO virt_to_page() seems too low-level as DMA
> > API.
> >
> > If something like dma_virt_to_page(dev, cpu_addr) which can take a cpu
> > address returned by dma_xxx APIs was defined, MIPS can implement it
> > appropriately.
> >
> > And then pgprot_noncached issues still exist...
> >
> > ---
> > Atsushi Nemoto
> >
> >
> >
> >
>
> I agree, and I am investigating to implement a dma_map_coherent, but It
> seems dma_map_coherent doesn't solve all the problem and will change a
> lot of code:(
>
>
> dma_virt_to_page can be something like this.
>
> diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
> index b92dd8c..d2ead8a 100644
> --- a/include/asm-mips/page.h
> +++ b/include/asm-mips/page.h
> @@ -181,6 +181,8 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>  #define virt_to_page(kaddr)    pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
>  #define virt_addr_valid(kaddr)    pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
>
> +#define dma_virt_to_page(dma_addr)
> pfn_to_page(PFN_DOWN(virt_to_phys(CAC_ADDR(kaddr))))
> +
>  #define VM_DATA_DEFAULT_FLAGS    (VM_READ | VM_WRITE | VM_EXEC | \
>                   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 655094d..5e694dd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -39,6 +39,10 @@ extern int sysctl_legacy_va_layout;
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
>
> +#ifndef dma_virt_to_page
> +#define dma_virt_to_page virt_to_page
> +#endif
> +
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>
>  /*
> diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
> index cefd228..8b29bfd 100644
> --- a/sound/core/sgbuf.c
> +++ b/sound/core/sgbuf.c
> @@ -91,7 +91,7 @@ void *snd_malloc_sgbuf_pages(struct device *device,
>          }
>          sgbuf->table[i].buf = tmpb.area;
>          sgbuf->table[i].addr = tmpb.addr;
> -        sgbuf->page_table[i] = virt_to_page(tmpb.area);
> +        sgbuf->page_table[i] = dma_virt_to_page(tmpb.area);
>          sgbuf->pages++;
>      }
>
>
