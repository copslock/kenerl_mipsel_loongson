Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 16:14:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36042 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493558AbZIJOOf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Sep 2009 16:14:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8AEFO5q010661;
	Thu, 10 Sep 2009 16:15:27 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8AEFICU010659;
	Thu, 10 Sep 2009 16:15:18 +0200
Date:	Thu, 10 Sep 2009 16:15:18 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxim Uvarov <muvarov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] TLB  handler fix for vmalloc'ed addresses
Message-ID: <20090910141518.GA10547@linux-mips.org>
References: <4AA656D8.9040608@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AA656D8.9040608@ru.mvista.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 08, 2009 at 05:06:32PM +0400, Maxim Uvarov wrote:

> Patch is attached.

Please send patches inline.

> TLB exception handler incorrecly handles situation
> with wrong vmalloc'ed addresses.  This patch adds
> verifications for vmalloc'ed addresses (similar to
> x86_64 implementation). So the code now traps inside
> do_page_fault() on access to the wrong area.
> 
> Signed-off-by: Maxim Uvarov <muvarov@ru.mvista.com>
> 
> Test case:
> 
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/kernel.h>
> #include <linux/kthread.h>
> #include <linux/delay.h>
> 
> static struct task_struct *ts;
> static int example_thread(void *dummy)
> {
> 	void *ptr;
> 	ptr = vmalloc(16*1024*1024);
> 	for(;;)
> 	{
> 		msleep(100);
> 	}
> }

So your test case allocates vmalloc memory but never touches it.

> 
> static void run_vmalloc(void *unused)
> {
> 	ts=kthread_run(example_thread,NULL,"vtest");
> }
> int init_module (void)
> {
> 	run_vmalloc(NULL);
> 	return 0;
> }
> 
> void cleanup_module (void)
> { /*Nothing*/}
> 
> 
> Originally kernel trapped on BUG() inside exit_mmap() and it was impossible
> to see what has happened. After this patch applied, nice back trace will be
> generated:
> 
> CPU 0 Unable to handle kernel paging request at virtual address c00000000036a148
> Oops[#1]:
> Cpu 0
> $ 0   : 0000000000000000 ffffffff81940000 0000000000000000 00000000ffff05a7
> $ 4   : 0000000000000000 ffffffffffffffff ffffffff81a0b7d0 ffffffff811983e4
> $ 8   : ffffffff817407b0 0000000000000000 0000000000000000 0000000000000000
> $12   : a80000003374bfe0 0000000000008c00 ffffffff811e9df8 0000000000000000
> $16   : ffffffff81164a68 a8000000352a3c50 c00000000036a0e8 0000000000000000
> $20   : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> $24   : 0000000000000002 a8000000337bb1a0                                  
> $28   : a800000033748000 a80000003374bf70 a80000003374bf70 c00000000036a148
> Hi    : 0000000000000000
> Lo    : 000000000000a311
> epc   : c00000000036a148 0xc00000000036a148     Tainted: P      
> ra    : c00000000036a148 0xc00000000036a148 <-- dead in kernel module vtest
> Status: 10008ce3    KX SX UX KERNEL EXL IE 
> Cause : 00000008
> BadVA : c00000000036a148
> PrId  : 000d0408
> Modules linked in:
> Process vtest (pid: 723, threadinfo=a800000033748000, task=a800000034530340)
> 	Stack : 0000000000000000 a80000003374bf90 ffffffff81176530 ffffffff81176488
> 	ffffffffffffffff ffffffffffffffff 0000000000000000 0000000000000000
> 	0000000000000000 a80000003374bfd0 ffffffff81125024 0000000000000000
> 	0000000000000000 0000000000000000 5a5a5a5a5a5a5a5a 5a5a5a5a5a5a5a5a
> 	5a5a5a5a5a5a5a5a 5a5a5a5a5a5a5aa5
> 	Call Trace:
> 	[<ffffffff81176530>] kthread+0x198/0x1f0
> 	[<ffffffff81176488>] kthread+0xf0/0x1f0
> 	[<ffffffff81125024>] kernel_thread_helper+0x14/0x20
> 
> 
> Code: (Bad address in epc)

This is a 64-bit kernel crash ...

> Index: linux-2.6.21/arch/mips/mm/fault.c
> ===================================================================
> --- linux-2.6.21.orig/arch/mips/mm/fault.c
> +++ linux-2.6.21/arch/mips/mm/fault.c
> @@ -282,22 +282,32 @@ vmalloc_fault:
>  		pte_t *pte_k;
>  
>  		pgd = (pgd_t *) pgd_current[raw_smp_processor_id()] + offset;
> -		pgd_k = init_mm.pgd + offset;
> +		pgd_k = pgd_offset_k(address);
>  
>  		if (!pgd_present(*pgd_k))
>  			goto no_context;
> -		set_pgd(pgd, *pgd_k);
> +		if (unlikely(!pgd_present(*pgd)))
> +			set_pgd(pgd, *pgd_k);
> +		else if (pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_k))
> +				goto no_context;
>  
>  		pud = pud_offset(pgd, address);
>  		pud_k = pud_offset(pgd_k, address);
>  		if (!pud_present(*pud_k))
>  			goto no_context;
> +		if (pud_none(*pud) ||
> +				pud_page_vaddr(*pud) != pud_page_vaddr(*pud_k))
> +			goto no_context;
>  
>  		pmd = pmd_offset(pud, address);
>  		pmd_k = pmd_offset(pud_k, address);
>  		if (!pmd_present(*pmd_k))
>  			goto no_context;
> -		set_pmd(pmd, *pmd_k);
> +		if (!pmd_present(*pmd))
> +			set_pmd(pmd, *pmd_k);
> +		else
> +			if (pmd_page(*pmd) != pmd_page(*pmd_k))
> +				goto no_context;
>  
>  		pte_k = pte_offset_kernel(pmd_k, address);
>  		if (!pte_present(*pte_k))

... but on 64-bit kernels vmalloc_fault: should not be reached ever.

  Ralf
