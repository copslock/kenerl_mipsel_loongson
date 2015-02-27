Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 04:10:57 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:34641 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006155AbbB0DKihyDOA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Feb 2015 04:10:38 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t1R37o42010868;
        Thu, 26 Feb 2015 19:07:50 -0800
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
Subject: [PATCH 5/5] mm: fold arch_randomize_brk into ARCH_HAS_ELF_RANDOMIZE
Date:   Thu, 26 Feb 2015 19:07:14 -0800
Message-Id: <1425006434-3106-6-git-send-email-keescook@chromium.org>
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
X-archive-position: 46034
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

On architectures that define CONFIG_ARCH_HAS_ELF_RANDOMIZE, collapse the
function declarations while continuing to handle CONFIG_COMPAT_BRK.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                   |  1 +
 arch/arm/include/asm/elf.h     |  4 ----
 arch/arm64/include/asm/elf.h   |  4 ----
 arch/mips/include/asm/elf.h    |  4 ----
 arch/powerpc/include/asm/elf.h |  4 ----
 arch/s390/include/asm/elf.h    |  3 ---
 arch/x86/include/asm/elf.h     |  3 ---
 fs/binfmt_elf.c                |  4 +---
 include/linux/elf-randomize.h  | 12 ++++++++++++
 9 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e315cc79ebe7..1c7e98f137db 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,7 @@ config ARCH_HAS_ELF_RANDOMIZE
 	  An architecture supports choosing randomized locations for
 	  stack, mmap, brk, and ET_DYN. Defined functions:
 	  - arch_mmap_rnd(), must respect (current->flags & PF_RANDOMIZE)
+	  - arch_randomize_brk()
 
 #
 # ABI hall of shame
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index afb9cafd3786..c1ff8ab12914 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -125,10 +125,6 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 #ifdef CONFIG_MMU
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index f724db00b235..faad6df49e5b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -156,10 +156,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
 #endif
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 #ifdef CONFIG_COMPAT
 
 #ifdef __AARCH64EB__
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 535f196ffe02..31d747d46a23 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -410,10 +410,6 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 struct arch_elf_state {
 	int fp_abi;
 	int interp_fp_abi;
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 57d289acb803..ee46ffef608e 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -128,10 +128,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 	(0x7ff >> (PAGE_SHIFT - 12)) : \
 	(0x3ffff >> (PAGE_SHIFT - 12)))
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
-
 #ifdef CONFIG_SPU_BASE
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 617f7fabdb0a..7cc271003ff6 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -226,9 +226,6 @@ struct linux_binprm;
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 int arch_setup_additional_pages(struct linux_binprm *, int);
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 void *fill_cpu_elf_notes(void *ptr, struct save_area *sa, __vector128 *vxrs);
 
 #endif
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index ca3347a9dab5..bbdace22daf8 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -338,9 +338,6 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 /*
  * True on X86_32 or when emulating IA32 on X86_64
  */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 203c2e6f9a25..96459c18d1eb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1041,15 +1041,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-#ifdef arch_randomize_brk
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
-#ifdef CONFIG_COMPAT_BRK
+#ifdef compat_brk_randomized
 		current->brk_randomized = 1;
 #endif
 	}
-#endif
 
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
diff --git a/include/linux/elf-randomize.h b/include/linux/elf-randomize.h
index 7a4eda02d2b1..b5f0bda9472e 100644
--- a/include/linux/elf-randomize.h
+++ b/include/linux/elf-randomize.h
@@ -1,10 +1,22 @@
 #ifndef _ELF_RANDOMIZE_H
 #define _ELF_RANDOMIZE_H
 
+struct mm_struct;
+
 #ifndef CONFIG_ARCH_HAS_ELF_RANDOMIZE
 static inline unsigned long arch_mmap_rnd(void) { return 0; }
+# if defined(arch_randomize_brk) && defined(CONFIG_COMPAT_BRK)
+#  define compat_brk_randomized
+# endif
+# ifndef arch_randomize_brk
+#  define arch_randomize_brk(mm)	(mm->brk)
+# endif
 #else
 extern unsigned long arch_mmap_rnd(void);
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+# ifdef CONFIG_COMPAT_BRK
+#  define compat_brk_randomized
+# endif
 #endif
 
 #endif
-- 
1.9.1
