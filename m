Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2014 12:13:49 +0200 (CEST)
Received: from mail-we0-f174.google.com ([74.125.82.174]:57847 "EHLO
        mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817387AbaDBKN2y77LC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2014 12:13:28 +0200
Received: by mail-we0-f174.google.com with SMTP id t60so7469996wes.5
        for <multiple recipients>; Wed, 02 Apr 2014 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rUSTWIdcgEW7AjShvuhTNRQaDQzivSL7qQ6mYiabV+E=;
        b=s5QGraJRtflPEYHuNixcfnIlcejIjd8JX7D2Y+bQYnBOmCFwlE3zdcxgYlNv8bMBCv
         DQJhpBkMxljGW3i5hkoPbbqGDZWUWKfODwRUrzzippqb058WGSm/dZEFVBVSH1K5+70u
         1Du24XwOanpKCHqbh80coECuaemVsR2TS60pZDgiskWlHFZccG8EjoenPMwmkjCUtVA/
         GYvAAS/hlz023p2sCwpiGGDy83raHFJKJCCfWe1HoNh71IOuSisuj5lGB0MxUcnttAP3
         t5eHiE3yWTA92XTRnC5sAw5NPQ853xzfFKEX1ot8mP3BgvgIGW/nCBs4fj6osQs0q4e6
         W7WA==
X-Received: by 10.180.206.16 with SMTP id lk16mr6038200wic.3.1396433603479;
        Wed, 02 Apr 2014 03:13:23 -0700 (PDT)
Received: from localhost.localdomain (p57A34F13.dip0.t-ipconnect.de. [87.163.79.19])
        by mx.google.com with ESMTPSA id w1sm3463877eel.16.2014.04.02.03.13.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Apr 2014 03:13:22 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     linux-audit@redhat.com, Steve Grubb <sgrubb@redhat.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Subject: [RESEND PATCH 1/2] MIPS syscall auditing patches
Date:   Wed,  2 Apr 2014 12:13:15 +0200
Message-Id: <1396433596-612624-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

From: Ralf Baechle <ralf@linux-mips.org>

this is the first cut of the MIPS auditing patches.  MIPS doesn't quite
fit into the existing pattern of other architectures and I'd appreciate
your comments and maybe even an Acked-by.

 - MIPS syscalls return a success / error flag in register $7.  If the
   flag is set then the return value in $2 is a *positive* error value.
   This means the existing AUDITSC_RESULT() macro does not work on
   MIPS and thus ptrace.c defines it's own version MIPS_AUDITSC_RESULT().

 - Linux on MIPS extends the traditional syscall table used by older UNIX
   implementations.  This is why 32-bit Linux syscalls are starting from
   4000; the native 64-bit syscalls start from 5000 and the N32 compat ABI
   from 6000.  The existing syscall bitmap is only large enough for at most
   2048 syscalls, so I had to increase AUDIT_BITMASK_SIZE to 256 which
   provides enough space for 8192 syscalls.  Because include/linux/audit.h
   and AUDIT_BITMASK_SIZE are exported to userspace I've used an #ifdef
   __mips__ for this.

 - I've introduced a flag __AUDIT_ARCH_ALT to indicate an alternative ABI.
   The name of the flag is intentionally very generic to make the name
   hopefully fit other architectures' eventual need as well.  On MIPS it
   indicates the 3rd ABI known as N32.

 - To make matters worse, most MIPS processors can be configured to be
   big or little endian.  Traditionally the the 64-bit little endian
   configuration is named mips64el, so I've changed references to MIPSEL64
   in audit.h to MIPS64EL.

 - The code treats the little endian MIPS architecture as separate from
   big endian.  Combined with the 3 ABIs that's 6 combinations.  I tried
   to sort of follow the example set by ARM which explicitly lists the
   (rare) big endian architecture variant - but it doesn't seem to very
   useful so I wonder if this could be squashed to just the three ABIs
   without consideration of endianess?

 - Talking about flags; I've defined the the N32 architecture flags were defined

    #define AUDIT_ARCH_MIPS64_N32  (EM_MIPS|__AUDIT_ARCH_ALT)
    #define AUDIT_ARCH_MIPS64EL_N32 (EM_MIPS|__AUDIT_ARCH_ALT|__AUDIT_ARCH_LE

    N32 is a 32-bit ABI but one that only runs on 64-bit processors as it
    uses 64-bit registers for 64-bit integers.  So I'm uncertain if the
    __AUDIT_ARCH_64BIT flags should be set or not.

Thanks in advance,

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
mlau: this is the patch Ralf sent in June 2011, I've just rediffed it against
      latest linux (3.15-rc0).

 arch/mips/Kconfig                   | 12 +++++
 arch/mips/include/asm/abi.h         |  1 +
 arch/mips/include/uapi/asm/unistd.h | 18 +++++---
 arch/mips/kernel/Makefile           |  4 ++
 arch/mips/kernel/audit-n32.c        | 58 +++++++++++++++++++++++
 arch/mips/kernel/audit-native.c     | 92 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/audit-o32.c        | 60 ++++++++++++++++++++++++
 arch/mips/kernel/ptrace.c           |  7 +++
 arch/mips/kernel/signal.c           | 20 +++++++-
 arch/mips/kernel/signal32.c         | 10 +++-
 arch/mips/kernel/signal_n32.c       | 10 +++-
 include/uapi/linux/audit.h          | 21 ++++++++-
 init/Kconfig                        |  3 +-
 13 files changed, 305 insertions(+), 11 deletions(-)
 create mode 100644 arch/mips/kernel/audit-n32.c
 create mode 100644 arch/mips/kernel/audit-native.c
 create mode 100644 arch/mips/kernel/audit-o32.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ecccd15..f1435b1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -49,6 +49,7 @@ config MIPS
 	select CLONE_BACKWARDS
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_CC_STACKPROTECTOR
+	select AUDIT_ARCH
 
 menu "Machine selection"
 
@@ -846,6 +847,15 @@ config FW_ARC
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
 
@@ -2516,6 +2526,7 @@ config SYSVIPC_COMPAT
 config MIPS32_O32
 	bool "Kernel support for o32 binaries"
 	depends on MIPS32_COMPAT
+	select AUDITSYSCALL_O32 if AUDITSYSCALL
 	help
 	  Select this option if you want to run o32 binaries.  These are pure
 	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
@@ -2526,6 +2537,7 @@ config MIPS32_O32
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
 	depends on MIPS32_COMPAT
+	select AUDITSYSCALL_N32 if AUDITSYSCALL
 	help
 	  Select this option if you want to run n32 binaries.  These are
 	  64-bit binaries using 32-bit quantities for addressing and certain
diff --git a/arch/mips/include/asm/abi.h b/arch/mips/include/asm/abi.h
index 909bb69..7ae5eed 100644
--- a/arch/mips/include/asm/abi.h
+++ b/arch/mips/include/asm/abi.h
@@ -22,6 +22,7 @@ struct mips_abi {
 			       sigset_t *set, siginfo_t *info);
 	const unsigned long	rt_signal_return_offset;
 	const unsigned long	restart;
+	const int audit_arch;
 };
 
 #endif /* _ASM_ABI_H */
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index d6e154a..eeece63 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -14,7 +14,9 @@
 
 #include <asm/sgidefs.h>
 
