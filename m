Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 01:50:42 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12414 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021953AbZE1Auf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 01:50:35 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1ddfb50000>; Wed, 27 May 2009 20:49:57 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:50:07 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:50:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4S0nVXo027961;
	Wed, 27 May 2009 17:49:31 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4S0msqB027957;
	Wed, 27 May 2009 17:48:54 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/5] MIPS: Add hugeTLBfs page defines.
Date:	Wed, 27 May 2009 17:47:43 -0700
Message-Id: <1243471666-27915-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A1DDED7.3020306@caviumnetworks.com>
References: <4A1DDED7.3020306@caviumnetworks.com>
X-OriginalArrivalTime: 28 May 2009 00:50:07.0002 (UTC) FILETIME=[3EB097A0:01C9DF2E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h     |   16 ++++++++++++++++
 arch/mips/include/asm/page.h         |    5 +++++
 arch/mips/include/asm/pgtable-bits.h |    1 +
 arch/mips/include/asm/pgtable.h      |   10 ++++++++++
 4 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 32ef8be..a581d60 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -220,6 +220,22 @@
 #error Bad page size configuration!
 #endif
 
+/*
+ * Default huge tlb size for a given kernel configuration
+ */
+#ifdef CONFIG_PAGE_SIZE_4KB
+#define PM_HUGE_MASK	PM_1M
+#elif defined(CONFIG_PAGE_SIZE_8KB)
+#define PM_HUGE_MASK	PM_4M
+#elif defined(CONFIG_PAGE_SIZE_16KB)
+#define PM_HUGE_MASK	PM_16M
+#elif defined(CONFIG_PAGE_SIZE_32KB)
+#define PM_HUGE_MASK	PM_64M
+#elif defined(CONFIG_PAGE_SIZE_64KB)
+#define PM_HUGE_MASK	PM_256M
+#elif defined(CONFIG_HUGETLB_PAGE)
+#error Bad page size configuration for hugetlbfs!
+#endif
 
 /*
  * Values used for computation of new tlb entries
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 9f946e4..61ef073 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -32,6 +32,11 @@
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
 
+#define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
+#define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
+#define HPAGE_MASK	(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/pfn.h>
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 51b34a4..1073e6d 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -72,6 +72,7 @@
 #else
 
 #define _PAGE_R4KBUG                (1<<5)  /* workaround for r4k bug  */
+#define _PAGE_HUGE                  (1<<5)  /* huge tlb page */
 #define _PAGE_GLOBAL                (1<<6)
 #define _PAGE_VALID                 (1<<7)
 #define _PAGE_SILENT_READ           (1<<7)  /* synonym                 */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 6a0edf7..1a9f9b2 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -292,6 +292,16 @@ static inline pte_t pte_mkyoung(pte_t pte)
 		pte_val(pte) |= _PAGE_SILENT_READ;
 	return pte;
 }
+
+#ifdef _PAGE_HUGE
+static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_HUGE;
+	return pte;
+}
+#endif /* _PAGE_HUGE */
 #endif
 static inline int pte_special(pte_t pte)	{ return 0; }
 static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
-- 
1.6.0.6
