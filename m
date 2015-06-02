Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 10:00:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38082 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006736AbbFBH76pkLW4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 09:59:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B9328A5455AB3;
        Tue,  2 Jun 2015 01:09:46 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 2 Jun
 2015 01:09:47 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 2 Jun
 2015 01:09:46 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 1 Jun 2015
 17:09:43 -0700
Subject: [PATCH 2/3] MIPS: enforce LL-SC loop enclosing with SYNC (ACQUIRE
 and RELEASE)
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>, <davem@davemloft.net>
Date:   Mon, 1 Jun 2015 17:09:43 -0700
Message-ID: <20150602000943.6668.28434.stgit@ubuntu-yegoshin>
In-Reply-To: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47777
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

Many MIPS32 R2 and all MIPS R6 CPUs are out of order execution, so it
needs memory barriers in SMP environment. However, past cores may have
a pipeline short enough to ignore that requirements and problem may
never occurs until recently.

This patch gives an option to enclose LL-SC loops by SYNC barriers in spinlocks,
atomics, futexes, cmpxchg and bitops.

So, this option is defined for MIPS32 R2 only, because that recent
CPUs may occasionally have problems in accordance with HW team.
And most of MIPS64 R2 vendor processors already have some kind of memory
barrier and the only one generic 5KEs has a pretty short pipeline.

Using memory barriers in MIPS R6 is mandatory, all that
processors have a speculative memory read which can inflict a trouble
without a correct use of barriers in LL-SC loop cycles.
The same is actually for MIPS32 R5 I5600 processor.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/Kconfig               |   25 +++++++++++++++++++++++++
 arch/mips/include/asm/barrier.h |   26 ++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c7d0cacece3d..676eb64f5545 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1896,6 +1896,30 @@ config MIPS_LIGHTWEIGHT_SYNC
 	  converted to generic "SYNC 0".
 
 	  If you unsure, say N here, it may slightly decrease your performance
+
+config MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC
+	bool "Enforce memory barriers at LLSC loops - atomics, spinlocks etc"
+	depends on CPU_MIPS32_R2
+	default y if CPU_MIPSR6
+	select WEAK_REORDERING_BEYOND_LLSC
+	help
+	  Many MIPS32 R2 and all MIPS R6 CPUs are out of order execution, so it
+	  needs memory barriers in SMP environment. However, past cores may have
+	  a pipeline short enough to ignore that requirements and problem may
+	  never occurs until recently.
+
+	  So, this option is defined for MIPS32 R2 only, because that recent
+	  CPUs may occasionally have problems in accordance with HW team.
+	  And MIPS64 R2 vendor processors already have some kind of memory
+	  barrier and the only one generic 5KEs has a pretty short pipeline.
+
+	  Using memory barriers in MIPS R6 is mandatory, all that
+	  processors have a speculative memory read which can inflict a trouble
+	  without a correct use of barriers in LL-SC loop cycles.
+	  The same is actually for MIPS32 R5 I5600 processor.
+
+	  If you unsure, say Y here, it may slightly decrease your performance
+	  but increase a reliability.
 endmenu
 
 #
@@ -1924,6 +1948,7 @@ config CPU_MIPSR2
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
+	select MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_SPRAM
 
 config EVA
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index d2a63abfc7c6..f3cc7a91ac0d 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -95,33 +95,51 @@
 #  define smp_mb()	__sync()
 #  define smp_rmb()	barrier()
 #  define smp_wmb()	__syncw()
+#  define smp_acquire() __sync()
+#  define smp_release() __sync()
 # else
 #  ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
 #  define smp_mb()      __asm__ __volatile__("sync 0x10" : : :"memory")
 #  define smp_rmb()     __asm__ __volatile__("sync 0x13" : : :"memory")
 #  define smp_wmb()     __asm__ __volatile__("sync 0x4" : : :"memory")
+#  define smp_acquire() __asm__ __volatile__("sync 0x11" : : :"memory")
+#  define smp_release() __asm__ __volatile__("sync 0x12" : : :"memory")
 #  else
 #  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
 #  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
 #  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define smp_acquire() __asm__ __volatile__("sync" : : :"memory")
+#  define smp_release() __asm__ __volatile__("sync" : : :"memory")
 #  endif
 # endif
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_acquire()   barrier()
+#define smp_release()   barrier()
 #endif
 
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
+#ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
+#define __WEAK_LLSC_MB          "       sync    0x10    \n"
+#define __WEAK_ACQUIRE          "       sync    0x11    \n"
+#define __WEAK_RELEASE          "       sync    0x12    \n"
+#else
 #define __WEAK_LLSC_MB		"	sync	\n"
+#define __WEAK_ACQUIRE          __WEAK_LLSC_MB
+#define __WEAK_RELEASE          __WEAK_LLSC_MB
+#endif
 #else
 #define __WEAK_LLSC_MB		"		\n"
+#define __WEAK_ACQUIRE          __WEAK_LLSC_MB
+#define __WEAK_RELEASE          __WEAK_LLSC_MB
 #endif
 
 #define set_mb(var, value) \
 	do { var = value; smp_mb(); } while (0)
 
-#define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
+#define smp_llsc_mb()           __asm__ __volatile__(__WEAK_ACQUIRE : : :"memory")
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
@@ -131,14 +149,14 @@
 					    "syncw\n\t"			\
 					    ".set pop" : : : "memory")
 #else
-#define smp_mb__before_llsc() smp_llsc_mb()
+#define smp_mb__before_llsc()   __asm__ __volatile__(__WEAK_RELEASE : : :"memory")
 #define nudge_writes() mb()
 #endif
 
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	smp_release();                                                       \
 	ACCESS_ONCE(*p) = (v);						\
 } while (0)
 
@@ -146,7 +164,7 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	smp_acquire();                                                       \
 	___p1;								\
 })
 
