Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 08:10:30 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:39195 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224845AbVBGIKO>;
	Mon, 7 Feb 2005 08:10:14 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j178ADH24156;
	Mon, 7 Feb 2005 09:10:13 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j178ADc04488;
	Mon, 7 Feb 2005 09:10:13 +0100
Message-ID: <42072264.6000001@schenk.isar.de>
Date:	Mon, 07 Feb 2005 09:10:12 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org>
In-Reply-To: <20050204004028.GC22311@linux-mips.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Jan 18, 2005 at 03:44:51PM +0100, Rojhalat Ibrahim wrote:
> 
> 
>>is there anything special I have to do
>>when I want to use more than 512MB of memory?
>>My Yosemite board works fine with 512MB
>>but when I try 1GB it crashes in 32bit mode
>>with highmem and also in 64bit mode.
>>The boot monitor (PMON) maps the 1024MB
>>to physical addresses 0x0000.0000 - 0x4000.0000.
> 
> 
> Can you try below patch?
> 
>   Ralf
> 
> --- linux/arch/mips/mm/c-r4k.c	2004-12-07 02:30:50.000000000 +0000
> +++ linux/arch/mips/mm/c-r4k.c	2005-02-04 00:31:34.623814760 +0000
> @@ -566,7 +566,10 @@
>  
>  	if (!cpu_has_ic_fills_f_dc) {
>  		unsigned long addr = (unsigned long) page_address(page);
> -		r4k_blast_dcache_page(addr);
> +		if (addr)
> +			r4k_blast_dcache_page(addr);
> +		else
> +			r4k_blast_dcache();
>  		if (!cpu_icache_snoops_remote_store)
>  			r4k_blast_scache_page(addr);
>  		ClearPageDcacheDirty(page);
> 


With a slightly extended patch it actually works. But afterwards
I get a lot of Illegal instructions and Segmentation faults, where
there shouldn't be any. Below is the patch I used.

Thanks
Rojhalat Ibrahim


--- linux/arch/mips/mm/c-r4k.c  2005-01-03 10:23:27.000000000 +0100
+++ linux-2.6.10/arch/mips/mm/c-r4k.c   2005-02-07 09:04:27.000000000 +0100
@@ -566,9 +566,17 @@

         if (!cpu_has_ic_fills_f_dc) {
                 unsigned long addr = (unsigned long) page_address(page);
-               r4k_blast_dcache_page(addr);
+               if (addr)
+                       r4k_blast_dcache_page(addr);
+               else
+                       r4k_blast_dcache();
                 if (!cpu_icache_snoops_remote_store)
-                       r4k_blast_scache_page(addr);
+               {
+                       if (addr)
+                               r4k_blast_scache_page(addr);
+                       else
+                               r4k_blast_scache();
+               }
                 ClearPageDcacheDirty(page);
         }
