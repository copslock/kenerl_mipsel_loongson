Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 03:23:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6005 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013392AbbEOBXVW0WmE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 03:23:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E7E21D22F5B3;
        Fri, 15 May 2015 02:23:16 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 15 May
 2015 02:23:17 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 15 May
 2015 02:23:17 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 14 May
 2015 18:23:14 -0700
Subject: [PATCH] MIPS64: Support of at least 48 bits of SEGBITS
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <aleksey.makarov@auriga.com>, <james.hogan@imgtec.com>,
        <paul.burton@imgtec.com>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <davidlohr@hp.com>, <kirill@shutemov.name>,
        <akpm@linux-foundation.org>, <mingo@kernel.org>
Date:   Thu, 14 May 2015 18:23:14 -0700
Message-ID: <20150515012314.6819.30051.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

SEGBITS default is 40 bits or less, depending from CPU type.
This patch introduces 48bits of application virtual address (SEGBITS) support.
It is defined only for 16K and 64K pages and is optional (configurable).

Penalty - a small number of additional pages for generic (small) applications.
But for 64K pages it adds 3rd level of PTE structure, which has a little
impact during software TLB refill.

This patch is needed because MIPS I6XXX and P6XXX cores have 48 bit of
virtual address in each segment (SEGBITS).

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/Kconfig                  |   10 ++++++++++
 arch/mips/include/asm/pgtable-64.h |   18 +++++++++++-------
 arch/mips/include/asm/processor.h  |    2 +-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 76efb02ae99f..0a151a59a9ac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2032,6 +2032,16 @@ config PAGE_SIZE_64KB
 
 endchoice
 
+config 48VMBITS
+	bool "48 bits virtual memory"
+	depends on PAGE_SIZE_16KB || PAGE_SIZE_64KB
+	help
+	  Define a maximum at least 48 bits of application virtual memory.
+	  Default is 40 bits or less, depending from CPU.
+	  In generic (small) application it is a small set of pages increase
+	  in page tables.
+	  If unsure, say N.
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index cf661a2fb141..c6b5473440e6 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -17,7 +17,7 @@
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
 
-#ifdef CONFIG_PAGE_SIZE_64KB
+#if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_48VMBITS)
 #include <asm-generic/pgtable-nopmd.h>
 #else
 #include <asm-generic/pgtable-nopud.h>
@@ -90,7 +90,11 @@
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
-#define PGD_ORDER		0
+#ifdef CONFIG_48VMBITS
+#define PGD_ORDER               1
+#else
+#define PGD_ORDER               0
+#endif
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_ORDER		0
 #define PTE_ORDER		0
@@ -104,7 +108,11 @@
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#ifdef CONFIG_48VMBITS
+#define PMD_ORDER		0
+#else
 #define PMD_ORDER		aieeee_attempt_to_allocate_pmd
+#endif
 #define PTE_ORDER		0
 #endif
 
@@ -114,11 +122,7 @@
 #endif
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
-#if PGDIR_SIZE >= TASK_SIZE64
-#define USER_PTRS_PER_PGD	(1)
-#else
-#define USER_PTRS_PER_PGD	(TASK_SIZE64 / PGDIR_SIZE)
-#endif
+#define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
 #define FIRST_USER_ADDRESS	0UL
 
 /*
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 9b3b48e21c22..3ccb63eaa6c8 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -69,7 +69,7 @@ extern unsigned int vced_count, vcei_count;
  * 8192EB ...
  */
 #define TASK_SIZE32	0x7fff8000UL
-#define TASK_SIZE64	0x10000000000UL
+#define TASK_SIZE64     (0x1UL << cpu_data[0].vmbits)
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 #define STACK_TOP_MAX	TASK_SIZE64
 
