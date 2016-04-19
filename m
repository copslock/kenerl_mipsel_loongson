Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:26:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57336 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027013AbcDSI0fBan8Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:26:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id AE3F037B5A48B;
        Tue, 19 Apr 2016 09:26:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:26:27 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:26:26 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 04/13] MIPS: Use enums to make asm/pgtable-bits.h readable
Date:   Tue, 19 Apr 2016 09:25:02 +0100
Message-ID: <1461054311-387-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
References: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.185]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

asm/pgtable-bits.h has grown to become an unreadable mess of #ifdef
directives defining bits conditionally upon other bits all at the
preprocessing stage, for no good reason.

Instead of having quite so many #ifdef's, simply use enums to provide
sequential numbering for bit shifts, without having to keep track
manually of what the last bit defined was. Masks are defined separately,
after the shifts, which allows for most of their definitions to be
reused for all systems rather than duplicated.

This patch is not intended to make any behavioural change to the code -
all bits should be used in the same way they were before this patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/include/asm/pgtable-bits.h | 189 +++++++++++++++--------------------
 1 file changed, 81 insertions(+), 108 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 2f40312..c81fc17 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -35,36 +35,25 @@
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
 /*
- * The following bits are implemented by the TLB hardware
+ * Page table bit offsets used for 64 bit physical addressing on MIPS32,
+ * for example with Alchemy, Netlogic XLP/XLR or XPA.
  */
-#define _PAGE_NO_EXEC_SHIFT	0
-#define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
-#define _PAGE_NO_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
-#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
-#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-#define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
-#define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
-#define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
-#define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
-#define _CACHE_SHIFT		(_PAGE_DIRTY_SHIFT + 1)
-#define _CACHE_MASK		(7 << _CACHE_SHIFT)
-
-/*
- * The following bits are implemented in software
- */
-#define _PAGE_PRESENT_SHIFT	(24)
-#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
-#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
-#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
-#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
-#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
-#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
-#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
-
-#define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
+enum pgtable_bits {
+	/* Used by TLB hardware (placed in EntryLo*) */
+	_PAGE_NO_EXEC_SHIFT,
+	_PAGE_NO_READ_SHIFT,
+	_PAGE_GLOBAL_SHIFT,
+	_PAGE_VALID_SHIFT,
+	_PAGE_DIRTY_SHIFT,
+	_CACHE_SHIFT,
+
+	/* Used only by software (masked out before writing EntryLo*) */
+	_PAGE_PRESENT_SHIFT = 24,
+	_PAGE_READ_SHIFT,
+	_PAGE_WRITE_SHIFT,
+	_PAGE_ACCESSED_SHIFT,
+	_PAGE_MODIFIED_SHIFT,
+};
 
 /*
  * Bits for extended EntryLo0/EntryLo1 registers
@@ -73,101 +62,85 @@
 
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-/*
- * The following bits are implemented in software
- */
-#define _PAGE_PRESENT_SHIFT	(0)
-#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
-#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
-#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
-#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
-#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
-#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
-#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+/* Page table bits used for r3k systems */
+enum pgtable_bits {
+	/* Used only by software (writes to EntryLo ignored) */
+	_PAGE_PRESENT_SHIFT,
+	_PAGE_READ_SHIFT,
+	_PAGE_WRITE_SHIFT,
+	_PAGE_ACCESSED_SHIFT,
+	_PAGE_MODIFIED_SHIFT,
+
+	/* Used by TLB hardware (placed in EntryLo) */
+	_PAGE_GLOBAL_SHIFT = 8,
+	_PAGE_VALID_SHIFT,
+	_PAGE_DIRTY_SHIFT,
+	_CACHE_UNCACHED_SHIFT,
+};
 
-/*
- * The following bits are implemented by the TLB hardware
- */
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_MODIFIED_SHIFT + 4)
-#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-#define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
-#define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
-#define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
-#define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
-#define _CACHE_UNCACHED_SHIFT	(_PAGE_DIRTY_SHIFT + 1)
-#define _CACHE_UNCACHED		(1 << _CACHE_UNCACHED_SHIFT)
-#define _CACHE_MASK		_CACHE_UNCACHED
+#else
 
-#define _PFN_SHIFT		PAGE_SHIFT
+/* Page table bits used for r4k systems */
+enum pgtable_bits {
+	/* Used only by software (masked out before writing EntryLo*) */
+	_PAGE_PRESENT_SHIFT,
+#if !defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_MIPSR6)
+	_PAGE_READ_SHIFT,
+#endif
+	_PAGE_WRITE_SHIFT,
+	_PAGE_ACCESSED_SHIFT,
+	_PAGE_MODIFIED_SHIFT,
+#if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
+	_PAGE_HUGE_SHIFT,
+#endif
 
-#else
-/*
- * Below are the "Normal" R4K cases
- */
+	/* Used by TLB hardware (placed in EntryLo*) */
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+	_PAGE_NO_EXEC_SHIFT,
+	_PAGE_NO_READ_SHIFT,
+	_PAGE_READ_SHIFT = _PAGE_NO_READ_SHIFT,
+#endif
+	_PAGE_GLOBAL_SHIFT,
+	_PAGE_VALID_SHIFT,
+	_PAGE_DIRTY_SHIFT,
+	_CACHE_SHIFT,
+};
 
-/*
- * The following bits are implemented in software
- */
-#define _PAGE_PRESENT_SHIFT	0
+#endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
+
+/* Used only by software */
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-/* R2 or later cores check for RI/XI support to determine _PAGE_READ */
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
-#define _PAGE_WRITE_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+# define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
 #else
-#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
-#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
-#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+# define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
 #endif
-#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
+#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
-#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
-
 #if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
-/* Huge TLB page */
-#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
-#define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
-#endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
-
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
-/* XI - page cannot be executed */
-#ifdef _PAGE_HUGE_SHIFT
-#define _PAGE_NO_EXEC_SHIFT	(_PAGE_HUGE_SHIFT + 1)
-#else
-#define _PAGE_NO_EXEC_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+# define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #endif
-#define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
-
-/* RI - page cannot be read */
-#define _PAGE_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
-#define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
-#define _PAGE_NO_READ_SHIFT	_PAGE_READ_SHIFT
-#define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_READ_SHIFT) : 0)
-#endif	/* defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) */
-
-#if defined(_PAGE_NO_READ_SHIFT)
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
-#elif defined(_PAGE_HUGE_SHIFT)
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_HUGE_SHIFT + 1)
-#else
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+
+/* Used by TLB hardware (placed in EntryLo*) */
+#if (defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32))
+# define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
+# define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
+#elif defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+# define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
+# define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_NO_READ_SHIFT) : 0)
 #endif
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-
-#define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
-#define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
 #define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
-#define _CACHE_SHIFT		(_PAGE_DIRTY_SHIFT + 1)
-#define _CACHE_MASK		(7 << _CACHE_SHIFT)
-
-#define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
-
-#endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+# define _CACHE_UNCACHED	(1 << _CACHE_UNCACHED_SHIFT)
+# define _CACHE_MASK		_CACHE_UNCACHED
+# define _PFN_SHIFT		PAGE_SHIFT
+#else
+# define _CACHE_MASK		(7 << _CACHE_SHIFT)
+# define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
+#endif
 
 #ifndef _PAGE_NO_EXEC
 #define _PAGE_NO_EXEC		0
-- 
2.8.0
