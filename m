Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2015 17:19:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3676 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013232AbbBSQTJg0mox (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Feb 2015 17:19:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 43F62F2DB7FA4
        for <linux-mips@linux-mips.org>; Thu, 19 Feb 2015 16:19:00 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 19 Feb
 2015 16:19:03 +0000
Received: from solomon.ba.imgtec.org (10.20.78.13) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 19 Feb
 2015 08:19:00 -0800
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH V4 2/5] MIPS: Rearrange PTE bits into fixed positions.
Date:   Thu, 19 Feb 2015 10:18:51 -0600
Message-ID: <1424362734-30364-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1424362734-30364-1-git-send-email-Steven.Hill@imgtec.com>
References: <1424362734-30364-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.13]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

This patch rearranges the PTE bits into fixed positions for R2
and later cores. In the past, the TLB handling code did runtime
checking of RI/XI and adjusted the shifts and rotates in order
to fit the largest PFN value into the PTE. The checking now
occurs when building the TLB handler, thus eliminating those
checks. These new arrangements also define the largest possible
PFN value that can fit in the PTE. HUGE page support is only
available on 64-bit platforms.

The new layouts of the PTE bits are the following:

   64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
   32-bit, R1 or earler:      CCC D V G M A W R P
   64-bit, R2 or later:       CCC D V G RI XI [S H] M A W R P
   32-bit, R2 or later:       CCC D V G RI XI M A W R P

In the case of cores that support the RI/XI bits, the value of
the R bit is ignored.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h |   79 ++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 068ac7d..dc39ea5 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -95,50 +95,73 @@
 
 #else
 /*
- * When using the RI/XI bit support, we have 13 bits of flags below
- * the physical address. The RI/XI bits are placed such that a SRL 5
- * can strip off the software bits, then a ROTR 2 can move the RI/XI
- * into bits [63:62]. This also limits physical address to 56 bits,
- * which is more than we need right now.
+ * Below are the "Normal" R4K cases
  */
-
+#if defined(CONFIG_64BIT) || !defined(CONFIG_CPU_MIPSR2)
 /*
  * The following bits are implemented in software
  */
 #define _PAGE_PRESENT_SHIFT	(0)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-#define _PAGE_READ_SHIFT	(cpu_has_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ ({BUG_ON(cpu_has_rixi); 1 << _PAGE_READ_SHIFT; })
+#define _PAGE_READ_SHIFT        (_PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_READ              (1 << _PAGE_READ_SHIFT)
 #define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+#else
+#define _PAGE_PRESENT_SHIFT	(0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+#define _PAGE_WRITE_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
+#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
+#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
+#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+#endif
 
-#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+#if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
 /* huge tlb page */
 #define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT + 1)
 #define _PAGE_SPLITTING		(1 << _PAGE_SPLITTING_SHIFT)
-#else
-#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
-#define _PAGE_HUGE		({BUG(); 1; })	/* Dummy value */
-#define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT)
-#define _PAGE_SPLITTING		({BUG(); 1; })	/* Dummy value */
-#endif
 
+#ifdef CONFIG_CPU_MIPSR2
 /* Page cannot be executed */
-#define _PAGE_NO_EXEC_SHIFT	(cpu_has_rixi ? _PAGE_SPLITTING_SHIFT + 1 : _PAGE_SPLITTING_SHIFT)
-#define _PAGE_NO_EXEC		({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_EXEC_SHIFT; })
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+
+#else	/* !CONFIG_CPU_MIPSR2 */
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+/* not supported */
+#define _PAGE_NO_EXEC		(0)
+#define _PAGE_NO_READ		(0)
+#endif	/* CONFIG_CPU_MIPSR2 */
+
+#endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
+
+#ifdef CONFIG_CPU_MIPSR2
+/* if not defined, we are 32BIT */
+#ifndef _PAGE_NO_EXEC_SHIFT
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+#endif
+#define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
 
 /* Page cannot be read */
-#define _PAGE_NO_READ_SHIFT	(cpu_has_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
-#define _PAGE_NO_READ		({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_READ_SHIFT; })
+#define _PAGE_NO_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
+
+/* unused if cpu_has_rixi */
+#define _PAGE_READ_SHIFT	_PAGE_NO_READ_SHIFT
+#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
 
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+#endif
+
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
 #define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
@@ -148,6 +171,14 @@
 
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 
+/*
+ * Below are the different layouts of the PTE bits:
+ *
+ *   64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
+ *   32-bit, R1 or earler:      CCC D V G M A W R P
+ *   64-bit, R2 or later:       CCC D V G RI XI [S H] M A W R P
+ *   32-bit, R2 or later:       CCC D V G RI XI M A W R P
+ */
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
 
 /*
@@ -159,14 +190,6 @@
 
 #define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
 
-#ifndef _PAGE_NO_READ
-#define _PAGE_NO_READ ({BUG(); 0; })
-#define _PAGE_NO_READ_SHIFT ({BUG(); 0; })
-#endif
-#ifndef _PAGE_NO_EXEC
-#define _PAGE_NO_EXEC ({BUG(); 0; })
-#endif
-
 
 #ifndef __ASSEMBLY__
 /*
@@ -249,7 +272,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_UNCACHED_ACCELERATED	(7<<_CACHE_SHIFT)
 #endif
 
-#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_rixi ? 0 : _PAGE_READ))
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_READ | _PAGE_ACCESSED)
 #define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
-- 
1.7.10.4
