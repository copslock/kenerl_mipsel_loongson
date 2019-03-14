Return-Path: <SRS0=2fIh=RR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A7C43381
	for <linux-mips@archiver.kernel.org>; Thu, 14 Mar 2019 02:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1777217F5
	for <linux-mips@archiver.kernel.org>; Thu, 14 Mar 2019 02:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruSyAjLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCNC45 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:56:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36674 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCNC45 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 13 Mar 2019 22:56:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so2963389pgr.3;
        Wed, 13 Mar 2019 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8jK5VJSZ3/R1A+P72ige4Tp9eTIQN3rzaAXW8n44Qqw=;
        b=ruSyAjLbB5H3OclJ6Efyg8XEHUSL22VPkoF6BDQafFqCZNtDtJyKu8t+gvXOviyUnT
         02Ssb7rm8dkLxq7kJscWOncJBZ4vvDGzKDl4+uMOAyjPAlFGPtZbVfcDbMMChwM2yhj6
         NUvnCDPkF3C49zqXnEehTEBKGhjFiznsb+9mgYYIKEYD9rMUFdGKROQEWwodIpIrDd72
         9FjgvwECt4LXhbScno10ClE5HlLvGbn1X2Zbyj67ifGx/9IZ0iwPqqwj4mPs8k4Bfhma
         U8tbrpojuxncvSKGpubfciNA2RuowXvZTQrYf9NeDLKkRfphGRu9Yp5Clz9YsrqiheHm
         E95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=8jK5VJSZ3/R1A+P72ige4Tp9eTIQN3rzaAXW8n44Qqw=;
        b=p7lmpGCnHF04MOLoFhA+4kbmONkwPBL20PAemI+/0LUgJigjXW6y0vkEnXorNZaS00
         SAoBrYDv9P8faYdQj69ZfI3+d1abzaKy/uMB3qQyB3zm/2bTs2e3Et8lXt4JqAmKksib
         rl/IShKCS9wBjDkcVIYRSGbip5N/Ry/EVmpZFVwN+ZLo5XVKstNaJzjgT1VdO9ig778z
         UCWwG4FQ2SA0/8aowlUnleXaQhhmqD5wtj28BvkxO/C3h0y9pLlWgRFlmDdJ/m2uebCb
         VGdzq++6qCr+aSJUWOO9EHDDmV4AS/Av0vMGe1q3716faEjpvoA3qu0E2AxcWz604Sgj
         qstQ==
X-Gm-Message-State: APjAAAUxTkTBtkMrZ5Atk5OWADTCUJRog5cXktPUkazReS4TyLqSdc3k
        s/SgpbasGA35T0hmri1DoGU=
X-Google-Smtp-Source: APXvYqxyJCiR4OR6W+8prFkszA5HgmbpRk+TcYbdA8OScSKW+iIxPwwaPzNjRVFt/ydnpCz7TiD2tw==
X-Received: by 2002:a62:69c3:: with SMTP id e186mr45965232pfc.169.1552532215675;
        Wed, 13 Mar 2019 19:56:55 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id c13sm33718213pfm.34.2019.03.13.19.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 19:56:54 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>, ambrosehua@gmail.com,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Xu Chenghua <xuchenghua@loongson.cn>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH for 4.9] MIPS: Loongson: Introduce and use loongson_llsc_mb()
Date:   Thu, 14 Mar 2019 10:58:08 +0800
Message-Id: <1552532288-4855-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
lld/scd is very weak ordering. We should add sync instructions "before
each ll/lld" and "at the branch-target between ll/sc" to workaround.
Otherwise, this flaw will cause deadlock occasionally (e.g. when doing
heavy load test with LTP).

Below is the explaination of CPU designer:

