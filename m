Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 21:29:59 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:39040 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20044743AbYHDU3t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 21:29:49 +0100
Received: (qmail invoked by alias); 04 Aug 2008 20:29:42 -0000
Received: from p548B1C75.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.28.117]
  by mail.gmx.net (mp057) with SMTP; 04 Aug 2008 22:29:42 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19bqGMIjW5bUMys+u1FgMvC20/wjz8tIrJ1/v45oF
	O7Zdi8xqndMFea
Message-ID: <489766BB.5090607@gmx.de>
Date:	Mon, 04 Aug 2008 22:29:47 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH/RFC]: SGI Octane (IP30) Patches, Part two, Octane core
References: <48914C74.6090309@gentoo.org>
In-Reply-To: <48914C74.6090309@gentoo.org>
X-Enigmail-Version: 0.95.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Kumba schrieb:
> 
> The second part is the actual IP30 Patch that makes these beasts boot. 
> Assuming you've already lit incense candles and sacrificed a PC to the
> MIPS Gods above.
> 
> There's one change that probably needs good scrutiny, as it changes a
> value in dma-default.c, and this'll affect other systems:
> 
> diff -Naurp linux-2.6.26.orig/arch/mips/mm/dma-default.c
> linux-2.6.26/arch/mips/mm/dma-default.c
> --- linux-2.6.26.orig/arch/mips/mm/dma-default.c        2008-07-13
> 17:51:29.000000000 -0400
> +++ linux-2.6.26/arch/mips/mm/dma-default.c     2008-07-25
> 03:14:40.000000000 -0400
> @@ -209,7 +209,7 @@ dma_addr_t dma_map_page(struct device *d
>                 dma_cache_wback_inv(addr, size);
>         }
> 
> -       return plat_map_dma_mem_page(dev, page) + offset;
> +       return plat_map_dma_mem_page(dev, page, size) + offset;
>  }
> 
I dont think that is needed.
IMHO This function schould map a whole page,
offset and size are only used for a part of that page. 
So i am using PAGE_SIZE in plat_map_dma_mem_page.

your version 
+static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
+                                       size_t size)
+{
+       dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page), 0, size);
+
+       return pa;
+}
+

my version
+static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
+                                       size_t size)
+{
+       dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page), 0, PAGE_SIZE);
+
+       return pa;
+}

Maybe it is only working, because the function dma_map_page is never used in my kernel.

> Thanks!,
> 
> 
> --Kumba
> 
