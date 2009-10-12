Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 05:19:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56685 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1491999AbZJLDTo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 05:19:44 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9C3KxxR027807;
	Mon, 12 Oct 2009 05:21:00 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9C3KxXj027805;
	Mon, 12 Oct 2009 05:20:59 +0200
Date:	Mon, 12 Oct 2009 05:20:59 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Dearman <chris@mips.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Avoid potential hazard on Context register
Message-ID: <20091012032059.GA27744@linux-mips.org>
References: <4AD17619.1000201@mips.com> <20091011133912.GA15684@linux-mips.org> <20091011145330.GA23369@linux-mips.org> <4AD23F92.8030902@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD23F92.8030902@mips.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 11, 2009 at 01:26:58PM -0700, Chris Dearman wrote:

> Ralf Baechle wrote:
>> There is no hazard barrier between writes to c0_context and subsequent
>> read accesses.  This is a fairly theoretical hole as c0_context is only
>> written on CPU bootup and other, unrelated code will almost certainly
> It was actually in the bootup code where I saw the problem, and this  
> patch doesn't deal with that case:
>
>>         MTC0            zero, CP0_CONTEXT       # clear context 
>> register         PTR_LA          $28, init_thread_union         /* Set 
>> the SP after an empty pt_regs.  */         PTR_LI          sp, 
>> _THREAD_SIZE - 32 - PT_SIZE         PTR_ADDU        sp, $28         
>> back_to_back_c0_hazard         set_saved_sp    sp, t0, t1 
>
> The problem I observed is that the Context valuse used by set_saved_sp  
> is whatever it inherits from YAMON.

So we need a double hazard barrier like below.

  Ralf

There is no hazard barrier between writes to c0_context and subsequent
read accesses.  This is a fairly theoretical hole as c0_context is only
written on CPU bootup and other, unrelated code will almost certainly
execute a hazard barrier somewhen between the write and read access.
Even if not, the window is probably in the thousands of cycles so likely
too large to actually consistute a pipeline hazard.

Reported and initial patch by Chris Dearman <chris@mips.com>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/mmu_context.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index ed331c2..d339d9d 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
+#include <asm/hazards.h>
 #include <asm/tlbflush.h>
 #ifdef CONFIG_MIPS_MT_SMTC
 #include <asm/mipsmtregs.h>
@@ -35,12 +36,16 @@ extern unsigned long pgd_current[];
 
 #ifdef CONFIG_32BIT
 #define TLBMISS_HANDLER_SETUP()						\
+	back_to_back_c0_hazard();					\
 	write_c0_context((unsigned long) smp_processor_id() << 25);	\
+	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 #ifdef CONFIG_64BIT
 #define TLBMISS_HANDLER_SETUP()						\
+	back_to_back_c0_hazard();					\
 	write_c0_context((unsigned long) smp_processor_id() << 26);	\
+	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 
