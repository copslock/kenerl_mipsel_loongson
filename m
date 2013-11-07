Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 18:10:22 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43747 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3KGRJ566ZCf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 18:09:57 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/6] MIPS: mm: Move UNIQUE_ENTRYHI macro to a header file
Date:   Thu, 7 Nov 2013 17:08:36 +0000
Message-ID: <1383844120-29601-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_07_17_09_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The UNIQUE_ENTRYHI definition was duplicated whenever there
was the need to flush the TLB entries. We move this common
definition to a header file.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/tlb.h | 2 ++
 arch/mips/mm/init.c         | 2 --
 arch/mips/mm/tlb-r4k.c      | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
index c67842b..235367ce 100644
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -18,6 +18,8 @@
  */
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
+#define UNIQUE_ENTRYHI(idx)	(CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+
 #include <asm-generic/tlb.h>
 
 #endif /* __ASM_TLB_H */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index e205ef5..6f44a31 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -171,8 +171,6 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	return (void*) vaddr;
 }
 
-#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
-
 void kunmap_coherent(void)
 {
 #ifndef CONFIG_MIPS_MT_SMTC
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index da3b0b9..363aa03 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -20,16 +20,11 @@
 #include <asm/bootinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
+#include <asm/tlb.h>
 #include <asm/tlbmisc.h>
 
 extern void build_tlb_refill_handler(void);
 
-/*
- * Make sure all entries differ.  If they're not different
- * MIPS32 will take revenge ...
- */
-#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
-
 /* Atomicity and interruptability */
 #ifdef CONFIG_MIPS_MT_SMTC
 
-- 
1.8.4
