Return-Path: <SRS0=93BA=PR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB43C43387
	for <linux-mips@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5BC206B6
	for <linux-mips@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfAIMoB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:44:01 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:57884 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbfAIMn6 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 9 Jan 2019 07:43:58 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 35F2972CA5E;
        Wed,  9 Jan 2019 15:43:53 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 2AAA17CCE38; Wed,  9 Jan 2019 15:43:53 +0300 (MSK)
Date:   Wed, 9 Jan 2019 15:43:53 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Mark Salter <msalter@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] syscall_get_arch: add "struct task_struct *" argument
Message-ID: <20190109124353.GN11981@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This argument is required to extend the generic ptrace API with
PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going
to be called from ptrace_request() along with syscall_get_nr(),
syscall_get_arguments(), syscall_get_error(), and
syscall_get_return_value() functions with a tracee as their argument.

The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
should describe what system call is being called and what its arguments
are.

Reverts: 5e937a9ae913 ("syscall_get_arch: remove useless function arguments")
Reverts: 1002d94d3076 ("syscall.h: fix doc text for syscall_get_arch()")
Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Kees Cook <keescook@chromium.org> # seccomp parts
Acked-by: Mark Salter <msalter@redhat.com> # for the c6x bit
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: x86@kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: nios2-dev@lists.rocketboards.org
Cc: openrisc@lists.librecores.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/alpha/include/asm/syscall.h      |  2 +-
 arch/arc/include/asm/syscall.h        |  2 +-
 arch/arm/include/asm/syscall.h        |  2 +-
 arch/arm64/include/asm/syscall.h      |  4 ++--
 arch/c6x/include/asm/syscall.h        |  2 +-
 arch/csky/include/asm/syscall.h       |  2 +-
 arch/h8300/include/asm/syscall.h      |  2 +-
 arch/hexagon/include/asm/syscall.h    |  2 +-
 arch/ia64/include/asm/syscall.h       |  2 +-
 arch/m68k/include/asm/syscall.h       |  2 +-
 arch/microblaze/include/asm/syscall.h |  2 +-
 arch/mips/include/asm/syscall.h       |  6 +++---
 arch/mips/kernel/ptrace.c             |  2 +-
 arch/nds32/include/asm/syscall.h      |  2 +-
 arch/nios2/include/asm/syscall.h      |  2 +-
 arch/openrisc/include/asm/syscall.h   |  2 +-
 arch/parisc/include/asm/syscall.h     |  4 ++--
 arch/powerpc/include/asm/syscall.h    | 10 ++++++++--
 arch/riscv/include/asm/syscall.h      |  2 +-
 arch/s390/include/asm/syscall.h       |  4 ++--
 arch/sh/include/asm/syscall_32.h      |  2 +-
 arch/sh/include/asm/syscall_64.h      |  2 +-
 arch/sparc/include/asm/syscall.h      |  5 +++--
 arch/unicore32/include/asm/syscall.h  |  2 +-
 arch/x86/include/asm/syscall.h        |  8 +++++---
 arch/x86/um/asm/syscall.h             |  2 +-
 arch/xtensa/include/asm/syscall.h     |  2 +-
 include/asm-generic/syscall.h         |  5 +++--
 kernel/auditsc.c                      |  4 ++--
 kernel/seccomp.c                      |  4 ++--
 30 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/include/asm/syscall.h b/arch/alpha/include/asm/syscall.h
index d73a6fcb519c..11c688c1d7ec 100644
--- a/arch/alpha/include/asm/syscall.h
+++ b/arch/alpha/include/asm/syscall.h
@@ -4,7 +4,7 @@
 
 #include <uapi/linux/audit.h>
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_ALPHA;
 }
diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscall.h
index c7fc4c0c3bcb..caf2697ef5b7 100644
--- a/arch/arc/include/asm/syscall.h
+++ b/arch/arc/include/asm/syscall.h
@@ -70,7 +70,7 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 }
 
 static inline int
-syscall_get_arch(void)
+syscall_get_arch(struct task_struct *task)
 {
 	return IS_ENABLED(CONFIG_ISA_ARCOMPACT)
 		? (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 06dea6bce293..3940ceac0bdc 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -104,7 +104,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->ARM_r0 + i, args, n * sizeof(args[0]));
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* ARM tasks don't change audit architectures on the fly. */
 	return AUDIT_ARCH_ARM;
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ad8be16a39c9..1870df03f774 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -117,9 +117,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
  * We don't care about endianness (__AUDIT_ARCH_LE bit) here because
  * AArch64 has the same system calls both on little- and big- endian.
  */
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
-	if (is_compat_task())
+	if (is_compat_thread(task_thread_info(task)))
 		return AUDIT_ARCH_ARM;
 
 	return AUDIT_ARCH_AARCH64;
diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
index 39dbd1ef994c..595057191c9c 100644
--- a/arch/c6x/include/asm/syscall.h
+++ b/arch/c6x/include/asm/syscall.h
@@ -121,7 +121,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
 		? AUDIT_ARCH_C6XBE : AUDIT_ARCH_C6X;
diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index d637445737b7..150ffb894fa2 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -70,7 +70,7 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 }
 
 static inline int
