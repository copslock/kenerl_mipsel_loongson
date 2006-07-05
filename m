Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 14:54:25 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:30699 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133454AbWGENyP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Jul 2006 14:54:15 +0100
Received: by ug-out-1314.google.com with SMTP id u2so2203928uge
        for <linux-mips@linux-mips.org>; Wed, 05 Jul 2006 06:54:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ujjyJfL9zq1ltiAzXmAnRRQ4b7F9tDmyHyJ5QFSN5z3t0+7iMx6620Qnaa0SOiFJU9+Z3cYSmLReI4RqDLqkXDwzM3eMgnDtq40tOqjpn1FCuVNb/0a0ulyCkpzELByng+E8r5yLDIo2KEgxFmiMshVC8RpAiE7pVUlYBk4EsqQ=
Received: by 10.78.167.12 with SMTP id p12mr3513568hue;
        Wed, 05 Jul 2006 06:54:14 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 33sm2343758hue.2006.07.05.06.54.11;
        Wed, 05 Jul 2006 06:54:14 -0700 (PDT)
Message-ID: <44ABC59C.6070607@innova-card.com>
Date:	Wed, 05 Jul 2006 15:58:52 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
References: <20060705.221354.74751389.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060705.221354.74751389.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> With SPARSEMEM, the single node can contains some holes so there might
> be many invalid pages.  For example, with two 256M memory and one 256M

Does SPARSEMEM is the only memory model where we can have memory holes ?

> hole, some variables (num_physpage, totalpages, nr_kernel_pages,
> nr_all_pages, etc.) will indicate that there are 768MB on this system.
> This is not desired because, for example, alloc_large_system_hash()
> allocates too many entries.
> 
> Use free_area_init_node() with counted zholes_size[] instead of
> free_area_init().
> 
> For num_physpages, use number of ram pages instead of max_low_pfn.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 802bdd3..d41dee5 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c

[snip]

>  
> @@ -174,29 +200,17 @@ #ifdef CONFIG_HIGHMEM
>  		zones_size[ZONE_HIGHMEM] = high - low;
>  #endif
>  
> +#ifdef CONFIG_SPARSEMEM
> +	pfn = 0;
> +	for (i = 0; i < MAX_NR_ZONES; i++)
> +		for (j = 0; j < zones_size[i]; j++, pfn++)
> +			if (!page_is_ram(pfn))
> +				zholes_size[i]++;
> +	free_area_init_node(0, NODE_DATA(0), zones_size,
> +			    __pa(PAGE_OFFSET), zholes_size);


Does this code really need the ifdef CONFIG_SPARSEMEM ? Can't we make
it generic instead. Only zholes_size[] initialisation really depends
on the memory model. Of course FLATMEM will let zholes_size as is...

If I remember correctly free_area_init_node() takes a pfn number as
fourth parameter: __pa(PAGE_OFFSET) results in a physical address...

BTW why using __pa(OFFSET) ? isn't it going to yield always into 0 ?
At least on MIPS, it's defined as

#define __pa(x)	((unsigned long) (x) - PAGE_OFFSET)

why not using ARCH_PFN_OFFSET instead ?

thanks

		Franck
