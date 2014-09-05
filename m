Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 03:04:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14863 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025893AbaIEBD6D1TFT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 03:03:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AB3C72C2A93CB;
        Fri,  5 Sep 2014 02:03:49 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:03:50 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:03:50 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 5 Sep 2014 02:03:50 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 4 Sep
 2014 18:03:47 -0700
Subject: [PATCH 1/3] MIPS: rearrange PTE bits into fixed positions
To:     <linux-mips@linux-mips.org>, <hauke@hauke-m.de>, <yanh@lemote.com>,
        <zajec5@gmail.com>, <ralf@linux-mips.org>, <alex.smith@imgtec.com>,
        <taohl@lemote.com>, <chenhc@lemote.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Thu, 4 Sep 2014 18:03:47 -0700
Message-ID: <20140905010347.15448.38394.stgit@linux-yegoshin>
In-Reply-To: <20140905010124.15448.53707.stgit@linux-yegoshin>
References: <20140905010124.15448.53707.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42395
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

Previously, code did a runtime check of RIXI and made runtime
shifts/etc to fit into PTE as much as possible PFN bits.
However, because there is no HUGE page support for MIPS32 R2
there is a way to fit all required bits in fixed positions:
PTE low bits are: CCC D V G RI(=R) XI M A W P
TLB refill will do a ROTR 6 (in case of cpu_has_rixi),
or SRL 6 to strip low bits.
All 20 bits PFN are preserved in high bits (4GB with 4KB pages)

Also rearrange PTE bits for MIPS64 R2 in fixed positions:
PTE low bits are: CCC D V G RI XI [S H] M A W R P
TLB refill will do a ROTR 7/9 (in case of cpu_has_rixi),
or SRL/DSRL 7/9 to strip low bits in absense of RIXI.
PFN size in high bits is 49 or 51 bits --> 512TB or 4*512TB for 4KB pages

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h |  102 ++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e592f36..4183771 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -102,6 +102,8 @@
 #define _CACHE_MASK		(1 << _CACHE_UNCACHED_SHIFT)
 
 #else /* 'Normal' r4K case */
+
+#ifndef CONFIG_CPU_MIPSR2
 /*
  * When using the RI/XI bit support, we have 13 bits of flags below
  * the physical address. The RI/XI bits are placed such that a SRL 5
@@ -154,6 +156,106 @@
 #define _PAGE_NO_READ_SHIFT	(cpu_has_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
 #define _PAGE_NO_READ		({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_READ_SHIFT; })
 
+#else /* CONFIG_CPU_MIPSR2 */
+
+/* static bits allocation in MIPS R2, two variants -
+   HUGE TLB in 64BIT kernel support or not.
+   RIXI support in both */
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Low bits are: CCC D V G RI XI [S H] M A W R P
+ * TLB refill will do a ROTR 7/9 (in case of cpu_has_rixi),
+ * or SRL/DSRL 7/9 to strip low bits.
+ * PFN size in high bits is 49 or 51 bit --> 512TB or 4*512TB for 4KB pages
+ */
+
+#define _PAGE_PRESENT_SHIFT	(0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+/* implemented in software, should be unused if cpu_has_rixi. */
+#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
+/* implemented in software */
+#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
+#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+/* implemented in software */
+#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
+#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
+/* implemented in software */
+#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
+#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+/* set:pagecache unset:swap */
+#define _PAGE_FILE		(_PAGE_MODIFIED)
+
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+/* huge tlb page */
+#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+#define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
+#define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT + 1)
+#define _PAGE_SPLITTING		(1 << _PAGE_SPLITTING_SHIFT)
+#else
+#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
+#define _PAGE_HUGE		({BUG(); 1; })	/* Dummy value */
+#define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT)
+#define _PAGE_SPLITTING		({BUG(); 1; })	/* Dummy value */
+#endif /* CONFIG_MIPS_HUGE_TLB_SUPPORT */
+
+/* Page cannot be executed */
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+#define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
+
+/* Page cannot be read */
+#define _PAGE_NO_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
+
+#else /* !CONFIG_64BIT */
+
+/*
+ * No HUGE page support
+ * Low bits are: CCC D V G RI(=R) XI M A W P
+ * TLB refill will do a ROTR 6 (in case of cpu_has_rixi),
+ * or SRL 6 to strip low bits.
+ * All 20 bits PFN are preserved in high bits (4GB in 4KB pages)
+ */
+
+#define _PAGE_PRESENT_SHIFT	(0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+/* implemented in software */
+#define _PAGE_WRITE_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+/* implemented in software */
+#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
+#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
+/* implemented in software */
+#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
+#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+/* set:pagecache unset:swap */
+#define _PAGE_FILE		(_PAGE_MODIFIED)
+
+/* huge tlb page dummies */
+#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
+#define _PAGE_HUGE		({BUG(); 1; })	/* Dummy value */
+#define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT)
+#define _PAGE_SPLITTING		({BUG(); 1; })	/* Dummy value */
+
+/* Page cannot be executed */
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+#define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
+
+/* Page cannot be read */
+#define _PAGE_NO_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
+
+/* implemented in software, should be unused if cpu_has_rixi. */
+#define _PAGE_READ_SHIFT	(_PAGE_NO_READ_SHIFT)
+#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
+
+#endif /* CONFIG_64BIT */
+
+#endif /* !CONFIG_CPU_MIPSR2 */
+
+
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 
