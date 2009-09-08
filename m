Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Sep 2009 18:17:14 +0200 (CEST)
Received: from ru.mvista.com ([213.79.90.228]:22052 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492691AbZIHQRG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Sep 2009 18:17:06 +0200
Received: from [192.168.11.243] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 11D568814; Tue,  8 Sep 2009 18:06:33 +0500 (SAMST)
Message-ID: <4AA656D8.9040608@ru.mvista.com>
Date:	Tue, 08 Sep 2009 17:06:32 +0400
From:	Maxim Uvarov <muvarov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [MIPS] TLB  handler fix for vmalloc'ed addresses
Content-Type: multipart/mixed;
 boundary="------------060200050905030006090904"
Return-Path: <muvarov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060200050905030006090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch is attached.

Best regards,
Maxim Uvarov.

--------------060200050905030006090904
Content-Type: text/x-patch;
 name="mips_tlb_fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips_tlb_fixup.patch"

TLB exception handler incorrecly handles situation
with wrong vmalloc'ed addresses.  This patch adds
verifications for vmalloc'ed addresses (similar to
x86_64 implementation). So the code now traps inside
do_page_fault() on access to the wrong area.

Signed-off-by: Maxim Uvarov <muvarov@ru.mvista.com>

Test case:

#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/kthread.h>
#include <linux/delay.h>

static struct task_struct *ts;
static int example_thread(void *dummy)
{
	void *ptr;
	ptr = vmalloc(16*1024*1024);
	for(;;)
	{
		msleep(100);
	}
}

static void run_vmalloc(void *unused)
{
	ts=kthread_run(example_thread,NULL,"vtest");
}
int init_module (void)
{
	run_vmalloc(NULL);
	return 0;
}

void cleanup_module (void)
{ /*Nothing*/}


Originally kernel trapped on BUG() inside exit_mmap() and it was impossible
to see what has happened. After this patch applied, nice back trace will be
generated:

CPU 0 Unable to handle kernel paging request at virtual address c00000000036a148
Oops[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff81940000 0000000000000000 00000000ffff05a7
$ 4   : 0000000000000000 ffffffffffffffff ffffffff81a0b7d0 ffffffff811983e4
$ 8   : ffffffff817407b0 0000000000000000 0000000000000000 0000000000000000
$12   : a80000003374bfe0 0000000000008c00 ffffffff811e9df8 0000000000000000
$16   : ffffffff81164a68 a8000000352a3c50 c00000000036a0e8 0000000000000000
$20   : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
$24   : 0000000000000002 a8000000337bb1a0                                  
$28   : a800000033748000 a80000003374bf70 a80000003374bf70 c00000000036a148
Hi    : 0000000000000000
Lo    : 000000000000a311
epc   : c00000000036a148 0xc00000000036a148     Tainted: P      
ra    : c00000000036a148 0xc00000000036a148 <-- dead in kernel module vtest
Status: 10008ce3    KX SX UX KERNEL EXL IE 
Cause : 00000008
BadVA : c00000000036a148
PrId  : 000d0408
Modules linked in:
Process vtest (pid: 723, threadinfo=a800000033748000, task=a800000034530340)
	Stack : 0000000000000000 a80000003374bf90 ffffffff81176530 ffffffff81176488
	ffffffffffffffff ffffffffffffffff 0000000000000000 0000000000000000
	0000000000000000 a80000003374bfd0 ffffffff81125024 0000000000000000
	0000000000000000 0000000000000000 5a5a5a5a5a5a5a5a 5a5a5a5a5a5a5a5a
	5a5a5a5a5a5a5a5a 5a5a5a5a5a5a5aa5
	Call Trace:
	[<ffffffff81176530>] kthread+0x198/0x1f0
	[<ffffffff81176488>] kthread+0xf0/0x1f0
	[<ffffffff81125024>] kernel_thread_helper+0x14/0x20


Code: (Bad address in epc)

Index: linux-2.6.21/arch/mips/mm/fault.c
===================================================================
--- linux-2.6.21.orig/arch/mips/mm/fault.c
+++ linux-2.6.21/arch/mips/mm/fault.c
@@ -282,22 +282,32 @@ vmalloc_fault:
 		pte_t *pte_k;
 
 		pgd = (pgd_t *) pgd_current[raw_smp_processor_id()] + offset;
-		pgd_k = init_mm.pgd + offset;
+		pgd_k = pgd_offset_k(address);
 
 		if (!pgd_present(*pgd_k))
 			goto no_context;
-		set_pgd(pgd, *pgd_k);
+		if (unlikely(!pgd_present(*pgd)))
+			set_pgd(pgd, *pgd_k);
+		else if (pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_k))
+				goto no_context;
 
 		pud = pud_offset(pgd, address);
 		pud_k = pud_offset(pgd_k, address);
 		if (!pud_present(*pud_k))
 			goto no_context;
+		if (pud_none(*pud) ||
+				pud_page_vaddr(*pud) != pud_page_vaddr(*pud_k))
+			goto no_context;
 
 		pmd = pmd_offset(pud, address);
 		pmd_k = pmd_offset(pud_k, address);
 		if (!pmd_present(*pmd_k))
 			goto no_context;
-		set_pmd(pmd, *pmd_k);
+		if (!pmd_present(*pmd))
+			set_pmd(pmd, *pmd_k);
+		else
+			if (pmd_page(*pmd) != pmd_page(*pmd_k))
+				goto no_context;
 
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))

--------------060200050905030006090904--
