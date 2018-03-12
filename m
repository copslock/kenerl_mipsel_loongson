Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 18:54:09 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:40294
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeCLRx7LlrBH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 18:53:59 +0100
Received: by mail-pf0-x243.google.com with SMTP id x1so4673330pfh.7;
        Mon, 12 Mar 2018 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/oOApaGWr+iqXGhKYuwk4qHPW68mAtEk9WIMQQRIlQ=;
        b=iHqZ3BZk+ZdvXLzVz5qSNYM/NEIkeUuSE5MSQpKywihkPiJP75/Y8h/KvXJ2vQHsl8
         BOE5ig7ZOfrPeyeq5ZyaEqLAE5oa7vpI/laxoRhMZqUNuG+pMdODVY5BhKQUmEIKCTVR
         /OELT5s0DSHNCLMdaXbonDJBbFJ1RhdUJinjB6BzdwcrhPzViwDscJeNFnebtVER9Wm4
         tCCWtDb390k6ZqFeCPlCi4rPI023JNWuBslTDblHSAK9cuzjsH52KYo9Ka1XBWMANwcM
         vC5HEiBro7CAu9yhlH6fpzbIirAHRclG8gYzhqLInULoD7lTdpeb80qheVQcAtLNtiz9
         Lb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/oOApaGWr+iqXGhKYuwk4qHPW68mAtEk9WIMQQRIlQ=;
        b=mXFni4uO0kfaOo4Qgmonow5EPW/A26CdQ4mEBTvUoCYkwMO3i2s43sS4lsQGAir8rF
         X0myjChGY6mRTfopyk2QtliUBhYfwzkBylG/K+dvGHrS9+LzT5po50+tzXuvTxJVrkvU
         RceU8M4UaQzziUgOQrKz4lEKVoGWpZh0rMm1qTtWKcPf1AN/LxCRj2noYWWQsOikuuBd
         5ulMzgdwNNOCKuPF3GnQ2CHD3cIvqy9w5hLxIABatvL7boq+T8/DN+nTCMVciEhYIaAA
         prf85PQt7pxQFOTPPvdMQb88gx9ncmTQe5HEZTnokhfM00ORTWGl0QxOaZBMEccK3QQn
         wo1g==
X-Gm-Message-State: AElRT7HVLERfZa9CwEPTBcQibzuOp8QJVjFpmnc+CDAkLifCnrenvCL4
        4gE4ax1wzep+ZclikWwVa/E=
X-Google-Smtp-Source: AG47ELuoBjNKYHrWokng5m9yA1VLZZA8eV7tJpM737T7c9t7lwj648XT5fMV4feAMQQhPJ0f4dj5Ng==
X-Received: by 10.101.101.5 with SMTP id x5mr7247643pgv.195.1520877232551;
        Mon, 12 Mar 2018 10:53:52 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id l64sm18906810pfi.142.2018.03.12.10.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 10:53:51 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com,
        davem@davemloft.net, deller@gmx.de, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
        heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com,
        hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com,
        sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
        sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com,
        will.deacon@arm.com, x86@kernel.org
Subject: [PATCH v4 02/10] include: Move compat_timespec/ timeval to compat_time.h
Date:   Mon, 12 Mar 2018 10:52:59 -0700
Message-Id: <20180312175307.11032-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180312175307.11032-1-deepa.kernel@gmail.com>
References: <20180312175307.11032-1-deepa.kernel@gmail.com>
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

All the current architecture specific defines for these
are the same. Refactor these common defines to a common
header file.

The new common linux/compat_time.h is also useful as it
will eventually be used to hold all the defines that
are needed for compat time types that support non y2038
safe types. New architectures need not have to define these
new types as they will only use new y2038 safe syscalls.
This file can be deleted after y2038 when we stop supporting
non y2038 safe syscalls.

The patch also requires an operation similar to:

git grep "asm/compat\.h" | cut -d ":" -f 1 |  xargs -n 1 sed -i -e "s%asm/compat.h%linux/compat.h%g"