-#if _MIPS_SIM == _MIPS_SIM_ABI32
+#if (defined(__WANT_SYSCALL_NUMBERS) &&					\
+     (__WANT_SYSCALL_NUMBERS == _MIPS_SIM_ABI32)) ||			\
+    (!defined(__WANT_SYSCALL_NUMBERS) && _MIPS_SIM == _MIPS_SIM_ABI32)
 
 /*
  * Linux o32 style syscalls are in the range from 4000 to 4999.
@@ -377,12 +379,14 @@
  */
 #define __NR_Linux_syscalls		350
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
+#endif /* Want O32 || _MIPS_SIM == _MIPS_SIM_ABI32  */
 
 #define __NR_O32_Linux			4000
 #define __NR_O32_Linux_syscalls		350
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if (defined(__WANT_SYSCALL_NUMBERS) && \
+     (__WANT_SYSCALL_NUMBERS == _MIPS_SIM_ABI64)) || \
+    (!defined(__WANT_SYSCALL_NUMBERS) && _MIPS_SIM == _MIPS_SIM_ABI64)
 
 /*
  * Linux 64-bit syscalls are in the range from 5000 to 5999.
@@ -705,12 +709,14 @@
  */
 #define __NR_Linux_syscalls		310
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
+#endif /* Want N64 || _MIPS_SIM == _MIPS_SIM_ABI64  */
 
 #define __NR_64_Linux			5000
 #define __NR_64_Linux_syscalls		310
 
-#if _MIPS_SIM == _MIPS_SIM_NABI32
+#if (defined(__WANT_SYSCALL_NUMBERS) && \
+     (__WANT_SYSCALL_NUMBERS == _MIPS_SIM_NABI32)) || \
+    (!defined(__WANT_SYSCALL_NUMBERS) && _MIPS_SIM == _MIPS_SIM_NABI32)
 
 /*
  * Linux N32 syscalls are in the range from 6000 to 6999.
@@ -1037,7 +1043,7 @@
  */
 #define __NR_Linux_syscalls		314
 
-#endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* Want N32 || _MIPS_SIM == _MIPS_SIM_NABI32  */
 
 #define __NR_N32_Linux			6000
 #define __NR_N32_Linux_syscalls		314
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 26c6175..2a4cf6a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -120,4 +120,8 @@ CFLAGS_branch.o			= $(CFLAGS_DSP)
 CFLAGS_ptrace.o			= $(CFLAGS_DSP)
 endif
 
+obj-$(CONFIG_AUDITSYSCALL_O32)	+= audit-o32.o
+obj-$(CONFIG_AUDITSYSCALL_N32)	+= audit-n32.o
+obj-$(CONFIG_AUDITSYSCALL)	+= audit-native.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
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
index 0000000..e883094
--- /dev/null
+++ b/arch/mips/kernel/audit-native.c
@@ -0,0 +1,92 @@
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
+		res = 0;
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
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7da9b76..0e7d74f 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/seccomp.h>
 #include <linux/ftrace.h>
 
