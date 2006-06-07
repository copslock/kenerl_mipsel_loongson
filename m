Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 05:12:13 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:676 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8126552AbWFGEME (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 05:12:04 +0100
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k574Bu5t018582;
	Tue, 6 Jun 2006 21:11:56 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Jun 2006 21:11:56 -0700
Received: from [192.168.96.27] ([192.168.96.27]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Jun 2006 21:11:55 -0700
Message-ID: <44865207.9080606@windriver.com>
Date:	Wed, 07 Jun 2006 12:11:51 +0800
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To:	art <art@sigrand.ru>
CC:	linux-mips@linux-mips.org
Subject: Re: Socket buffer allocation outside DMA-able memory
References: <6A3254532ACD7A42805B4E1BFD18080EEA211B@ism-mail01.corp.ad.wrs.com> <10452.060607@sigrand.ru>
In-Reply-To: <10452.060607@sigrand.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2006 04:11:55.0877 (UTC) FILETIME=[8387C950:01C689E8]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Hi art,

I think maybe my first noise is more easy to go.

As you know, sk_buff is made of a skb header and the packet data 
container. The skb header is allocated from the slab cache, while the 
packet data container is allocated via kmalloc().

So if you can add your low 32MB memory into ZONE_DMA, then your can call 
__dev_alloc_skb() with __GFP_DMA flag in your driver, which should make 
sure that the packet data container is in ZONE_DMA.

Best Regards,
Mark.Zhan

art wrote:
> Hello Rongkai,
>
> Thanks! Good idea!
>
>
> ZR> After having a look at the latest 2.6.17-rc6 codes, __dev_alloc_skb is defined like this:
>
> ZR> #ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
> ZR> /**
> ZR>  *      __dev_alloc_skb - allocate an skbuff for sending
> ZR>  *      @length: length to allocate
> ZR>  *      @gfp_mask: get_free_pages mask, passed to alloc_skb
> ZR>  *
> ZR>  *      Allocate a new &sk_buff and assign it a usage count of one. The
> ZR>  *      buffer has unspecified headroom built in. Users should allocate
> ZR>  *      the headroom they think they need without accounting for the
> ZR>  *      built in space. The built in space is used for optimisations.
> ZR>  *
> ZR>  *      %NULL is returned in there is no free memory.
> ZR>  */
> ZR> static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
> ZR>                                               gfp_t gfp_mask)
> ZR> {
> ZR>         struct sk_buff *skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
> ZR>         if (likely(skb))
> ZR>                 skb_reserve(skb, NET_SKB_PAD);
> ZR>         return skb;
> ZR> }
> ZR> #else
> ZR> extern struct sk_buff *__dev_alloc_skb(unsigned int length, int gfp_mask);
> ZR> #endif
>
>
> ZR> Therefore, you also can consider to implement your machine-specific __dev_alloc_skb() function, and force the skb is allocated from your low 32MB memory zone.
>
>
>
>   
