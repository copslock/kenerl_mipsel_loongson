Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 19:23:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994705AbeJPRXH1KTkN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Oct 2018 19:23:07 +0200
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A98421477;
        Tue, 16 Oct 2018 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710580;
        bh=sn/oKwQJlc6qaWg5c2z2LYL3L1jTFXKpZo+GyI8W2xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ng7cn00/f1as/j9QsJ8xXl15LsYed3CXyWQSH+LMzXeFIEs1Dp8Ii9Xk1UzFcpZoP
         AA+XZnDRfDSA+6F42ZJTHBP8pYArrbM+dXy6kl0Qcu3Hd6yuuiwPFtpGKFp3Vs3Eh9
         lvqqPGv+qvTD7nJcvkFIn2Ub2NC80VzQ5nhDH4lU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 16/71] MIPS: VDSO: Always map near top of user memory
Date:   Tue, 16 Oct 2018 19:09:13 +0200
Message-Id: <20181016170540.218002691@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=yPgj=M4=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit ea7e0480a4b695d0aa6b3fa99bd658a003122113 upstream.

When using the legacy mmap layout, for example triggered using ulimit -s
unlimited, get_unmapped_area() fills memory from bottom to top starting
from a fairly low address near TASK_UNMAPPED_BASE.

This placement is suboptimal if the user application wishes to allocate
large amounts of heap memory using the brk syscall. With the VDSO being
located low in the user's virtual address space, the amount of space
available for access using brk is limited much more than it was prior to
the introduction of the VDSO.

For example:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00cc3000-00ce4000 rwxp 00000000 00:00 0          [heap]
  2ab96000-2ab98000 r--p 00000000 00:00 0          [vvar]
  2ab98000-2ab99000 r-xp 00000000 00:00 0          [vdso]
  2ab99000-2ab9d000 rwxp 00000000 00:00 0
  ...

Resolve this by adjusting STACK_TOP to reserve space for the VDSO &
providing an address hint to get_unmapped_area() causing it to use this
space even when using the legacy mmap layout.

We reserve enough space for the VDSO, plus 1MB or 256MB for 32 bit & 64
bit systems respectively within which we randomize the VDSO base
address. Previously this randomization was taken care of by the mmap
base address randomization performed by arch_mmap_rnd(). The 1MB & 256MB
sizes are somewhat arbitrary but chosen such that we have some
randomization without taking up too much of the user's virtual address
space, which is often in short supply for 32 bit systems.

With this the VDSO is always mapped at a high address, leaving lots of
space for statically linked programs to make use of brk:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00c28000-00c49000 rwxp 00000000 00:00 0          [heap]
  ...
  7f67c000-7f69d000 rwxp 00000000 00:00 0          [stack]
  7f7fc000-7f7fd000 rwxp 00000000 00:00 0
  7fcf1000-7fcf3000 r--p 00000000 00:00 0          [vvar]
  7fcf3000-7fcf4000 r-xp 00000000 00:00 0          [vdso]

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Huacai Chen <chenhc@lemote.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/processor.h |   10 +++++-----
 arch/mips/kernel/process.c        |   25 +++++++++++++++++++++++++
 arch/mips/kernel/vdso.c           |   18 +++++++++++++++++-
 3 files changed, 47 insertions(+), 6 deletions(-)

--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -13,6 +13,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/sizes.h>
 #include <linux/threads.h>
 
 #include <asm/cachectl.h>
@@ -80,11 +81,10 @@ extern unsigned int vced_count, vcei_cou
 
 #endif
 
-/*
- * One page above the stack is used for branch delay slot "emulation".
- * See dsemul.c for details.
- */
-#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - PAGE_SIZE)
+#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_256M)
+
+extern unsigned long mips_stack_top(void);
+#define STACK_TOP		mips_stack_top()
 
 /*
  * This decides where the kernel will search for a free chunk of vm
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/prctl.h>
 #include <linux/nmi.h>
 
+#include <asm/abi.h>
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -35,6 +36,7 @@
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/irq.h>
+#include <asm/mips-cps.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
@@ -621,6 +623,29 @@ out:
 	return pc;
 }
 
+unsigned long mips_stack_top(void)
+{
+	unsigned long top = TASK_SIZE & PAGE_MASK;
+
+	/* One page for branch delay slot "emulation" */
+	top -= PAGE_SIZE;
+
+	/* Space for the VDSO, data page & GIC user page */
+	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+	top -= PAGE_SIZE;
+	top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+	/* Space for cache colour alignment */
+	if (cpu_has_dc_aliases)
+		top -= shm_align_mask + 1;
+
+	/* Space to randomize the VDSO base */
+	if (current->flags & PF_RANDOMIZE)
+		top -= VDSO_RANDOMIZE_SIZE;
+
+	return top;
+}
+
 /*
  * Don't forget that the stack pointer must be aligned on a 8 bytes
  * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -16,6 +16,7 @@
 #include <linux/irqchip/mips-gic.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
@@ -97,6 +98,21 @@ void update_vsyscall_tz(void)
 	}
 }
 
+static unsigned long vdso_base(void)
+{
+	unsigned long base;
+
+	/* Skip the delay slot emulation page */
+	base = STACK_TOP + PAGE_SIZE;
+
+	if (current->flags & PF_RANDOMIZE) {
+		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
+		base = PAGE_ALIGN(base);
+	}
+
+	return base;
+}
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
@@ -138,7 +154,7 @@ int arch_setup_additional_pages(struct l
 	if (cpu_has_dc_aliases)
 		size += shm_align_mask + 1;
 
-	base = get_unmapped_area(NULL, 0, size, 0, 0);
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
