Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6FC169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925432175B
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrIkGZ6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfBFMBT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:01:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43176 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMBT (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 07:01:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so2967126plb.10
        for <linux-mips@vger.kernel.org>; Wed, 06 Feb 2019 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bogk6pcvWffju0yM8fIqllYghtYYFwTdPsO3Yx7P7Ok=;
        b=ZrIkGZ6K8bC7cw0kwK1i2gayp7wRx7kzHgDV1q8dKSQljk4qzCx7XxncyxqW7z5FvI
         JuYgqZiztSeP9Xl6Tr7nEnUMzycPcf8xM3DOtY44+E320jCQwpvYb7MXfdeNXH1Apas3
         t78JdmMR15EWlQ22fLpLsMiBeSJIhe+2T3YXV4Sp6QUwif4JxuWZaTz2taE/w3elSYmt
         xqmRFSOie3q+MQLz3A+S+w2fb0VWZtaS7NKY0JjSEmvbAm0bm0mPCWdAnOE1xedXubbq
         0OeZI8r72WkxHQA145fItnzgJLzAEZWKy3aLih06BIy3l5Q4HvLKNk+Fti0P1K9HUlWG
         DPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=bogk6pcvWffju0yM8fIqllYghtYYFwTdPsO3Yx7P7Ok=;
        b=ZqF8i8fkVkP9y/5Jp3gArk88WQxBi7v+wUTCL63EqoJehW8z3MDIBaP5L4/15viF/j
         p0eAThWZVhVEuaeceIJ7nfzp2gEe+aDCWoicF0oMl8aczIREzvApGiIrHR7cxh0Hs7ox
         zCxV8PkRMWhv38nMgH4dsSmPmGjCbxhpP7l2yqvEuMcHU/7fYcKbqcqMViTeMx6qUTEi
         7Vpk1WY8QcbfR0xERsRXg1ZDER72Asp02KHX0mUyibb0fv52m1KhgWcpF6x4ruKEs31h
         E5cKBRh4b+TSiyIwFH8Y5ukcrun9yuNphPwN1tC2ptcvvvZ0Rvu7jxxOVZLRHbdgpW1F
         BIzA==
X-Gm-Message-State: AHQUAubs4VMjlRJKVZSEOGMTNn8xMnT+k9DVotAbUGkNVkazofp1rP5r
        udlivNjTQNDBwbUa3lENvPg=
X-Google-Smtp-Source: AHgI3IZ+oc1tpPC9JPEG+37aoCy41fL9vyyx3v7H49mHDmnC00QNfMb9ODUeTlUgjn0kaYClERyYYw==
X-Received: by 2002:a17:902:704c:: with SMTP id h12mr10651177plt.30.1549454478015;
        Wed, 06 Feb 2019 04:01:18 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id z14sm6544394pgv.47.2019.02.06.04.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 04:01:17 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Add syscall auditing support
Date:   Wed,  6 Feb 2019 20:01:20 +0800
Message-Id: <1549454480-8962-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Ralf Baechle <ralf@linux-mips.org>

The original patch is from Ralf. I have maintained it for more than six
years on Loongson platform, and it works perfectly. Most of the commit
messages are written by Ralf.

MIPS doesn't quite fit into the existing pattern of other architectures
and I'd appreciate your comments and maybe even an Acked-by.

 - Linux on MIPS extends the traditional syscall table used by older UNIX
   implementations.  This is why 32-bit Linux syscalls are starting from
   4000; the native 64-bit syscalls start from 5000 and the N32 compat ABI
   from 6000.  The existing syscall bitmap is only large enough for at most
   2048 syscalls, so I had to increase AUDIT_BITMASK_SIZE to 256 which
   provides enough space for 8192 syscalls.  Because include/uapi/linux/
   audit.h and AUDIT_BITMASK_SIZE are exported to userspace I've used an
   #ifdef __mips__ for this.

 - The code treats the little endian MIPS architecture as separate from
   big endian.  Combined with the 3 ABIs that's 6 combinations.  I tried
   to sort of follow the example set by ARM which explicitly lists the
   (rare) big endian architecture variant - but it doesn't seem to very
   useful so I wonder if this could be squashed to just the three ABIs
   without consideration of endianess?

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                   | 13 +++++
 arch/mips/include/asm/abi.h         |  1 +
 arch/mips/include/asm/unistd.h      | 10 ++++
 arch/mips/include/uapi/asm/unistd.h | 21 ++++----
 arch/mips/kernel/Makefile           |  4 ++
 arch/mips/kernel/audit-n32.c        | 58 ++++++++++++++++++++++
 arch/mips/kernel/audit-native.c     | 97 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/audit-o32.c        | 60 +++++++++++++++++++++++
 arch/mips/kernel/signal.c           | 18 +++++++
 arch/mips/kernel/signal_n32.c       |  8 +++
 arch/mips/kernel/signal_o32.c       |  8 +++
 include/uapi/linux/audit.h          | 10 ++++
 kernel/auditsc.c                    | 13 +++++
 13 files changed, 312 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/kernel/audit-n32.c
 create mode 100644 arch/mips/kernel/audit-native.c
 create mode 100644 arch/mips/kernel/audit-o32.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 25266d1..2662f7d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -14,6 +14,7 @@ config MIPS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select AUDIT_ARCH
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
@@ -35,6 +36,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
@@ -1064,6 +1066,15 @@ config FW_ARC
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
+config AUDIT_ARCH
+	bool
+
+config AUDITSYSCALL_O32
+	bool
+
+config AUDITSYSCALL_N32
+	bool
+
 config BOOT_RAW
 	bool
 
@@ -3149,6 +3160,7 @@ config MIPS32_O32
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC
+	select AUDITSYSCALL_O32 if AUDITSYSCALL
 	help
 	  Select this option if you want to run o32 binaries.  These are pure
 	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
@@ -3162,6 +3174,7 @@ config MIPS32_N32
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC
+	select AUDITSYSCALL_N32 if AUDITSYSCALL
 	help
 	  Select this option if you want to run n32 binaries.  These are
 	  64-bit binaries using 32-bit quantities for addressing and certain
diff --git a/arch/mips/include/asm/abi.h b/arch/mips/include/asm/abi.h
index dba7f4b..6e717a4a 100644
--- a/arch/mips/include/asm/abi.h
+++ b/arch/mips/include/asm/abi.h
@@ -21,6 +21,7 @@ struct mips_abi {
 	int (* const setup_rt_frame)(void *sig_return, struct ksignal *ksig,
 				     struct pt_regs *regs, sigset_t *set);
 	const unsigned long	restart;
+	const int audit_arch;
 
 	unsigned	off_sc_fpregs;
 	unsigned	off_sc_fpc_csr;
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index b23d74a..06240be 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -71,4 +71,14 @@
 
 #endif /* !__ASSEMBLY__ */
 
+#ifdef CONFIG_MIPS32_N32
+#define NR_syscalls	(__NR_N32_Linux + __NR_N32_Linux_syscalls)
+#elif defined(CONFIG_64BIT)
+#define NR_syscalls	(__NR_64_Linux  + __NR_64_Linux_syscalls)
+#elif defined(CONFIG_32BIT)
+#define NR_syscalls	(__NR_O32_Linux + __NR_O32_Linux_syscalls)
+#else
+#error Must know ABIs in use to define NR_syscalls
+#endif
+
 #endif /* _ASM_UNISTD_H */
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 4abe387..b501ea1 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -6,34 +6,37 @@
  *
  * Copyright (C) 1995, 96, 97, 98, 99, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- *
- * Changed system calls macros _syscall5 - _syscall7 to push args 5 to 7 onto
- * the stack. Robin Farine for ACN S.A, Copyright (C) 1996 by ACN S.A
  */
 #ifndef _UAPI_ASM_UNISTD_H
 #define _UAPI_ASM_UNISTD_H
 
 #include <asm/sgidefs.h>
 
-#if _MIPS_SIM == _MIPS_SIM_ABI32
+#if (defined(__WANT_SYSCALL_NUMBERS) &&					\
+	(__WANT_SYSCALL_NUMBERS == _MIPS_SIM_ABI32)) ||			\
+	(!defined(__WANT_SYSCALL_NUMBERS) && _MIPS_SIM == _MIPS_SIM_ABI32)
 
 #define __NR_Linux	4000
 #include <asm/unistd_o32.h>
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
+#endif /* Want O32 || _MIPS_SIM == _MIPS_SIM_ABI32  */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if (defined(__WANT_SYSCALL_NUMBERS) &&					\
+	(__WANT_SYSCALL_NUMBERS == _MIPS_SIM_ABI64)) ||			\
+	(!defined(__WANT_SYSCALL_NUMBERS) && _MIPS_SIM == _MIPS_SIM_ABI64)
 
 #define __NR_Linux	5000
 #include <asm/unistd_n64.h>
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
+#endif /* Want N64 || _MIPS_SIM == _MIPS_SIM_ABI64  */
 