"For Loongson 3 family, when a memory access instruction (load, store,
or prefetch)'s executing occurs between the execution of LL and SC, the
success or failure of SC is not predictable. Although programmer would
not insert memory access instructions between LL and SC, the memory
instructions before LL in program-order, may dynamically executed
between the execution of LL/SC, so a memory fence (SYNC) is needed
before LL/LLD to avoid this situation.

Since Loongson-3A R2 (3A2000), we have improved our hardware design to
handle this case. But we later deduce a rarely circumstance that some
speculatively executed memory instructions due to branch misprediction
between LL/SC still fall into the above case, so a memory fence (SYNC)
at branch-target (if its target is not between LL/SC) is needed for
Loongson 3A1000, 3B1500, 3A2000 and 3A3000.

Our processor is continually evolving and we aim to to remove all these
workaround-SYNCs around LL/SC for new-come processor."

Here is an example:

Both cpu1 and cpu2 simutaneously run atomic_add by 1 on same atomic var,
this bug cause both 'sc' run by two cpus (in atomic_add) succeed at same
time('sc' return 1), and the variable is only *added by 1*, sometimes,
which is wrong and unacceptable(it should be added by 2).

Why disable fix-loongson3-llsc in compiler?
Because compiler fix will cause problems in kernel's __ex_table section.

This patch fix all the cases in kernel, but:

+. the fix at the end of futex_atomic_cmpxchg_inatomic is for branch-target
of 'bne', there other cases which smp_mb__before_llsc() and smp_llsc_mb() fix
the ll and branch-target coincidently such as atomic_sub_if_positive/
cmpxchg/xchg, just like this one.

+. Loongson 3 does support CONFIG_EDAC_ATOMIC_SCRUB, so no need to touch
edac.h

+. local_ops and cmpxchg_local should not be affected by this bug since
only the owner can write.

+. mips_atomic_set for syscall.c is deprecated and rarely used, just let
it go

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
[paul.burton@mips.com:
  - Simplify the addition of -mno-fix-loongson3-llsc to cflags, and add
    a comment describing why it's there.
  - Make loongson_llsc_mb() a no-op when
    CONFIG_CPU_LOONGSON3_WORKAROUNDS=n, rather than a compiler memory
    barrier.
  - Add a comment describing the bug & how loongson_llsc_mb() helps
    in asm/barrier.h.]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: ambrosehua@gmail.com
Cc: Steven J . Hill <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Li Xuefeng <lixuefeng@loongson.cn>
Cc: Xu Chenghua <xuchenghua@loongson.cn>
Cc: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Kconfig                | 15 +++++++++++++++
 arch/mips/include/asm/atomic.h   |  6 ++++++
 arch/mips/include/asm/barrier.h  | 36 ++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/bitops.h   |  5 +++++
 arch/mips/include/asm/futex.h    |  3 +++
 arch/mips/include/asm/pgtable.h  |  2 ++
 arch/mips/include/asm/spinlock.h |  7 +++++++
 arch/mips/loongson64/Platform    | 23 +++++++++++++++++++++++
 arch/mips/mm/tlbex.c             | 10 ++++++++++
 9 files changed, 107 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bb9940c..4766262 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1396,6 +1396,21 @@ config LOONGSON3_ENHANCEMENT
 	  please say 'N' here. If you want a high-performance kernel to run on
 	  new Loongson 3 machines only, please say 'Y' here.
 
+config CPU_LOONGSON3_WORKAROUNDS
+	bool "Old Loongson 3 LLSC Workarounds"
+	default y if SMP
+	depends on CPU_LOONGSON3
+	help
+	  Loongson 3 processors have the llsc issues which require workarounds.
+	  Without workarounds the system may hang unexpectedly.
+
+	  Newer Loongson 3 will fix these issues and no workarounds are needed.
+	  The workarounds have no significant side effect on them but may
+	  decrease the performance of the system so this option should be
+	  disabled unless the kernel is intended to be run on old systems.
+
+	  If unsure, please say Y.
+
 config CPU_LOONGSON2E
 	bool "Loongson 2E"
 	depends on SYS_HAS_CPU_LOONGSON2E
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176b..31ecdda 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -59,6 +59,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
 									      \
