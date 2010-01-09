Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jan 2010 02:17:56 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1991 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493014Ab0AIBRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jan 2010 02:17:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b47d9420000>; Fri, 08 Jan 2010 17:17:54 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 17:17:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 17:17:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o091HmYs002386;
        Fri, 8 Jan 2010 17:17:48 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o091Hma1002384;
        Fri, 8 Jan 2010 17:17:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Use optimized memory barrier primitives.
Date:   Fri,  8 Jan 2010 17:17:44 -0800
Message-Id: <1262999864-2353-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B47D8ED.1020006@caviumnetworks.com>
References: <4B47D8ED.1020006@caviumnetworks.com>
X-OriginalArrivalTime: 09 Jan 2010 01:17:50.0241 (UTC) FILETIME=[8F6A3910:01CA90C9]
X-archive-position: 25550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6012

In order to achieve correct synchronization semantics, the Octeon port
had defined CONFIG_WEAK_REORDERING_BEYOND_LLSC.  This resulted in code
that looks like:

   sync
   ll ...
   .
   .
   .
   sc ...
   .
   .
   sync

The second SYNC was redundant, but harmless.

Octeon has a SYNCW instruction that acts as a write-memory-barrier
(due to an erratum in some parts two SYNCW are used).  It is much
faster than SYNC because it imposes ordering on the writes, but
doesn't otherwise stall the execution pipeline.  On Octeon, SYNC
stalls execution until all preceeding writes are committed to the
coherent memory system.

Using:

    syncw;syncw
    ll
    .
    .
    .
    sc
    .
    .

Has identical semantics to the first sequence, but is much faster.
The SYNCW orders the writes, and the SC will not complete successfully
until the write is committed to the coherent memory system.  So at the
end all preceeding writes have been committed.  Since Octeon does not
do speculative reads, this functions as a full barrier.

The patch removes CONFIG_WEAK_REORDERING_BEYOND_LLSC, and substitutes
SYNCW for SYNC in write-memory-barriers.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig               |    1 -
 arch/mips/include/asm/barrier.h |   43 ++++++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9dde8d1..cd04d36 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1295,7 +1295,6 @@ config CPU_CAVIUM_OCTEON
 	select SYS_SUPPORTS_SMP
 	select NR_CPUS_DEFAULT_16
 	select WEAK_ORDERING
-	select WEAK_REORDERING_BEYOND_LLSC
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
 	help
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 1a5a51c..a2670a2 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -88,12 +88,20 @@
 		: /* no output */		\
 		: "m" (*(int *)CKSEG1)		\
 		: "memory")
-
-#define fast_wmb()	__sync()
-#define fast_rmb()	__sync()
-#define fast_mb()	__sync()
-#ifdef CONFIG_SGI_IP28
-#define fast_iob()				\
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+# define OCTEON_SYNCW_STR	".set push\n.set arch=octeon\nsyncw\nsyncw\n.set pop\n"
+# define __syncw() 	__asm__ __volatile__(OCTEON_SYNCW_STR : : : "memory")
+
+# define fast_wmb()	__syncw()
+# define fast_rmb()	barrier()
+# define fast_mb()	__sync()
+# define fast_iob()	do { } while (0)
+#else /* ! CONFIG_CPU_CAVIUM_OCTEON */
+# define fast_wmb()	__sync()
+# define fast_rmb()	__sync()
+# define fast_mb()	__sync()
+# ifdef CONFIG_SGI_IP28
+#  define fast_iob()				\
 	__asm__ __volatile__(			\
 		".set	push\n\t"		\
 		".set	noreorder\n\t"		\
@@ -104,13 +112,14 @@
 		: /* no output */		\
 		: "m" (*(int *)CKSEG1ADDR(0x1fa00004)) \
 		: "memory")
-#else
-#define fast_iob()				\
+# else
+#  define fast_iob()				\
 	do {					\
 		__sync();			\
 		__fast_iob();			\
 	} while (0)
-#endif
+# endif
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
 
 #ifdef CONFIG_CPU_HAS_WB
 
@@ -131,9 +140,15 @@
 #endif /* !CONFIG_CPU_HAS_WB */
 
 #if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
-#define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
-#define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
-#define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
+# ifdef CONFIG_CPU_CAVIUM_OCTEON
+#  define smp_mb()	__sync()
+#  define smp_rmb()	barrier()
+#  define smp_wmb()	__syncw()
+# else
+#  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
+#  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
+# endif
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
@@ -151,6 +166,10 @@
 
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define smp_mb__before_llsc() smp_wmb()
+#else
 #define smp_mb__before_llsc() smp_llsc_mb()
+#endif
 
 #endif /* __ASM_BARRIER_H */
-- 
1.6.0.6
