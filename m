Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 May 2015 11:36:20 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27010730AbbECJgTDSOvf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 May 2015 11:36:19 +0200
Date:   Sun, 3 May 2015 10:36:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: pgtable-bits.h: Correct _PAGE_GLOBAL_SHIFT build
 failure
Message-ID: <alpine.LFD.2.11.1505022309360.30428@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Correct a build failure introduced by be0c37c9 [MIPS: Rearrange PTE bits 
into fixed positions.]:

In file included from ./arch/mips/include/asm/io.h:27:0,
                 from ./arch/mips/include/asm/page.h:176,
                 from include/linux/mm_types.h:15,
                 from include/linux/sched.h:27,
                 from include/linux/ptrace.h:5,
                 from arch/mips/kernel/cpu-probe.c:16:
./arch/mips/include/asm/pgtable-bits.h:164:0: error: "_PAGE_GLOBAL_SHIFT" redefined [-Werror]
 #define _PAGE_GLOBAL_SHIFT (_PAGE_MODIFIED_SHIFT + 1)
 ^
./arch/mips/include/asm/pgtable-bits.h:141:0: note: this is the location of the previous definition
 #define _PAGE_GLOBAL_SHIFT (_PAGE_SPLITTING_SHIFT + 1)
 ^
cc1: all warnings being treated as errors
make[2]: *** [arch/mips/kernel/cpu-probe.o] Error 1

for 64BIT/CPU_MIPSR1/MIPS_HUGE_TLB_SUPPORT configurations.  Remove the 
scattered double `_PAGE_NO_EXEC_SHIFT' and `_PAGE_GLOBAL_SHIFT' macro 
definitions and rearrange them so that the respective macros these 
definitions are based on are also those used for guarding conditionals.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 This is a regression present in 4.1-rc1, so please push upstream ASAP.

  Maciej

linux-mips-page-global-shift.diff
Index: linux-org/arch/mips/include/asm/pgtable-bits.h
===================================================================
--- linux-org.orig/arch/mips/include/asm/pgtable-bits.h	2015-05-02 23:12:15.583154000 +0100
+++ linux-org/arch/mips/include/asm/pgtable-bits.h	2015-05-02 23:14:28.334176000 +0100
@@ -133,20 +133,13 @@
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT + 1)
 #define _PAGE_SPLITTING		(1 << _PAGE_SPLITTING_SHIFT)
-
-/* Only R2 or newer cores have the XI bit */
-#ifdef CONFIG_CPU_MIPSR2
-#define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
-#else
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
-#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-#endif	/* CONFIG_CPU_MIPSR2 */
-
 #endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
 
 #ifdef CONFIG_CPU_MIPSR2
 /* XI - page cannot be executed */
-#ifndef _PAGE_NO_EXEC_SHIFT
+#ifdef _PAGE_SPLITTING_SHIFT
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+#else
 #define _PAGE_NO_EXEC_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #endif
 #define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
@@ -156,14 +149,16 @@
 #define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
 #define _PAGE_NO_READ_SHIFT	_PAGE_READ_SHIFT
 #define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_READ_SHIFT) : 0)
+#endif	/* CONFIG_CPU_MIPSR2 */
 
+#if defined(_PAGE_NO_READ_SHIFT)
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
-#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-
-#else	/* !CONFIG_CPU_MIPSR2 */
+#elif defined(_PAGE_SPLITTING_SHIFT)
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+#else
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+#endif
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-#endif	/* CONFIG_CPU_MIPSR2 */
 
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