+		loongson_llsc_mb();					      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
@@ -100,6 +101,7 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
 									      \
+		loongson_llsc_mb();					      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
@@ -148,6 +150,7 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
 									      \
+		loongson_llsc_mb();					      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
@@ -401,6 +404,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
 									      \
+		loongson_llsc_mb();					      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
@@ -442,6 +446,7 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
 									      \
+		loongson_llsc_mb();					      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
@@ -491,6 +496,7 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
 									      \
+		loongson_llsc_mb();					      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index a5eb1bb..b7f6ac5 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -222,6 +222,42 @@
 #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
 #define __smp_mb__after_atomic()	smp_llsc_mb()
 
+/*
+ * Some Loongson 3 CPUs have a bug wherein execution of a memory access (load,
+ * store or pref) in between an ll & sc can cause the sc instruction to
+ * erroneously succeed, breaking atomicity. Whilst it's unusual to write code
+ * containing such sequences, this bug bites harder than we might otherwise
+ * expect due to reordering & speculation:
+ *
+ * 1) A memory access appearing prior to the ll in program order may actually
+ *    be executed after the ll - this is the reordering case.
+ *
+ *    In order to avoid this we need to place a memory barrier (ie. a sync
+ *    instruction) prior to every ll instruction, in between it & any earlier
+ *    memory access instructions. Many of these cases are already covered by
+ *    smp_mb__before_llsc() but for the remaining cases, typically ones in
+ *    which multiple CPUs may operate on a memory location but ordering is not
+ *    usually guaranteed, we use loongson_llsc_mb() below.
+ *
+ *    This reordering case is fixed by 3A R2 CPUs, ie. 3A2000 models and later.
+ *
+ * 2) If a conditional branch exists between an ll & sc with a target outside
+ *    of the ll-sc loop, for example an exit upon value mismatch in cmpxchg()
+ *    or similar, then misprediction of the branch may allow speculative
+ *    execution of memory accesses from outside of the ll-sc loop.
+ *
+ *    In order to avoid this we need a memory barrier (ie. a sync instruction)
+ *    at each affected branch target, for which we also use loongson_llsc_mb()
+ *    defined below.
+ *
+ *    This case affects all current Loongson 3 CPUs.
+ */
+#ifdef CONFIG_CPU_LOONGSON3_WORKAROUNDS /* Loongson-3's LLSC workaround */
+#define loongson_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
+#else
+#define loongson_llsc_mb()	do { } while (0)
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef..38a162d 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -68,6 +68,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	" __LL "%0, %1		# set_bit	\n"
@@ -78,6 +79,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
@@ -120,6 +122,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		: "ir" (~(1UL << bit)));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	" __LL "%0, %1		# clear_bit	\n"
@@ -130,6 +133,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
@@ -188,6 +192,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index a9e61ea..0a62a91 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -50,6 +50,7 @@
 		  "i" (-EFAULT)						\
 		: "memory");						\
 	} else if (cpu_has_llsc) {					\
+		loongson_llsc_mb();					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
@@ -162,6 +163,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		  "i" (-EFAULT)
 		: "memory");
 	} else if (cpu_has_llsc) {
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"# futex_atomic_cmpxchg_inatomic			\n"
 		"	.set	push					\n"
@@ -190,6 +192,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
 		  "i" (-EFAULT)
 		: "memory");
