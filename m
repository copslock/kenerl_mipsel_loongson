Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 04:08:58 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:54149 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006150AbbB0DI41p2MZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Feb 2015 04:08:56 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t1R37fu0010830;
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
Subject: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
Date:   Thu, 26 Feb 2015 19:07:13 -0800
Message-Id: <1425006434-3106-5-git-send-email-keescook@chromium.org>
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
X-archive-position: 46032
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

This moves arch_mmap_rnd() into the ELF loader for handling ET_DYN ASLR
in a separate region from mmap ASLR, as already done on s390. Removes
CONFIG_BINFMT_ELF_RANDOMIZE_PIE.

Reported-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Kconfig            |  1 -
 arch/arm64/Kconfig          |  1 -
 arch/mips/Kconfig           |  1 -
 arch/powerpc/Kconfig        |  1 -
 arch/s390/include/asm/elf.h |  4 ++--
 arch/x86/Kconfig            |  1 -
 fs/Kconfig.binfmt           |  3 ---
 fs/binfmt_elf.c             | 17 ++---------------
 8 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 248d99cabaa8..e2f0ef9c6ee3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,7 +1,6 @@
 config ARM
 	bool
 	default y
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5f469095e0e2..07e0fc7adc88 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,5 @@
 config ARM64
 	def_bool y
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 72ce5cece768..557c5f1772c1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -23,7 +23,6 @@ config MIPS
 	select HAVE_KRETPROBES
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_SYSCALL_TRACEPOINTS
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select RTC_LIB if !MACH_LOONGSON
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 14fe1c411489..910fa4f9ad1e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -88,7 +88,6 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 9ed68e7ee856..617f7fabdb0a 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -163,9 +163,9 @@ extern unsigned int vdso_enabled;
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk. 64-bit
    tasks are aligned to 4GB. */
-#define ELF_ET_DYN_BASE (arch_mmap_rnd() + (is_32bit_task() ? \
+#define ELF_ET_DYN_BASE	(is_32bit_task() ? \
 				(STACK_TOP / 3 * 2) : \
-				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)))
+				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9aa91727fbf8..328be0fab910 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -87,7 +87,6 @@ config X86
 	select HAVE_ARCH_KMEMCHECK
 	select HAVE_ARCH_KASAN if X86_64 && SPARSEMEM_VMEMMAP
 	select HAVE_USER_RETURN_NOTIFIER
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 270c48148f79..2d0cbbd14cfc 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -27,9 +27,6 @@ config COMPAT_BINFMT_ELF
 	bool
 	depends on COMPAT && BINFMT_ELF
 
-config ARCH_BINFMT_ELF_RANDOMIZE_PIE
-	bool
-
 config ARCH_BINFMT_ELF_STATE
 	bool
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b1c5ef5d9322..203c2e6f9a25 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -910,21 +910,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * default mmap base, as well as whatever program they
 			 * might try to exec.  This is because the brk will
 			 * follow the loader, and is not movable.  */
-#ifdef CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE
-			/* Memory randomization might have been switched off
-			 * in runtime via sysctl or explicit setting of
-			 * personality flags.
-			 * If that is the case, retain the original non-zero
-			 * load_bias value in order to establish proper
-			 * non-randomized mappings.
-			 */
-			if (current->flags & PF_RANDOMIZE)
-				load_bias = 0;
-			else
-				load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-#else
-			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-#endif
+			load_bias = ELF_ET_DYN_BASE + arch_mmap_rnd() - vaddr;
+			load_bias = ELF_PAGESTART(load_bias);
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
-- 
1.9.1
