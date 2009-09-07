Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2009 20:24:46 +0200 (CEST)
Received: from [65.98.92.6] ([65.98.92.6]:4175 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493455AbZIGSYi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Sep 2009 20:24:38 +0200
Received: (qmail 30898 invoked from network); 7 Sep 2009 18:24:35 -0000
Received: from unknown (HELO two) (127.0.0.1)
  by 127.0.0.1 with SMTP; 7 Sep 2009 18:24:35 -0000
Received: by two (sSMTP sendmail emulation); Mon, 07 Sep 2009 11:24:35 -0700
From:	Kevin Cernekee <cernekee@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:	Mon, 7 Sep 2009 11:11:31 -0700
Subject: [PATCHv2] MIPS: Machine check exception in kmap_coherent()
Message-Id: <2c228c5e48509b7c8296a6c50af3ad73@localhost>
In-Reply-To: <20090907102613.GA25295@linux-mips.org>
References: <20090907102613.GA25295@linux-mips.org>
User-Agent: vim 7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Create an extra set of fixmap entries for use in interrupt handlers.
This prevents fixmap VA conflicts between copy_user_highpage() running
in user context, and local_r4k_flush_cache_page() invoked from an SMP
IPI.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/fixmap.h |    4 ++--
 arch/mips/mm/init.c            |    6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 0f5caa1..dd924b9 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -48,9 +48,9 @@ enum fixed_addresses {
 #define FIX_N_COLOURS 8
 	FIX_CMAP_BEGIN,
 #ifdef CONFIG_MIPS_MT_SMTC
-	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS),
+	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS * 2),
 #else
-	FIX_CMAP_END = FIX_CMAP_BEGIN + FIX_N_COLOURS,
+	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * 2),
 #endif
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0e82050..43ebe65 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
 #include <linux/pfn.h>
+#include <linux/hardirq.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -132,7 +133,10 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	inc_preempt_count();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 #ifdef CONFIG_MIPS_MT_SMTC
-	idx += FIX_N_COLOURS * smp_processor_id();
+	idx += FIX_N_COLOURS * smp_processor_id() +
+		(in_interrupt() ? (FIX_N_COLOURS * NR_CPUS) : 0);
+#else
+	idx += in_interrupt() ? FIX_N_COLOURS : 0;
 #endif
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
 	pte = mk_pte(page, PAGE_KERNEL);
-- 
1.6.3.1