+		loongson_llsc_mb();
 	} else
 		return -ENOSYS;
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 9e9e944..aab7b38 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -229,6 +229,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
 		} else if (kernel_uses_llsc) {
+			loongson_llsc_mb();
 			__asm__ __volatile__ (
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	.set	push				\n"
@@ -244,6 +245,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	.set	mips0				\n"
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
+			loongson_llsc_mb();
 		}
 #else /* !CONFIG_SMP */
 		if (pte_none(*buddy))
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index a8df44d..30f980b 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -115,6 +115,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		  [my_ticket] "=&r" (my_ticket)
 		: [inc] "r" (inc));
 	} else {
+		loongson_llsc_mb();
 		__asm__ __volatile__ (
 		"	.set push		# arch_spin_lock	\n"
 		"	.set noreorder					\n"
@@ -190,6 +191,7 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		  [now_serving] "=&r" (tmp3)
 		: [inc] "r" (inc));
 	} else {
+		loongson_llsc_mb();
 		__asm__ __volatile__ (
 		"	.set push		# arch_spin_trylock	\n"
 		"	.set noreorder					\n"
@@ -259,6 +261,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"1:	ll	%1, %2	# arch_read_lock	\n"
@@ -320,6 +323,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"1:	ll	%1, %2	# arch_write_lock	\n"
@@ -345,6 +349,7 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 	: "=m" (rw->lock)
 	: "m" (rw->lock)
 	: "memory");
+	nudge_writes();
 }
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
@@ -370,6 +375,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"	.set	noreorder	# arch_read_trylock	\n"
 		"	li	%2, 0					\n"
@@ -414,6 +420,7 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	ll	%1, %3	# arch_write_trylock	\n"
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 0fce460..c1a4d4d 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -23,6 +23,29 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
 endif
 
 cflags-$(CONFIG_CPU_LOONGSON3)	+= -Wa,--trap
+
+#
+# Some versions of binutils, not currently mainline as of 2019/02/04, support
+# an -mfix-loongson3-llsc flag which emits a sync prior to each ll instruction
+# to work around a CPU bug (see loongson_llsc_mb() in asm/barrier.h for a
+# description).
+#
+# We disable this in order to prevent the assembler meddling with the
+# instruction that labels refer to, ie. if we label an ll instruction:
+#
+# 1: ll v0, 0(a0)
+#
+# ...then with the assembler fix applied the label may actually point at a sync
+# instruction inserted by the assembler, and if we were using the label in an
+# exception table the table would no longer contain the address of the ll
+# instruction.
+#
+# Avoid this by explicitly disabling that assembler behaviour. If upstream
+# binutils does not merge support for the flag then we can revisit & remove
+# this later - for now it ensures vendor toolchains don't cause problems.
+#
+cflags-$(CONFIG_CPU_LOONGSON3)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+
 #
 # binutils from v2.25 on and gcc starting from v4.9.0 treat -march=loongson3a
 # as MIPS64 R2; older versions as just R1.  This leaves the possibility open
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 2da5649..0026c77 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -931,6 +931,8 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 * to mimic that here by taking a load/istream page
 		 * fault.
 		 */
+		if (IS_ENABLED(CONFIG_CPU_LOONGSON3_WORKAROUNDS))
+			uasm_i_sync(p, 0);
 		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(p, ptr);
 
@@ -1637,6 +1639,8 @@ static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
+	if (IS_ENABLED(CONFIG_CPU_LOONGSON3_WORKAROUNDS))
+		uasm_i_sync(p, 0);
 # ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if (cpu_has_64bits)
 		uasm_i_lld(p, pte, 0, ptr);
@@ -2218,6 +2222,8 @@ static void build_r4000_tlb_load_handler(void)
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	if (IS_ENABLED(CONFIG_CPU_LOONGSON3_WORKAROUNDS))
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
@@ -2273,6 +2279,8 @@ static void build_r4000_tlb_store_handler(void)
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	if (IS_ENABLED(CONFIG_CPU_LOONGSON3_WORKAROUNDS))
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
@@ -2329,6 +2337,8 @@ static void build_r4000_tlb_modify_handler(void)
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	if (IS_ENABLED(CONFIG_CPU_LOONGSON3_WORKAROUNDS))
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-- 
2.7.0

