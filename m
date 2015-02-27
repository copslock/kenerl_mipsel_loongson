Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 04:10:40 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:33585 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006150AbbB0DKidbhTC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Feb 2015 04:10:38 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t1R37fHn010828;
        Thu, 26 Feb 2015 19:07:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Behan Webster <behanw@converseincode.com>,
        Ismael Ripoll <iripoll@upv.es>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] mm: expose arch_mmap_rnd when available
Date:   Thu, 26 Feb 2015 19:07:11 -0800
Message-Id: <1425006434-3106-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1425006434-3106-1-git-send-email-keescook@chromium.org>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

When an architecture fully supports randomizing the ELF load location, the
arch_mmap_rnd() function becomes available. Rename and expose these functions
where they exist. Introduces CONFIG_ARCH_HAS_ELF_RANDOMIZE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                  |  7 +++++++
 arch/arm/Kconfig              |  1 +
 arch/arm/mm/mmap.c            |  4 ++--
 arch/arm64/Kconfig            |  1 +
 arch/arm64/mm/mmap.c          |  4 ++--
 arch/mips/Kconfig             |  1 +
 arch/mips/mm/mmap.c           |  9 ++++++---
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/mm/mmap.c        |  4 ++--
 arch/s390/Kconfig             |  1 +
 arch/s390/mm/mmap.c           |  8 ++++----
 arch/x86/Kconfig              |  1 +
 arch/x86/mm/mmap.c            |  6 +++---
 fs/binfmt_elf.c               |  1 +
 include/linux/elf-randomize.h | 10 ++++++++++
 15 files changed, 43 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/elf-randomize.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a458d5..e315cc79ebe7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -484,6 +484,13 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	  This spares a stack switch and improves cache usage on softirq
 	  processing.
 
+config ARCH_HAS_ELF_RANDOMIZE
+	bool
+	help
+	  An architecture supports choosing randomized locations for
+	  stack, mmap, brk, and ET_DYN. Defined functions:
+	  - arch_mmap_rnd(), must respect (current->flags & PF_RANDOMIZE)
+
 #
 # ABI hall of shame
 #
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a2bc9b..248d99cabaa8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	default y
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 0f8bc158f2c6..3c1fedb034bb 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -169,7 +169,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0UL;
 
@@ -183,7 +183,7 @@ static unsigned long mmap_rnd(void)
 
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
-	unsigned long random_factor = mmap_rnd();
+	unsigned long random_factor = arch_mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e97331ffb..5f469095e0e2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 54922d1275b8..b7117cb4bc07 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -47,7 +47,7 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
@@ -66,7 +66,7 @@ static unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(STACK_TOP - gap - mmap_rnd());
+	return PAGE_ALIGN(STACK_TOP - gap - arch_mmap_rnd());
 }
 
 /*
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c7a16904cd03..72ce5cece768 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -24,6 +24,7 @@ config MIPS
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select RTC_LIB if !MACH_LOONGSON
 	select GENERIC_ATOMIC64 if !64BIT
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index f1baadd56e82..d32490d99671 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -164,9 +164,12 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	}
 }
 
-static inline unsigned long brk_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
-	unsigned long rnd = get_random_int();
+	unsigned long rnd = 0;
+
+	if (current->flags & PF_RANDOMIZE)
+		rnd = get_random_int();
 
 	rnd = rnd << PAGE_SHIFT;
 	/* 8MB for 32bit, 256MB for 64bit */
@@ -183,7 +186,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	unsigned long base = mm->brk;
 	unsigned long ret;
 
-	ret = PAGE_ALIGN(base + brk_rnd());
+	ret = PAGE_ALIGN(base + arch_mmap_rnd());
 
 	if (ret < mm->brk)
 		return mm->brk;
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940494bb..14fe1c411489 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -89,6 +89,7 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index cb8bdbe4972f..d1111b49f03d 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -53,7 +53,7 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
@@ -76,7 +76,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
+	return PAGE_ALIGN(TASK_SIZE - gap - arch_mmap_rnd());
 }
 
 /*
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 373cd5badf1c..4d707bb3e8dd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -65,6 +65,7 @@ config S390
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 179a2c20b01f..77759e35671b 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -60,7 +60,7 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
@@ -72,7 +72,7 @@ static unsigned long mmap_rnd(void)
 
 static unsigned long mmap_base_legacy(void)
 {
-	return TASK_UNMAPPED_BASE + mmap_rnd();
+	return TASK_UNMAPPED_BASE + arch_mmap_rnd();
 }
 
 static inline unsigned long mmap_base(void)
@@ -84,7 +84,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 	gap &= PAGE_MASK;
-	return STACK_TOP - stack_maxrandom_size() - mmap_rnd() - gap;
+	return STACK_TOP - stack_maxrandom_size() - arch_mmap_rnd() - gap;
 }
 
 unsigned long
@@ -187,7 +187,7 @@ unsigned long randomize_et_dyn(void)
 	if (!is_32bit_task())
 		/* Align to 4GB */
 		base &= ~((1UL << 32) - 1);
-	return base + mmap_rnd();
+	return base + arch_mmap_rnd();
 }
 
 #ifndef CONFIG_64BIT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c2fb8a87dccb..9aa91727fbf8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -88,6 +88,7 @@ config X86
 	select HAVE_ARCH_KASAN if X86_64 && SPARSEMEM_VMEMMAP
 	select HAVE_USER_RETURN_NOTIFIER
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select SPARSE_IRQ
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index df4552bd239e..a65e2b3154da 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -65,7 +65,7 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
@@ -91,7 +91,7 @@ static unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
+	return PAGE_ALIGN(TASK_SIZE - gap - arch_mmap_rnd());
 }
 
 /*
@@ -103,7 +103,7 @@ static unsigned long mmap_legacy_base(void)
 	if (mmap_is_ia32())
 		return TASK_UNMAPPED_BASE;
 	else
-		return TASK_UNMAPPED_BASE + mmap_rnd();
+		return TASK_UNMAPPED_BASE + arch_mmap_rnd();
 }
 
 /*
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 995986b8e36b..b1c5ef5d9322 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -31,6 +31,7 @@
 #include <linux/security.h>
 #include <linux/random.h>
 #include <linux/elf.h>
+#include <linux/elf-randomize.h>
 #include <linux/utsname.h>
 #include <linux/coredump.h>
 #include <linux/sched.h>
diff --git a/include/linux/elf-randomize.h b/include/linux/elf-randomize.h
new file mode 100644
index 000000000000..7a4eda02d2b1
--- /dev/null
+++ b/include/linux/elf-randomize.h
@@ -0,0 +1,10 @@
+#ifndef _ELF_RANDOMIZE_H
+#define _ELF_RANDOMIZE_H
+
+#ifndef CONFIG_ARCH_HAS_ELF_RANDOMIZE
+static inline unsigned long arch_mmap_rnd(void) { return 0; }
+#else
+extern unsigned long arch_mmap_rnd(void);
+#endif
+
+#endif
-- 
1.9.1