Cc: acme@kernel.org
Cc: benh@kernel.crashing.org
Cc: borntraeger@de.ibm.com
Cc: catalin.marinas@arm.com
Cc: cmetcalf@mellanox.com
Cc: cohuck@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: devel@driverdev.osuosl.org
Cc: gerald.schaefer@de.ibm.com
Cc: gregkh@linuxfoundation.org
Cc: heiko.carstens@de.ibm.com
Cc: hoeppner@linux.vnet.ibm.com
Cc: hpa@zytor.com
Cc: jejb@parisc-linux.org
Cc: jwi@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: mark.rutland@arm.com
Cc: mingo@redhat.com
Cc: mpe@ellerman.id.au
Cc: oberpar@linux.vnet.ibm.com
Cc: oprofile-list@lists.sf.net
Cc: paulus@samba.org
Cc: peterz@infradead.org
Cc: ralf@linux-mips.org
Cc: rostedt@goodmis.org
Cc: rric@kernel.org
Cc: schwidefsky@de.ibm.com
Cc: sebott@linux.vnet.ibm.com
Cc: sparclinux@vger.kernel.org
Cc: sth@linux.vnet.ibm.com
Cc: ubraun@linux.vnet.ibm.com
Cc: will.deacon@arm.com
Cc: x86@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: James Hogan <jhogan@kernel.org>
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/arm64/include/asm/compat.h   | 11 -----------
 arch/arm64/include/asm/stat.h     |  1 +
 arch/arm64/kernel/hw_breakpoint.c |  1 -
 arch/arm64/kernel/perf_regs.c     |  2 +-
 arch/arm64/kernel/process.c       |  1 -
 arch/mips/include/asm/compat.h    | 11 -----------
 arch/mips/kernel/signal32.c       |  2 +-
 arch/parisc/include/asm/compat.h  | 11 -----------
 arch/powerpc/include/asm/compat.h | 11 -----------
 arch/powerpc/kernel/asm-offsets.c |  2 +-
 arch/powerpc/oprofile/backtrace.c |  2 +-
 arch/s390/hypfs/hypfs_sprp.c      |  1 -
 arch/s390/include/asm/compat.h    | 11 -----------
 arch/s390/include/asm/elf.h       |  4 ++--
 arch/s390/kvm/priv.c              |  1 -
 arch/s390/pci/pci_clp.c           |  1 -
 arch/sparc/include/asm/compat.h   | 11 -----------
 arch/tile/include/asm/compat.h    | 11 -----------
 arch/x86/events/core.c            |  2 +-
 arch/x86/include/asm/compat.h     | 11 -----------
 arch/x86/include/asm/ftrace.h     |  2 +-
 arch/x86/include/asm/sys_ia32.h   |  2 +-
 arch/x86/kernel/sys_x86_64.c      |  2 +-
 drivers/s390/block/dasd_ioctl.c   |  1 -
 drivers/s390/char/fs3270.c        |  1 -
 drivers/s390/char/sclp_ctl.c      |  1 -
 drivers/s390/char/vmcp.c          |  1 -
 drivers/s390/cio/chsc_sch.c       |  1 -
 drivers/s390/net/qeth_core_main.c |  2 +-
 include/linux/compat.h            |  1 +
 include/linux/compat_time.h       | 19 +++++++++++++++++++
 31 files changed, 32 insertions(+), 109 deletions(-)
 create mode 100644 include/linux/compat_time.h

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index c00c62e1a4a3..0030f79808b3 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -34,7 +34,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -66,16 +65,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 #ifdef __AARCH64EB__
 	short		st_dev;
diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index 15e35598ac40..eab738019707 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -20,6 +20,7 @@
 
 #ifdef CONFIG_COMPAT
 