-#if _MIPS_SIM == _MIPS_SIM_NABI32
+#if (defined(__WANT_SYSCALL_NUMBERS) &&					\
+	(__WANT_SYSCALL_NUMBERS == _MIPS_SIM_NABI32)) ||		\
+	(!defined(__WANT_SYSCALL_NUMBERS) && _MIPS_SIM == _MIPS_SIM_NABI32)
 
 #define __NR_Linux	6000
 #include <asm/unistd_n32.h>
 
-#endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* Want N32 || _MIPS_SIM == _MIPS_SIM_NABI32  */
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 89b07ea..9de423a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -106,6 +106,10 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 
+obj-$(CONFIG_AUDITSYSCALL_O32)	+= audit-o32.o
+obj-$(CONFIG_AUDITSYSCALL_N32)	+= audit-n32.o
+obj-$(CONFIG_AUDITSYSCALL)	+= audit-native.o
+
 obj-$(CONFIG_MIPS_CM)		+= mips-cm.o
 obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
 
diff --git a/arch/mips/kernel/audit-n32.c b/arch/mips/kernel/audit-n32.c
new file mode 100644
index 0000000..2248badc
--- /dev/null
+++ b/arch/mips/kernel/audit-n32.c
@@ -0,0 +1,58 @@
+#define __WANT_SYSCALL_NUMBERS _MIPS_SIM_NABI32
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/audit.h>
+#include <asm/unistd.h>
+
+static unsigned dir_class_n32[] = {
+#include <asm-generic/audit_dir_write.h>
+~0U
+};
+
+static unsigned read_class_n32[] = {
+#include <asm-generic/audit_read.h>
+~0U
+};
+
+static unsigned write_class_n32[] = {
+#include <asm-generic/audit_write.h>
+~0U
+};
+
+static unsigned chattr_class_n32[] = {
+#include <asm-generic/audit_change_attr.h>
+~0U
+};
+
+static unsigned signal_class_n32[] = {
+#include <asm-generic/audit_signal.h>
+~0U
+};
+
+int audit_classify_syscall_n32(int abi, unsigned syscall)
+{
+	switch (syscall) {
+	case __NR_open:
+		return 2;
+	case __NR_openat:
+		return 3;
+	case __NR_execve:
+		return 5;
+	default:
+		return 0;
+	}
+}
+
+static int __init audit_classes_n32_init(void)
+{
+	audit_register_class(AUDIT_CLASS_WRITE_N32, write_class_n32);
+	audit_register_class(AUDIT_CLASS_READ_N32, read_class_n32);
+	audit_register_class(AUDIT_CLASS_DIR_WRITE_N32, dir_class_n32);
+	audit_register_class(AUDIT_CLASS_CHATTR_N32, chattr_class_n32);
+	audit_register_class(AUDIT_CLASS_SIGNAL_N32, signal_class_n32);
+
+	return 0;
+}
+
+__initcall(audit_classes_n32_init);
diff --git a/arch/mips/kernel/audit-native.c b/arch/mips/kernel/audit-native.c
new file mode 100644
index 0000000..09ae3db
--- /dev/null
+++ b/arch/mips/kernel/audit-native.c
@@ -0,0 +1,97 @@
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/audit.h>
+#include <asm/unistd.h>
+
+static unsigned dir_class[] = {
+#include <asm-generic/audit_dir_write.h>
+~0U
+};
+
+static unsigned read_class[] = {
+#include <asm-generic/audit_read.h>
+~0U
+};
+
+static unsigned write_class[] = {
+#include <asm-generic/audit_write.h>
+~0U
+};
+
+static unsigned chattr_class[] = {
+#include <asm-generic/audit_change_attr.h>
+~0U
+};
+
+static unsigned signal_class[] = {
+#include <asm-generic/audit_signal.h>
+~0U
+};
+
+
+/*
+ * Pretend to be a single architecture
+ */
+int audit_classify_arch(int arch)
+{
+	return 0;
+}
+
+extern int audit_classify_syscall_o32(int abi, unsigned syscall);
+extern int audit_classify_syscall_n32(int abi, unsigned syscall);
+
+int audit_classify_syscall(int abi, unsigned syscall)
+{
+	int res;
+
+	switch (syscall) {
+	case __NR_open:
+		res = 2;
+		break;
+
+	case __NR_openat:
+		res = 3;
+		break;
+
+#ifdef __NR_socketcall		/* Only exists on O32 */
+	case __NR_socketcall:
+		res = 4;
+		break;
+#endif
+	case __NR_execve:
+		res = 5;
+		break;
+	default:
+#ifdef CONFIG_AUDITSYSCALL_O32
+		res = audit_classify_syscall_o32(abi, syscall);
+		if (res)
+			break;
+#endif
+#ifdef CONFIG_AUDITSYSCALL_N32
+		res = audit_classify_syscall_n32(abi, syscall);
+		if (res)
+			break;
+#endif
+		if (abi == AUDIT_ARCH_MIPS || abi == AUDIT_ARCH_MIPSEL)
+			res = 1;
+		else if (abi == AUDIT_ARCH_MIPS64 || abi == AUDIT_ARCH_MIPSEL64)
+			res = 0;
+		else if (abi == AUDIT_ARCH_MIPS64N32 || abi == AUDIT_ARCH_MIPSEL64N32)
+			res = 6;
+	}
+
+	return res;
+}
+
+static int __init audit_classes_init(void)
+{
+	audit_register_class(AUDIT_CLASS_WRITE, write_class);
+	audit_register_class(AUDIT_CLASS_READ, read_class);
+	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
+	audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
+	audit_register_class(AUDIT_CLASS_SIGNAL, signal_class);
+
+	return 0;
+}
+
+__initcall(audit_classes_init);
diff --git a/arch/mips/kernel/audit-o32.c b/arch/mips/kernel/audit-o32.c
new file mode 100644
index 0000000..e8b9b50
--- /dev/null
+++ b/arch/mips/kernel/audit-o32.c
@@ -0,0 +1,60 @@
+#define __WANT_SYSCALL_NUMBERS _MIPS_SIM_ABI32
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/audit.h>
+#include <linux/unistd.h>
+
+static unsigned dir_class_o32[] = {
+#include <asm-generic/audit_dir_write.h>
+~0U
+};
+
+static unsigned read_class_o32[] = {
+#include <asm-generic/audit_read.h>
+~0U
+};
+
+static unsigned write_class_o32[] = {
+#include <asm-generic/audit_write.h>
+~0U
+};
+
+static unsigned chattr_class_o32[] = {
+#include <asm-generic/audit_change_attr.h>
+~0U
+};
+
+static unsigned signal_class_o32[] = {
+#include <asm-generic/audit_signal.h>
+~0U
+};
+
+int audit_classify_syscall_o32(int abi, unsigned syscall)
+{
+	switch (syscall) {
+	case __NR_open:
+		return 2;
+	case __NR_openat:
+		return 3;
+	case __NR_socketcall:
+		return 4;
+	case __NR_execve:
+		return 5;
+	default:
+		return 0;
+	}
+}
+
+static int __init audit_classes_o32_init(void)
+{
+	audit_register_class(AUDIT_CLASS_WRITE_32, write_class_o32);
+	audit_register_class(AUDIT_CLASS_READ_32, read_class_o32);
+	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, dir_class_o32);
+	audit_register_class(AUDIT_CLASS_CHATTR_32, chattr_class_o32);
+	audit_register_class(AUDIT_CLASS_SIGNAL_32, signal_class_o32);
+
+	return 0;
+}
+
+__initcall(audit_classes_o32_init);
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d753379..09e4aef 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2014, Imagination Technologies Ltd.
  */
