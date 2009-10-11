Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 16:52:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45292 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492559AbZJKOwR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 16:52:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9BErWtd000926;
	Sun, 11 Oct 2009 16:53:32 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9BErUx3000924;
	Sun, 11 Oct 2009 16:53:30 +0200
Date:	Sun, 11 Oct 2009 16:53:30 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Dearman <chris@mips.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Avoid potential hazard on Context register
Message-ID: <20091011145330.GA23369@linux-mips.org>
References: <4AD17619.1000201@mips.com> <20091011133912.GA15684@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091011133912.GA15684@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

There is no hazard barrier between writes to c0_context and subsequent
read accesses.  This is a fairly theoretical hole as c0_context is only
written on CPU bootup and other, unrelated code will almost certainly
execute a hazard barrier somewhen between the write and read access.
Even if not, the window is probably in the thousands of cycles so likely
too large to actually consistute a pipeline hazard.

Reported and initial patch by Chris Dearman <chris@mips.com>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/mmu_context.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index ed331c2..6083db5 100644
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
@@ -36,11 +37,13 @@ extern unsigned long pgd_current[];
 #ifdef CONFIG_32BIT
 #define TLBMISS_HANDLER_SETUP()						\
 	write_c0_context((unsigned long) smp_processor_id() << 25);	\
+	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 #ifdef CONFIG_64BIT
 #define TLBMISS_HANDLER_SETUP()						\
 	write_c0_context((unsigned long) smp_processor_id() << 26);	\
+	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 