+#include <linux/compat_time.h>
 #include <asm/compat.h>
 
 /*
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 74bb56f656ef..413dbe530da8 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -30,7 +30,6 @@
 #include <linux/smp.h>
 #include <linux/uaccess.h>
 
-#include <asm/compat.h>
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 1d091d048d04..0bbac612146e 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
 #include <linux/bug.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm/compat.h>
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c0da6efe5465..a725e81d0063 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,7 +51,6 @@
 #include <linux/thread_info.h>
 
 #include <asm/alternative.h>
-#include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 9a0fa66b81ac..3e548ee99a2f 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -14,7 +14,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_suseconds_t;
 
@@ -46,16 +45,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	s32		st_pad1[3];
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c4db910a8794..b5d9e1784aff 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -8,13 +8,13 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2016, Imagination Technologies Ltd.
  */
+#include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/syscalls.h>
 
-#include <asm/compat.h>
 #include <asm/compat-signal.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index c22db5323244..6f256e7b95e3 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -13,7 +13,6 @@
 
 typedef u32	compat_size_t;
 typedef s32	compat_ssize_t;
-typedef s32	compat_time_t;
 typedef s32	compat_clock_t;
 typedef s32	compat_pid_t;
 typedef u32	__compat_uid_t;
@@ -40,16 +39,6 @@ typedef u32	compat_ulong_t;
 typedef u64	compat_u64;
 typedef u32	compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t		tv_sec;
-	s32			tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t		tv_sec;
-	s32			tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
 	compat_ino_t		st_ino;	/* 32 bits */
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 62168e1158f1..b4773c81f7d5 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -17,7 +17,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u32		__compat_uid_t;
@@ -45,16 +44,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ea5eb91b836e..4a314620344f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -13,6 +13,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -42,7 +43,6 @@
 #include <asm/paca.h>
 #include <asm/lppaca.h>
 #include <asm/cache.h>
-#include <asm/compat.h>
 #include <asm/mmu.h>
 #include <asm/hvcall.h>
 #include <asm/xics.h>
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index ecc66d5f02c9..11ff763c03ad 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -11,7 +11,7 @@
 #include <linux/sched.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
-#include <asm/compat.h>
+#include <linux/compat.h>
 #include <asm/oprofile_impl.h>
 
 #define STACK_SP(STACK)		*(STACK)
diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
index ae0ed8dd5f1b..5d85a039391c 100644
--- a/arch/s390/hypfs/hypfs_sprp.c
+++ b/arch/s390/hypfs/hypfs_sprp.c
@@ -13,7 +13,6 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
-#include <asm/compat.h>
 #include <asm/diag.h>
 #include <asm/sclp.h>
 #include "hypfs.h"
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 9830fb6b076e..501aaff85304 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -53,7 +53,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -97,16 +96,6 @@ typedef struct {
 	u32 gprs_high[NUM_GPRS];
 } s390_compat_regs_high;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	u16		__pad1;
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 1a61b1b997f2..7d22a474a040 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -125,8 +125,9 @@
  * ELF register definitions..
  */
 
+#include <linux/compat.h>
+
 #include <asm/ptrace.h>
-#include <asm/compat.h>
 #include <asm/syscall.h>
 #include <asm/user.h>
 
@@ -136,7 +137,6 @@ typedef s390_regs elf_gregset_t;
 typedef s390_fp_regs compat_elf_fpregset_t;
 typedef s390_compat_regs compat_elf_gregset_t;
 
-#include <linux/compat.h>
 #include <linux/sched/mm.h>	/* for task_struct */
 #include <asm/mmu_context.h>
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ebfa0442e569..a3bce0e84346 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -26,7 +26,6 @@
 #include <asm/gmap.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
-#include <asm/compat.h>
 #include <asm/sclp.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 93cd0f1ca12b..19b2d2a9b43d 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -19,7 +19,6 @@
 #include <linux/uaccess.h>
 #include <asm/pci_debug.h>
 #include <asm/pci_clp.h>
-#include <asm/compat.h>
 #include <asm/clp.h>
 #include <uapi/asm/clp.h>
 
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 615283e16f22..844a89739e76 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -11,7 +11,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -39,16 +38,6 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index 769ff6ac0bf5..06188e0da2de 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -29,7 +29,6 @@ typedef u32		compat_ulong_t;
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_off_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef u32		compat_ino_t;
 typedef u32		compat_caddr_t;
