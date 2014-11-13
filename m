Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 16:54:04 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:38130 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013634AbaKMPwT7MG0s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 16:52:19 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Xowgu-0007pf-CM; Thu, 13 Nov 2014 09:52:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 2/8] MIPS: Rearrange PTE bits into fixed positions for MIPS R2.
Date:   Thu, 13 Nov 2014 09:51:58 -0600
Message-Id: <1415893924-36351-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44137
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Previously, code did a runtime check of RIXI and made runtime
shifts/rotates to fit the largest PFN into the PTE as possible.
However, since there is no HUGE page support for MIPS32R2 there
is a way to fit all bits in fixed positions. The PTE low bits
are defined as:

   CCC D V G RI(=R) XI M A W P

A TLB refill will do a ROTR 4/6 (RIXI) or SRL 4/6 to strip out
low bits. All 20 bits of the PFN are preserved in the high bits.
The bits for MIPS64R2 are now defined as:

   CCC D V G RI XI [S H] M A W R P

A TLB refill will do a ROTR 7/9 (RIXI) or [D]SRL 7/9 to strip
out low bits. The PFN size in the 64-bit PTE is 49 bits for
16KB pages and 51 bits for 4KB pages.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h |  101 ++++++++++++++++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c         |    4 ++
 2 files changed, 105 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e747bfa..f336281 100644
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
@@ -154,6 +156,105 @@
 #define _PAGE_NO_READ_SHIFT	(cpu_has_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
 #define _PAGE_NO_READ		({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_READ_SHIFT; })
 
+#else /* CONFIG_CPU_MIPSR2 */
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
+#define _PAGE_PRESENT_SHIFT     (0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+/* implemented in software, should be unused if cpu_has_rixi. */
+#define _PAGE_READ_SHIFT        (_PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_READ              (1 << _PAGE_READ_SHIFT)
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
+#define _PAGE_NO_EXEC_SHIFT     (_PAGE_SPLITTING_SHIFT + 1)
+#define _PAGE_NO_EXEC           (1 << _PAGE_NO_EXEC_SHIFT)
+
+/* Page cannot be read */
+#define _PAGE_NO_READ_SHIFT     (_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ           (1 << _PAGE_NO_READ_SHIFT)
+
+#else /* !CONFIG_64BIT */
+
+#ifndef CONFIG_MIPS_HUGE_TLB_SUPPORT
+
+/*
+ * No HUGE page support
+ * Low bits are: CCC D V G RI(=R) XI M A W P
+ * TLB refill will do a ROTR 6 (in case of cpu_has_rixi),
+ * or SRL 6 to strip low bits.
+ * All 20 bits PFN are preserved in high bits (4GB in 4KB pages)
+ */
+
+#define _PAGE_PRESENT_SHIFT     (0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+/* implemented in software */
+#define _PAGE_WRITE_SHIFT       (_PAGE_PRESENT_SHIFT + 1)
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
+#define _PAGE_NO_EXEC_SHIFT     (_PAGE_SPLITTING_SHIFT + 1)
+#define _PAGE_NO_EXEC           (1 << _PAGE_NO_EXEC_SHIFT)
+
+/* Page cannot be read */
+#define _PAGE_NO_READ_SHIFT     (_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ           (1 << _PAGE_NO_READ_SHIFT)
+
+/* implemented in software, should be unused if cpu_has_rixi. */
+#define _PAGE_READ_SHIFT        (_PAGE_NO_READ_SHIFT)
+#define _PAGE_READ              (1 << _PAGE_READ_SHIFT)
+
+#endif /* !CONFIG_MIPS_HUGE_TLB_SUPPORT */
+
+#endif /* CONFIG_64BIT */
+
+#endif /* !CONFIG_CPU_MIPSR2 */
+
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5342674..17d7e12 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -399,10 +399,14 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 
 	if (config3 & MIPS_CONF3_SM) {
 		c->ases |= MIPS_ASE_SMARTMIPS;
+#if defined(CONFIG_64BIT) || !defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
 		c->options |= MIPS_CPU_RIXI;
+#endif
 	}
+#if defined(CONFIG_64BIT) || !defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
 	if (config3 & MIPS_CONF3_RXI)
 		c->options |= MIPS_CPU_RIXI;
+#endif
 	if (config3 & MIPS_CONF3_DSP)
 		c->ases |= MIPS_ASE_DSP;
 	if (config3 & MIPS_CONF3_DSP2P)
-- 
1.7.10.4
