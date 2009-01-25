Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 12:31:53 +0000 (GMT)
Received: from mow300.po.2iij.NET ([210.128.50.200]:54474 "EHLO
	mow.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S21364913AbZAYMbv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Jan 2009 12:31:51 +0000
Received: by mow.po.2iij.net (mow300) id n0PCVmAd002661; Sun, 25 Jan 2009 21:31:48 +0900
Received: from delta (133.6.30.125.dy.iij4u.or.jp [125.30.6.133])
	by mbox.po.2iij.net (po-mbox305) id n0PCVjRg000510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Jan 2009 21:31:46 +0900
Date:	Sun, 25 Jan 2009 21:30:38 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix oops in r4k_dma_cache_inv
Message-Id: <20090125213038.0f54be07.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20090124191055.GA29966@linux-mips.org>
References: <20090124221542.bcc6c19f.yoichi_yuasa@tripeaks.co.jp>
	<20090124191055.GA29966@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

It's good for me.

Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

On Sat, 24 Jan 2009 19:10:55 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sat, Jan 24, 2009 at 10:15:42PM +0900, Yoichi Yuasa wrote:
> 
> Patch looks ok - but I think we also have to assume that the starting
> address of the range might be miss-aligned, so how about this patch?
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 56290a7..c43f4b2 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -619,8 +619,20 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>  		if (size >= scache_size)
>  			r4k_blast_scache();
>  		else {
> -			cache_op(Hit_Writeback_Inv_SD, addr);
> -			cache_op(Hit_Writeback_Inv_SD, addr + size - 1);
> +			unsigned long lsize = cpu_scache_line_size();
> +			unsigned long almask = ~(lsize - 1);
> +
> +			/*
> +			 * There is no clearly documented alignment requirement
> +			 * for the cache instruction on MIPS processors and
> +			 * some processors, among them the RM5200 and RM7000
> +			 * QED processors will throw an address error for cache
> +			 * hit ops with insufficient alignment.  Solved by
> +			 * aligning the address to cache line size.
> +			 */
> +			cache_op(Hit_Writeback_Inv_SD, addr & almask);
> +			cache_op(Hit_Writeback_Inv_SD,
> +				 (addr + size - 1) & almask);
>  			blast_inv_scache_range(addr, addr + size);
>  		}
>  		return;
> @@ -629,9 +641,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>  	if (cpu_has_safe_index_cacheops && size >= dcache_size) {
>  		r4k_blast_dcache();
>  	} else {
> +		unsigned long lsize = cpu_dcache_line_size();
> +		unsigned long almask = ~(lsize - 1);
> +
>  		R4600_HIT_CACHEOP_WAR_IMPL;
> -		cache_op(Hit_Writeback_Inv_D, addr);
> -		cache_op(Hit_Writeback_Inv_D, addr + size - 1);
> +		cache_op(Hit_Writeback_Inv_D, addr & almask);
> +		cache_op(Hit_Writeback_Inv_D, (addr + size - 1)  & almask);
>  		blast_inv_dcache_range(addr, addr + size);
>  	}
>  
