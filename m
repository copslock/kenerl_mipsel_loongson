Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 15:50:43 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:50193 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133495AbWAPPuY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 15:50:24 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 7366564D54; Mon, 16 Jan 2006 15:53:54 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id DFF1A8517; Mon, 16 Jan 2006 15:53:43 +0000 (GMT)
Date:	Mon, 16 Jan 2006 15:53:43 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Support /proc/kcore for MIPS
Message-ID: <20060116155343.GE26771@deprecation.cyrius.com>
References: <20050121005954.GA10260@nevyn.them.org> <20050214020209.GA25335@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214020209.GA25335@nevyn.them.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Daniel Jacobowitz <dan@debian.org> [2005-02-13 21:02]:
> Ping.  I've now tested this patch in both 32-bit and 64-bit kernels.

Ralf, can this be applied or are there objections?

> On Thu, Jan 20, 2005 at 07:59:54PM -0500, Daniel Jacobowitz wrote:
> > I wanted to do live debugging on an ornery task_struct this morning, so I
> > hooked up /proc/kcore for MIPS.  I'm pretty sure that the CKSEG0 bits are
> > wrong, but I did need to cover that region - because the SB-1 kernel links
> > at 0xffffffff80100000 or so, disassembly and printing static variables don't
> > work unless the debugger can read that region.
> > 
> > Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>
> > 
> > Index: linux/arch/mips/mm/init.c
> > ===================================================================
> > --- linux.orig/arch/mips/mm/init.c	2005-01-20 16:26:58.791321462 -0500
> > +++ linux/arch/mips/mm/init.c	2005-01-20 16:34:27.231213174 -0500
> > @@ -24,6 +24,7 @@
> >  #include <linux/bootmem.h>
> >  #include <linux/highmem.h>
> >  #include <linux/swap.h>
> > +#include <linux/proc_fs.h>
> >  
> >  #include <asm/bootinfo.h>
> >  #include <asm/cachectl.h>
> > @@ -197,6 +198,11 @@
> >  	return 0;
> >  }
> >  
> > +static struct kcore_list kcore_mem, kcore_vmalloc;
> > +#ifdef CONFIG_MIPS64
> > +static struct kcore_list kcore_kseg0;
> > +#endif
> > +
> >  void __init mem_init(void)
> >  {
> >  	unsigned long codesize, reservedpages, datasize, initsize;
> > @@ -247,6 +253,16 @@
> >  	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
> >  	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
> >  
> > +#ifdef CONFIG_MIPS64
> > +	if ((unsigned long) &_text > (unsigned long) CKSEG0)
> > +		/* The -4 is a hack so that user tools don't have to handle
> > +		   the overflow.  */
> > +		kclist_add(&kcore_kseg0, (void *) CKSEG0, 0x80000000 - 4);
> > +#endif
> > +	kclist_add(&kcore_mem, __va(0), max_low_pfn << PAGE_SHIFT);
> > +	kclist_add(&kcore_vmalloc, (void *)VMALLOC_START,
> > +		   VMALLOC_END-VMALLOC_START);
> > +
> >  	printk(KERN_INFO "Memory: %luk/%luk available (%ldk kernel code, "
> >  	       "%ldk reserved, %ldk data, %ldk init, %ldk highmem)\n",
> >  	       (unsigned long) nr_free_pages() << (PAGE_SHIFT-10),

-- 
Martin Michlmayr
http://www.cyrius.com/
