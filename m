Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 11:04:58 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:35812 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133460AbVK3LEj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 11:04:39 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 5345FC021;
	Wed, 30 Nov 2005 12:07:57 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 9894E1BC096;
	Wed, 30 Nov 2005 12:07:59 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id B676F1A18C1;
	Wed, 30 Nov 2005 12:07:58 +0100 (CET)
Subject: MIPS no FP patch
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Cc:	Jordan Crouse <jordan.crouse@amd.com>
Content-Type: multipart/mixed; boundary="=-AZcuWd0hzG6Kj7KQhnEu"
Date:	Wed, 30 Nov 2005 12:07:32 +0100
Message-Id: <1133348852.24526.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips


--=-AZcuWd0hzG6Kj7KQhnEu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

This is a patch that makes FP emulation in kernel an option.
I used this when I was looking why there are still some
FP instruction in glibc, even though it was configured with
--withot-fp. This seemed the best way to ensure this.

It is for the 2.6.14-rc2, but I think there is only a minimal
work to use it on latest kernel.

BR,
Matej


--=-AZcuWd0hzG6Kj7KQhnEu
Content-Disposition: attachment; filename=linux-2.6.14-rc2-no-fp.patch
Content-Type: text/x-patch; name=linux-2.6.14-rc2-no-fp.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patch introduces a option, with which you can enable
or disable the FP emulator in the kernel.
It was written to ensure that no user space binaries uses
FP instruction. This was necessary because glibc
still contained some FP instructions even though it
was configured with --without-fp and gcc with --with-float=soft.
See <http://sources.redhat.com/ml/crossgcc/2005-09/msg00054.html>
for details and <http://sources.redhat.com/ml/crossgcc/2005-09/msg00125.html>
for patch.

Signed-off-by: Matej Kupljen <matej.kupljen@ultra.si>

diff -ruN linux-latest/arch/mips/Kconfig linux-20051025-dbau1200/arch/mips/Kconfig
--- linux-latest/arch/mips/Kconfig	2005-10-24 13:36:24.000000000 +0200
+++ linux-20051025-dbau1200/arch/mips/Kconfig	2005-11-30 11:14:59.823169816 +0100
@@ -1623,6 +1623,13 @@
 
 source "kernel/Kconfig.preempt"
 
+config MIPS_FPU_EMULATOR
+	bool "Include FPU emulator in the kernel"
+	default y
+	help
+	  Enables or disables FP emulation in kernel.
+	  If unsure, say YES
+
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
diff -ruN linux-latest/arch/mips/Makefile linux-20051025-dbau1200/arch/mips/Makefile
--- linux-latest/arch/mips/Makefile	2005-10-24 13:36:24.000000000 +0200
+++ linux-20051025-dbau1200/arch/mips/Makefile	2005-11-30 10:45:12.000000000 +0100
@@ -752,7 +752,13 @@
 libs-$(CONFIG_32BIT)	+= arch/mips/lib-32/
 libs-$(CONFIG_64BIT)	+= arch/mips/lib-64/
 
-core-y			+= arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/
+core-y			+= arch/mips/kernel/ arch/mips/mm/
+
+ifdef CONFIG_MIPS_FPU_EMULATOR
+core-y                 += arch/mips/math-emu/
+else
+core-y                 += arch/mips/no-math-emu/
+endif
 
 drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
 
diff -ruN linux-latest/arch/mips/no-math-emu/cp1emu.c linux-20051025-dbau1200/arch/mips/no-math-emu/cp1emu.c
--- linux-latest/arch/mips/no-math-emu/cp1emu.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-20051025-dbau1200/arch/mips/no-math-emu/cp1emu.c	2005-11-30 11:44:16.410128008 +0100
@@ -0,0 +1,21 @@
+/*
+ * cp1emu.c: a MIPS coprocessor 1 (fpu) instruction emulator
+ * 
+ * Dummy file that just calls BUG() when a coprocessor 1
+ * instruction is encountered.
+ * It was wrtitten to ensure that no FP instruction is
+ * present in userspace binaries.
+ * 
+ * Written by Matej Kupljen <matej.kupljen@ultra.si>, 2005
+ */
+
+#include <asm/fpu_emulator.h>
+#include <asm/processor.h>
+#include <asm/bug.h>
+
+int fpu_emulator_cop1Handler(int xcptno, struct pt_regs *xcp,
+	struct mips_fpu_soft_struct *ctx)
+{
+	BUG();
+	return 0;
+}
diff -ruN linux-latest/arch/mips/no-math-emu/dsemul.c linux-20051025-dbau1200/arch/mips/no-math-emu/dsemul.c
--- linux-latest/arch/mips/no-math-emu/dsemul.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-20051025-dbau1200/arch/mips/no-math-emu/dsemul.c	2005-11-30 11:44:11.307903664 +0100
@@ -0,0 +1,14 @@
+/*
+ * Dummy file to support kernel without FP emulator.
+ * Matej Kupljen <matej.kupljen@ultra.si>, 2005
+ */
+
+#include <asm/fpu_emulator.h>
+#include <asm/processor.h>
+#include <asm/bug.h>
+
+int do_dsemulret(struct pt_regs *xcp)
+{
+	BUG();
+	return 1;
+}
diff -ruN linux-latest/arch/mips/no-math-emu/kernel_linkage.c linux-20051025-dbau1200/arch/mips/no-math-emu/kernel_linkage.c
--- linux-latest/arch/mips/no-math-emu/kernel_linkage.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-20051025-dbau1200/arch/mips/no-math-emu/kernel_linkage.c	2005-11-30 11:44:05.818738144 +0100
@@ -0,0 +1,53 @@
+/*
+ *  Kevin D. Kissell, kevink@mips and Carsten Langgaard, carstenl@mips.com
+ *  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * 
+ * Dummy file to support kernel without FP emulator.
+ * 
+ * Modified by Matej Kupljen <matej.kupljen@ultra.si>, 2005
+ */
+
+#include <asm/fpu_emulator.h>
+#include <linux/sched.h>
+#include <asm/bug.h>
+
+void fpu_emulator_init_fpu(void)
+{
+	static int first = 1;
+
+	if (first) {
+		first = 0;
+		printk("Kernel without FPU emulator!\n");
+	}
+}
+
+int fpu_emulator_save_context(struct sigcontext *sc)
+{
+	BUG();
+	return -1;
+}
+
+int fpu_emulator_restore_context(struct sigcontext *sc)
+{
+	BUG();
+	return -1;
+}
+
+#ifdef CONFIG_MIPS64
+/*
+ * This is the o32 version
+ */
+
+int fpu_emulator_save_context32(struct sigcontext32 *sc)
+{
+	BUG();
+	return -1;
+}
+
+int fpu_emulator_restore_context32(struct sigcontext32 *sc)
+{
+	BUG();
+
+	return err;
+}
+#endif
diff -ruN linux-latest/arch/mips/no-math-emu/Makefile linux-20051025-dbau1200/arch/mips/no-math-emu/Makefile
--- linux-latest/arch/mips/no-math-emu/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-20051025-dbau1200/arch/mips/no-math-emu/Makefile	2005-09-06 09:13:54.000000000 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for the Linux/MIPS kernel FPU emulation.
+#
+
+obj-y	:= cp1emu.o kernel_linkage.o dsemul.o

--=-AZcuWd0hzG6Kj7KQhnEu--