+#include <asm/abi.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/dsp.h>
@@ -48,6 +49,12 @@
 #include <trace/events/syscalls.h>
 
 /*
+ * The standard AUDITSC_RESULT() assumes errno values < 0 indicate error
+ * but MIPS passes an error flag instead.
+ */
+#define MIPS_AUDITSC_RESULT(x)	((x) ? AUDITSC_FAILURE : AUDITSC_SUCCESS)
+
+/*
  * Called by kernel/ptrace.c when detaching..
  *
  * Make sure single step bits etc are not set.
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5199563..457b076 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -7,6 +7,7 @@
  * Copyright (C) 1994 - 2000  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+#include <linux/audit.h>
 #include <linux/cache.h>
 #include <linux/context_tracking.h>
 #include <linux/irqflags.h>
@@ -475,7 +476,24 @@ struct mips_abi mips_abi = {
 	.setup_rt_frame = setup_rt_frame,
 	.rt_signal_return_offset =
 		offsetof(struct mips_vdso, rt_signal_trampoline),
-	.restart	= __NR_restart_syscall
+	.restart	= __NR_restart_syscall,
+#ifdef CONFIG_64BIT
+# ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS64,
+# elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPS64EL,
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
 };
 
 static void handle_signal(unsigned long sig, siginfo_t *info,
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 3d60f77..8148df2 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -7,6 +7,7 @@
  * Copyright (C) 1994 - 2000, 2006  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+#include <linux/audit.h>
 #include <linux/cache.h>
 #include <linux/compat.h>
 #include <linux/sched.h>
@@ -557,7 +558,14 @@ struct mips_abi mips_abi_32 = {
 	.setup_rt_frame = setup_rt_frame_32,
 	.rt_signal_return_offset =
 		offsetof(struct mips_vdso, o32_rt_signal_trampoline),
-	.restart	= __NR_O32_restart_syscall
+	.restart	= __NR_O32_restart_syscall,
+#ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS,
+#elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPSEL,
+#else
+# error "Neither big nor little endian ???"
+#endif
 };
 
 static int signal32_init(void)
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index b2241bb..2f643c6 100644
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
@@ -157,5 +158,12 @@ struct mips_abi mips_abi_n32 = {
 	.setup_rt_frame = setup_rt_frame_n32,
 	.rt_signal_return_offset =
 		offsetof(struct mips_vdso, n32_rt_signal_trampoline),
-	.restart	= __NR_N32_restart_syscall
+	.restart	= __NR_N32_restart_syscall,
+#ifdef __BIG_ENDIAN
+	.audit_arch	= AUDIT_ARCH_MIPS64_N32,
+#elif defined(__LITTLE_ENDIAN)
+	.audit_arch	= AUDIT_ARCH_MIPS64EL_N32,
+#else
+# error "Neither big nor little endian ???"
+#endif
 };
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 2d48fe1..2d3c9f3 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -164,7 +164,11 @@
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
 
@@ -180,6 +184,18 @@
 #define AUDIT_CLASS_SIGNAL 8
 #define AUDIT_CLASS_SIGNAL_32 9
 
+/*
+ * WARNING: Not officially assigned by upstream yet; the names of these
+ * constants might change breaking source compatibility.  The values might
+ * change breaking binary compatibility.  With the audit package being the
+ * only known user at this time the potencial problem is small
+ */
+#define AUDIT_CLASS_DIR_WRITE_N32	10
+#define AUDIT_CLASS_CHATTR_N32		11
+#define AUDIT_CLASS_READ_N32		12
+#define AUDIT_CLASS_WRITE_N32		13
+#define AUDIT_CLASS_SIGNAL_N32		14
+
 /* This bitmask is used to validate user input.  It represents all bits that
  * are currently used in an audit field constant understood by the kernel.
  * If you are adding a new #define AUDIT_<whatever>, please ensure that
@@ -333,6 +349,7 @@ enum {
 /* distinguish syscall tables */
 #define __AUDIT_ARCH_64BIT 0x80000000
 #define __AUDIT_ARCH_LE	   0x40000000
+#define __AUDIT_ARCH_ALT   0x20000000		/* indicates alternative ABI  */
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
@@ -345,7 +362,9 @@ enum {
 #define AUDIT_ARCH_MIPS		(EM_MIPS)
 #define AUDIT_ARCH_MIPSEL	(EM_MIPS|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_MIPS64	(EM_MIPS|__AUDIT_ARCH_64BIT)
-#define AUDIT_ARCH_MIPSEL64	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_MIPS64EL	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_MIPS64_N32	(EM_MIPS|__AUDIT_ARCH_ALT)
+#define AUDIT_ARCH_MIPS64EL_N32	(EM_MIPS|__AUDIT_ARCH_ALT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
 #define AUDIT_ARCH_PARISC	(EM_PARISC)
 #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
diff --git a/init/Kconfig b/init/Kconfig
index d56cb03..70bb150 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -284,7 +284,8 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ALPHA)
+	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || \
+			     ALPHA || MIPS)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
-- 
1.9.1
