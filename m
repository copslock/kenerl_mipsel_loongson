Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 02:02:41 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:35048 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225223AbVBNCCZ>;
	Mon, 14 Feb 2005 02:02:25 +0000
Received: from drow by nevyn.them.org with local (Exim 4.44 #1 (Debian))
	id 1D0VYv-0006d5-52; Sun, 13 Feb 2005 21:02:09 -0500
Date:	Sun, 13 Feb 2005 21:02:09 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: Support /proc/kcore for MIPS
Message-ID: <20050214020209.GA25335@nevyn.them.org>
References: <20050121005954.GA10260@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121005954.GA10260@nevyn.them.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Ping.  I've now tested this patch in both 32-bit and 64-bit kernels.

On Thu, Jan 20, 2005 at 07:59:54PM -0500, Daniel Jacobowitz wrote:
> I wanted to do live debugging on an ornery task_struct this morning, so I
> hooked up /proc/kcore for MIPS.  I'm pretty sure that the CKSEG0 bits are
> wrong, but I did need to cover that region - because the SB-1 kernel links
> at 0xffffffff80100000 or so, disassembly and printing static variables don't
> work unless the debugger can read that region.
> 
> Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>
> 
> Index: linux/arch/mips/mm/init.c
> ===================================================================
> --- linux.orig/arch/mips/mm/init.c	2005-01-20 16:26:58.791321462 -0500
> +++ linux/arch/mips/mm/init.c	2005-01-20 16:34:27.231213174 -0500
> @@ -24,6 +24,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/highmem.h>
>  #include <linux/swap.h>
> +#include <linux/proc_fs.h>
>  
>  #include <asm/bootinfo.h>
>  #include <asm/cachectl.h>
> @@ -197,6 +198,11 @@
>  	return 0;
>  }
>  
> +static struct kcore_list kcore_mem, kcore_vmalloc;
> +#ifdef CONFIG_MIPS64
> +static struct kcore_list kcore_kseg0;
> +#endif
> +
>  void __init mem_init(void)
>  {
>  	unsigned long codesize, reservedpages, datasize, initsize;
> @@ -247,6 +253,16 @@
>  	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
>  	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
>  
> +#ifdef CONFIG_MIPS64
> +	if ((unsigned long) &_text > (unsigned long) CKSEG0)
> +		/* The -4 is a hack so that user tools don't have to handle
> +		   the overflow.  */
> +		kclist_add(&kcore_kseg0, (void *) CKSEG0, 0x80000000 - 4);
> +#endif
> +	kclist_add(&kcore_mem, __va(0), max_low_pfn << PAGE_SHIFT);
> +	kclist_add(&kcore_vmalloc, (void *)VMALLOC_START,
> +		   VMALLOC_END-VMALLOC_START);
> +
>  	printk(KERN_INFO "Memory: %luk/%luk available (%ldk kernel code, "
>  	       "%ldk reserved, %ldk data, %ldk init, %ldk highmem)\n",
>  	       (unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
> 
> -- 
> Daniel Jacobowitz
> 
> 

-- 
Daniel Jacobowitz
CodeSourcery, LLC
