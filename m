Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 20:00:17 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:21168 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133677AbWEOSAJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 20:00:09 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 566C744F4B; Mon, 15 May 2006 20:00:08 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FfhLy-00033P-Qh; Mon, 15 May 2006 18:59:34 +0100
Date:	Mon, 15 May 2006 18:59:34 +0100
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Qemu system shutdown support
Message-ID: <20060515175934.GA11370@networkno.de>
References: <20060515172558.GD9026@networkno.de> <20060515173023.GA13776@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515173023.GA13776@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Thiemo Seufer <ths@networkno.de> [2006-05-15 18:25]:
> > +{
> > +        volatile unsigned int *reg = (unsigned int *)QEMU_RESTART_REG;
> 
> This should be a tab.

Updated.


Support for qemu system shutdown.


Signed-off-by:  Thiemo Seufer <ths@networkno.de>


diff -urpN linux-orig/arch/mips/qemu/Makefile linux-work/arch/mips/qemu/Makefile
--- linux-orig/arch/mips/qemu/Makefile	2006-04-24 12:02:26.000000000 +0100
+++ linux-work/arch/mips/qemu/Makefile	2006-05-15 03:07:31.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for Qemu specific kernel interface routines under Linux.
 #
 
-obj-y		= q-firmware.o q-irq.o q-mem.o q-setup.o
+obj-y		= q-firmware.o q-irq.o q-mem.o q-setup.o q-reset.o
 
 obj-$(CONFIG_VT) += q-vga.o
 obj-$(CONFIG_SMP) += q-smp.o
diff -urpN linux-orig/arch/mips/qemu/q-reset.c linux-work/arch/mips/qemu/q-reset.c
--- linux-orig/arch/mips/qemu/q-reset.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-work/arch/mips/qemu/q-reset.c	2006-05-15 03:06:44.000000000 +0100
@@ -0,0 +1,34 @@
+#include <linux/config.h>
+
+#include <asm/io.h>
+#include <asm/reboot.h>
+#include <asm/cacheflush.h>
+#include <asm/qemu.h>
+
+static void qemu_machine_restart(char *command)
+{
+	volatile unsigned int *reg = (unsigned int *)QEMU_RESTART_REG;
+
+	set_c0_status(ST0_BEV | ST0_ERL);
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	flush_cache_all();
+	write_c0_wired(0);
+	*reg = 42;
+	while (1)
+		cpu_wait();
+}
+
+static void qemu_machine_halt(void)
+{
+	volatile unsigned int *reg = (unsigned int *)QEMU_HALT_REG;
+
+	*reg = 42;
+	while (1)
+		cpu_wait();
+}
+
+void qemu_reboot_setup(void)
+{
+	_machine_restart = qemu_machine_restart;
+	_machine_halt = qemu_machine_halt;
+}
diff -urpN linux-orig/arch/mips/qemu/q-setup.c linux-work/arch/mips/qemu/q-setup.c
--- linux-orig/arch/mips/qemu/q-setup.c	2006-04-24 12:02:26.000000000 +0100
+++ linux-work/arch/mips/qemu/q-setup.c	2006-05-15 03:06:44.000000000 +0100
@@ -3,6 +3,7 @@
 #include <asm/time.h>
 
 extern void qvga_init(void);
+extern void qemu_reboot_setup(void);
 
 #define QEMU_PORT_BASE 0xb4000000
 
@@ -27,4 +28,6 @@ void __init plat_setup(void)
 	qvga_init();
 #endif
 	board_timer_setup = qemu_timer_setup;
+
+	qemu_reboot_setup();
 }
diff -urpN linux-orig/include/asm-mips/qemu.h linux-work/include/asm-mips/qemu.h
--- linux-orig/include/asm-mips/qemu.h	2006-04-24 12:02:35.000000000 +0100
+++ linux-work/include/asm-mips/qemu.h	2006-05-15 03:06:44.000000000 +0100
@@ -21,4 +21,10 @@
  */
 #define QEMU_C0_COUNTER_CLOCK	100000000
 
+/*
+ * Magic qemu system control location.
+ */
+#define QEMU_RESTART_REG	0xBFBF0000
+#define QEMU_HALT_REG		0xBFBF0004
+
 #endif /* __ASM_QEMU_H */