@@ -59,16 +58,6 @@ typedef unsigned long compat_elf_greg_t;
 #define COMPAT_ELF_NGREG (sizeof(struct pt_regs) / sizeof(compat_elf_greg_t))
 typedef compat_elf_greg_t compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 #define compat_stat stat
 #define compat_statfs statfs
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 140d33288e78..6b8961912781 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2391,7 +2391,7 @@ static unsigned long get_segment_base(unsigned int segment)
 
 #ifdef CONFIG_IA32_EMULATION
 
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 static inline int
 perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index e1c8dab86670..7cd314b71c51 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -17,7 +17,6 @@
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
-typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
@@ -46,16 +45,6 @@ typedef u32		compat_u32;
 typedef u64 __attribute__((aligned(4))) compat_u64;
 typedef u32		compat_uptr_t;
 
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	u16		__pad1;
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 09ad88572746..db25aa15b705 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -49,7 +49,7 @@ int ftrace_int3_handler(struct pt_regs *regs);
 #if !defined(__ASSEMBLY__) && !defined(COMPILE_OFFSETS)
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_IA32_EMULATION)
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 /*
  * Because ia32 syscalls do not map to x86_64 syscall numbers
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 82c34ee25a65..8c4083dcd901 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -12,11 +12,11 @@
 
 #ifdef CONFIG_COMPAT
 
+#include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
 #include <linux/signal.h>
-#include <asm/compat.h>
 #include <asm/ia32.h>
 
 /* ia32/sys_ia32.c */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 676774b9bb8d..6cba5755958c 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -19,7 +20,6 @@
 #include <linux/elf.h>
 
 #include <asm/elf.h>
-#include <asm/compat.h>
 #include <asm/ia32.h>
 #include <asm/syscalls.h>
 #include <asm/mpx.h>
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 7bdc6aaa0ba3..2016e0ed5865 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -18,7 +18,6 @@
 #include <linux/fs.h>
 #include <linux/blkpg.h>
 #include <linux/slab.h>
-#include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/schid.h>
 #include <asm/cmb.h>
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 61822480a2a0..16a4e8528bbc 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/ebcdic.h>
diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index a78cea0c3a09..248b5db3eaa8 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/ioctl.h>
 #include <linux/fs.h>
-#include <asm/compat.h>
 #include <asm/sclp_ctl.h>
 #include <asm/sclp.h>
 
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 17e411c57576..948ce82a7725 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -23,7 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/cma.h>
 #include <linux/mm.h>
-#include <asm/compat.h>
 #include <asm/cpcmd.h>
 #include <asm/debug.h>
 #include <asm/vmcp.h>
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 0015729d917d..8d9f36625ba5 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -16,7 +16,6 @@
 #include <linux/miscdevice.h>
 #include <linux/kernel_stat.h>
 
-#include <asm/compat.h>
 #include <asm/cio.h>
 #include <asm/chsc.h>
 #include <asm/isc.h>
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c8b308cfabf1..d3529ef6e0f7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -10,6 +10,7 @@
 #define KMSG_COMPONENT "qeth"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
@@ -32,7 +33,6 @@
 #include <asm/chpid.h>
 #include <asm/io.h>
 #include <asm/sysinfo.h>
-#include <asm/compat.h>
 #include <asm/diag.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
diff --git a/include/linux/compat.h b/include/linux/compat.h
index bdf1908a392e..0eb4a3a8f62e 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/compat_time.h>
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
new file mode 100644
index 000000000000..56a54a1e4355
--- /dev/null
+++ b/include/linux/compat_time.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_COMPAT_TIME_H
+#define _LINUX_COMPAT_TIME_H
+
+#include <linux/types.h>
+
+typedef s32		compat_time_t;
+
+struct compat_timespec {
+	compat_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct compat_timeval {
+	compat_time_t	tv_sec;
+	s32		tv_usec;
+};
+
+#endif /* _LINUX_COMPAT_TIME_H */
-- 
2.14.1