+#include <linux/audit.h>
 #include <linux/cache.h>
 #include <linux/context_tracking.h>
 #include <linux/irqflags.h>
@@ -790,6 +791,23 @@ struct mips_abi mips_abi = {
 #endif
 	.setup_rt_frame = setup_rt_frame,
 	.restart	= __NR_restart_syscall,
+#ifdef CONFIG_64BIT
+# ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS64,
+# elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPSEL64,
+# else
+#  error "Neither big nor little endian ???"
+# endif
+#else
+# ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS,
+# elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPSEL,
+# else
+#  error "Neither big nor little endian ???"
+# endif
+#endif
 
 	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
 	.off_sc_fpc_csr = offsetof(struct sigcontext, sc_fpc_csr),
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index c498b02..1ee9156 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -15,6 +15,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
+#include <linux/audit.h>
 #include <linux/cache.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -153,6 +154,13 @@ static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
 struct mips_abi mips_abi_n32 = {
 	.setup_rt_frame = setup_rt_frame_n32,
 	.restart	= __NR_N32_restart_syscall,
+#ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS64N32,
+#elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPSEL64N32,
+#else
+# error "Neither big nor little endian ???"
+#endif
 
 	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
 	.off_sc_fpc_csr = offsetof(struct sigcontext, sc_fpc_csr),
diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_o32.c
index df25961..74698f7 100644
--- a/arch/mips/kernel/signal_o32.c
+++ b/arch/mips/kernel/signal_o32.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2016, Imagination Technologies Ltd.
  */
+#include <linux/audit.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
@@ -244,6 +245,13 @@ struct mips_abi mips_abi_32 = {
 	.setup_frame	= setup_frame_32,
 	.setup_rt_frame = setup_rt_frame_32,
 	.restart	= __NR_O32_restart_syscall,
+#ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS,
+#elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPSEL,
+#else
+# error "Neither big nor little endian ???"
+#endif
 
 	.off_sc_fpregs = offsetof(struct sigcontext32, sc_fpregs),
 	.off_sc_fpc_csr = offsetof(struct sigcontext32, sc_fpc_csr),
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index f28acd9..c231555 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -175,7 +175,11 @@
  * AUDIT_LIST commands must be implemented. */
 #define AUDIT_MAX_FIELDS   64
 #define AUDIT_MAX_KEY_LEN  256
+#ifdef __mips__
+#define AUDIT_BITMASK_SIZE 256
+#else
 #define AUDIT_BITMASK_SIZE 64
+#endif
 #define AUDIT_WORD(nr) ((__u32)((nr)/32))
 #define AUDIT_BIT(nr)  (1 << ((nr) - AUDIT_WORD(nr)*32))
 
@@ -191,6 +195,12 @@
 #define AUDIT_CLASS_SIGNAL 8
 #define AUDIT_CLASS_SIGNAL_32 9
 
+#define AUDIT_CLASS_DIR_WRITE_N32	10
+#define AUDIT_CLASS_CHATTR_N32		11
+#define AUDIT_CLASS_READ_N32		12
+#define AUDIT_CLASS_WRITE_N32		13
+#define AUDIT_CLASS_SIGNAL_N32		14
+
 /* This bitmask is used to validate user input.  It represents all bits that
  * are currently used in an audit field constant understood by the kernel.
  * If you are adding a new #define AUDIT_<whatever>, please ensure that
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6593a52..1f5fa4d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -168,6 +168,19 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
 		return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
 	case 5: /* execve */
 		return mask & AUDIT_PERM_EXEC;
+#ifdef CONFIG_MIPS
+	case 6: /* for N32 */
+		if ((mask & AUDIT_PERM_WRITE) &&
+		     audit_match_class(AUDIT_CLASS_WRITE_N32, n))
+			return 1;
+		if ((mask & AUDIT_PERM_READ) &&
+		     audit_match_class(AUDIT_CLASS_READ_N32, n))
+			return 1;
+		if ((mask & AUDIT_PERM_ATTR) &&
+		     audit_match_class(AUDIT_CLASS_CHATTR_N32, n))
+			return 1;
+		return 0;
+#endif
 	default:
 		return 0;
 	}
-- 
2.7.0

