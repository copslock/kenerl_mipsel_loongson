Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 09:57:32 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:65311 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224991AbVBHJ5Q>;
	Tue, 8 Feb 2005 09:57:16 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j189vEH00649;
	Tue, 8 Feb 2005 10:57:14 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j189vEc13328;
	Tue, 8 Feb 2005 10:57:14 +0100
Message-ID: <42088CFA.6090605@schenk.isar.de>
Date:	Tue, 08 Feb 2005 10:57:14 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org>
In-Reply-To: <20050208001742.GA15336@linux-mips.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> Blowing away the entire S-cache is extreme overkill.  We really want to
> avoid this if possible as it'll have serious performance impact.  As for
> the RM9000 that means we have a struct page pointer, therefore we know
> the physical address of the page and can perform a selective flush on the
> second level cache.  See below for a patch which tries that.
> 
> Obviously this one only tries to optimize performance a bit further but
> doesn't really solve the remaining problem.
> 
>   Ralf
> 
> Index: arch/mips/mm/c-r4k.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
> retrieving revision 1.101
> diff -u -r1.101 c-r4k.c
> --- arch/mips/mm/c-r4k.c	7 Feb 2005 21:53:39 -0000	1.101
> +++ arch/mips/mm/c-r4k.c	8 Feb 2005 00:18:17 -0000
> @@ -566,9 +566,21 @@
>  
>  	if (!cpu_has_ic_fills_f_dc) {
>  		unsigned long addr = (unsigned long) page_address(page);
> -		r4k_blast_dcache_page(addr);
> -		if (!cpu_icache_snoops_remote_store)
> -			r4k_blast_scache_page(addr);
> +
> +		if (addr)
> +			r4k_blast_dcache_page(addr);
> +		else
> +			r4k_blast_dcache();
> +
> +		if (!cpu_icache_snoops_remote_store) {
> +			if (addr)
> +				r4k_blast_scache_page(addr);
> +			else {
> +				addr = page_to_pfn(page) << PAGE_SHIFT;
> +				addr = CKSEG + (addr & ~((1UL << 24) - 1));
> +				r4k_blast_scache_page_indexed(addr);
> +			}
> +		}
>  		ClearPageDcacheDirty(page);
>  	}
>  
> 

I presume CKSEG is CKSEG0 in the above patch. With that it works
about the same as before. So do you have any clue what the problem
behind all that really is? Furthermore I still have all those
"Illegal instruction" and "Segmentation fault" messages that
shouldn't be there.

Thanks
Rojhalat Ibrahim