-syscall_get_arch(void)
+syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_CSKY;
 }
diff --git a/arch/h8300/include/asm/syscall.h b/arch/h8300/include/asm/syscall.h
index 5135910616e2..d316c3d40d4e 100644
--- a/arch/h8300/include/asm/syscall.h
+++ b/arch/h8300/include/asm/syscall.h
@@ -49,7 +49,7 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 }
 
 static inline int
-syscall_get_arch(void)
+syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_H8300;
 }
diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index de3917aad3fd..47b0bc3f16be 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -46,7 +46,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_HEXAGON;
 }
diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
index 1d0b875fec44..47ab33f5448a 100644
--- a/arch/ia64/include/asm/syscall.h
+++ b/arch/ia64/include/asm/syscall.h
@@ -81,7 +81,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	ia64_syscall_get_set_arguments(task, regs, i, n, args, 1);
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_IA64;
 }
diff --git a/arch/m68k/include/asm/syscall.h b/arch/m68k/include/asm/syscall.h
index d4d7deda8d50..465ac039be09 100644
--- a/arch/m68k/include/asm/syscall.h
+++ b/arch/m68k/include/asm/syscall.h
@@ -4,7 +4,7 @@
 
 #include <uapi/linux/audit.h>
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_M68K;
 }
diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
index 220decd605a4..77a86fafa974 100644
--- a/arch/microblaze/include/asm/syscall.h
+++ b/arch/microblaze/include/asm/syscall.h
@@ -101,7 +101,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs);
 asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_MICROBLAZE;
 }
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 6cf8ffb5367e..6a22c9352ef6 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -140,14 +140,14 @@ extern const unsigned long sys_call_table[];
 extern const unsigned long sys32_call_table[];
 extern const unsigned long sysn32_call_table[];
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_MIPS;
 #ifdef CONFIG_64BIT
-	if (!test_thread_flag(TIF_32BIT_REGS)) {
+	if (!test_tsk_thread_flag(task, TIF_32BIT_REGS)) {
 		arch |= __AUDIT_ARCH_64BIT;
 		/* N32 sets only TIF_32BIT_ADDR */
-		if (test_thread_flag(TIF_32BIT_ADDR))
+		if (test_tsk_thread_flag(task, TIF_32BIT_ADDR))
 			arch |= __AUDIT_ARCH_CONVENTION_MIPS64_N32;
 	}
 #endif
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 0057c910bc2f..2ead6ff919b7 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1418,7 +1418,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		unsigned long args[6];
 
 		sd.nr = syscall;
-		sd.arch = syscall_get_arch();
+		sd.arch = syscall_get_arch(current);
 		syscall_get_arguments(current, regs, 0, 6, args);
 		for (i = 0; i < 6; i++)
 			sd.args[i] = args[i];
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index cc56a3962f8b..7501e376a6b1 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -188,7 +188,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 }
 
 static inline int
-syscall_get_arch(void)
+syscall_get_arch(struct task_struct *task)
 {
 	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
 		? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index cf35e210fc4d..f0f6ae208e78 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -136,7 +136,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_NIOS2;
 }
diff --git a/arch/openrisc/include/asm/syscall.h b/arch/openrisc/include/asm/syscall.h
index 2db9f1cf0694..46b10c674bd2 100644
--- a/arch/openrisc/include/asm/syscall.h
+++ b/arch/openrisc/include/asm/syscall.h
@@ -72,7 +72,7 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_OPENRISC;
 }
diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index 8bff1a58c97f..c04ffc6ac928 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -62,11 +62,11 @@ static inline void syscall_rollback(struct task_struct *task,
 	/* do nothing */
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_PARISC;
 #ifdef CONFIG_64BIT
-	if (!is_compat_task())
+	if (!__is_compat_task(task))
 		arch = AUDIT_ARCH_PARISC64;
 #endif
 	return arch;
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 1a0e7a8b1c81..efb50429c9f4 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -99,9 +99,15 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		regs->orig_gpr3 = args[0];
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
-	int arch = is_32bit_task() ? AUDIT_ARCH_PPC : AUDIT_ARCH_PPC64;
+	int arch;
+
+	if (IS_ENABLED(CONFIG_PPC64) && !test_tsk_thread_flag(task, TIF_32BIT))
+		arch = AUDIT_ARCH_PPC64;
+	else
+		arch = AUDIT_ARCH_PPC;
+
 #ifdef __LITTLE_ENDIAN__
 	arch |= __AUDIT_ARCH_LE;
 #endif
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index bba3da6ef157..ca120a36a037 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -100,7 +100,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_64BIT
 	return AUDIT_ARCH_RISCV64;
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 96f9a9151fde..5a40ea8b90ea 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -92,10 +92,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		regs->orig_gpr2 = args[0];
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_COMPAT
-	if (test_tsk_thread_flag(current, TIF_31BIT))
+	if (test_tsk_thread_flag(task, TIF_31BIT))
 		return AUDIT_ARCH_S390;
 #endif
 	return AUDIT_ARCH_S390X;
diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 6e118799831c..08de429eccd4 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -95,7 +95,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_SH;
 
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index 43882580c7f9..9b62a2404531 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -63,7 +63,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->regs[2 + i], args, n * sizeof(args[0]));
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_SH;
 
diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index 053989e3f6a6..9ffb367c17fd 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -128,10 +128,11 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		regs->u_regs[UREG_I0 + i + j] = args[j];
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 #if defined(CONFIG_SPARC64) && defined(CONFIG_COMPAT)
-	return in_compat_syscall() ? AUDIT_ARCH_SPARC : AUDIT_ARCH_SPARC64;
+	return test_tsk_thread_flag(task, TIF_32BIT)
+		? AUDIT_ARCH_SPARC : AUDIT_ARCH_SPARC64;
 #elif defined(CONFIG_SPARC64)
 	return AUDIT_ARCH_SPARC64;
 #else
diff --git a/arch/unicore32/include/asm/syscall.h b/arch/unicore32/include/asm/syscall.h
index 3a6b885476b4..607961797fff 100644
--- a/arch/unicore32/include/asm/syscall.h
+++ b/arch/unicore32/include/asm/syscall.h
@@ -4,7 +4,7 @@
 
 #include <uapi/linux/audit.h>
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_UNICORE;
 }
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index d653139857af..435f3f09279c 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -107,7 +107,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->bx + i, args, n * sizeof(args[0]));
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_I386;
 }
@@ -236,10 +236,12 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		}
 }
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* x32 tasks should be considered AUDIT_ARCH_X86_64. */
-	return in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
+	return (IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		task->thread_info.status & TS_COMPAT)
+		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 #endif	/* CONFIG_X86_32 */
 
diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index ef898af102d1..56a2f0913e3c 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -9,7 +9,7 @@ typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_X86_32
 	return AUDIT_ARCH_I386;
diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index a168bf81c7f4..0681ca656809 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -14,7 +14,7 @@
 #include <asm/ptrace.h>
 #include <uapi/linux/audit.h>
 
-static inline int syscall_get_arch(void)
+static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_XTENSA;
 }
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 0c938a4354f6..e0d060b43321 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -144,14 +144,15 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 
 /**
  * syscall_get_arch - return the AUDIT_ARCH for the current system call
+ * @task:	task of interest, must be blocked
  *
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
- * It's only valid to call this when current is stopped on entry to a system
+ * It's only valid to call this when @task is stopped on entry to a system
  * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
  */
-int syscall_get_arch(void);
+int syscall_get_arch(struct task_struct *task);
 #endif	/* _ASM_SYSCALL_H */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6593a5207fb0..919fe4ef4314 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1505,7 +1505,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 			return;
 	}
 
-	context->arch	    = syscall_get_arch();
+	context->arch	    = syscall_get_arch(current);
 	context->major      = major;
 	context->argv[0]    = a1;
 	context->argv[1]    = a2;
@@ -2480,7 +2480,7 @@ void audit_seccomp(unsigned long syscall, long signr, int code)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
-			 signr, syscall_get_arch(), syscall,
+			 signr, syscall_get_arch(current), syscall,
 			 in_compat_syscall(), KSTK_EIP(current), code);
 	audit_log_end(ab);
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d7f538847b84..803a69e6af37 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -148,7 +148,7 @@ static void populate_seccomp_data(struct seccomp_data *sd)
 	unsigned long args[6];
 
 	sd->nr = syscall_get_nr(task, regs);
-	sd->arch = syscall_get_arch();
+	sd->arch = syscall_get_arch(task);
 	syscall_get_arguments(task, regs, 0, 6, args);
 	sd->args[0] = args[0];
 	sd->args[1] = args[1];
@@ -589,7 +589,7 @@ static void seccomp_init_siginfo(kernel_siginfo_t *info, int syscall, int reason
 	info->si_code = SYS_SECCOMP;
 	info->si_call_addr = (void __user *)KSTK_EIP(current);
 	info->si_errno = reason;
-	info->si_arch = syscall_get_arch();
+	info->si_arch = syscall_get_arch(current);
 	info->si_syscall = syscall;
 }
 
-- 
ldv
