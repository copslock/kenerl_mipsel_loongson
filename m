Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2008 16:30:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:24319 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026383AbYGJPaQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2008 16:30:16 +0100
Received: from localhost (p7221-ipad210funabasi.chiba.ocn.ne.jp [58.88.126.221])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 27694AAB9; Fri, 11 Jul 2008 00:29:51 +0900 (JST)
Date:	Fri, 11 Jul 2008 00:31:36 +0900 (JST)
Message-Id: <20080711.003136.106261691.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] reorganize txx9 code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Move arch/mips/{jmr3927,tx4927,tx4938} into arch/mips/txx9/ tree.
This will help more code sharing and maintainance.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
git-diff --stat -M output:
 arch/mips/Kconfig                                  |    3 +-
 arch/mips/Makefile                                 |   12 ++--
 arch/mips/jmr3927/common/Makefile                  |    7 --
 arch/mips/jmr3927/common/puts.c                    |   60 --------------------
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/fixup-jmr3927.c                      |    2 +-
 arch/mips/pci/fixup-rbtx4927.c                     |    2 +-
 arch/mips/pci/{fixup-tx4938.c => fixup-rbtx4938.c} |    2 +-
 arch/mips/pci/ops-tx3927.c                         |    2 +-
 arch/mips/pci/ops-tx4927.c                         |    2 +-
 arch/mips/pci/ops-tx4938.c                         |    2 +-
 arch/mips/pci/pci-jmr3927.c                        |    2 +-
 arch/mips/tx4927/Kconfig                           |    3 -
 arch/mips/tx4927/common/Makefile                   |   10 ---
 arch/mips/tx4927/common/tx4927_dbgio.c             |   43 --------------
 arch/mips/tx4927/toshiba_rbtx4927/Makefile         |    5 --
 arch/mips/tx4938/common/Makefile                   |    8 ---
 arch/mips/tx4938/toshiba_rbtx4938/Makefile         |    7 --
 arch/mips/{tx4938 => txx9}/Kconfig                 |    4 +
 arch/mips/txx9/generic/Makefile                    |   10 +++
 arch/mips/{tx4938/common => txx9/generic}/dbgio.c  |    0 
 .../tx4927_irq.c => txx9/generic/irq_tx4927.c}     |    3 +-
 .../common/irq.c => txx9/generic/irq_tx4938.c}     |    2 +-
 .../tx4927_prom.c => txx9/generic/mem_tx4927.c}    |    1 -
 .../common/prom.c => txx9/generic/mem_tx4938.c}    |    0 
 .../common => txx9/generic}/smsc_fdc37m81x.c       |    2 +-
 .../{jmr3927/rbhma3100 => txx9/jmr3927}/Makefile   |    4 +-
 .../{jmr3927/rbhma3100 => txx9/jmr3927}/init.c     |    2 +-
 .../mips/{jmr3927/rbhma3100 => txx9/jmr3927}/irq.c |    2 +-
 .../{jmr3927/rbhma3100 => txx9/jmr3927}/kgdb_io.c  |    2 +-
 arch/mips/{jmr3927/common => txx9/jmr3927}/prom.c  |   26 +++++++++
 .../{jmr3927/rbhma3100 => txx9/jmr3927}/setup.c    |    2 +-
 arch/mips/txx9/rbtx4927/Makefile                   |    3 +
 .../toshiba_rbtx4927_irq.c => txx9/rbtx4927/irq.c} |    4 +-
 .../rbtx4927/prom.c}                               |    2 +-
 .../rbtx4927/setup.c}                              |    4 +-
 arch/mips/txx9/rbtx4938/Makefile                   |    3 +
 .../toshiba_rbtx4938 => txx9/rbtx4938}/irq.c       |    4 +-
 .../toshiba_rbtx4938 => txx9/rbtx4938}/prom.c      |    4 +-
 .../toshiba_rbtx4938 => txx9/rbtx4938}/setup.c     |    6 +-
 .../rbtx4938}/spi_eeprom.c                         |    4 +-
 include/asm-mips/{jmr3927 => txx9}/jmr3927.h       |    8 +-
 .../{tx4927/toshiba_rbtx4927.h => txx9/rbtx4927.h} |    8 +-
 include/asm-mips/{tx4938 => txx9}/rbtx4938.h       |    9 +--
 include/asm-mips/{tx4927 => txx9}/smsc_fdc37m81x.h |    2 -
 include/asm-mips/{tx4938 => txx9}/spi.h            |    7 +-
 include/asm-mips/{jmr3927 => txx9}/tx3927.h        |    8 +-
 include/asm-mips/{tx4927 => txx9}/tx4927.h         |    6 +-
 include/asm-mips/{tx4938 => txx9}/tx4938.h         |    5 +-
 include/asm-mips/{jmr3927 => txx9}/txx927.h        |    6 +-
 50 files changed, 107 insertions(+), 220 deletions(-)


diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a038142..3202960 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -642,8 +642,7 @@ source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
 source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
-source "arch/mips/tx4927/Kconfig"
-source "arch/mips/tx4938/Kconfig"
+source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 
 endmenu
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 36aa690..8e1e49c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -553,8 +553,8 @@ all-$(CONFIG_SNI_RM)		:= vmlinux.ecoff
 #
 # Toshiba JMR-TX3927 board
 #
-core-$(CONFIG_TOSHIBA_JMR3927)	+= arch/mips/jmr3927/rbhma3100/ \
-				   arch/mips/jmr3927/common/
+core-$(CONFIG_TOSHIBA_JMR3927)	+= arch/mips/txx9/jmr3927/ \
+				   arch/mips/txx9/generic/
 cflags-$(CONFIG_TOSHIBA_JMR3927) += -Iinclude/asm-mips/mach-jmr3927
 load-$(CONFIG_TOSHIBA_JMR3927)	+= 0xffffffff80050000
 
@@ -562,16 +562,16 @@ load-$(CONFIG_TOSHIBA_JMR3927)	+= 0xffffffff80050000
 # Toshiba RBTX4927 board or
 # Toshiba RBTX4937 board
 #
-core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/toshiba_rbtx4927/
-core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/common/
+core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/rbtx4927/
+core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/generic/
 cflags-$(CONFIG_TOSHIBA_RBTX4927) += -Iinclude/asm-mips/mach-tx49xx
 load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 
 #
 # Toshiba RBTX4938 board
 #
-core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/tx4938/toshiba_rbtx4938/
-core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/tx4938/common/
+core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/txx9/rbtx4938/
+core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/txx9/generic/
 cflags-$(CONFIG_TOSHIBA_RBTX4938) += -Iinclude/asm-mips/mach-tx49xx
 load-$(CONFIG_TOSHIBA_RBTX4938) += 0xffffffff80100000
 
diff --git a/arch/mips/jmr3927/common/Makefile b/arch/mips/jmr3927/common/Makefile
deleted file mode 100644
index 8fd4fcc..0000000
--- a/arch/mips/jmr3927/common/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for the common code of TOSHIBA JMR-TX3927 board
-#
-
-obj-y	 += prom.o puts.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/jmr3927/common/prom.c b/arch/mips/jmr3927/common/prom.c
deleted file mode 100644
index 5398813..0000000
--- a/arch/mips/jmr3927/common/prom.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *    PROM library initialisation code, assuming a version of
- *    pmon is the boot code.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * Based on arch/mips/au1000/common/prom.c
- *
- * This file was derived from Carsten Langgaard's
- * arch/mips/mips-boards/xx files.
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
-void  __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr;
-	int prom_argc = fw_arg0;
-	char **prom_argv = (char **) fw_arg1;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
diff --git a/arch/mips/jmr3927/common/puts.c b/arch/mips/jmr3927/common/puts.c
deleted file mode 100644
index c611ab4..0000000
--- a/arch/mips/jmr3927/common/puts.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Low level uart routines to directly access a TX[34]927 SIO.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ahennessy@mvista.com or source@mvista.com
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * Based on arch/mips/au1000/common/puts.c
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <asm/jmr3927/tx3927.h>
-
-#define TIMEOUT       0xffffff
-
-void
-prom_putchar(char c)
-{
-        int i = 0;
-
-        do {
-            i++;
-            if (i>TIMEOUT)
-                break;
-        } while (!(tx3927_sioptr(1)->cisr & TXx927_SICISR_TXALS));
-	tx3927_sioptr(1)->tfifo = c;
-	return;
-}
-
-void
-puts(const char *cp)
-{
-    while (*cp)
-	prom_putchar(*cp++);
-    prom_putchar('\r');
-    prom_putchar('\n');
-}
diff --git a/arch/mips/jmr3927/rbhma3100/Makefile b/arch/mips/jmr3927/rbhma3100/Makefile
deleted file mode 100644
index d86e30d..0000000
--- a/arch/mips/jmr3927/rbhma3100/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-# Makefile for TOSHIBA JMR-TX3927 board
-#
-
-obj-y	 			+= init.o irq.o setup.o
-obj-$(CONFIG_KGDB)		+= kgdb_io.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/jmr3927/rbhma3100/init.c b/arch/mips/jmr3927/rbhma3100/init.c
deleted file mode 100644
index 700b9cf..0000000
--- a/arch/mips/jmr3927/rbhma3100/init.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * arch/mips/jmr3927/common/init.c
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <asm/bootinfo.h>
-#include <asm/jmr3927/jmr3927.h>
-
-extern void  __init prom_init_cmdline(void);
-
-const char *get_system_type(void)
-{
-	return "Toshiba"
-#ifdef CONFIG_TOSHIBA_JMR3927
-	       " JMR_TX3927"
-#endif
-	;
-}
-
-extern void puts(const char *cp);
-
-void __init prom_init(void)
-{
-#ifdef CONFIG_TOSHIBA_JMR3927
-	/* CCFG */
-	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
-		puts("Warning: TX3927 TLB off\n");
-#endif
-
-	prom_init_cmdline();
-	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/jmr3927/rbhma3100/irq.c b/arch/mips/jmr3927/rbhma3100/irq.c
deleted file mode 100644
index 3a47e8c..0000000
--- a/arch/mips/jmr3927/rbhma3100/irq.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-
-#include <asm/processor.h>
-#include <asm/jmr3927/jmr3927.h>
-
-#if JMR3927_IRQ_END > NR_IRQS
-#error JMR3927_IRQ_END > NR_IRQS
-#endif
-
-static unsigned char irc_level[TX3927_NUM_IR] = {
-	5, 5, 5, 5, 5, 5,	/* INT[5:0] */
-	7, 7,			/* SIO */
-	5, 5, 5, 0, 0,		/* DMA, PIO, PCI */
-	6, 6, 6			/* TMR */
-};
-
-/*
- * CP0_STATUS is a thread's resource (saved/restored on context switch).
- * So disable_irq/enable_irq MUST handle IOC/IRC registers.
- */
-static void mask_irq_ioc(unsigned int irq)
-{
-	/* 0: mask */
-	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
-	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
-	unsigned int bit = 1 << irq_nr;
-	jmr3927_ioc_reg_out(imask & ~bit, JMR3927_IOC_INTM_ADDR);
-	/* flush write buffer */
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
-}
-static void unmask_irq_ioc(unsigned int irq)
-{
-	/* 0: mask */
-	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
-	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
-	unsigned int bit = 1 << irq_nr;
-	jmr3927_ioc_reg_out(imask | bit, JMR3927_IOC_INTM_ADDR);
-	/* flush write buffer */
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned long cp0_cause = read_c0_cause();
-	int irq;
-
-	if ((cp0_cause & CAUSEF_IP7) == 0)
-		return;
-	irq = (cp0_cause >> CAUSEB_IP2) & 0x0f;
-
-	do_IRQ(irq + JMR3927_IRQ_IRC);
-}
-
-static irqreturn_t jmr3927_ioc_interrupt(int irq, void *dev_id)
-{
-	unsigned char istat = jmr3927_ioc_reg_in(JMR3927_IOC_INTS2_ADDR);
-	int i;
-
-	for (i = 0; i < JMR3927_NR_IRQ_IOC; i++) {
-		if (istat & (1 << i)) {
-			irq = JMR3927_IRQ_IOC + i;
-			do_IRQ(irq);
-		}
-	}
-	return IRQ_HANDLED;
-}
-
-static struct irqaction ioc_action = {
-	.handler = jmr3927_ioc_interrupt,
-	.mask = CPU_MASK_NONE,
-	.name = "IOC",
-};
-
-static irqreturn_t jmr3927_pcierr_interrupt(int irq, void *dev_id)
-{
-	printk(KERN_WARNING "PCI error interrupt (irq 0x%x).\n", irq);
-	printk(KERN_WARNING "pcistat:%02x, lbstat:%04lx\n",
-	       tx3927_pcicptr->pcistat, tx3927_pcicptr->lbstat);
-
-	return IRQ_HANDLED;
-}
-static struct irqaction pcierr_action = {
-	.handler = jmr3927_pcierr_interrupt,
-	.mask = CPU_MASK_NONE,
-	.name = "PCI error",
-};
-
-static void __init jmr3927_irq_init(void);
-
-void __init arch_init_irq(void)
-{
-	/* Now, interrupt control disabled, */
-	/* all IRC interrupts are masked, */
-	/* all IRC interrupt mode are Low Active. */
-
-	/* mask all IOC interrupts */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTM_ADDR);
-	/* setup IOC interrupt mode (SOFT:High Active, Others:Low Active) */
-	jmr3927_ioc_reg_out(JMR3927_IOC_INTF_SOFT, JMR3927_IOC_INTP_ADDR);
-
-	/* clear PCI Soft interrupts */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTS1_ADDR);
-	/* clear PCI Reset interrupts */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-
-	jmr3927_irq_init();
-
-	/* setup IOC interrupt 1 (PCI, MODEM) */
-	setup_irq(JMR3927_IRQ_IOCINT, &ioc_action);
-
-#ifdef CONFIG_PCI
-	setup_irq(JMR3927_IRQ_IRC_PCI, &pcierr_action);
-#endif
-
-	/* enable all CPU interrupt bits. */
-	set_c0_status(ST0_IM);	/* IE bit is still 0. */
-}
-
-static struct irq_chip jmr3927_irq_ioc = {
-	.name = "jmr3927_ioc",
-	.ack = mask_irq_ioc,
-	.mask = mask_irq_ioc,
-	.mask_ack = mask_irq_ioc,
-	.unmask = unmask_irq_ioc,
-};
-
-static void __init jmr3927_irq_init(void)
-{
-	u32 i;
-
-	txx9_irq_init(TX3927_IRC_REG);
-	for (i = 0; i < TXx9_MAX_IR; i++)
-		txx9_irq_set_pri(i, irc_level[i]);
-	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
-}
diff --git a/arch/mips/jmr3927/rbhma3100/kgdb_io.c b/arch/mips/jmr3927/rbhma3100/kgdb_io.c
deleted file mode 100644
index 342579c..0000000
--- a/arch/mips/jmr3927/rbhma3100/kgdb_io.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Low level uart routines to directly access a TX[34]927 SIO.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ahennessy@mvista.com or source@mvista.com
- *
- * Based on arch/mips/ddb5xxx/ddb5477/kgdb_io.c
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <asm/jmr3927/jmr3927.h>
-
-#define TIMEOUT       0xffffff
-
-static int remoteDebugInitialized = 0;
-static void debugInit(int baud);
-
-int putDebugChar(unsigned char c)
-{
-        int i = 0;
-
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		debugInit(38400);
-	}
-
-        do {
-            slow_down();
-            i++;
-            if (i>TIMEOUT) {
-                break;
-            }
-        } while (!(tx3927_sioptr(0)->cisr & TXx927_SICISR_TXALS));
-	tx3927_sioptr(0)->tfifo = c;
-
-	return 1;
-}
-
-unsigned char getDebugChar(void)
-{
-        int i = 0;
-	int dicr;
-	char c;
-
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		debugInit(38400);
-	}
-
-	/* diable RX int. */
-	dicr = tx3927_sioptr(0)->dicr;
-	tx3927_sioptr(0)->dicr = 0;
-
-        do {
-            slow_down();
-            i++;
-            if (i>TIMEOUT) {
-                break;
-            }
-        } while (tx3927_sioptr(0)->disr & TXx927_SIDISR_UVALID)
-		;
-	c = tx3927_sioptr(0)->rfifo;
-
-	/* clear RX int. status */
-	tx3927_sioptr(0)->disr &= ~TXx927_SIDISR_RDIS;
-	/* enable RX int. */
-	tx3927_sioptr(0)->dicr = dicr;
-
-	return c;
-}
-
-static void debugInit(int baud)
-{
-	tx3927_sioptr(0)->lcr = 0x020;
-	tx3927_sioptr(0)->dicr = 0;
-	tx3927_sioptr(0)->disr = 0x4100;
-	tx3927_sioptr(0)->cisr = 0x014;
-	tx3927_sioptr(0)->fcr = 0;
-	tx3927_sioptr(0)->flcr = 0x02;
-	tx3927_sioptr(0)->bgr = ((JMR3927_BASE_BAUD + baud / 2) / baud) |
-		TXx927_SIBGR_BCLK_T0;
-}
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
deleted file mode 100644
index f39c444..0000000
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ /dev/null
@@ -1,445 +0,0 @@
-/*
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/gpio.h>
-#ifdef CONFIG_SERIAL_TXX9
-#include <linux/serial_core.h>
-#endif
-
-#include <asm/txx9tmr.h>
-#include <asm/txx9pio.h>
-#include <asm/reboot.h>
-#include <asm/jmr3927/jmr3927.h>
-#include <asm/mipsregs.h>
-
-extern void puts(const char *cp);
-
-/* don't enable - see errata */
-static int jmr3927_ccfg_toeon;
-
-static inline void do_reset(void)
-{
-#if 1	/* Resetting PCI bus */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI, JMR3927_IOC_RESET_ADDR);
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_RESET_ADDR);	/* flush WB */
-	mdelay(1);
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-#endif
-	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_CPU, JMR3927_IOC_RESET_ADDR);
-}
-
-static void jmr3927_machine_restart(char *command)
-{
-	local_irq_disable();
-	puts("Rebooting...");
-	do_reset();
-}
-
-static void jmr3927_machine_halt(void)
-{
-	puts("JMR-TX3927 halted.\n");
-	while (1);
-}
-
-static void jmr3927_machine_power_off(void)
-{
-	puts("JMR-TX3927 halted. Please turn off the power.\n");
-	while (1);
-}
-
-void __init plat_time_init(void)
-{
-	txx9_clockevent_init(TX3927_TMR_REG(0),
-			     TXX9_IRQ_BASE + JMR3927_IRQ_IRC_TMR(0),
-			     JMR3927_IMCLK);
-	txx9_clocksource_init(TX3927_TMR_REG(1), JMR3927_IMCLK);
-}
-
-#define DO_WRITE_THROUGH
-#define DO_ENABLE_CACHE
-
-extern char * __init prom_getcmdline(void);
-static void jmr3927_board_init(void);
-extern struct resource pci_io_resource;
-extern struct resource pci_mem_resource;
-
-void __init plat_mem_setup(void)
-{
-	char *argptr;
-
-	set_io_port_base(JMR3927_PORT_BASE + JMR3927_PCIIO);
-
-	_machine_restart = jmr3927_machine_restart;
-	_machine_halt = jmr3927_machine_halt;
-	pm_power_off = jmr3927_machine_power_off;
-
-	/*
-	 * IO/MEM resources.
-	 */
-	ioport_resource.start = pci_io_resource.start;
-	ioport_resource.end = pci_io_resource.end;
-	iomem_resource.start = 0;
-	iomem_resource.end = 0xffffffff;
-
-	/* Reboot on panic */
-	panic_timeout = 180;
-
-	/* cache setup */
-	{
-		unsigned int conf;
-#ifdef DO_ENABLE_CACHE
-		int mips_ic_disable = 0, mips_dc_disable = 0;
-#else
-		int mips_ic_disable = 1, mips_dc_disable = 1;
-#endif
-#ifdef DO_WRITE_THROUGH
-		int mips_config_cwfon = 0;
-		int mips_config_wbon = 0;
-#else
-		int mips_config_cwfon = 1;
-		int mips_config_wbon = 1;
-#endif
-
-		conf = read_c0_conf();
-		conf &= ~(TX39_CONF_ICE | TX39_CONF_DCE | TX39_CONF_WBON | TX39_CONF_CWFON);
-		conf |= mips_ic_disable ? 0 : TX39_CONF_ICE;
-		conf |= mips_dc_disable ? 0 : TX39_CONF_DCE;
-		conf |= mips_config_wbon ? TX39_CONF_WBON : 0;
-		conf |= mips_config_cwfon ? TX39_CONF_CWFON : 0;
-
-		write_c0_conf(conf);
-		write_c0_cache(0);
-	}
-
-	/* initialize board */
-	jmr3927_board_init();
-
-	argptr = prom_getcmdline();
-
-	if ((argptr = strstr(argptr, "toeon")) != NULL)
-		jmr3927_ccfg_toeon = 1;
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "ip=")) == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " ip=bootp");
-	}
-
-#ifdef CONFIG_SERIAL_TXX9
-	{
-		extern int early_serial_txx9_setup(struct uart_port *port);
-		int i;
-		struct uart_port req;
-		for(i = 0; i < 2; i++) {
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.membase = (unsigned char __iomem *)TX3927_SIO_REG(i);
-			req.mapbase = TX3927_SIO_REG(i);
-			req.irq = i == 0 ?
-				JMR3927_IRQ_IRC_SIO0 : JMR3927_IRQ_IRC_SIO1;
-			if (i == 0)
-				req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-			req.uartclk = JMR3927_IMCLK;
-			early_serial_txx9_setup(&req);
-		}
-	}
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "console=")) == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS1,115200");
-	}
-#endif
-#endif
-}
-
-static void tx3927_setup(void);
-
-static void __init jmr3927_board_init(void)
-{
-	tx3927_setup();
-
-	/* SIO0 DTR on */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
-
-	jmr3927_led_set(0);
-
-	printk("JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
-	       jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
-	       jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
-	       jmr3927_dipsw1(), jmr3927_dipsw2(),
-	       jmr3927_dipsw3(), jmr3927_dipsw4());
-}
-
-static void __init tx3927_setup(void)
-{
-	int i;
-#ifdef CONFIG_PCI
-	unsigned long mips_pci_io_base = JMR3927_PCIIO;
-	unsigned long mips_pci_io_size = JMR3927_PCIIO_SIZE;
-	unsigned long mips_pci_mem_base = JMR3927_PCIMEM;
-	unsigned long mips_pci_mem_size = JMR3927_PCIMEM_SIZE;
-	/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
-	unsigned long mips_pci_io_pciaddr = 0;
-#endif
-
-	/* SDRAMC are configured by PROM */
-
-	/* ROMC */
-	tx3927_romcptr->cr[1] = JMR3927_ROMCE1 | 0x00030048;
-	tx3927_romcptr->cr[2] = JMR3927_ROMCE2 | 0x000064c8;
-	tx3927_romcptr->cr[3] = JMR3927_ROMCE3 | 0x0003f698;
-	tx3927_romcptr->cr[5] = JMR3927_ROMCE5 | 0x0000f218;
-
-	/* CCFG */
-	/* enable Timeout BusError */
-	if (jmr3927_ccfg_toeon)
-		tx3927_ccfgptr->ccfg |= TX3927_CCFG_TOE;
-
-	/* clear BusErrorOnWrite flag */
-	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_BEOW;
-	/* Disable PCI snoop */
-	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_PSNP;
-	/* do reset on watchdog */
-	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
-
-#ifdef DO_WRITE_THROUGH
-	/* Enable PCI SNOOP - with write through only */
-	tx3927_ccfgptr->ccfg |= TX3927_CCFG_PSNP;
-#endif
-
-	/* Pin selection */
-	tx3927_ccfgptr->pcfg &= ~TX3927_PCFG_SELALL;
-	tx3927_ccfgptr->pcfg |=
-		TX3927_PCFG_SELSIOC(0) | TX3927_PCFG_SELSIO_ALL |
-		(TX3927_PCFG_SELDMA_ALL & ~TX3927_PCFG_SELDMA(1));
-
-	printk("TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
-	       tx3927_ccfgptr->crir,
-	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
-
-	/* TMR */
-	for (i = 0; i < TX3927_NR_TMR; i++)
-		txx9_tmr_init(TX3927_TMR_REG(i));
-
-	/* DMA */
-	tx3927_dmaptr->mcr = 0;
-	for (i = 0; i < ARRAY_SIZE(tx3927_dmaptr->ch); i++) {
-		/* reset channel */
-		tx3927_dmaptr->ch[i].ccr = TX3927_DMA_CCR_CHRST;
-		tx3927_dmaptr->ch[i].ccr = 0;
-	}
-	/* enable DMA */
-#ifdef __BIG_ENDIAN
-	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN;
-#else
-	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN | TX3927_DMA_MCR_LE;
-#endif
-
-#ifdef CONFIG_PCI
-	/* PCIC */
-	printk("TX3927 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:",
-	       tx3927_pcicptr->did, tx3927_pcicptr->vid,
-	       tx3927_pcicptr->rid);
-	if (!(tx3927_ccfgptr->ccfg & TX3927_CCFG_PCIXARB)) {
-		printk("External\n");
-		/* XXX */
-	} else {
-		printk("Internal\n");
-
-		/* Reset PCI Bus */
-		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-		udelay(100);
-		jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI,
-				    JMR3927_IOC_RESET_ADDR);
-		udelay(100);
-		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
-
-
-		/* Disable External PCI Config. Access */
-		tx3927_pcicptr->lbc = TX3927_PCIC_LBC_EPCAD;
-#ifdef __BIG_ENDIAN
-		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_IBSE |
-			TX3927_PCIC_LBC_TIBSE |
-			TX3927_PCIC_LBC_TMFBSE | TX3927_PCIC_LBC_MSDSE;
-#endif
-		/* LB->PCI mappings */
-		tx3927_pcicptr->iomas = ~(mips_pci_io_size - 1);
-		tx3927_pcicptr->ilbioma = mips_pci_io_base;
-		tx3927_pcicptr->ipbioma = mips_pci_io_pciaddr;
-		tx3927_pcicptr->mmas = ~(mips_pci_mem_size - 1);
-		tx3927_pcicptr->ilbmma = mips_pci_mem_base;
-		tx3927_pcicptr->ipbmma = mips_pci_mem_base;
-		/* PCI->LB mappings */
-		tx3927_pcicptr->iobas = 0xffffffff;
-		tx3927_pcicptr->ioba = 0;
-		tx3927_pcicptr->tlbioma = 0;
-		tx3927_pcicptr->mbas = ~(mips_pci_mem_size - 1);
-		tx3927_pcicptr->mba = 0;
-		tx3927_pcicptr->tlbmma = 0;
-		/* Enable Direct mapping Address Space Decoder */
-		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_ILMDE | TX3927_PCIC_LBC_ILIDE;
-
-		/* Clear All Local Bus Status */
-		tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
-		/* Enable All Local Bus Interrupts */
-		tx3927_pcicptr->lbim = TX3927_PCIC_LBIM_ALL;
-		/* Clear All PCI Status Error */
-		tx3927_pcicptr->pcistat = TX3927_PCIC_PCISTATIM_ALL;
-		/* Enable All PCI Status Error Interrupts */
-		tx3927_pcicptr->pcistatim = TX3927_PCIC_PCISTATIM_ALL;
-
-		/* PCIC Int => IRC IRQ10 */
-		tx3927_pcicptr->il = TX3927_IR_PCI;
-		/* Target Control (per errata) */
-		tx3927_pcicptr->tc = TX3927_PCIC_TC_OF8E | TX3927_PCIC_TC_IF8E;
-
-		/* Enable Bus Arbiter */
-		tx3927_pcicptr->pbapmc = TX3927_PCIC_PBAPMC_PBAEN;
-
-		tx3927_pcicptr->pcicmd = PCI_COMMAND_MASTER |
-			PCI_COMMAND_MEMORY |
-			PCI_COMMAND_IO |
-			PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-	}
-#endif /* CONFIG_PCI */
-
-	/* PIO */
-	/* PIO[15:12] connected to LEDs */
-	__raw_writel(0x0000f000, &tx3927_pioptr->dir);
-	__raw_writel(0, &tx3927_pioptr->maskcpu);
-	__raw_writel(0, &tx3927_pioptr->maskext);
-	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
-	gpio_request(11, "dipsw1");
-	gpio_request(10, "dipsw2");
-	{
-		unsigned int conf;
-
-	conf = read_c0_conf();
-               if (!(conf & TX39_CONF_ICE))
-                       printk("TX3927 I-Cache disabled.\n");
-               if (!(conf & TX39_CONF_DCE))
-                       printk("TX3927 D-Cache disabled.\n");
-               else if (!(conf & TX39_CONF_WBON))
-                       printk("TX3927 D-Cache WriteThrough.\n");
-               else if (!(conf & TX39_CONF_CWFON))
-                       printk("TX3927 D-Cache WriteBack.\n");
-               else
-                       printk("TX3927 D-Cache WriteBack (CWF) .\n");
-	}
-}
-
-/* This trick makes rtc-ds1742 driver usable as is. */
-unsigned long __swizzle_addr_b(unsigned long port)
-{
-	if ((port & 0xffff0000) != JMR3927_IOC_NVRAMB_ADDR)
-		return port;
-	port = (port & 0xffff0000) | (port & 0x7fff << 1);
-#ifdef __BIG_ENDIAN
-	return port;
-#else
-	return port | 1;
-#endif
-}
-EXPORT_SYMBOL(__swizzle_addr_b);
-
-static int __init jmr3927_rtc_init(void)
-{
-	static struct resource __initdata res = {
-		.start	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE,
-		.end	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev;
-	dev = platform_device_register_simple("rtc-ds1742", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-device_initcall(jmr3927_rtc_init);
-
-/* Watchdog support */
-
-static int __init txx9_wdt_init(unsigned long base)
-{
-	struct resource res = {
-		.start	= base,
-		.end	= base + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("txx9wdt", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-
-static int __init jmr3927_wdt_init(void)
-{
-	return txx9_wdt_init(TX3927_TMR_REG(2));
-}
-device_initcall(jmr3927_wdt_init);
-
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)JMR3927_IMCLK;
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 80fa5ab..4608e43 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
-obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
+obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o ops-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index e974394..41dcd6a 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -31,7 +31,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-#include <asm/jmr3927/jmr3927.h>
+#include <asm/txx9/jmr3927.h>
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 2d234ca..26013ba 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -37,7 +37,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <asm/tx4927/tx4927.h>
+#include <asm/txx9/tx4927.h>
 
 #undef  DEBUG
 #ifdef  DEBUG
diff --git a/arch/mips/pci/fixup-rbtx4938.c b/arch/mips/pci/fixup-rbtx4938.c
new file mode 100644
index 0000000..64d4510
--- /dev/null
+++ b/arch/mips/pci/fixup-rbtx4938.c
@@ -0,0 +1,92 @@
+/*
+ * Toshiba rbtx4938 pci routines
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/txx9/rbtx4938.h>
+
+extern struct pci_controller tx4938_pci_controller[];
+
+static int pci_get_irq(const struct pci_dev *dev, int pin)
+{
+	int irq = pin;
+	u8 slot = PCI_SLOT(dev->devfn);
+	struct pci_controller *controller = (struct pci_controller *)dev->sysdata;
+
+	if (controller == &tx4938_pci_controller[1]) {
+		/* TX4938 PCIC1 */
+		switch (slot) {
+		case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
+			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH0_SEL)
+				return RBTX4938_IRQ_IRC + TX4938_IR_ETH0;
+			break;
+		case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
+			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH1_SEL)
+				return RBTX4938_IRQ_IRC + TX4938_IR_ETH1;
+			break;
+		}
+		return 0;
+	}
+
+	/* IRQ rotation */
+	irq--;	/* 0-3 */
+	if (dev->bus->parent == NULL &&
+	    (slot == TX4938_PCIC_IDSEL_AD_TO_SLOT(23))) {
+		/* PCI CardSlot (IDSEL=A23) */
+		/* PCIA => PCIA (IDSEL=A23) */
+		irq = (irq + 0 + slot) % 4;
+	} else {
+		/* PCI Backplane */
+		irq = (irq + 33 - slot) % 4;
+	}
+	irq++;	/* 1-4 */
+
+	switch (irq) {
+	case 1:
+		irq = RBTX4938_IRQ_IOC_PCIA;
+		break;
+	case 2:
+		irq = RBTX4938_IRQ_IOC_PCIB;
+		break;
+	case 3:
+		irq = RBTX4938_IRQ_IOC_PCIC;
+		break;
+	case 4:
+		irq = RBTX4938_IRQ_IOC_PCID;
+		break;
+	}
+	return irq;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	unsigned char irq = 0;
+
+	irq = pci_get_irq(dev, pin);
+
+	printk(KERN_INFO "PCI: 0x%02x:0x%02x(0x%02x,0x%02x) IRQ=%d\n",
+	       dev->bus->number, dev->devfn, PCI_SLOT(dev->devfn),
+	       PCI_FUNC(dev->devfn), irq);
+
+	return irq;
+}
+
+/*
+ * Do platform specific device initialization at pci_enable_device() time
+ */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
diff --git a/arch/mips/pci/fixup-tx4938.c b/arch/mips/pci/fixup-tx4938.c
deleted file mode 100644
index f2ba06e..0000000
--- a/arch/mips/pci/fixup-tx4938.c
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Toshiba rbtx4938 pci routines
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/tx4938/rbtx4938.h>
-
-extern struct pci_controller tx4938_pci_controller[];
-
-static int pci_get_irq(const struct pci_dev *dev, int pin)
-{
-	int irq = pin;
-	u8 slot = PCI_SLOT(dev->devfn);
-	struct pci_controller *controller = (struct pci_controller *)dev->sysdata;
-
-	if (controller == &tx4938_pci_controller[1]) {
-		/* TX4938 PCIC1 */
-		switch (slot) {
-		case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
-			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH0_SEL)
-				return RBTX4938_IRQ_IRC + TX4938_IR_ETH0;
-			break;
-		case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
-			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH1_SEL)
-				return RBTX4938_IRQ_IRC + TX4938_IR_ETH1;
-			break;
-		}
-		return 0;
-	}
-
-	/* IRQ rotation */
-	irq--;	/* 0-3 */
-	if (dev->bus->parent == NULL &&
-	    (slot == TX4938_PCIC_IDSEL_AD_TO_SLOT(23))) {
-		/* PCI CardSlot (IDSEL=A23) */
-		/* PCIA => PCIA (IDSEL=A23) */
-		irq = (irq + 0 + slot) % 4;
-	} else {
-		/* PCI Backplane */
-		irq = (irq + 33 - slot) % 4;
-	}
-	irq++;	/* 1-4 */
-
-	switch (irq) {
-	case 1:
-		irq = RBTX4938_IRQ_IOC_PCIA;
-		break;
-	case 2:
-		irq = RBTX4938_IRQ_IOC_PCIB;
-		break;
-	case 3:
-		irq = RBTX4938_IRQ_IOC_PCIC;
-		break;
-	case 4:
-		irq = RBTX4938_IRQ_IOC_PCID;
-		break;
-	}
-	return irq;
-}
-
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	unsigned char irq = 0;
-
-	irq = pci_get_irq(dev, pin);
-
-	printk(KERN_INFO "PCI: 0x%02x:0x%02x(0x%02x,0x%02x) IRQ=%d\n",
-	       dev->bus->number, dev->devfn, PCI_SLOT(dev->devfn),
-	       PCI_FUNC(dev->devfn), irq);
-
-	return irq;
-}
-
-/*
- * Do platform specific device initialization at pci_enable_device() time
- */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index aa698bd..5d398f6 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -39,7 +39,7 @@
 #include <linux/init.h>
 
 #include <asm/addrspace.h>
-#include <asm/jmr3927/jmr3927.h>
+#include <asm/txx9/jmr3927.h>
 
 static inline int mkaddr(unsigned char bus, unsigned char dev_fn,
 	unsigned char where)
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 1bbafeb..54730ee 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -40,7 +40,7 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <asm/tx4927/tx4927.h>
+#include <asm/txx9/tx4927.h>
 
 /* initialize in setup */
 struct resource pci_io_resource = {
diff --git a/arch/mips/pci/ops-tx4938.c b/arch/mips/pci/ops-tx4938.c
index a450c40..34494b8 100644
--- a/arch/mips/pci/ops-tx4938.c
+++ b/arch/mips/pci/ops-tx4938.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 
 #include <asm/addrspace.h>
-#include <asm/tx4938/rbtx4938.h>
+#include <asm/txx9/rbtx4938.h>
 
 /* initialize in setup */
 struct resource pci_io_resource = {
diff --git a/arch/mips/pci/pci-jmr3927.c b/arch/mips/pci/pci-jmr3927.c
index cb84f4e..7fb6bd7 100644
--- a/arch/mips/pci/pci-jmr3927.c
+++ b/arch/mips/pci/pci-jmr3927.c
@@ -31,7 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <asm/jmr3927/jmr3927.h>
+#include <asm/txx9/jmr3927.h>
 #include <asm/debug.h>
 
 struct resource pci_io_resource = {
diff --git a/arch/mips/tx4927/Kconfig b/arch/mips/tx4927/Kconfig
deleted file mode 100644
index 5fbbe12..0000000
--- a/arch/mips/tx4927/Kconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-config TOSHIBA_FPCIB0
-	bool "FPCIB0 Backplane Support"
-	depends on TOSHIBA_RBTX4927
diff --git a/arch/mips/tx4927/common/Makefile b/arch/mips/tx4927/common/Makefile
deleted file mode 100644
index a7fe76a..0000000
--- a/arch/mips/tx4927/common/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for common code for Toshiba TX4927 based systems
-#
-
-obj-y	+= tx4927_prom.o tx4927_irq.o
-
-obj-$(CONFIG_TOSHIBA_FPCIB0)	   += smsc_fdc37m81x.o
-obj-$(CONFIG_KGDB)                 += tx4927_dbgio.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4927/common/smsc_fdc37m81x.c b/arch/mips/tx4927/common/smsc_fdc37m81x.c
deleted file mode 100644
index 33f517b..0000000
--- a/arch/mips/tx4927/common/smsc_fdc37m81x.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * Interface for smsc fdc48m81x Super IO chip
- *
- * Author: MontaVista Software, Inc. source@mvista.com
- *
- * 2001-2003 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Copyright 2004 (c) MontaVista Software, Inc.
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <asm/io.h>
-#include <asm/tx4927/smsc_fdc37m81x.h>
-
-#define DEBUG
-
-/* Common Registers */
-#define SMSC_FDC37M81X_CONFIG_INDEX  0x00
-#define SMSC_FDC37M81X_CONFIG_DATA   0x01
-#define SMSC_FDC37M81X_CONF          0x02
-#define SMSC_FDC37M81X_INDEX         0x03
-#define SMSC_FDC37M81X_DNUM          0x07
-#define SMSC_FDC37M81X_DID           0x20
-#define SMSC_FDC37M81X_DREV          0x21
-#define SMSC_FDC37M81X_PCNT          0x22
-#define SMSC_FDC37M81X_PMGT          0x23
-#define SMSC_FDC37M81X_OSC           0x24
-#define SMSC_FDC37M81X_CONFPA0       0x26
-#define SMSC_FDC37M81X_CONFPA1       0x27
-#define SMSC_FDC37M81X_TEST4         0x2B
-#define SMSC_FDC37M81X_TEST5         0x2C
-#define SMSC_FDC37M81X_TEST1         0x2D
-#define SMSC_FDC37M81X_TEST2         0x2E
-#define SMSC_FDC37M81X_TEST3         0x2F
-
-/* Logical device numbers */
-#define SMSC_FDC37M81X_FDD           0x00
-#define SMSC_FDC37M81X_SERIAL1       0x04
-#define SMSC_FDC37M81X_SERIAL2       0x05
-#define SMSC_FDC37M81X_KBD           0x07
-
-/* Logical device Config Registers */
-#define SMSC_FDC37M81X_ACTIVE        0x30
-#define SMSC_FDC37M81X_BASEADDR0     0x60
-#define SMSC_FDC37M81X_BASEADDR1     0x61
-#define SMSC_FDC37M81X_INT           0x70
-#define SMSC_FDC37M81X_INT2          0x72
-#define SMSC_FDC37M81X_MODE          0xF0
-
-/* Chip Config Values */
-#define SMSC_FDC37M81X_CONFIG_ENTER  0x55
-#define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
-#define SMSC_FDC37M81X_CHIP_ID       0x4d
-
-static unsigned long g_smsc_fdc37m81x_base = 0;
-
-static inline unsigned char smsc_fdc37m81x_rd(unsigned char index)
-{
-	outb(index, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
-
-	return inb(g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_DATA);
-}
-
-static inline void smsc_dc37m81x_wr(unsigned char index, unsigned char data)
-{
-	outb(index, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
-	outb(data, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_DATA);
-}
-
-void smsc_fdc37m81x_config_beg(void)
-{
-	if (g_smsc_fdc37m81x_base) {
-		outb(SMSC_FDC37M81X_CONFIG_ENTER,
-		     g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
-	}
-}
-
-void smsc_fdc37m81x_config_end(void)
-{
-	if (g_smsc_fdc37m81x_base)
-		outb(SMSC_FDC37M81X_CONFIG_EXIT,
-		     g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
-}
-
-u8 smsc_fdc37m81x_config_get(u8 reg)
-{
-	u8 val = 0;
-
-	if (g_smsc_fdc37m81x_base)
-		val = smsc_fdc37m81x_rd(reg);
-
-	return val;
-}
-
-void smsc_fdc37m81x_config_set(u8 reg, u8 val)
-{
-	if (g_smsc_fdc37m81x_base)
-		smsc_dc37m81x_wr(reg, val);
-}
-
-unsigned long __init smsc_fdc37m81x_init(unsigned long port)
-{
-	const int field = sizeof(unsigned long) * 2;
-	u8 chip_id;
-
-	if (g_smsc_fdc37m81x_base)
-		printk("smsc_fdc37m81x_init() stepping on old base=0x%0*lx\n",
-		       field, g_smsc_fdc37m81x_base);
-
-	g_smsc_fdc37m81x_base = port;
-
-	smsc_fdc37m81x_config_beg();
-
-	chip_id = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DID);
-	if (chip_id == SMSC_FDC37M81X_CHIP_ID)
-		smsc_fdc37m81x_config_end();
-	else {
-		printk("smsc_fdc37m81x_init() unknow chip id 0x%02x\n",
-		       chip_id);
-		g_smsc_fdc37m81x_base = 0;
-	}
-
-	return g_smsc_fdc37m81x_base;
-}
-
-#ifdef DEBUG
-void smsc_fdc37m81x_config_dump_one(char *key, u8 dev, u8 reg)
-{
-	printk("%s: dev=0x%02x reg=0x%02x val=0x%02x\n", key, dev, reg,
-	       smsc_fdc37m81x_rd(reg));
-}
-
-void smsc_fdc37m81x_config_dump(void)
-{
-	u8 orig;
-	char *fname = "smsc_fdc37m81x_config_dump()";
-
-	smsc_fdc37m81x_config_beg();
-
-	orig = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DNUM);
-
-	printk("%s: common\n", fname);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
-				       SMSC_FDC37M81X_DNUM);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
-				       SMSC_FDC37M81X_DID);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
-				       SMSC_FDC37M81X_DREV);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
-				       SMSC_FDC37M81X_PCNT);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
-				       SMSC_FDC37M81X_PMGT);
-
-	printk("%s: keyboard\n", fname);
-	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, SMSC_FDC37M81X_KBD);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
-				       SMSC_FDC37M81X_ACTIVE);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
-				       SMSC_FDC37M81X_INT);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
-				       SMSC_FDC37M81X_INT2);
-	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
-				       SMSC_FDC37M81X_LDCR_F0);
-
-	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, orig);
-
-	smsc_fdc37m81x_config_end();
-}
-#endif
diff --git a/arch/mips/tx4927/common/tx4927_dbgio.c b/arch/mips/tx4927/common/tx4927_dbgio.c
deleted file mode 100644
index ea1ff23..0000000
--- a/arch/mips/tx4927/common/tx4927_dbgio.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * linux/arch/mips/tx4927/common/tx4927_dbgio.c
- *
- * kgdb interface for gdb
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/types.h>
-
-u8 getDebugChar(void)
-{
-	extern u8 txx9_sio_kdbg_rd(void);
-	return (txx9_sio_kdbg_rd());
-}
-
-int putDebugChar(u8 byte)
-{
-	extern int txx9_sio_kdbg_wr( u8 ch );
-	return (txx9_sio_kdbg_wr(byte));
-}
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
deleted file mode 100644
index 0aabd57..0000000
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * Common tx4927 irq handler
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/tx4927/tx4927.h>
-#ifdef CONFIG_TOSHIBA_RBTX4927
-#include <asm/tx4927/toshiba_rbtx4927.h>
-#endif
-
-void __init tx4927_irq_init(void)
-{
-	mips_cpu_irq_init();
-	txx9_irq_init(TX4927_IRC_REG);
-	set_irq_chained_handler(TX4927_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP7)			/* cpu timer */
-		do_IRQ(TX4927_IRQ_CPU_TIMER);
-	else if (pending & STATUSF_IP2) {		/* tx4927 pic */
-		int irq = txx9_irq();
-#ifdef CONFIG_TOSHIBA_RBTX4927
-		if (irq == TX4927_IRQ_NEST_EXT_ON_PIC)
-			irq = toshiba_rbtx4927_irq_nested(irq);
-#endif
-		if (unlikely(irq < 0)) {
-			spurious_interrupt();
-			return;
-		}
-		do_IRQ(irq);
-	} else if (pending & STATUSF_IP0)		/* user line 0 */
-		do_IRQ(TX4927_IRQ_USER0);
-	else if (pending & STATUSF_IP1)			/* user line 1 */
-		do_IRQ(TX4927_IRQ_USER1);
-	else
-		spurious_interrupt();
-}
diff --git a/arch/mips/tx4927/common/tx4927_prom.c b/arch/mips/tx4927/common/tx4927_prom.c
deleted file mode 100644
index cc2aa9d..0000000
--- a/arch/mips/tx4927/common/tx4927_prom.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * linux/arch/mips/tx4927/common/tx4927_prom.c
- *
- * common tx4927 memory interface
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/io.h>
-#include <asm/tx4927/tx4927.h>
-
-static unsigned int __init tx4927_process_sdccr(unsigned long addr)
-{
-	u64 val;
-	unsigned int sdccr_ce;
-	unsigned int sdccr_bs;
-	unsigned int sdccr_rs;
-	unsigned int sdccr_cs;
-	unsigned int sdccr_mw;
-	unsigned int bs = 0;
-	unsigned int rs = 0;
-	unsigned int cs = 0;
-	unsigned int mw = 0;
-	unsigned int msize = 0;
-
-	val = __raw_readq((void __iomem *)addr);
-
-	/* MVMCP -- need #defs for these bits masks */
-	sdccr_ce = ((val & (1 << 10)) >> 10);
-	sdccr_bs = ((val & (1 << 8)) >> 8);
-	sdccr_rs = ((val & (3 << 5)) >> 5);
-	sdccr_cs = ((val & (3 << 2)) >> 2);
-	sdccr_mw = ((val & (1 << 0)) >> 0);
-
-	if (sdccr_ce) {
-		switch (sdccr_bs) {
-		case 0:{
-				bs = 2;
-				break;
-			}
-		case 1:{
-				bs = 4;
-				break;
-			}
-		}
-		switch (sdccr_rs) {
-		case 0:{
-				rs = 2048;
-				break;
-			}
-		case 1:{
-				rs = 4096;
-				break;
-			}
-		case 2:{
-				rs = 8192;
-				break;
-			}
-		case 3:{
-				rs = 0;
-				break;
-			}
-		}
-		switch (sdccr_cs) {
-		case 0:{
-				cs = 256;
-				break;
-			}
-		case 1:{
-				cs = 512;
-				break;
-			}
-		case 2:{
-				cs = 1024;
-				break;
-			}
-		case 3:{
-				cs = 2048;
-				break;
-			}
-		}
-		switch (sdccr_mw) {
-		case 0:{
-				mw = 8;
-				break;
-			}	/* 8 bytes = 64 bits */
-		case 1:{
-				mw = 4;
-				break;
-			}	/* 4 bytes = 32 bits */
-		}
-	}
-
-	/*            bytes per chip     MB per chip      num chips */
-	msize = (((rs * cs * mw) / (1024 * 1024)) * bs);
-
-	return (msize);
-}
-
-
-unsigned int __init tx4927_get_mem_size(void)
-{
-	unsigned int c0;
-	unsigned int c1;
-	unsigned int c2;
-	unsigned int c3;
-	unsigned int total;
-
-	/* MVMCP -- need #defs for these registers */
-	c0 = tx4927_process_sdccr(0xff1f8000);
-	c1 = tx4927_process_sdccr(0xff1f8008);
-	c2 = tx4927_process_sdccr(0xff1f8010);
-	c3 = tx4927_process_sdccr(0xff1f8018);
-	total = c0 + c1 + c2 + c3;
-
-	return (total);
-}
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/Makefile b/arch/mips/tx4927/toshiba_rbtx4927/Makefile
deleted file mode 100644
index 13f9672..0000000
--- a/arch/mips/tx4927/toshiba_rbtx4927/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y	+= toshiba_rbtx4927_prom.o
-obj-y	+= toshiba_rbtx4927_setup.o
-obj-y	+= toshiba_rbtx4927_irq.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
deleted file mode 100644
index c18901a..0000000
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
- *
- * Toshiba RBTX4927 specific interrupt handlers
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-/*
-IRQ  Device
-00   RBTX4927-ISA/00
-01   RBTX4927-ISA/01 PS2/Keyboard
-02   RBTX4927-ISA/02 Cascade RBTX4927-ISA (irqs 8-15)
-03   RBTX4927-ISA/03
-04   RBTX4927-ISA/04
-05   RBTX4927-ISA/05
-06   RBTX4927-ISA/06
-07   RBTX4927-ISA/07
-08   RBTX4927-ISA/08
-09   RBTX4927-ISA/09
-10   RBTX4927-ISA/10
-11   RBTX4927-ISA/11
-12   RBTX4927-ISA/12 PS2/Mouse (not supported at this time)
-13   RBTX4927-ISA/13
-14   RBTX4927-ISA/14 IDE
-15   RBTX4927-ISA/15
-
-16   TX4927-CP0/00 Software 0
-17   TX4927-CP0/01 Software 1
-18   TX4927-CP0/02 Cascade TX4927-CP0
-19   TX4927-CP0/03 Multiplexed -- do not use
-20   TX4927-CP0/04 Multiplexed -- do not use
-21   TX4927-CP0/05 Multiplexed -- do not use
-22   TX4927-CP0/06 Multiplexed -- do not use
-23   TX4927-CP0/07 CPU TIMER
-
-24   TX4927-PIC/00
-25   TX4927-PIC/01
-26   TX4927-PIC/02
-27   TX4927-PIC/03 Cascade RBTX4927-IOC
-28   TX4927-PIC/04
-29   TX4927-PIC/05 RBTX4927 RTL-8019AS ethernet
-30   TX4927-PIC/06
-31   TX4927-PIC/07
-32   TX4927-PIC/08 TX4927 SerialIO Channel 0
-33   TX4927-PIC/09 TX4927 SerialIO Channel 1
-34   TX4927-PIC/10
-35   TX4927-PIC/11
-36   TX4927-PIC/12
-37   TX4927-PIC/13
-38   TX4927-PIC/14
-39   TX4927-PIC/15
-40   TX4927-PIC/16 TX4927 PCI PCI-C
-41   TX4927-PIC/17
-42   TX4927-PIC/18
-43   TX4927-PIC/19
-44   TX4927-PIC/20
-45   TX4927-PIC/21
-46   TX4927-PIC/22 TX4927 PCI PCI-ERR
-47   TX4927-PIC/23 TX4927 PCI PCI-PMA (not used)
-48   TX4927-PIC/24
-49   TX4927-PIC/25
-50   TX4927-PIC/26
-51   TX4927-PIC/27
-52   TX4927-PIC/28
-53   TX4927-PIC/29
-54   TX4927-PIC/30
-55   TX4927-PIC/31
-
-56 RBTX4927-IOC/00 FPCIB0 PCI-D PJ4/A PJ5/B SB/C PJ6/D PJ7/A (SouthBridge/NotUsed)        [RTL-8139=PJ4]
-57 RBTX4927-IOC/01 FPCIB0 PCI-C PJ4/D PJ5/A SB/B PJ6/C PJ7/D (SouthBridge/NotUsed)        [RTL-8139=PJ5]
-58 RBTX4927-IOC/02 FPCIB0 PCI-B PJ4/C PJ5/D SB/A PJ6/B PJ7/C (SouthBridge/IDE/pin=1,INTR) [RTL-8139=NotSupported]
-59 RBTX4927-IOC/03 FPCIB0 PCI-A PJ4/B PJ5/C SB/D PJ6/A PJ7/B (SouthBridge/USB/pin=4)      [RTL-8139=PJ6]
-60 RBTX4927-IOC/04
-61 RBTX4927-IOC/05
-62 RBTX4927-IOC/06
-63 RBTX4927-IOC/07
-
-NOTES:
-SouthBridge/INTR is mapped to SouthBridge/A=PCI-B/#58
-SouthBridge/ISA/pin=0 no pci irq used by this device
-SouthBridge/IDE/pin=1 no pci irq used by this device, using INTR via ISA IRQ14
-SouthBridge/USB/pin=4 using pci irq SouthBridge/D=PCI-A=#59
-SouthBridge/PMC/pin=0 no pci irq used by this device
-SuperIO/PS2/Keyboard, using INTR via ISA IRQ1
-SuperIO/PS2/Mouse, using INTR via ISA IRQ12 (mouse not currently supported)
-JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthBridge, JP4, JP5, JP6
-*/
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <asm/io.h>
-#ifdef CONFIG_TOSHIBA_FPCIB0
-#include <asm/i8259.h>
-#endif
-#include <asm/tx4927/toshiba_rbtx4927.h>
-
-#define TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG   0
-#define TOSHIBA_RBTX4927_IRQ_IOC_RAW_END   7
-
-#define TOSHIBA_RBTX4927_IRQ_IOC_BEG  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG)	/* 56 */
-#define TOSHIBA_RBTX4927_IRQ_IOC_END  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_END)	/* 63 */
-
-#define TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC TX4927_IRQ_NEST_EXT_ON_PIC
-#define TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC (TOSHIBA_RBTX4927_IRQ_IOC_BEG+2)
-
-extern int tx4927_using_backplane;
-
-static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
-static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
-
-#define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
-static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
-	.name = TOSHIBA_RBTX4927_IOC_NAME,
-	.ack = toshiba_rbtx4927_irq_ioc_disable,
-	.mask = toshiba_rbtx4927_irq_ioc_disable,
-	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
-	.unmask = toshiba_rbtx4927_irq_ioc_enable,
-};
-#define TOSHIBA_RBTX4927_IOC_INTR_ENAB (void __iomem *)0xbc002000UL
-#define TOSHIBA_RBTX4927_IOC_INTR_STAT (void __iomem *)0xbc002006UL
-
-int toshiba_rbtx4927_irq_nested(int sw_irq)
-{
-	u8 level3;
-
-	level3 = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
-	if (level3) {
-		sw_irq = TOSHIBA_RBTX4927_IRQ_IOC_BEG + fls(level3) - 1;
-#ifdef CONFIG_TOSHIBA_FPCIB0
-		if (sw_irq == TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC &&
-		    tx4927_using_backplane) {
-			int irq = i8259_irq();
-			if (irq >= 0)
-				sw_irq = irq;
-		}
-#endif
-	}
-	return (sw_irq);
-}
-
-static struct irqaction toshiba_rbtx4927_irq_ioc_action = {
-	.handler	= no_action,
-	.flags		= IRQF_SHARED,
-	.mask		= CPU_MASK_NONE,
-	.name		= TOSHIBA_RBTX4927_IOC_NAME
-};
-
-static void __init toshiba_rbtx4927_irq_ioc_init(void)
-{
-	int i;
-
-	for (i = TOSHIBA_RBTX4927_IRQ_IOC_BEG;
-	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
-					 handle_level_irq);
-
-	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC,
-		  &toshiba_rbtx4927_irq_ioc_action);
-}
-
-static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
-{
-	unsigned char v;
-
-	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
-	v |= (1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
-	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
-}
-
-static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
-{
-	unsigned char v;
-
-	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
-	v &= ~(1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
-	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
-	mmiowb();
-}
-
-void __init arch_init_irq(void)
-{
-	extern void tx4927_irq_init(void);
-
-	tx4927_irq_init();
-	toshiba_rbtx4927_irq_ioc_init();
-#ifdef CONFIG_TOSHIBA_FPCIB0
-	if (tx4927_using_backplane)
-		init_i8259_irqs();
-#endif
-	/* Onboard 10M Ether: High Active */
-	set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
-}
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
deleted file mode 100644
index fdbad4b..0000000
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * rbtx4927 specific prom routines
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2002 MontaVista Software Inc.
- *
- * Copyright (C) 2004 MontaVista Software Inc.
- * Author: Manish Lachwani, mlachwani@mvista.com
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/string.h>
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/tx4927/tx4927.h>
-
-void __init prom_init_cmdline(void)
-{
-	int argc = (int) fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;			/* Always ignore the "-c" at argv[0] */
-
-	/* ignore all built-in args if any f/w args given */
-	if (argc > 1) {
-		*arcs_cmdline = '\0';
-	}
-
-	for (i = 1; i < argc; i++) {
-		if (i != 1) {
-			strcat(arcs_cmdline, " ");
-		}
-		strcat(arcs_cmdline, argv[i]);
-	}
-}
-
-void __init prom_init(void)
-{
-	extern int tx4927_get_mem_size(void);
-	extern char* toshiba_name;
-	int msize;
-
-	prom_init_cmdline();
-
-	if ((read_c0_prid() & 0xff) == PRID_REV_TX4927) {
-		mips_machtype = MACH_TOSHIBA_RBTX4927;
-		toshiba_name  = "TX4927";
-	} else {
-		mips_machtype = MACH_TOSHIBA_RBTX4937;
-		toshiba_name  = "TX4937";
-	}
-
-	msize = tx4927_get_mem_size();
-	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-const char *get_system_type(void)
-{
-	return "Toshiba RBTX4927/RBTX4937";
-}
-
-char * __init prom_getcmdline(void)
-{
-        return &(arcs_cmdline[0]);
-}
-
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
deleted file mode 100644
index 185f303..0000000
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ /dev/null
@@ -1,703 +0,0 @@
-/*
- * Toshiba rbtx4927 specific setup
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2002 MontaVista Software Inc.
- *
- * Copyright (C) 1996, 97, 2001, 04  Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: RidgeRun, Inc.
- *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
- *
- * Copyright 2001 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * Copyright 2002 MontaVista Software Inc.
- * Author: Michael Pruznick, michael_pruznick@mvista.com
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * Copyright (C) 2004 MontaVista Software Inc.
- * Author: Manish Lachwani, mlachwani@mvista.com
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/pm.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/txx9tmr.h>
-#ifdef CONFIG_TOSHIBA_FPCIB0
-#include <asm/tx4927/smsc_fdc37m81x.h>
-#endif
-#include <asm/tx4927/toshiba_rbtx4927.h>
-#ifdef CONFIG_SERIAL_TXX9
-#include <linux/serial_core.h>
-#endif
-
-/* These functions are used for rebooting or halting the machine*/
-extern void toshiba_rbtx4927_restart(char *command);
-extern void toshiba_rbtx4927_halt(void);
-extern void toshiba_rbtx4927_power_off(void);
-
-int tx4927_using_backplane = 0;
-
-extern void toshiba_rbtx4927_irq_setup(void);
-
-char *prom_getcmdline(void);
-
-#ifdef CONFIG_PCI
-#undef TX4927_SUPPORT_COMMAND_IO
-#undef  TX4927_SUPPORT_PCI_66
-int tx4927_cpu_clock = 100000000;	/* 100MHz */
-unsigned long mips_pci_io_base;
-unsigned long mips_pci_io_size;
-unsigned long mips_pci_mem_base;
-unsigned long mips_pci_mem_size;
-/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
-unsigned long mips_pci_io_pciaddr = 0;
-unsigned long mips_memory_upper;
-static int tx4927_ccfg_toeon = 1;
-static int tx4927_pcic_trdyto = 0;	/* default: disabled */
-unsigned long tx4927_ce_base[8];
-int tx4927_pci66 = 0;		/* 0:auto */
-#endif
-
-char *toshiba_name = "";
-
-#ifdef CONFIG_PCI
-extern struct pci_controller tx4927_controller;
-
-static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
-				    int top_bus, int busnr, int devfn)
-{
-	static struct pci_dev dev;
-	static struct pci_bus bus;
-
-	dev.sysdata = (void *)hose;
-	dev.devfn = devfn;
-	bus.number = busnr;
-	bus.ops = hose->pci_ops;
-	bus.parent = NULL;
-	dev.bus = &bus;
-
-	return &dev;
-}
-
-#define EARLY_PCI_OP(rw, size, type)                                    \
-static int early_##rw##_config_##size(struct pci_controller *hose,      \
-        int top_bus, int bus, int devfn, int offset, type value)        \
-{                                                                       \
-        return pci_##rw##_config_##size(                                \
-                fake_pci_dev(hose, top_bus, bus, devfn),                \
-                offset, value);                                         \
-}
-
-EARLY_PCI_OP(read, byte, u8 *)
-EARLY_PCI_OP(read, dword, u32 *)
-EARLY_PCI_OP(write, byte, u8)
-EARLY_PCI_OP(write, dword, u32)
-
-static int __init tx4927_pcibios_init(void)
-{
-	unsigned int id;
-	u32 pci_devfn;
-	int devfn_start = 0;
-	int devfn_stop = 0xff;
-	int busno = 0; /* One bus on the Toshiba */
-	struct pci_controller *hose = &tx4927_controller;
-
-	for (pci_devfn = devfn_start; pci_devfn < devfn_stop; pci_devfn++) {
-		early_read_config_dword(hose, busno, busno, pci_devfn,
-					PCI_VENDOR_ID, &id);
-
-		if (id == 0xffffffff) {
-			continue;
-		}
-
-		if (id == 0x94601055) {
-			u8 v08_64;
-			u32 v32_b0;
-			u8 v08_e1;
-
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x64, &v08_64);
-			early_read_config_dword(hose, busno, busno,
-						pci_devfn, 0xb0, &v32_b0);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0xe1, &v08_e1);
-
-			/* serial irq control */
-			v08_64 = 0xd0;
-
-			/* serial irq pin */
-			v32_b0 |= 0x00010000;
-
-			/* ide irq on isa14 */
-			v08_e1 &= 0xf0;
-			v08_e1 |= 0x0d;
-
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x64, v08_64);
-			early_write_config_dword(hose, busno, busno,
-						 pci_devfn, 0xb0, v32_b0);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0xe1, v08_e1);
-		}
-
-		if (id == 0x91301055) {
-			u8 v08_04;
-			u8 v08_09;
-			u8 v08_41;
-			u8 v08_43;
-			u8 v08_5c;
-
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x04, &v08_04);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x09, &v08_09);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x41, &v08_41);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x43, &v08_43);
-			early_read_config_byte(hose, busno, busno,
-					       pci_devfn, 0x5c, &v08_5c);
-
-			/* enable ide master/io */
-			v08_04 |= (PCI_COMMAND_MASTER | PCI_COMMAND_IO);
-
-			/* enable ide native mode */
-			v08_09 |= 0x05;
-
-			/* enable primary ide */
-			v08_41 |= 0x80;
-
-			/* enable secondary ide */
-			v08_43 |= 0x80;
-
-			/*
-			 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
-			 *
-			 * This line of code is intended to provide the user with a work
-			 * around solution to the anomalies cited in SMSC's anomaly sheet
-			 * entitled, "SLC90E66 Functional Rev.J_0.1 Anomalies"".
-			 *
-			 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
-			 */
-			v08_5c |= 0x01;
-
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x5c, v08_5c);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x04, v08_04);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x09, v08_09);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x41, v08_41);
-			early_write_config_byte(hose, busno, busno,
-						pci_devfn, 0x43, v08_43);
-		}
-
-	}
-
-	register_pci_controller(&tx4927_controller);
-	return 0;
-}
-
-arch_initcall(tx4927_pcibios_init);
-
-extern struct resource pci_io_resource;
-extern struct resource pci_mem_resource;
-
-void __init tx4927_pci_setup(void)
-{
-	static int called = 0;
-	extern unsigned int tx4927_get_mem_size(void);
-
-	mips_memory_upper = tx4927_get_mem_size() << 20;
-	mips_memory_upper += KSEG0;
-	mips_pci_io_base = TX4927_PCIIO;
-	mips_pci_io_size = TX4927_PCIIO_SIZE;
-	mips_pci_mem_base = TX4927_PCIMEM;
-	mips_pci_mem_size = TX4927_PCIMEM_SIZE;
-
-	if (!called) {
-		printk
-		    ("%s PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
-		     toshiba_name,
-		     (unsigned short) (tx4927_pcicptr->pciid >> 16),
-		     (unsigned short) (tx4927_pcicptr->pciid & 0xffff),
-		     (unsigned short) (tx4927_pcicptr->pciccrev & 0xff),
-		     (!(tx4927_ccfgptr->
-			ccfg & TX4927_CCFG_PCIXARB)) ? "External" :
-		     "Internal");
-		called = 1;
-	}
-	printk("%s PCIC --%s PCICLK:", toshiba_name,
-	       (tx4927_ccfgptr->ccfg & TX4927_CCFG_PCI66) ? " PCI66" : "");
-	if (tx4927_ccfgptr->pcfg & TX4927_PCFG_PCICLKEN_ALL) {
-		int pciclk = 0;
-		if (mips_machtype == MACH_TOSHIBA_RBTX4937)
-			switch ((unsigned long) tx4927_ccfgptr->
-				ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
-			case TX4937_CCFG_PCIDIVMODE_4:
-				pciclk = tx4927_cpu_clock / 4;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_4_5:
-				pciclk = tx4927_cpu_clock * 2 / 9;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_5:
-				pciclk = tx4927_cpu_clock / 5;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_5_5:
-				pciclk = tx4927_cpu_clock * 2 / 11;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_8:
-				pciclk = tx4927_cpu_clock / 8;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_9:
-				pciclk = tx4927_cpu_clock / 9;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_10:
-				pciclk = tx4927_cpu_clock / 10;
-				break;
-			case TX4937_CCFG_PCIDIVMODE_11:
-				pciclk = tx4927_cpu_clock / 11;
-				break;
-			}
-
-		else
-			switch ((unsigned long) tx4927_ccfgptr->
-				ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
-			case TX4927_CCFG_PCIDIVMODE_2_5:
-				pciclk = tx4927_cpu_clock * 2 / 5;
-				break;
-			case TX4927_CCFG_PCIDIVMODE_3:
-				pciclk = tx4927_cpu_clock / 3;
-				break;
-			case TX4927_CCFG_PCIDIVMODE_5:
-				pciclk = tx4927_cpu_clock / 5;
-				break;
-			case TX4927_CCFG_PCIDIVMODE_6:
-				pciclk = tx4927_cpu_clock / 6;
-				break;
-			}
-
-		printk("Internal(%dMHz)", pciclk / 1000000);
-	} else
-		printk("External");
-	printk("\n");
-
-	/* GB->PCI mappings */
-	tx4927_pcicptr->g2piomask = (mips_pci_io_size - 1) >> 4;
-	tx4927_pcicptr->g2piogbase = mips_pci_io_base |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_G2PIOGBASE_ECHG
-#else
-	    TX4927_PCIC_G2PIOGBASE_BSDIS
-#endif
-	    ;
-
-	tx4927_pcicptr->g2piopbase = 0;
-
-	tx4927_pcicptr->g2pmmask[0] = (mips_pci_mem_size - 1) >> 4;
-	tx4927_pcicptr->g2pmgbase[0] = mips_pci_mem_base |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_G2PMnGBASE_ECHG
-#else
-	    TX4927_PCIC_G2PMnGBASE_BSDIS
-#endif
-	    ;
-	tx4927_pcicptr->g2pmpbase[0] = mips_pci_mem_base;
-
-	tx4927_pcicptr->g2pmmask[1] = 0;
-	tx4927_pcicptr->g2pmgbase[1] = 0;
-	tx4927_pcicptr->g2pmpbase[1] = 0;
-	tx4927_pcicptr->g2pmmask[2] = 0;
-	tx4927_pcicptr->g2pmgbase[2] = 0;
-	tx4927_pcicptr->g2pmpbase[2] = 0;
-
-
-	/* PCI->GB mappings (I/O 256B) */
-	tx4927_pcicptr->p2giopbase = 0;	/* 256B */
-
-	/* PCI->GB mappings (MEM 512MB) M0 gets all of memory */
-	tx4927_pcicptr->p2gm0plbase = 0;
-	tx4927_pcicptr->p2gm0pubase = 0;
-	tx4927_pcicptr->p2gmgbase[0] = 0 | TX4927_PCIC_P2GMnGBASE_TMEMEN |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_P2GMnGBASE_TECHG
-#else
-	    TX4927_PCIC_P2GMnGBASE_TBSDIS
-#endif
-	    ;
-
-	/* PCI->GB mappings (MEM 16MB) -not used */
-	tx4927_pcicptr->p2gm1plbase = 0xffffffff;
-	tx4927_pcicptr->p2gm1pubase = 0xffffffff;
-	tx4927_pcicptr->p2gmgbase[1] = 0;
-
-	/* PCI->GB mappings (MEM 1MB) -not used */
-	tx4927_pcicptr->p2gm2pbase = 0xffffffff;
-	tx4927_pcicptr->p2gmgbase[2] = 0;
-
-
-	/* Enable Initiator Memory 0 Space, I/O Space, Config */
-	tx4927_pcicptr->pciccfg &= TX4927_PCIC_PCICCFG_LBWC_MASK;
-	tx4927_pcicptr->pciccfg |=
-	    TX4927_PCIC_PCICCFG_IMSE0 | TX4927_PCIC_PCICCFG_IISE |
-	    TX4927_PCIC_PCICCFG_ICAE | TX4927_PCIC_PCICCFG_ATR;
-
-
-	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
-	tx4927_pcicptr->pcicfg1 = 0;
-
-	if (tx4927_pcic_trdyto >= 0) {
-		tx4927_pcicptr->g2ptocnt &= ~0xff;
-		tx4927_pcicptr->g2ptocnt |= (tx4927_pcic_trdyto & 0xff);
-	}
-
-	/* Clear All Local Bus Status */
-	tx4927_pcicptr->pcicstatus = TX4927_PCIC_PCICSTATUS_ALL;
-	/* Enable All Local Bus Interrupts */
-	tx4927_pcicptr->pcicmask = TX4927_PCIC_PCICSTATUS_ALL;
-	/* Clear All Initiator Status */
-	tx4927_pcicptr->g2pstatus = TX4927_PCIC_G2PSTATUS_ALL;
-	/* Enable All Initiator Interrupts */
-	tx4927_pcicptr->g2pmask = TX4927_PCIC_G2PSTATUS_ALL;
-	/* Clear All PCI Status Error */
-	tx4927_pcicptr->pcistatus =
-	    (tx4927_pcicptr->pcistatus & 0x0000ffff) |
-	    (TX4927_PCIC_PCISTATUS_ALL << 16);
-	/* Enable All PCI Status Error Interrupts */
-	tx4927_pcicptr->pcimask = TX4927_PCIC_PCISTATUS_ALL;
-
-	/* PCIC Int => IRC IRQ16 */
-	tx4927_pcicptr->pcicfg2 =
-	    (tx4927_pcicptr->pcicfg2 & 0xffffff00) | TX4927_IR_PCIC;
-
-	if (!(tx4927_ccfgptr->ccfg & TX4927_CCFG_PCIXARB)) {
-		/* XXX */
-	} else {
-		/* Reset Bus Arbiter */
-		tx4927_pcicptr->pbacfg = TX4927_PCIC_PBACFG_RPBA;
-		/* Enable Bus Arbiter */
-		tx4927_pcicptr->pbacfg = TX4927_PCIC_PBACFG_PBAEN;
-	}
-
-	tx4927_pcicptr->pcistatus = PCI_COMMAND_MASTER |
-	    PCI_COMMAND_MEMORY |
-	    PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-}
-#endif /* CONFIG_PCI */
-
-static void __noreturn wait_forever(void)
-{
-	while (1)
-		if (cpu_wait)
-			(*cpu_wait)();
-}
-
-void toshiba_rbtx4927_restart(char *command)
-{
-	printk(KERN_NOTICE "System Rebooting...\n");
-
-	/* enable the s/w reset register */
-	writeb(RBTX4927_SW_RESET_ENABLE_SET, RBTX4927_SW_RESET_ENABLE);
-
-	/* wait for enable to be seen */
-	while ((readb(RBTX4927_SW_RESET_ENABLE) &
-		RBTX4927_SW_RESET_ENABLE_SET) == 0x00);
-
-	/* do a s/w reset */
-	writeb(RBTX4927_SW_RESET_DO_SET, RBTX4927_SW_RESET_DO);
-
-	/* do something passive while waiting for reset */
-	local_irq_disable();
-	wait_forever();
-	/* no return */
-}
-
-void toshiba_rbtx4927_halt(void)
-{
-	printk(KERN_NOTICE "System Halted\n");
-	local_irq_disable();
-	wait_forever();
-	/* no return */
-}
-
-void toshiba_rbtx4927_power_off(void)
-{
-	toshiba_rbtx4927_halt();
-	/* no return */
-}
-
-void __init plat_mem_setup(void)
-{
-	int i;
-	u32 cp0_config;
-	char *argptr;
-
-	printk("CPU is %s\n", toshiba_name);
-
-	/* f/w leaves this on at startup */
-	clear_c0_status(ST0_ERL);
-
-	/* enable caches -- HCP5 does this, pmon does not */
-	cp0_config = read_c0_config();
-	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
-	write_c0_config(cp0_config);
-
-	set_io_port_base(KSEG1 + TBTX4927_ISA_IO_OFFSET);
-
-	ioport_resource.end = 0xffffffff;
-	iomem_resource.end = 0xffffffff;
-
-	_machine_restart = toshiba_rbtx4927_restart;
-	_machine_halt = toshiba_rbtx4927_halt;
-	pm_power_off = toshiba_rbtx4927_power_off;
-
-	for (i = 0; i < TX4927_NR_TMR; i++)
-		txx9_tmr_init(TX4927_TMR_REG(0) & 0xfffffffffULL);
-
-#ifdef CONFIG_PCI
-
-	/* PCIC */
-	/*
-	   * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
-	   *
-	   * For TX4927:
-	   * PCIDIVMODE[12:11]'s initial value is given by S9[4:3] (ON:0, OFF:1).
-	   * CPU 166MHz: PCI 66MHz : PCIDIVMODE: 00 (1/2.5)
-	   * CPU 200MHz: PCI 66MHz : PCIDIVMODE: 01 (1/3)
-	   * CPU 166MHz: PCI 33MHz : PCIDIVMODE: 10 (1/5)
-	   * CPU 200MHz: PCI 33MHz : PCIDIVMODE: 11 (1/6)
-	   * i.e. S9[3]: ON (83MHz), OFF (100MHz)
-	   *
-	   * For TX4937:
-	   * PCIDIVMODE[12:11]'s initial value is given by S1[5:4] (ON:0, OFF:1)
-	   * PCIDIVMODE[10] is 0.
-	   * CPU 266MHz: PCI 33MHz : PCIDIVMODE: 000 (1/8)
-	   * CPU 266MHz: PCI 66MHz : PCIDIVMODE: 001 (1/4)
-	   * CPU 300MHz: PCI 33MHz : PCIDIVMODE: 010 (1/9)
-	   * CPU 300MHz: PCI 66MHz : PCIDIVMODE: 011 (1/4.5)
-	   * CPU 333MHz: PCI 33MHz : PCIDIVMODE: 100 (1/10)
-	   * CPU 333MHz: PCI 66MHz : PCIDIVMODE: 101 (1/5)
-	   *
-	 */
-	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
-		switch ((unsigned long)tx4927_ccfgptr->
-			ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
-		case TX4937_CCFG_PCIDIVMODE_8:
-		case TX4937_CCFG_PCIDIVMODE_4:
-			tx4927_cpu_clock = 266666666;	/* 266MHz */
-			break;
-		case TX4937_CCFG_PCIDIVMODE_9:
-		case TX4937_CCFG_PCIDIVMODE_4_5:
-			tx4927_cpu_clock = 300000000;	/* 300MHz */
-			break;
-		default:
-			tx4927_cpu_clock = 333333333;	/* 333MHz */
-		}
-	else
-		switch ((unsigned long)tx4927_ccfgptr->
-			ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
-		case TX4927_CCFG_PCIDIVMODE_2_5:
-		case TX4927_CCFG_PCIDIVMODE_5:
-			tx4927_cpu_clock = 166666666;	/* 166MHz */
-			break;
-		default:
-			tx4927_cpu_clock = 200000000;	/* 200MHz */
-		}
-
-	/* CCFG */
-	/* do reset on watchdog */
-	tx4927_ccfgptr->ccfg |= TX4927_CCFG_WR;
-	/* enable Timeout BusError */
-	if (tx4927_ccfg_toeon)
-		tx4927_ccfgptr->ccfg |= TX4927_CCFG_TOE;
-
-	tx4927_pci_setup();
-	if (tx4927_using_backplane == 1)
-		printk("backplane board IS installed\n");
-	else
-		printk("No Backplane \n");
-
-	/* this is on ISA bus behind PCI bus, so need PCI up first */
-#ifdef CONFIG_TOSHIBA_FPCIB0
-	if (tx4927_using_backplane) {
-		smsc_fdc37m81x_init(0x3f0);
-		smsc_fdc37m81x_config_beg();
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
-					  SMSC_FDC37M81X_KBD);
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
-		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
-					  1);
-		smsc_fdc37m81x_config_end();
-	}
-#endif
-#endif /* CONFIG_PCI */
-
-#ifdef CONFIG_SERIAL_TXX9
-	{
-		extern int early_serial_txx9_setup(struct uart_port *port);
-		struct uart_port req;
-		for(i = 0; i < 2; i++) {
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.membase = (char *)(0xff1ff300 + i * 0x100);
-			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = TX4927_IRQ_PIC_BEG + 8 + i;
-			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-			req.uartclk = 50000000;
-			early_serial_txx9_setup(&req);
-		}
-	}
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "console=") == NULL) {
-                strcat(argptr, " console=ttyS0,38400");
-        }
-#endif
-#endif
-
-#ifdef CONFIG_ROOT_NFS
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "root=") == NULL) {
-                strcat(argptr, " root=/dev/nfs rw");
-        }
-#endif
-
-#ifdef CONFIG_IP_PNP
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "ip=") == NULL) {
-                strcat(argptr, " ip=any");
-        }
-#endif
-}
-
-void __init plat_time_init(void)
-{
-	mips_hpt_frequency = tx4927_cpu_clock / 2;
-	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
-		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
-				     TXX9_IRQ_BASE + 17,
-				     50000000);
-}
-
-static int __init toshiba_rbtx4927_rtc_init(void)
-{
-	static struct resource __initdata res = {
-		.start	= 0x1c010000,
-		.end	= 0x1c010000 + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("rtc-ds1742", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-device_initcall(toshiba_rbtx4927_rtc_init);
-
-static int __init rbtx4927_ne_init(void)
-{
-	static struct resource __initdata res[] = {
-		{
-			.start	= RBTX4927_RTL_8019_BASE,
-			.end	= RBTX4927_RTL_8019_BASE + 0x20 - 1,
-			.flags	= IORESOURCE_IO,
-		}, {
-			.start	= RBTX4927_RTL_8019_IRQ,
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("ne", -1,
-						res, ARRAY_SIZE(res));
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-device_initcall(rbtx4927_ne_init);
-
-/* Watchdog support */
-
-static int __init txx9_wdt_init(unsigned long base)
-{
-	struct resource res = {
-		.start	= base,
-		.end	= base + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("txx9wdt", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-
-static int __init rbtx4927_wdt_init(void)
-{
-	return txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
-}
-device_initcall(rbtx4927_wdt_init);
-
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)50000000;
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/tx4938/Kconfig b/arch/mips/tx4938/Kconfig
deleted file mode 100644
index d90e9cd..0000000
--- a/arch/mips/tx4938/Kconfig
+++ /dev/null
@@ -1,24 +0,0 @@
-if TOSHIBA_RBTX4938
-
-comment "Multiplex Pin Select"
-choice
-	prompt "PIO[58:61]"
-	default TOSHIBA_RBTX4938_MPLEX_PIO58_61
-
-config TOSHIBA_RBTX4938_MPLEX_PIO58_61
-	bool "PIO"
-config TOSHIBA_RBTX4938_MPLEX_NAND
-	bool "NAND"
-config TOSHIBA_RBTX4938_MPLEX_ATA
-	bool "ATA"
-
-endchoice
-
-config TX4938_NAND_BOOT
-	depends on EXPERIMENTAL && TOSHIBA_RBTX4938_MPLEX_NAND
-	bool "NAND Boot Support (EXPERIMENTAL)"
-	help
-	  This is only for Toshiba RBTX4938 reference board, which has NAND IPL.
-	  Select this option if you need to use NAND boot.
-
-endif
diff --git a/arch/mips/tx4938/common/Makefile b/arch/mips/tx4938/common/Makefile
deleted file mode 100644
index 56aa1ed..0000000
--- a/arch/mips/tx4938/common/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-# Makefile for common code for Toshiba TX4927 based systems
-#
-
-obj-y	+= prom.o irq.o
-obj-$(CONFIG_KGDB) += dbgio.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4938/common/dbgio.c b/arch/mips/tx4938/common/dbgio.c
deleted file mode 100644
index 33b9c67..0000000
--- a/arch/mips/tx4938/common/dbgio.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * linux/arch/mips/tx4938/common/dbgio.c
- *
- * kgdb interface for gdb
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2005 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Support for TX4938 in 2.6 - Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
- */
-
-#include <linux/types>
-
-extern u8 txx9_sio_kdbg_rd(void);
-extern int txx9_sio_kdbg_wr( u8 ch );
-
-u8 getDebugChar(void)
-{
-	return (txx9_sio_kdbg_rd());
-}
-
-int putDebugChar(u8 byte)
-{
-	return (txx9_sio_kdbg_wr(byte));
-}
-
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
deleted file mode 100644
index c059b89..0000000
--- a/arch/mips/tx4938/common/irq.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * linux/arch/mips/tx4938/common/irq.c
- *
- * Common tx4938 irq handler
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/tx4938/rbtx4938.h>
-
-void __init
-tx4938_irq_init(void)
-{
-	mips_cpu_irq_init();
-	txx9_irq_init(TX4938_IRC_REG);
-	set_irq_chained_handler(TX4938_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
-}
-
-int toshiba_rbtx4938_irq_nested(int irq);
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status();
-
-	if (pending & STATUSF_IP7)
-		do_IRQ(TX4938_IRQ_CPU_TIMER);
-	else if (pending & STATUSF_IP2) {
-		int irq = txx9_irq();
-		if (irq == TX4938_IRQ_PIC_BEG + TX4938_IR_INT(0))
-			irq = toshiba_rbtx4938_irq_nested(irq);
-		if (irq >= 0)
-			do_IRQ(irq);
-		else
-			spurious_interrupt();
-	} else if (pending & STATUSF_IP1)
-		do_IRQ(TX4938_IRQ_USER1);
-	else if (pending & STATUSF_IP0)
-		do_IRQ(TX4938_IRQ_USER0);
-}
diff --git a/arch/mips/tx4938/common/prom.c b/arch/mips/tx4938/common/prom.c
deleted file mode 100644
index 20baeae..0000000
--- a/arch/mips/tx4938/common/prom.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * linux/arch/mips/tx4938/common/prom.c
- *
- * common tx4938 memory interface
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-static unsigned int __init
-tx4938_process_sdccr(u64 * addr)
-{
-	u64 val;
-	unsigned int sdccr_ce;
-	unsigned int sdccr_rs;
-	unsigned int sdccr_cs;
-	unsigned int sdccr_mw;
-	unsigned int rs = 0;
-	unsigned int cs = 0;
-	unsigned int mw = 0;
-	unsigned int bc = 4;
-	unsigned int msize = 0;
-
-	val = ____raw_readq((void __iomem *)addr);
-
-	/* MVMCP -- need #defs for these bits masks */
-	sdccr_ce = ((val & (1 << 10)) >> 10);
-	sdccr_rs = ((val & (3 << 5)) >> 5);
-	sdccr_cs = ((val & (7 << 2)) >> 2);
-	sdccr_mw = ((val & (1 << 0)) >> 0);
-
-	if (sdccr_ce) {
-		switch (sdccr_rs) {
-		case 0:{
-				rs = 2048;
-				break;
-			}
-		case 1:{
-				rs = 4096;
-				break;
-			}
-		case 2:{
-				rs = 8192;
-				break;
-			}
-		default:{
-				rs = 0;
-				break;
-			}
-		}
-		switch (sdccr_cs) {
-		case 0:{
-				cs = 256;
-				break;
-			}
-		case 1:{
-				cs = 512;
-				break;
-			}
-		case 2:{
-				cs = 1024;
-				break;
-			}
-		case 3:{
-				cs = 2048;
-				break;
-			}
-		case 4:{
-				cs = 4096;
-				break;
-			}
-		default:{
-				cs = 0;
-				break;
-			}
-		}
-		switch (sdccr_mw) {
-		case 0:{
-				mw = 8;
-				break;
-			}	/* 8 bytes = 64 bits */
-		case 1:{
-				mw = 4;
-				break;
-			}	/* 4 bytes = 32 bits */
-		}
-	}
-
-	/*           bytes per chip    MB per chip          bank count */
-	msize = (((rs * cs * mw) / (1024 * 1024)) * (bc));
-
-	/* MVMCP -- bc hard coded to 4 from table 9.3.1     */
-	/*          boad supports bc=2 but no way to detect */
-
-	return (msize);
-}
-
-unsigned int __init
-tx4938_get_mem_size(void)
-{
-	unsigned int c0;
-	unsigned int c1;
-	unsigned int c2;
-	unsigned int c3;
-	unsigned int total;
-
-	/* MVMCP -- need #defs for these registers */
-	c0 = tx4938_process_sdccr((u64 *) 0xff1f8000);
-	c1 = tx4938_process_sdccr((u64 *) 0xff1f8008);
-	c2 = tx4938_process_sdccr((u64 *) 0xff1f8010);
-	c3 = tx4938_process_sdccr((u64 *) 0xff1f8018);
-	total = c0 + c1 + c2 + c3;
-
-	return (total);
-}
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/Makefile b/arch/mips/tx4938/toshiba_rbtx4938/Makefile
deleted file mode 100644
index 2316dd7..0000000
--- a/arch/mips/tx4938/toshiba_rbtx4938/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for common code for Toshiba TX4927 based systems
-#
-
-obj-y	+= prom.o setup.o irq.o spi_eeprom.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
deleted file mode 100644
index 4d6a8dc..0000000
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * linux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
- *
- * Toshiba RBTX4938 specific interrupt handlers
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-/*
-IRQ  Device
-
-16   TX4938-CP0/00 Software 0
-17   TX4938-CP0/01 Software 1
-18   TX4938-CP0/02 Cascade TX4938-CP0
-19   TX4938-CP0/03 Multiplexed -- do not use
-20   TX4938-CP0/04 Multiplexed -- do not use
-21   TX4938-CP0/05 Multiplexed -- do not use
-22   TX4938-CP0/06 Multiplexed -- do not use
-23   TX4938-CP0/07 CPU TIMER
-
-24   TX4938-PIC/00
-25   TX4938-PIC/01
-26   TX4938-PIC/02 Cascade RBTX4938-IOC
-27   TX4938-PIC/03 RBTX4938 RTL-8019AS Ethernet
-28   TX4938-PIC/04
-29   TX4938-PIC/05 TX4938 ETH1
-30   TX4938-PIC/06 TX4938 ETH0
-31   TX4938-PIC/07
-32   TX4938-PIC/08 TX4938 SIO 0
-33   TX4938-PIC/09 TX4938 SIO 1
-34   TX4938-PIC/10 TX4938 DMA0
-35   TX4938-PIC/11 TX4938 DMA1
-36   TX4938-PIC/12 TX4938 DMA2
-37   TX4938-PIC/13 TX4938 DMA3
-38   TX4938-PIC/14
-39   TX4938-PIC/15
-40   TX4938-PIC/16 TX4938 PCIC
-41   TX4938-PIC/17 TX4938 TMR0
-42   TX4938-PIC/18 TX4938 TMR1
-43   TX4938-PIC/19 TX4938 TMR2
-44   TX4938-PIC/20
-45   TX4938-PIC/21
-46   TX4938-PIC/22 TX4938 PCIERR
-47   TX4938-PIC/23
-48   TX4938-PIC/24
-49   TX4938-PIC/25
-50   TX4938-PIC/26
-51   TX4938-PIC/27
-52   TX4938-PIC/28
-53   TX4938-PIC/29
-54   TX4938-PIC/30
-55   TX4938-PIC/31 TX4938 SPI
-
-56 RBTX4938-IOC/00 PCI-D
-57 RBTX4938-IOC/01 PCI-C
-58 RBTX4938-IOC/02 PCI-B
-59 RBTX4938-IOC/03 PCI-A
-60 RBTX4938-IOC/04 RTC
-61 RBTX4938-IOC/05 ATA
-62 RBTX4938-IOC/06 MODEM
-63 RBTX4938-IOC/07 SWINT
-*/
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <asm/tx4938/rbtx4938.h>
-
-static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
-static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq);
-
-#define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
-static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
-	.name = TOSHIBA_RBTX4938_IOC_NAME,
-	.ack = toshiba_rbtx4938_irq_ioc_disable,
-	.mask = toshiba_rbtx4938_irq_ioc_disable,
-	.mask_ack = toshiba_rbtx4938_irq_ioc_disable,
-	.unmask = toshiba_rbtx4938_irq_ioc_enable,
-};
-
-int
-toshiba_rbtx4938_irq_nested(int sw_irq)
-{
-	u8 level3;
-
-	level3 = readb(rbtx4938_imstat_addr);
-	if (level3)
-		/* must use fls so onboard ATA has priority */
-		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + fls(level3) - 1;
-
-	return sw_irq;
-}
-
-static struct irqaction toshiba_rbtx4938_irq_ioc_action = {
-	.handler = no_action,
-	.flags = 0,
-	.mask = CPU_MASK_NONE,
-	.name = TOSHIBA_RBTX4938_IOC_NAME,
-};
-
-/**********************************************************************************/
-/* Functions for ioc                                                              */
-/**********************************************************************************/
-static void __init
-toshiba_rbtx4938_irq_ioc_init(void)
-{
-	int i;
-
-	for (i = TOSHIBA_RBTX4938_IRQ_IOC_BEG;
-	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
-					 handle_level_irq);
-
-	setup_irq(RBTX4938_IRQ_IOCINT,
-		  &toshiba_rbtx4938_irq_ioc_action);
-}
-
-static void
-toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
-{
-	unsigned char v;
-
-	v = readb(rbtx4938_imask_addr);
-	v |= (1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
-	writeb(v, rbtx4938_imask_addr);
-	mmiowb();
-}
-
-static void
-toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
-{
-	unsigned char v;
-
-	v = readb(rbtx4938_imask_addr);
-	v &= ~(1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
-	writeb(v, rbtx4938_imask_addr);
-	mmiowb();
-}
-
-void __init arch_init_irq(void)
-{
-	extern void tx4938_irq_init(void);
-
-	/* Now, interrupt control disabled, */
-	/* all IRC interrupts are masked, */
-	/* all IRC interrupt mode are Low Active. */
-
-	/* mask all IOC interrupts */
-	writeb(0, rbtx4938_imask_addr);
-
-	/* clear SoftInt interrupts */
-	writeb(0, rbtx4938_softint_addr);
-	tx4938_irq_init();
-	toshiba_rbtx4938_irq_ioc_init();
-	/* Onboard 10M Ether: High Active */
-	set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
-}
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/prom.c b/arch/mips/tx4938/toshiba_rbtx4938/prom.c
deleted file mode 100644
index 1644bff..0000000
--- a/arch/mips/tx4938/toshiba_rbtx4938/prom.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c
- *
- * rbtx4938 specific prom routines
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-#include <asm/tx4938/tx4938.h>
-
-void __init prom_init_cmdline(void)
-{
-	int argc = (int) fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/* ignore all built-in args if any f/w args given */
-	if (argc > 1) {
-		*arcs_cmdline = '\0';
-	}
-
-	for (i = 1; i < argc; i++) {
-		if (i != 1) {
-			strcat(arcs_cmdline, " ");
-		}
-		strcat(arcs_cmdline, argv[i]);
-	}
-}
-
-void __init prom_init(void)
-{
-	extern int tx4938_get_mem_size(void);
-	int msize;
-#ifndef CONFIG_TX4938_NAND_BOOT
-	prom_init_cmdline();
-#endif
-
-	msize = tx4938_get_mem_size();
-	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
-
-	return;
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
-{
-	return;
-}
-
-const char *get_system_type(void)
-{
-	return "Toshiba RBTX4938";
-}
-
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
deleted file mode 100644
index 3a3659e..0000000
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ /dev/null
@@ -1,1124 +0,0 @@
-/*
- * linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
- *
- * Setup pointers to hardware-dependent routines.
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/console.h>
-#include <linux/pci.h>
-#include <linux/pm.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/gpio.h>
-
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/txx9tmr.h>
-#include <asm/io.h>
-#include <asm/bootinfo.h>
-#include <asm/tx4938/rbtx4938.h>
-#ifdef CONFIG_SERIAL_TXX9
-#include <linux/serial_core.h>
-#endif
-#include <linux/spi/spi.h>
-#include <asm/tx4938/spi.h>
-#include <asm/txx9pio.h>
-
-extern char * __init prom_getcmdline(void);
-static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
-
-/* These functions are used for rebooting or halting the machine*/
-extern void rbtx4938_machine_restart(char *command);
-extern void rbtx4938_machine_halt(void);
-extern void rbtx4938_machine_power_off(void);
-
-/* clocks */
-unsigned int txx9_master_clock;
-unsigned int txx9_cpu_clock;
-unsigned int txx9_gbus_clock;
-
-unsigned long rbtx4938_ce_base[8];
-unsigned long rbtx4938_ce_size[8];
-int txboard_pci66_mode;
-static int tx4938_pcic_trdyto;	/* default: disabled */
-static int tx4938_pcic_retryto;	/* default: disabled */
-static int tx4938_ccfg_toeon = 1;
-
-struct tx4938_pcic_reg *pcicptrs[4] = {
-       tx4938_pcicptr  /* default setting for TX4938 */
-};
-
-static struct {
-	unsigned long base;
-	unsigned long size;
-} phys_regions[16] __initdata;
-static int num_phys_regions  __initdata;
-
-#define PHYS_REGION_MINSIZE	0x10000
-
-void rbtx4938_machine_halt(void)
-{
-        printk(KERN_NOTICE "System Halted\n");
-	local_irq_disable();
-
-	while (1)
-		__asm__(".set\tmips3\n\t"
-			"wait\n\t"
-			".set\tmips0");
-}
-
-void rbtx4938_machine_power_off(void)
-{
-        rbtx4938_machine_halt();
-        /* no return */
-}
-
-void rbtx4938_machine_restart(char *command)
-{
-	local_irq_disable();
-
-	printk("Rebooting...");
-	writeb(1, rbtx4938_softresetlock_addr);
-	writeb(1, rbtx4938_sfvol_addr);
-	writeb(1, rbtx4938_softreset_addr);
-	while(1)
-		;
-}
-
-void __init
-txboard_add_phys_region(unsigned long base, unsigned long size)
-{
-	if (num_phys_regions >= ARRAY_SIZE(phys_regions)) {
-		printk("phys_region overflow\n");
-		return;
-	}
-	phys_regions[num_phys_regions].base = base;
-	phys_regions[num_phys_regions].size = size;
-	num_phys_regions++;
-}
-unsigned long __init
-txboard_find_free_phys_region(unsigned long begin, unsigned long end,
-			      unsigned long size)
-{
-	unsigned long base;
-	int i;
-
-	for (base = begin / size * size; base < end; base += size) {
-		for (i = 0; i < num_phys_regions; i++) {
-			if (phys_regions[i].size &&
-			    base <= phys_regions[i].base + (phys_regions[i].size - 1) &&
-			    base + (size - 1) >= phys_regions[i].base)
-				break;
-		}
-		if (i == num_phys_regions)
-			return base;
-	}
-	return 0;
-}
-unsigned long __init
-txboard_find_free_phys_region_shrink(unsigned long begin, unsigned long end,
-				     unsigned long *size)
-{
-	unsigned long sz, base;
-	for (sz = *size; sz >= PHYS_REGION_MINSIZE; sz /= 2) {
-		base = txboard_find_free_phys_region(begin, end, sz);
-		if (base) {
-			*size = sz;
-			return base;
-		}
-	}
-	return 0;
-}
-unsigned long __init
-txboard_request_phys_region_range(unsigned long begin, unsigned long end,
-				  unsigned long size)
-{
-	unsigned long base;
-	base = txboard_find_free_phys_region(begin, end, size);
-	if (base)
-		txboard_add_phys_region(base, size);
-	return base;
-}
-unsigned long __init
-txboard_request_phys_region(unsigned long size)
-{
-	unsigned long base;
-	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
-	base = txboard_find_free_phys_region(begin, end, size);
-	if (base)
-		txboard_add_phys_region(base, size);
-	return base;
-}
-unsigned long __init
-txboard_request_phys_region_shrink(unsigned long *size)
-{
-	unsigned long base;
-	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
-	base = txboard_find_free_phys_region_shrink(begin, end, size);
-	if (base)
-		txboard_add_phys_region(base, *size);
-	return base;
-}
-
-#ifdef CONFIG_PCI
-void __init
-tx4938_pcic_setup(struct tx4938_pcic_reg *pcicptr,
-		  struct pci_controller *channel,
-		  unsigned long pci_io_base,
-		  int extarb)
-{
-	int i;
-
-	/* Disable All Initiator Space */
-	pcicptr->pciccfg &= ~(TX4938_PCIC_PCICCFG_G2PMEN(0)|
-			      TX4938_PCIC_PCICCFG_G2PMEN(1)|
-			      TX4938_PCIC_PCICCFG_G2PMEN(2)|
-			      TX4938_PCIC_PCICCFG_G2PIOEN);
-
-	/* GB->PCI mappings */
-	pcicptr->g2piomask = (channel->io_resource->end - channel->io_resource->start) >> 4;
-	pcicptr->g2piogbase = pci_io_base |
-#ifdef __BIG_ENDIAN
-		TX4938_PCIC_G2PIOGBASE_ECHG
-#else
-		TX4938_PCIC_G2PIOGBASE_BSDIS
-#endif
-		;
-	pcicptr->g2piopbase = 0;
-	for (i = 0; i < 3; i++) {
-		pcicptr->g2pmmask[i] = 0;
-		pcicptr->g2pmgbase[i] = 0;
-		pcicptr->g2pmpbase[i] = 0;
-	}
-	if (channel->mem_resource->end) {
-		pcicptr->g2pmmask[0] = (channel->mem_resource->end - channel->mem_resource->start) >> 4;
-		pcicptr->g2pmgbase[0] = channel->mem_resource->start |
-#ifdef __BIG_ENDIAN
-			TX4938_PCIC_G2PMnGBASE_ECHG
-#else
-			TX4938_PCIC_G2PMnGBASE_BSDIS
-#endif
-			;
-		pcicptr->g2pmpbase[0] = channel->mem_resource->start;
-	}
-	/* PCI->GB mappings (I/O 256B) */
-	pcicptr->p2giopbase = 0; /* 256B */
-	pcicptr->p2giogbase = 0;
-	/* PCI->GB mappings (MEM 512MB (64MB on R1.x)) */
-	pcicptr->p2gm0plbase = 0;
-	pcicptr->p2gm0pubase = 0;
-	pcicptr->p2gmgbase[0] = 0 |
-		TX4938_PCIC_P2GMnGBASE_TMEMEN |
-#ifdef __BIG_ENDIAN
-		TX4938_PCIC_P2GMnGBASE_TECHG
-#else
-		TX4938_PCIC_P2GMnGBASE_TBSDIS
-#endif
-		;
-	/* PCI->GB mappings (MEM 16MB) */
-	pcicptr->p2gm1plbase = 0xffffffff;
-	pcicptr->p2gm1pubase = 0xffffffff;
-	pcicptr->p2gmgbase[1] = 0;
-	/* PCI->GB mappings (MEM 1MB) */
-	pcicptr->p2gm2pbase = 0xffffffff; /* 1MB */
-	pcicptr->p2gmgbase[2] = 0;
-
-	pcicptr->pciccfg &= TX4938_PCIC_PCICCFG_GBWC_MASK;
-	/* Enable Initiator Memory Space */
-	if (channel->mem_resource->end)
-		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PMEN(0);
-	/* Enable Initiator I/O Space */
-	if (channel->io_resource->end)
-		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PIOEN;
-	/* Enable Initiator Config */
-	pcicptr->pciccfg |=
-		TX4938_PCIC_PCICCFG_ICAEN |
-		TX4938_PCIC_PCICCFG_TCAR;
-
-	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
-	pcicptr->pcicfg1 = 0;
-
-	pcicptr->g2ptocnt &= ~0xffff;
-
-	if (tx4938_pcic_trdyto >= 0) {
-		pcicptr->g2ptocnt &= ~0xff;
-		pcicptr->g2ptocnt |= (tx4938_pcic_trdyto & 0xff);
-	}
-
-	if (tx4938_pcic_retryto >= 0) {
-		pcicptr->g2ptocnt &= ~0xff00;
-		pcicptr->g2ptocnt |= ((tx4938_pcic_retryto<<8) & 0xff00);
-	}
-
-	/* Clear All Local Bus Status */
-	pcicptr->pcicstatus = TX4938_PCIC_PCICSTATUS_ALL;
-	/* Enable All Local Bus Interrupts */
-	pcicptr->pcicmask = TX4938_PCIC_PCICSTATUS_ALL;
-	/* Clear All Initiator Status */
-	pcicptr->g2pstatus = TX4938_PCIC_G2PSTATUS_ALL;
-	/* Enable All Initiator Interrupts */
-	pcicptr->g2pmask = TX4938_PCIC_G2PSTATUS_ALL;
-	/* Clear All PCI Status Error */
-	pcicptr->pcistatus =
-		(pcicptr->pcistatus & 0x0000ffff) |
-		(TX4938_PCIC_PCISTATUS_ALL << 16);
-	/* Enable All PCI Status Error Interrupts */
-	pcicptr->pcimask = TX4938_PCIC_PCISTATUS_ALL;
-
-	if (!extarb) {
-		/* Reset Bus Arbiter */
-		pcicptr->pbacfg = TX4938_PCIC_PBACFG_RPBA;
-		pcicptr->pbabm = 0;
-		/* Enable Bus Arbiter */
-		pcicptr->pbacfg = TX4938_PCIC_PBACFG_PBAEN;
-	}
-
-      /* PCIC Int => IRC IRQ16 */
-	pcicptr->pcicfg2 =
-		    (pcicptr->pcicfg2 & 0xffffff00) | TX4938_IR_PCIC;
-
-	pcicptr->pcistatus = PCI_COMMAND_MASTER |
-		PCI_COMMAND_MEMORY |
-		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-}
-
-int __init
-tx4938_report_pciclk(void)
-{
-	unsigned long pcode = TX4938_REV_PCODE();
-	int pciclk = 0;
-	printk("TX%lx PCIC --%s PCICLK:",
-	       pcode,
-	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) ? " PCI66" : "");
-	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
-
-		switch ((unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK) {
-		case TX4938_CCFG_PCIDIVMODE_4:
-			pciclk = txx9_cpu_clock / 4; break;
-		case TX4938_CCFG_PCIDIVMODE_4_5:
-			pciclk = txx9_cpu_clock * 2 / 9; break;
-		case TX4938_CCFG_PCIDIVMODE_5:
-			pciclk = txx9_cpu_clock / 5; break;
-		case TX4938_CCFG_PCIDIVMODE_5_5:
-			pciclk = txx9_cpu_clock * 2 / 11; break;
-		case TX4938_CCFG_PCIDIVMODE_8:
-			pciclk = txx9_cpu_clock / 8; break;
-		case TX4938_CCFG_PCIDIVMODE_9:
-			pciclk = txx9_cpu_clock / 9; break;
-		case TX4938_CCFG_PCIDIVMODE_10:
-			pciclk = txx9_cpu_clock / 10; break;
-		case TX4938_CCFG_PCIDIVMODE_11:
-			pciclk = txx9_cpu_clock / 11; break;
-		}
-		printk("Internal(%dMHz)", pciclk / 1000000);
-	} else {
-		printk("External");
-		pciclk = -1;
-	}
-	printk("\n");
-	return pciclk;
-}
-
-void __init set_tx4938_pcicptr(int ch, struct tx4938_pcic_reg *pcicptr)
-{
-	pcicptrs[ch] = pcicptr;
-}
-
-struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch)
-{
-       return pcicptrs[ch];
-}
-
-static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
-                                    int top_bus, int busnr, int devfn)
-{
-	static struct pci_dev dev;
-	static struct pci_bus bus;
-
-	dev.sysdata = bus.sysdata = hose;
-	dev.devfn = devfn;
-	bus.number = busnr;
-	bus.ops = hose->pci_ops;
-	bus.parent = NULL;
-	dev.bus = &bus;
-
-	return &dev;
-}
-
-#define EARLY_PCI_OP(rw, size, type)                                    \
-static int early_##rw##_config_##size(struct pci_controller *hose,      \
-        int top_bus, int bus, int devfn, int offset, type value)        \
-{                                                                       \
-        return pci_##rw##_config_##size(                                \
-                fake_pci_dev(hose, top_bus, bus, devfn),                \
-                offset, value);                                         \
-}
-
-EARLY_PCI_OP(read, word, u16 *)
-
-int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bus)
-{
-	u32 pci_devfn;
-	unsigned short vid;
-	int devfn_start = 0;
-	int devfn_stop = 0xff;
-	int cap66 = -1;
-	u16 stat;
-
-	printk("PCI: Checking 66MHz capabilities...\n");
-
-	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
-		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID,
-					   &vid) != PCIBIOS_SUCCESSFUL)
-			continue;
-
-		if (vid == 0xffff) continue;
-
-		/* check 66MHz capability */
-		if (cap66 < 0)
-			cap66 = 1;
-		if (cap66) {
-			early_read_config_word(hose, top_bus, current_bus, pci_devfn,
-					       PCI_STATUS, &stat);
-			if (!(stat & PCI_STATUS_66MHZ)) {
-				printk(KERN_DEBUG "PCI: %02x:%02x not 66MHz capable.\n",
-				       current_bus, pci_devfn);
-				cap66 = 0;
-				break;
-			}
-		}
-	}
-	return cap66 > 0;
-}
-
-int __init
-tx4938_pciclk66_setup(void)
-{
-	int pciclk;
-
-	/* Assert M66EN */
-	tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI66;
-	/* Double PCICLK (if possible) */
-	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
-		unsigned int pcidivmode =
-			tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK;
-		switch (pcidivmode) {
-		case TX4938_CCFG_PCIDIVMODE_8:
-		case TX4938_CCFG_PCIDIVMODE_4:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_4;
-			pciclk = txx9_cpu_clock / 4;
-			break;
-		case TX4938_CCFG_PCIDIVMODE_9:
-		case TX4938_CCFG_PCIDIVMODE_4_5:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_4_5;
-			pciclk = txx9_cpu_clock * 2 / 9;
-			break;
-		case TX4938_CCFG_PCIDIVMODE_10:
-		case TX4938_CCFG_PCIDIVMODE_5:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_5;
-			pciclk = txx9_cpu_clock / 5;
-			break;
-		case TX4938_CCFG_PCIDIVMODE_11:
-		case TX4938_CCFG_PCIDIVMODE_5_5:
-		default:
-			pcidivmode = TX4938_CCFG_PCIDIVMODE_5_5;
-			pciclk = txx9_cpu_clock * 2 / 11;
-			break;
-		}
-		tx4938_ccfgptr->ccfg =
-			(tx4938_ccfgptr->ccfg & ~TX4938_CCFG_PCIDIVMODE_MASK)
-			| pcidivmode;
-		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
-		       (unsigned long)tx4938_ccfgptr->ccfg);
-	} else {
-		pciclk = -1;
-	}
-	return pciclk;
-}
-
-extern struct pci_controller tx4938_pci_controller[];
-static int __init tx4938_pcibios_init(void)
-{
-	unsigned long mem_base[2];
-	unsigned long mem_size[2] = {TX4938_PCIMEM_SIZE_0, TX4938_PCIMEM_SIZE_1}; /* MAX 128M,64K */
-	unsigned long io_base[2];
-	unsigned long io_size[2] = {TX4938_PCIIO_SIZE_0, TX4938_PCIIO_SIZE_1}; /* MAX 16M,64K */
-	/* TX4938 PCIC1: 64K MEM/IO is enough for ETH0,ETH1 */
-	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
-
-	PCIBIOS_MIN_IO = 0x00001000UL;
-
-	mem_base[0] = txboard_request_phys_region_shrink(&mem_size[0]);
-	io_base[0] = txboard_request_phys_region_shrink(&io_size[0]);
-
-	printk("TX4938 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
-	       (unsigned short)(tx4938_pcicptr->pciid >> 16),
-	       (unsigned short)(tx4938_pcicptr->pciid & 0xffff),
-	       (unsigned short)(tx4938_pcicptr->pciccrev & 0xff),
-	       extarb ? "External" : "Internal");
-
-	/* setup PCI area */
-	tx4938_pci_controller[0].io_resource->start = io_base[0];
-	tx4938_pci_controller[0].io_resource->end = (io_base[0] + io_size[0]) - 1;
-	tx4938_pci_controller[0].mem_resource->start = mem_base[0];
-	tx4938_pci_controller[0].mem_resource->end = mem_base[0] + mem_size[0] - 1;
-
-	set_tx4938_pcicptr(0, tx4938_pcicptr);
-
-	register_pci_controller(&tx4938_pci_controller[0]);
-
-	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) {
-		printk("TX4938_CCFG_PCI66 already configured\n");
-		txboard_pci66_mode = -1; /* already configured */
-	}
-
-	/* Reset PCI Bus */
-	writeb(0, rbtx4938_pcireset_addr);
-	/* Reset PCIC */
-	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
-	if (txboard_pci66_mode > 0)
-		tx4938_pciclk66_setup();
-	mdelay(10);
-	/* clear PCIC reset */
-	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
-	writeb(1, rbtx4938_pcireset_addr);
-	mmiowb();
-	tx4938_report_pcic_status1(tx4938_pcicptr);
-
-	tx4938_report_pciclk();
-	tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
-	if (txboard_pci66_mode == 0 &&
-	    txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
-		/* Reset PCI Bus */
-		writeb(0, rbtx4938_pcireset_addr);
-		/* Reset PCIC */
-		tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
-		tx4938_pciclk66_setup();
-		mdelay(10);
-		/* clear PCIC reset */
-		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
-		writeb(1, rbtx4938_pcireset_addr);
-		mmiowb();
-		/* Reinitialize PCIC */
-		tx4938_report_pciclk();
-		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
-	}
-
-	mem_base[1] = txboard_request_phys_region_shrink(&mem_size[1]);
-	io_base[1] = txboard_request_phys_region_shrink(&io_size[1]);
-	/* Reset PCIC1 */
-	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIC1RST;
-	/* PCI1DMD==0 => PCI1CLK==GBUSCLK/2 => PCI66 */
-	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD))
-		tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI1_66;
-	else
-		tx4938_ccfgptr->ccfg &= ~TX4938_CCFG_PCI1_66;
-	mdelay(10);
-	/* clear PCIC1 reset */
-	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
-	tx4938_report_pcic_status1(tx4938_pcic1ptr);
-
-	printk("TX4938 PCIC1 -- DID:%04x VID:%04x RID:%02x",
-	       (unsigned short)(tx4938_pcic1ptr->pciid >> 16),
-	       (unsigned short)(tx4938_pcic1ptr->pciid & 0xffff),
-	       (unsigned short)(tx4938_pcic1ptr->pciccrev & 0xff));
-	printk("%s PCICLK:%dMHz\n",
-	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1_66) ? " PCI66" : "",
-	       txx9_gbus_clock /
-	       ((tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD) ? 4 : 2) /
-	       1000000);
-
-	/* assumption: CPHYSADDR(mips_io_port_base) == io_base[0] */
-	tx4938_pci_controller[1].io_resource->start =
-		io_base[1] - io_base[0];
-	tx4938_pci_controller[1].io_resource->end =
-		io_base[1] - io_base[0] + io_size[1] - 1;
-	tx4938_pci_controller[1].mem_resource->start = mem_base[1];
-	tx4938_pci_controller[1].mem_resource->end =
-		mem_base[1] + mem_size[1] - 1;
-	set_tx4938_pcicptr(1, tx4938_pcic1ptr);
-
-	register_pci_controller(&tx4938_pci_controller[1]);
-
-	tx4938_pcic_setup(tx4938_pcic1ptr, &tx4938_pci_controller[1], io_base[1], extarb);
-
-	/* map ioport 0 to PCI I/O space address 0 */
-	set_io_port_base(KSEG1 + io_base[0]);
-
-	return 0;
-}
-
-arch_initcall(tx4938_pcibios_init);
-
-#endif /* CONFIG_PCI */
-
-/* SPI support */
-
-/* chip select for SPI devices */
-#define	SEEPROM1_CS	7	/* PIO7 */
-#define	SEEPROM2_CS	0	/* IOC */
-#define	SEEPROM3_CS	1	/* IOC */
-#define	SRTC_CS	2	/* IOC */
-
-#ifdef CONFIG_PCI
-static int __init rbtx4938_ethaddr_init(void)
-{
-	unsigned char dat[17];
-	unsigned char sum;
-	int i;
-
-	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
-	if (spi_eeprom_read(SEEPROM1_CS, 0, dat, sizeof(dat))) {
-		printk(KERN_ERR "seeprom: read error.\n");
-		return -ENODEV;
-	} else {
-		if (strcmp(dat, "MAC") != 0)
-			printk(KERN_WARNING "seeprom: bad signature.\n");
-		for (i = 0, sum = 0; i < sizeof(dat); i++)
-			sum += dat[i];
-		if (sum)
-			printk(KERN_WARNING "seeprom: bad checksum.\n");
-	}
-	for (i = 0; i < 2; i++) {
-		unsigned int id =
-			TXX9_IRQ_BASE + (i ? TX4938_IR_ETH1 : TX4938_IR_ETH0);
-		struct platform_device *pdev;
-		if (!(tx4938_ccfgptr->pcfg &
-		      (i ? TX4938_PCFG_ETH1_SEL : TX4938_PCFG_ETH0_SEL)))
-			continue;
-		pdev = platform_device_alloc("tc35815-mac", id);
-		if (!pdev ||
-		    platform_device_add_data(pdev, &dat[4 + 6 * i], 6) ||
-		    platform_device_add(pdev))
-			platform_device_put(pdev);
-	}
-	return 0;
-}
-device_initcall(rbtx4938_ethaddr_init);
-#endif /* CONFIG_PCI */
-
-static void __init rbtx4938_spi_setup(void)
-{
-	/* set SPI_SEL */
-	tx4938_ccfgptr->pcfg |= TX4938_PCFG_SPI_SEL;
-}
-
-static struct resource rbtx4938_fpga_resource;
-
-static char pcode_str[8];
-static struct resource tx4938_reg_resource = {
-	.start	= TX4938_REG_BASE,
-	.end	= TX4938_REG_BASE + TX4938_REG_SIZE,
-	.name	= pcode_str,
-	.flags	= IORESOURCE_MEM
-};
-
-void __init tx4938_board_setup(void)
-{
-	int i;
-	unsigned long divmode;
-	int cpuclk = 0;
-	unsigned long pcode = TX4938_REV_PCODE();
-
-	ioport_resource.start = 0x1000;
-	ioport_resource.end = 0xffffffff;
-	iomem_resource.start = 0x1000;
-	iomem_resource.end = 0xffffffff;	/* expand to 4GB */
-
-	sprintf(pcode_str, "TX%lx", pcode);
-	/* SDRAMC,EBUSC are configured by PROM */
-	for (i = 0; i < 8; i++) {
-		if (!(tx4938_ebuscptr->cr[i] & 0x8))
-			continue;	/* disabled */
-		rbtx4938_ce_base[i] = (unsigned long)TX4938_EBUSC_BA(i);
-		txboard_add_phys_region(rbtx4938_ce_base[i], TX4938_EBUSC_SIZE(i));
-	}
-
-	/* clocks */
-	if (txx9_master_clock) {
-		/* calculate gbus_clock and cpu_clock_freq from master_clock */
-		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_8:
-		case TX4938_CCFG_DIVMODE_10:
-		case TX4938_CCFG_DIVMODE_12:
-		case TX4938_CCFG_DIVMODE_16:
-		case TX4938_CCFG_DIVMODE_18:
-			txx9_gbus_clock = txx9_master_clock * 4; break;
-		default:
-			txx9_gbus_clock = txx9_master_clock;
-		}
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_2:
-		case TX4938_CCFG_DIVMODE_8:
-			cpuclk = txx9_gbus_clock * 2; break;
-		case TX4938_CCFG_DIVMODE_2_5:
-		case TX4938_CCFG_DIVMODE_10:
-			cpuclk = txx9_gbus_clock * 5 / 2; break;
-		case TX4938_CCFG_DIVMODE_3:
-		case TX4938_CCFG_DIVMODE_12:
-			cpuclk = txx9_gbus_clock * 3; break;
-		case TX4938_CCFG_DIVMODE_4:
-		case TX4938_CCFG_DIVMODE_16:
-			cpuclk = txx9_gbus_clock * 4; break;
-		case TX4938_CCFG_DIVMODE_4_5:
-		case TX4938_CCFG_DIVMODE_18:
-			cpuclk = txx9_gbus_clock * 9 / 2; break;
-		}
-		txx9_cpu_clock = cpuclk;
-	} else {
-		if (txx9_cpu_clock == 0) {
-			txx9_cpu_clock = 300000000;	/* 300MHz */
-		}
-		/* calculate gbus_clock and master_clock from cpu_clock_freq */
-		cpuclk = txx9_cpu_clock;
-		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_2:
-		case TX4938_CCFG_DIVMODE_8:
-			txx9_gbus_clock = cpuclk / 2; break;
-		case TX4938_CCFG_DIVMODE_2_5:
-		case TX4938_CCFG_DIVMODE_10:
-			txx9_gbus_clock = cpuclk * 2 / 5; break;
-		case TX4938_CCFG_DIVMODE_3:
-		case TX4938_CCFG_DIVMODE_12:
-			txx9_gbus_clock = cpuclk / 3; break;
-		case TX4938_CCFG_DIVMODE_4:
-		case TX4938_CCFG_DIVMODE_16:
-			txx9_gbus_clock = cpuclk / 4; break;
-		case TX4938_CCFG_DIVMODE_4_5:
-		case TX4938_CCFG_DIVMODE_18:
-			txx9_gbus_clock = cpuclk * 2 / 9; break;
-		}
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_8:
-		case TX4938_CCFG_DIVMODE_10:
-		case TX4938_CCFG_DIVMODE_12:
-		case TX4938_CCFG_DIVMODE_16:
-		case TX4938_CCFG_DIVMODE_18:
-			txx9_master_clock = txx9_gbus_clock / 4; break;
-		default:
-			txx9_master_clock = txx9_gbus_clock;
-		}
-	}
-	/* change default value to udelay/mdelay take reasonable time */
-	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
-
-	/* CCFG */
-	/* clear WatchDogReset,BusErrorOnWrite flag (W1C) */
-	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WDRST | TX4938_CCFG_BEOW;
-	/* do reset on watchdog */
-	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WR;
-	/* clear PCIC1 reset */
-	if (tx4938_ccfgptr->clkctr & TX4938_CLKCTR_PCIC1RST)
-		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
-
-	/* enable Timeout BusError */
-	if (tx4938_ccfg_toeon)
-		tx4938_ccfgptr->ccfg |= TX4938_CCFG_TOE;
-
-	/* DMA selection */
-	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_DMASEL_ALL;
-
-	/* Use external clock for external arbiter */
-	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB))
-		tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_PCICLKEN_ALL;
-
-	printk("%s -- %dMHz(M%dMHz) CRIR:%08lx CCFG:%Lx PCFG:%Lx\n",
-	       pcode_str,
-	       cpuclk / 1000000, txx9_master_clock / 1000000,
-	       (unsigned long)tx4938_ccfgptr->crir,
-	       tx4938_ccfgptr->ccfg,
-	       tx4938_ccfgptr->pcfg);
-
-	printk("%s SDRAMC --", pcode_str);
-	for (i = 0; i < 4; i++) {
-		unsigned long long cr = tx4938_sdramcptr->cr[i];
-		unsigned long ram_base, ram_size;
-		if (!((unsigned long)cr & 0x00000400))
-			continue;	/* disabled */
-		ram_base = (unsigned long)(cr >> 49) << 21;
-		ram_size = ((unsigned long)(cr >> 33) + 1) << 21;
-		if (ram_base >= 0x20000000)
-			continue;	/* high memory (ignore) */
-		printk(" CR%d:%016Lx", i, cr);
-		txboard_add_phys_region(ram_base, ram_size);
-	}
-	printk(" TR:%09Lx\n", tx4938_sdramcptr->tr);
-
-	/* SRAM */
-	if (pcode == 0x4938 && tx4938_sramcptr->cr & 1) {
-		unsigned int size = 0x800;
-		unsigned long base =
-			(tx4938_sramcptr->cr >> (39-11)) & ~(size - 1);
-		 txboard_add_phys_region(base, size);
-	}
-
-	/* TMR */
-	for (i = 0; i < TX4938_NR_TMR; i++)
-		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
-
-	/* enable DMA */
-	for (i = 0; i < 2; i++)
-		____raw_writeq(TX4938_DMA_MCR_MSTEN,
-			       (void __iomem *)(TX4938_DMA_REG(i) + 0x50));
-
-	/* PIO */
-	__raw_writel(0, &tx4938_pioptr->maskcpu);
-	__raw_writel(0, &tx4938_pioptr->maskext);
-
-	/* TX4938 internal registers */
-	if (request_resource(&iomem_resource, &tx4938_reg_resource))
-		printk("request resource for internal registers failed\n");
-}
-
-#ifdef CONFIG_PCI
-static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr)
-{
-	unsigned short pcistatus = (unsigned short)(pcicptr->pcistatus >> 16);
-	unsigned long g2pstatus = pcicptr->g2pstatus;
-	unsigned long pcicstatus = pcicptr->pcicstatus;
-	static struct {
-		unsigned long flag;
-		const char *str;
-	} pcistat_tbl[] = {
-		{ PCI_STATUS_DETECTED_PARITY,	"DetectedParityError" },
-		{ PCI_STATUS_SIG_SYSTEM_ERROR,	"SignaledSystemError" },
-		{ PCI_STATUS_REC_MASTER_ABORT,	"ReceivedMasterAbort" },
-		{ PCI_STATUS_REC_TARGET_ABORT,	"ReceivedTargetAbort" },
-		{ PCI_STATUS_SIG_TARGET_ABORT,	"SignaledTargetAbort" },
-		{ PCI_STATUS_PARITY,	"MasterParityError" },
-	}, g2pstat_tbl[] = {
-		{ TX4938_PCIC_G2PSTATUS_TTOE,	"TIOE" },
-		{ TX4938_PCIC_G2PSTATUS_RTOE,	"RTOE" },
-	}, pcicstat_tbl[] = {
-		{ TX4938_PCIC_PCICSTATUS_PME,	"PME" },
-		{ TX4938_PCIC_PCICSTATUS_TLB,	"TLB" },
-		{ TX4938_PCIC_PCICSTATUS_NIB,	"NIB" },
-		{ TX4938_PCIC_PCICSTATUS_ZIB,	"ZIB" },
-		{ TX4938_PCIC_PCICSTATUS_PERR,	"PERR" },
-		{ TX4938_PCIC_PCICSTATUS_SERR,	"SERR" },
-		{ TX4938_PCIC_PCICSTATUS_GBE,	"GBE" },
-		{ TX4938_PCIC_PCICSTATUS_IWB,	"IWB" },
-	};
-	int i;
-
-	printk("pcistat:%04x(", pcistatus);
-	for (i = 0; i < ARRAY_SIZE(pcistat_tbl); i++)
-		if (pcistatus & pcistat_tbl[i].flag)
-			printk("%s ", pcistat_tbl[i].str);
-	printk("), g2pstatus:%08lx(", g2pstatus);
-	for (i = 0; i < ARRAY_SIZE(g2pstat_tbl); i++)
-		if (g2pstatus & g2pstat_tbl[i].flag)
-			printk("%s ", g2pstat_tbl[i].str);
-	printk("), pcicstatus:%08lx(", pcicstatus);
-	for (i = 0; i < ARRAY_SIZE(pcicstat_tbl); i++)
-		if (pcicstatus & pcicstat_tbl[i].flag)
-			printk("%s ", pcicstat_tbl[i].str);
-	printk(")\n");
-}
-
-void tx4938_report_pcic_status(void)
-{
-	int i;
-	struct tx4938_pcic_reg *pcicptr;
-	for (i = 0; (pcicptr = get_tx4938_pcicptr(i)) != NULL; i++)
-		tx4938_report_pcic_status1(pcicptr);
-}
-
-#endif /* CONFIG_PCI */
-
-void __init plat_time_init(void)
-{
-	mips_hpt_frequency = txx9_cpu_clock / 2;
-	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_TINTDIS)
-		txx9_clockevent_init(TX4938_TMR_REG(0) & 0xfffffffffULL,
-				     TXX9_IRQ_BASE + TX4938_IR_TMR(0),
-				     txx9_gbus_clock / 2);
-}
-
-void __init plat_mem_setup(void)
-{
-	unsigned long long pcfg;
-	char *argptr;
-
-	iomem_resource.end = 0xffffffff;	/* 4GB */
-
-	if (txx9_master_clock == 0)
-		txx9_master_clock = 25000000; /* 25MHz */
-	tx4938_board_setup();
-#ifndef CONFIG_PCI
-	set_io_port_base(RBTX4938_ETHER_BASE);
-#endif
-
-#ifdef CONFIG_SERIAL_TXX9
-	{
-		extern int early_serial_txx9_setup(struct uart_port *port);
-		int i;
-		struct uart_port req;
-		for(i = 0; i < 2; i++) {
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.membase = (char *)(0xff1ff300 + i * 0x100);
-			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = RBTX4938_IRQ_IRC_SIO(i);
-			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-			req.uartclk = 50000000;
-			early_serial_txx9_setup(&req);
-		}
-	}
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "console=") == NULL) {
-                strcat(argptr, " console=ttyS0,38400");
-        }
-#endif
-#endif
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
-	printk("PIOSEL: disabling both ata and nand selection\n");
-	local_irq_disable();
-	tx4938_ccfgptr->pcfg &= ~(TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
-#endif
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
-	printk("PIOSEL: enabling nand selection\n");
-	tx4938_ccfgptr->pcfg |= TX4938_PCFG_NDF_SEL;
-	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_ATA_SEL;
-#endif
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
-	printk("PIOSEL: enabling ata selection\n");
-	tx4938_ccfgptr->pcfg |= TX4938_PCFG_ATA_SEL;
-	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_NDF_SEL;
-#endif
-
-#ifdef CONFIG_IP_PNP
-	argptr = prom_getcmdline();
-	if (strstr(argptr, "ip=") == NULL) {
-		strcat(argptr, " ip=any");
-	}
-#endif
-
-
-#ifdef CONFIG_FB
-	{
-		conswitchp = &dummy_con;
-	}
-#endif
-
-	rbtx4938_spi_setup();
-	pcfg = tx4938_ccfgptr->pcfg;	/* updated */
-	/* fixup piosel */
-	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-	    TX4938_PCFG_ATA_SEL)
-		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x04,
-		       rbtx4938_piosel_addr);
-	else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-		 TX4938_PCFG_NDF_SEL)
-		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x08,
-		       rbtx4938_piosel_addr);
-	else
-		writeb(readb(rbtx4938_piosel_addr) & ~(0x08 | 0x04),
-		       rbtx4938_piosel_addr);
-
-	rbtx4938_fpga_resource.name = "FPGA Registers";
-	rbtx4938_fpga_resource.start = CPHYSADDR(RBTX4938_FPGA_REG_ADDR);
-	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
-	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	if (request_resource(&iomem_resource, &rbtx4938_fpga_resource))
-		printk("request resource for fpga failed\n");
-
-	_machine_restart = rbtx4938_machine_restart;
-	_machine_halt = rbtx4938_machine_halt;
-	pm_power_off = rbtx4938_machine_power_off;
-
-	writeb(0xff, rbtx4938_led_addr);
-	printk(KERN_INFO "RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
-	       readb(rbtx4938_fpga_rev_addr),
-	       readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
-}
-
-static int __init rbtx4938_ne_init(void)
-{
-	struct resource res[] = {
-		{
-			.start	= RBTX4938_RTL_8019_BASE,
-			.end	= RBTX4938_RTL_8019_BASE + 0x20 - 1,
-			.flags	= IORESOURCE_IO,
-		}, {
-			.start	= RBTX4938_RTL_8019_IRQ,
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("ne", -1,
-						res, ARRAY_SIZE(res));
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-device_initcall(rbtx4938_ne_init);
-
-/* GPIO support */
-
-int gpio_to_irq(unsigned gpio)
-{
-	return -EINVAL;
-}
-
-int irq_to_gpio(unsigned irq)
-{
-	return -EINVAL;
-}
-
-static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
-
-static void rbtx4938_spi_gpio_set(struct gpio_chip *chip, unsigned int offset,
-				  int value)
-{
-	u8 val;
-	unsigned long flags;
-	spin_lock_irqsave(&rbtx4938_spi_gpio_lock, flags);
-	val = readb(rbtx4938_spics_addr);
-	if (value)
-		val |= 1 << offset;
-	else
-		val &= ~(1 << offset);
-	writeb(val, rbtx4938_spics_addr);
-	mmiowb();
-	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
-}
-
-static int rbtx4938_spi_gpio_dir_out(struct gpio_chip *chip,
-				     unsigned int offset, int value)
-{
-	rbtx4938_spi_gpio_set(chip, offset, value);
-	return 0;
-}
-
-static struct gpio_chip rbtx4938_spi_gpio_chip = {
-	.set = rbtx4938_spi_gpio_set,
-	.direction_output = rbtx4938_spi_gpio_dir_out,
-	.label = "RBTX4938-SPICS",
-	.base = 16,
-	.ngpio = 3,
-};
-
-/* SPI support */
-
-static void __init txx9_spi_init(unsigned long base, int irq)
-{
-	struct resource res[] = {
-		{
-			.start	= base,
-			.end	= base + 0x20 - 1,
-			.flags	= IORESOURCE_MEM,
-		}, {
-			.start	= irq,
-			.flags	= IORESOURCE_IRQ,
-		},
-	};
-	platform_device_register_simple("spi_txx9", 0,
-					res, ARRAY_SIZE(res));
-}
-
-static int __init rbtx4938_spi_init(void)
-{
-	struct spi_board_info srtc_info = {
-		.modalias = "rtc-rs5c348",
-		.max_speed_hz = 1000000, /* 1.0Mbps @ Vdd 2.0V */
-		.bus_num = 0,
-		.chip_select = 16 + SRTC_CS,
-		/* Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS  */
-		.mode = SPI_MODE_1 | SPI_CS_HIGH,
-	};
-	spi_register_board_info(&srtc_info, 1);
-	spi_eeprom_register(SEEPROM1_CS);
-	spi_eeprom_register(16 + SEEPROM2_CS);
-	spi_eeprom_register(16 + SEEPROM3_CS);
-	gpio_request(16 + SRTC_CS, "rtc-rs5c348");
-	gpio_direction_output(16 + SRTC_CS, 0);
-	gpio_request(SEEPROM1_CS, "seeprom1");
-	gpio_direction_output(SEEPROM1_CS, 1);
-	gpio_request(16 + SEEPROM2_CS, "seeprom2");
-	gpio_direction_output(16 + SEEPROM2_CS, 1);
-	gpio_request(16 + SEEPROM3_CS, "seeprom3");
-	gpio_direction_output(16 + SEEPROM3_CS, 1);
-	txx9_spi_init(TX4938_SPI_REG & 0xfffffffffULL, RBTX4938_IRQ_IRC_SPI);
-	return 0;
-}
-
-static int __init rbtx4938_arch_init(void)
-{
-	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, 16);
-	gpiochip_add(&rbtx4938_spi_gpio_chip);
-	return rbtx4938_spi_init();
-}
-arch_initcall(rbtx4938_arch_init);
-
-/* Watchdog support */
-
-static int __init txx9_wdt_init(unsigned long base)
-{
-	struct resource res = {
-		.start	= base,
-		.end	= base + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	};
-	struct platform_device *dev =
-		platform_device_register_simple("txx9wdt", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
-}
-
-static int __init rbtx4938_wdt_init(void)
-{
-	return txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
-}
-device_initcall(rbtx4938_wdt_init);
-
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)(txx9_gbus_clock / 2 / 4);
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)(txx9_gbus_clock / 2);
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c b/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
deleted file mode 100644
index 4d6b4ad..0000000
--- a/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * linux/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/eeprom.h>
-#include <asm/tx4938/spi.h>
-
-#define AT250X0_PAGE_SIZE	8
-
-/* register board information for at25 driver */
-int __init spi_eeprom_register(int chipid)
-{
-	static struct spi_eeprom eeprom = {
-		.name = "at250x0",
-		.byte_len = 128,
-		.page_size = AT250X0_PAGE_SIZE,
-		.flags = EE_ADDR1,
-	};
-	struct spi_board_info info = {
-		.modalias = "at25",
-		.max_speed_hz = 1500000,	/* 1.5Mbps */
-		.bus_num = 0,
-		.chip_select = chipid,
-		.platform_data = &eeprom,
-		/* Mode 0: High-Active, Sample-Then-Shift */
-	};
-
-	return spi_register_board_info(&info, 1);
-}
-
-/* simple temporary spi driver to provide early access to seeprom. */
-
-static struct read_param {
-	int chipid;
-	int address;
-	unsigned char *buf;
-	int len;
-} *read_param;
-
-static int __init early_seeprom_probe(struct spi_device *spi)
-{
-	int stat = 0;
-	u8 cmd[2];
-	int len = read_param->len;
-	char *buf = read_param->buf;
-	int address = read_param->address;
-
-	dev_info(&spi->dev, "spiclk %u KHz.\n",
-		 (spi->max_speed_hz + 500) / 1000);
-	if (read_param->chipid != spi->chip_select)
-		return -ENODEV;
-	while (len > 0) {
-		/* spi_write_then_read can only work with small chunk */
-		int c = len < AT250X0_PAGE_SIZE ? len : AT250X0_PAGE_SIZE;
-		cmd[0] = 0x03;	/* AT25_READ */
-		cmd[1] = address;
-		stat = spi_write_then_read(spi, cmd, sizeof(cmd), buf, c);
-		buf += c;
-		len -= c;
-		address += c;
-	}
-	return stat;
-}
-
-static struct spi_driver early_seeprom_driver __initdata = {
-	.driver = {
-		.name	= "at25",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= early_seeprom_probe,
-};
-
-int __init spi_eeprom_read(int chipid, int address,
-			   unsigned char *buf, int len)
-{
-	int ret;
-	struct read_param param = {
-		.chipid = chipid,
-		.address = address,
-		.buf = buf,
-		.len = len
-	};
-
-	read_param = &param;
-	ret = spi_register_driver(&early_seeprom_driver);
-	if (!ret)
-		spi_unregister_driver(&early_seeprom_driver);
-	return ret;
-}
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
new file mode 100644
index 0000000..98d1034
--- /dev/null
+++ b/arch/mips/txx9/Kconfig
@@ -0,0 +1,28 @@
+config TOSHIBA_FPCIB0
+	bool "FPCIB0 Backplane Support"
+	depends on TOSHIBA_RBTX4927
+
+if TOSHIBA_RBTX4938
+
+comment "Multiplex Pin Select"
+choice
+	prompt "PIO[58:61]"
+	default TOSHIBA_RBTX4938_MPLEX_PIO58_61
+
+config TOSHIBA_RBTX4938_MPLEX_PIO58_61
+	bool "PIO"
+config TOSHIBA_RBTX4938_MPLEX_NAND
+	bool "NAND"
+config TOSHIBA_RBTX4938_MPLEX_ATA
+	bool "ATA"
+
+endchoice
+
+config TX4938_NAND_BOOT
+	depends on EXPERIMENTAL && TOSHIBA_RBTX4938_MPLEX_NAND
+	bool "NAND Boot Support (EXPERIMENTAL)"
+	help
+	  This is only for Toshiba RBTX4938 reference board, which has NAND IPL.
+	  Select this option if you need to use NAND boot.
+
+endif
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
new file mode 100644
index 0000000..8cb4a7e
--- /dev/null
+++ b/arch/mips/txx9/generic/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for common code for TXx9 based systems
+#
+
+obj-$(CONFIG_TOSHIBA_RBTX4927)	+= mem_tx4927.o irq_tx4927.o
+obj-$(CONFIG_TOSHIBA_RBTX4938)	+= mem_tx4938.o irq_tx4938.o
+obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
+obj-$(CONFIG_KGDB)	+= dbgio.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/generic/dbgio.c b/arch/mips/txx9/generic/dbgio.c
new file mode 100644
index 0000000..33b9c67
--- /dev/null
+++ b/arch/mips/txx9/generic/dbgio.c
@@ -0,0 +1,48 @@
+/*
+ * linux/arch/mips/tx4938/common/dbgio.c
+ *
+ * kgdb interface for gdb
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Support for TX4938 in 2.6 - Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
+ */
+
+#include <linux/types>
+
+extern u8 txx9_sio_kdbg_rd(void);
+extern int txx9_sio_kdbg_wr( u8 ch );
+
+u8 getDebugChar(void)
+{
+	return (txx9_sio_kdbg_rd());
+}
+
+int putDebugChar(u8 byte)
+{
+	return (txx9_sio_kdbg_wr(byte));
+}
+
diff --git a/arch/mips/txx9/generic/irq_tx4927.c b/arch/mips/txx9/generic/irq_tx4927.c
new file mode 100644
index 0000000..685ecc2
--- /dev/null
+++ b/arch/mips/txx9/generic/irq_tx4927.c
@@ -0,0 +1,64 @@
+/*
+ * Common tx4927 irq handler
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#ifdef CONFIG_TOSHIBA_RBTX4927
+#include <asm/txx9/rbtx4927.h>
+#endif
+
+void __init tx4927_irq_init(void)
+{
+	mips_cpu_irq_init();
+	txx9_irq_init(TX4927_IRC_REG);
+	set_irq_chained_handler(TX4927_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (pending & STATUSF_IP7)			/* cpu timer */
+		do_IRQ(TX4927_IRQ_CPU_TIMER);
+	else if (pending & STATUSF_IP2) {		/* tx4927 pic */
+		int irq = txx9_irq();
+#ifdef CONFIG_TOSHIBA_RBTX4927
+		if (irq == TX4927_IRQ_NEST_EXT_ON_PIC)
+			irq = toshiba_rbtx4927_irq_nested(irq);
+#endif
+		if (unlikely(irq < 0)) {
+			spurious_interrupt();
+			return;
+		}
+		do_IRQ(irq);
+	} else if (pending & STATUSF_IP0)		/* user line 0 */
+		do_IRQ(TX4927_IRQ_USER0);
+	else if (pending & STATUSF_IP1)			/* user line 1 */
+		do_IRQ(TX4927_IRQ_USER1);
+	else
+		spurious_interrupt();
+}
diff --git a/arch/mips/txx9/generic/irq_tx4938.c b/arch/mips/txx9/generic/irq_tx4938.c
new file mode 100644
index 0000000..0886d91
--- /dev/null
+++ b/arch/mips/txx9/generic/irq_tx4938.c
@@ -0,0 +1,48 @@
+/*
+ * linux/arch/mips/tx4938/common/irq.c
+ *
+ * Common tx4938 irq handler
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/txx9/rbtx4938.h>
+
+void __init
+tx4938_irq_init(void)
+{
+	mips_cpu_irq_init();
+	txx9_irq_init(TX4938_IRC_REG);
+	set_irq_chained_handler(TX4938_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
+}
+
+int toshiba_rbtx4938_irq_nested(int irq);
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status();
+
+	if (pending & STATUSF_IP7)
+		do_IRQ(TX4938_IRQ_CPU_TIMER);
+	else if (pending & STATUSF_IP2) {
+		int irq = txx9_irq();
+		if (irq == TX4938_IRQ_PIC_BEG + TX4938_IR_INT(0))
+			irq = toshiba_rbtx4938_irq_nested(irq);
+		if (irq >= 0)
+			do_IRQ(irq);
+		else
+			spurious_interrupt();
+	} else if (pending & STATUSF_IP1)
+		do_IRQ(TX4938_IRQ_USER1);
+	else if (pending & STATUSF_IP0)
+		do_IRQ(TX4938_IRQ_USER0);
+}
diff --git a/arch/mips/txx9/generic/mem_tx4927.c b/arch/mips/txx9/generic/mem_tx4927.c
new file mode 100644
index 0000000..12dfc37
--- /dev/null
+++ b/arch/mips/txx9/generic/mem_tx4927.c
@@ -0,0 +1,141 @@
+/*
+ * linux/arch/mips/tx4927/common/tx4927_prom.c
+ *
+ * common tx4927 memory interface
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2001-2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+static unsigned int __init tx4927_process_sdccr(unsigned long addr)
+{
+	u64 val;
+	unsigned int sdccr_ce;
+	unsigned int sdccr_bs;
+	unsigned int sdccr_rs;
+	unsigned int sdccr_cs;
+	unsigned int sdccr_mw;
+	unsigned int bs = 0;
+	unsigned int rs = 0;
+	unsigned int cs = 0;
+	unsigned int mw = 0;
+	unsigned int msize = 0;
+
+	val = __raw_readq((void __iomem *)addr);
+
+	/* MVMCP -- need #defs for these bits masks */
+	sdccr_ce = ((val & (1 << 10)) >> 10);
+	sdccr_bs = ((val & (1 << 8)) >> 8);
+	sdccr_rs = ((val & (3 << 5)) >> 5);
+	sdccr_cs = ((val & (3 << 2)) >> 2);
+	sdccr_mw = ((val & (1 << 0)) >> 0);
+
+	if (sdccr_ce) {
+		switch (sdccr_bs) {
+		case 0:{
+				bs = 2;
+				break;
+			}
+		case 1:{
+				bs = 4;
+				break;
+			}
+		}
+		switch (sdccr_rs) {
+		case 0:{
+				rs = 2048;
+				break;
+			}
+		case 1:{
+				rs = 4096;
+				break;
+			}
+		case 2:{
+				rs = 8192;
+				break;
+			}
+		case 3:{
+				rs = 0;
+				break;
+			}
+		}
+		switch (sdccr_cs) {
+		case 0:{
+				cs = 256;
+				break;
+			}
+		case 1:{
+				cs = 512;
+				break;
+			}
+		case 2:{
+				cs = 1024;
+				break;
+			}
+		case 3:{
+				cs = 2048;
+				break;
+			}
+		}
+		switch (sdccr_mw) {
+		case 0:{
+				mw = 8;
+				break;
+			}	/* 8 bytes = 64 bits */
+		case 1:{
+				mw = 4;
+				break;
+			}	/* 4 bytes = 32 bits */
+		}
+	}
+
+	/*            bytes per chip     MB per chip      num chips */
+	msize = (((rs * cs * mw) / (1024 * 1024)) * bs);
+
+	return (msize);
+}
+
+
+unsigned int __init tx4927_get_mem_size(void)
+{
+	unsigned int c0;
+	unsigned int c1;
+	unsigned int c2;
+	unsigned int c3;
+	unsigned int total;
+
+	/* MVMCP -- need #defs for these registers */
+	c0 = tx4927_process_sdccr(0xff1f8000);
+	c1 = tx4927_process_sdccr(0xff1f8008);
+	c2 = tx4927_process_sdccr(0xff1f8010);
+	c3 = tx4927_process_sdccr(0xff1f8018);
+	total = c0 + c1 + c2 + c3;
+
+	return (total);
+}
diff --git a/arch/mips/txx9/generic/mem_tx4938.c b/arch/mips/txx9/generic/mem_tx4938.c
new file mode 100644
index 0000000..20baeae
--- /dev/null
+++ b/arch/mips/txx9/generic/mem_tx4938.c
@@ -0,0 +1,124 @@
+/*
+ * linux/arch/mips/tx4938/common/prom.c
+ *
+ * common tx4938 memory interface
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+static unsigned int __init
+tx4938_process_sdccr(u64 * addr)
+{
+	u64 val;
+	unsigned int sdccr_ce;
+	unsigned int sdccr_rs;
+	unsigned int sdccr_cs;
+	unsigned int sdccr_mw;
+	unsigned int rs = 0;
+	unsigned int cs = 0;
+	unsigned int mw = 0;
+	unsigned int bc = 4;
+	unsigned int msize = 0;
+
+	val = ____raw_readq((void __iomem *)addr);
+
+	/* MVMCP -- need #defs for these bits masks */
+	sdccr_ce = ((val & (1 << 10)) >> 10);
+	sdccr_rs = ((val & (3 << 5)) >> 5);
+	sdccr_cs = ((val & (7 << 2)) >> 2);
+	sdccr_mw = ((val & (1 << 0)) >> 0);
+
+	if (sdccr_ce) {
+		switch (sdccr_rs) {
+		case 0:{
+				rs = 2048;
+				break;
+			}
+		case 1:{
+				rs = 4096;
+				break;
+			}
+		case 2:{
+				rs = 8192;
+				break;
+			}
+		default:{
+				rs = 0;
+				break;
+			}
+		}
+		switch (sdccr_cs) {
+		case 0:{
+				cs = 256;
+				break;
+			}
+		case 1:{
+				cs = 512;
+				break;
+			}
+		case 2:{
+				cs = 1024;
+				break;
+			}
+		case 3:{
+				cs = 2048;
+				break;
+			}
+		case 4:{
+				cs = 4096;
+				break;
+			}
+		default:{
+				cs = 0;
+				break;
+			}
+		}
+		switch (sdccr_mw) {
+		case 0:{
+				mw = 8;
+				break;
+			}	/* 8 bytes = 64 bits */
+		case 1:{
+				mw = 4;
+				break;
+			}	/* 4 bytes = 32 bits */
+		}
+	}
+
+	/*           bytes per chip    MB per chip          bank count */
+	msize = (((rs * cs * mw) / (1024 * 1024)) * (bc));
+
+	/* MVMCP -- bc hard coded to 4 from table 9.3.1     */
+	/*          boad supports bc=2 but no way to detect */
+
+	return (msize);
+}
+
+unsigned int __init
+tx4938_get_mem_size(void)
+{
+	unsigned int c0;
+	unsigned int c1;
+	unsigned int c2;
+	unsigned int c3;
+	unsigned int total;
+
+	/* MVMCP -- need #defs for these registers */
+	c0 = tx4938_process_sdccr((u64 *) 0xff1f8000);
+	c1 = tx4938_process_sdccr((u64 *) 0xff1f8008);
+	c2 = tx4938_process_sdccr((u64 *) 0xff1f8010);
+	c3 = tx4938_process_sdccr((u64 *) 0xff1f8018);
+	total = c0 + c1 + c2 + c3;
+
+	return (total);
+}
diff --git a/arch/mips/txx9/generic/smsc_fdc37m81x.c b/arch/mips/txx9/generic/smsc_fdc37m81x.c
new file mode 100644
index 0000000..69e4874
--- /dev/null
+++ b/arch/mips/txx9/generic/smsc_fdc37m81x.c
@@ -0,0 +1,172 @@
+/*
+ * Interface for smsc fdc48m81x Super IO chip
+ *
+ * Author: MontaVista Software, Inc. source@mvista.com
+ *
+ * 2001-2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Copyright 2004 (c) MontaVista Software, Inc.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/txx9/smsc_fdc37m81x.h>
+
+#define DEBUG
+
+/* Common Registers */
+#define SMSC_FDC37M81X_CONFIG_INDEX  0x00
+#define SMSC_FDC37M81X_CONFIG_DATA   0x01
+#define SMSC_FDC37M81X_CONF          0x02
+#define SMSC_FDC37M81X_INDEX         0x03
+#define SMSC_FDC37M81X_DNUM          0x07
+#define SMSC_FDC37M81X_DID           0x20
+#define SMSC_FDC37M81X_DREV          0x21
+#define SMSC_FDC37M81X_PCNT          0x22
+#define SMSC_FDC37M81X_PMGT          0x23
+#define SMSC_FDC37M81X_OSC           0x24
+#define SMSC_FDC37M81X_CONFPA0       0x26
+#define SMSC_FDC37M81X_CONFPA1       0x27
+#define SMSC_FDC37M81X_TEST4         0x2B
+#define SMSC_FDC37M81X_TEST5         0x2C
+#define SMSC_FDC37M81X_TEST1         0x2D
+#define SMSC_FDC37M81X_TEST2         0x2E
+#define SMSC_FDC37M81X_TEST3         0x2F
+
+/* Logical device numbers */
+#define SMSC_FDC37M81X_FDD           0x00
+#define SMSC_FDC37M81X_SERIAL1       0x04
+#define SMSC_FDC37M81X_SERIAL2       0x05
+#define SMSC_FDC37M81X_KBD           0x07
+
+/* Logical device Config Registers */
+#define SMSC_FDC37M81X_ACTIVE        0x30
+#define SMSC_FDC37M81X_BASEADDR0     0x60
+#define SMSC_FDC37M81X_BASEADDR1     0x61
+#define SMSC_FDC37M81X_INT           0x70
+#define SMSC_FDC37M81X_INT2          0x72
+#define SMSC_FDC37M81X_MODE          0xF0
+
+/* Chip Config Values */
+#define SMSC_FDC37M81X_CONFIG_ENTER  0x55
+#define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
+#define SMSC_FDC37M81X_CHIP_ID       0x4d
+
+static unsigned long g_smsc_fdc37m81x_base = 0;
+
+static inline unsigned char smsc_fdc37m81x_rd(unsigned char index)
+{
+	outb(index, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+
+	return inb(g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_DATA);
+}
+
+static inline void smsc_dc37m81x_wr(unsigned char index, unsigned char data)
+{
+	outb(index, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+	outb(data, g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_DATA);
+}
+
+void smsc_fdc37m81x_config_beg(void)
+{
+	if (g_smsc_fdc37m81x_base) {
+		outb(SMSC_FDC37M81X_CONFIG_ENTER,
+		     g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+	}
+}
+
+void smsc_fdc37m81x_config_end(void)
+{
+	if (g_smsc_fdc37m81x_base)
+		outb(SMSC_FDC37M81X_CONFIG_EXIT,
+		     g_smsc_fdc37m81x_base + SMSC_FDC37M81X_CONFIG_INDEX);
+}
+
+u8 smsc_fdc37m81x_config_get(u8 reg)
+{
+	u8 val = 0;
+
+	if (g_smsc_fdc37m81x_base)
+		val = smsc_fdc37m81x_rd(reg);
+
+	return val;
+}
+
+void smsc_fdc37m81x_config_set(u8 reg, u8 val)
+{
+	if (g_smsc_fdc37m81x_base)
+		smsc_dc37m81x_wr(reg, val);
+}
+
+unsigned long __init smsc_fdc37m81x_init(unsigned long port)
+{
+	const int field = sizeof(unsigned long) * 2;
+	u8 chip_id;
+
+	if (g_smsc_fdc37m81x_base)
+		printk("smsc_fdc37m81x_init() stepping on old base=0x%0*lx\n",
+		       field, g_smsc_fdc37m81x_base);
+
+	g_smsc_fdc37m81x_base = port;
+
+	smsc_fdc37m81x_config_beg();
+
+	chip_id = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DID);
+	if (chip_id == SMSC_FDC37M81X_CHIP_ID)
+		smsc_fdc37m81x_config_end();
+	else {
+		printk("smsc_fdc37m81x_init() unknow chip id 0x%02x\n",
+		       chip_id);
+		g_smsc_fdc37m81x_base = 0;
+	}
+
+	return g_smsc_fdc37m81x_base;
+}
+
+#ifdef DEBUG
+void smsc_fdc37m81x_config_dump_one(char *key, u8 dev, u8 reg)
+{
+	printk("%s: dev=0x%02x reg=0x%02x val=0x%02x\n", key, dev, reg,
+	       smsc_fdc37m81x_rd(reg));
+}
+
+void smsc_fdc37m81x_config_dump(void)
+{
+	u8 orig;
+	char *fname = "smsc_fdc37m81x_config_dump()";
+
+	smsc_fdc37m81x_config_beg();
+
+	orig = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DNUM);
+
+	printk("%s: common\n", fname);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_DNUM);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_DID);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_DREV);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_PCNT);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
+				       SMSC_FDC37M81X_PMGT);
+
+	printk("%s: keyboard\n", fname);
+	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, SMSC_FDC37M81X_KBD);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_ACTIVE);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_INT);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_INT2);
+	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
+				       SMSC_FDC37M81X_LDCR_F0);
+
+	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, orig);
+
+	smsc_fdc37m81x_config_end();
+}
+#endif
diff --git a/arch/mips/txx9/jmr3927/Makefile b/arch/mips/txx9/jmr3927/Makefile
new file mode 100644
index 0000000..5f83ea3
--- /dev/null
+++ b/arch/mips/txx9/jmr3927/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for TOSHIBA JMR-TX3927 board
+#
+
+obj-y	+= prom.o init.o irq.o setup.o
+obj-$(CONFIG_KGDB)	+= kgdb_io.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/jmr3927/init.c b/arch/mips/txx9/jmr3927/init.c
new file mode 100644
index 0000000..1bbb534
--- /dev/null
+++ b/arch/mips/txx9/jmr3927/init.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *              ahennessy@mvista.com
+ *
+ * arch/mips/jmr3927/common/init.c
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <asm/bootinfo.h>
+#include <asm/txx9/jmr3927.h>
+
+extern void  __init prom_init_cmdline(void);
+
+const char *get_system_type(void)
+{
+	return "Toshiba"
+#ifdef CONFIG_TOSHIBA_JMR3927
+	       " JMR_TX3927"
+#endif
+	;
+}
+
+extern void puts(const char *cp);
+
+void __init prom_init(void)
+{
+#ifdef CONFIG_TOSHIBA_JMR3927
+	/* CCFG */
+	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
+		puts("Warning: TX3927 TLB off\n");
+#endif
+
+	prom_init_cmdline();
+	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
+}
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
new file mode 100644
index 0000000..85e1daf
--- /dev/null
+++ b/arch/mips/txx9/jmr3927/irq.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *              ahennessy@mvista.com
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+#include <asm/processor.h>
+#include <asm/txx9/jmr3927.h>
+
+#if JMR3927_IRQ_END > NR_IRQS
+#error JMR3927_IRQ_END > NR_IRQS
+#endif
+
+static unsigned char irc_level[TX3927_NUM_IR] = {
+	5, 5, 5, 5, 5, 5,	/* INT[5:0] */
+	7, 7,			/* SIO */
+	5, 5, 5, 0, 0,		/* DMA, PIO, PCI */
+	6, 6, 6			/* TMR */
+};
+
+/*
+ * CP0_STATUS is a thread's resource (saved/restored on context switch).
+ * So disable_irq/enable_irq MUST handle IOC/IRC registers.
+ */
+static void mask_irq_ioc(unsigned int irq)
+{
+	/* 0: mask */
+	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
+	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
+	unsigned int bit = 1 << irq_nr;
+	jmr3927_ioc_reg_out(imask & ~bit, JMR3927_IOC_INTM_ADDR);
+	/* flush write buffer */
+	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
+}
+static void unmask_irq_ioc(unsigned int irq)
+{
+	/* 0: mask */
+	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
+	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
+	unsigned int bit = 1 << irq_nr;
+	jmr3927_ioc_reg_out(imask | bit, JMR3927_IOC_INTM_ADDR);
+	/* flush write buffer */
+	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long cp0_cause = read_c0_cause();
+	int irq;
+
+	if ((cp0_cause & CAUSEF_IP7) == 0)
+		return;
+	irq = (cp0_cause >> CAUSEB_IP2) & 0x0f;
+
+	do_IRQ(irq + JMR3927_IRQ_IRC);
+}
+
+static irqreturn_t jmr3927_ioc_interrupt(int irq, void *dev_id)
+{
+	unsigned char istat = jmr3927_ioc_reg_in(JMR3927_IOC_INTS2_ADDR);
+	int i;
+
+	for (i = 0; i < JMR3927_NR_IRQ_IOC; i++) {
+		if (istat & (1 << i)) {
+			irq = JMR3927_IRQ_IOC + i;
+			do_IRQ(irq);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static struct irqaction ioc_action = {
+	.handler = jmr3927_ioc_interrupt,
+	.mask = CPU_MASK_NONE,
+	.name = "IOC",
+};
+
+static irqreturn_t jmr3927_pcierr_interrupt(int irq, void *dev_id)
+{
+	printk(KERN_WARNING "PCI error interrupt (irq 0x%x).\n", irq);
+	printk(KERN_WARNING "pcistat:%02x, lbstat:%04lx\n",
+	       tx3927_pcicptr->pcistat, tx3927_pcicptr->lbstat);
+
+	return IRQ_HANDLED;
+}
+static struct irqaction pcierr_action = {
+	.handler = jmr3927_pcierr_interrupt,
+	.mask = CPU_MASK_NONE,
+	.name = "PCI error",
+};
+
+static void __init jmr3927_irq_init(void);
+
+void __init arch_init_irq(void)
+{
+	/* Now, interrupt control disabled, */
+	/* all IRC interrupts are masked, */
+	/* all IRC interrupt mode are Low Active. */
+
+	/* mask all IOC interrupts */
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTM_ADDR);
+	/* setup IOC interrupt mode (SOFT:High Active, Others:Low Active) */
+	jmr3927_ioc_reg_out(JMR3927_IOC_INTF_SOFT, JMR3927_IOC_INTP_ADDR);
+
+	/* clear PCI Soft interrupts */
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTS1_ADDR);
+	/* clear PCI Reset interrupts */
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+
+	jmr3927_irq_init();
+
+	/* setup IOC interrupt 1 (PCI, MODEM) */
+	setup_irq(JMR3927_IRQ_IOCINT, &ioc_action);
+
+#ifdef CONFIG_PCI
+	setup_irq(JMR3927_IRQ_IRC_PCI, &pcierr_action);
+#endif
+
+	/* enable all CPU interrupt bits. */
+	set_c0_status(ST0_IM);	/* IE bit is still 0. */
+}
+
+static struct irq_chip jmr3927_irq_ioc = {
+	.name = "jmr3927_ioc",
+	.ack = mask_irq_ioc,
+	.mask = mask_irq_ioc,
+	.mask_ack = mask_irq_ioc,
+	.unmask = unmask_irq_ioc,
+};
+
+static void __init jmr3927_irq_init(void)
+{
+	u32 i;
+
+	txx9_irq_init(TX3927_IRC_REG);
+	for (i = 0; i < TXx9_MAX_IR; i++)
+		txx9_irq_set_pri(i, irc_level[i]);
+	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
+		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
+}
diff --git a/arch/mips/txx9/jmr3927/kgdb_io.c b/arch/mips/txx9/jmr3927/kgdb_io.c
new file mode 100644
index 0000000..5bd757e
--- /dev/null
+++ b/arch/mips/txx9/jmr3927/kgdb_io.c
@@ -0,0 +1,105 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *	Low level uart routines to directly access a TX[34]927 SIO.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *         	ahennessy@mvista.com or source@mvista.com
+ *
+ * Based on arch/mips/ddb5xxx/ddb5477/kgdb_io.c
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/txx9/jmr3927.h>
+
+#define TIMEOUT       0xffffff
+
+static int remoteDebugInitialized = 0;
+static void debugInit(int baud);
+
+int putDebugChar(unsigned char c)
+{
+        int i = 0;
+
+	if (!remoteDebugInitialized) {
+		remoteDebugInitialized = 1;
+		debugInit(38400);
+	}
+
+        do {
+            slow_down();
+            i++;
+            if (i>TIMEOUT) {
+                break;
+            }
+        } while (!(tx3927_sioptr(0)->cisr & TXx927_SICISR_TXALS));
+	tx3927_sioptr(0)->tfifo = c;
+
+	return 1;
+}
+
+unsigned char getDebugChar(void)
+{
+        int i = 0;
+	int dicr;
+	char c;
+
+	if (!remoteDebugInitialized) {
+		remoteDebugInitialized = 1;
+		debugInit(38400);
+	}
+
+	/* diable RX int. */
+	dicr = tx3927_sioptr(0)->dicr;
+	tx3927_sioptr(0)->dicr = 0;
+
+        do {
+            slow_down();
+            i++;
+            if (i>TIMEOUT) {
+                break;
+            }
+        } while (tx3927_sioptr(0)->disr & TXx927_SIDISR_UVALID)
+		;
+	c = tx3927_sioptr(0)->rfifo;
+
+	/* clear RX int. status */
+	tx3927_sioptr(0)->disr &= ~TXx927_SIDISR_RDIS;
+	/* enable RX int. */
+	tx3927_sioptr(0)->dicr = dicr;
+
+	return c;
+}
+
+static void debugInit(int baud)
+{
+	tx3927_sioptr(0)->lcr = 0x020;
+	tx3927_sioptr(0)->dicr = 0;
+	tx3927_sioptr(0)->disr = 0x4100;
+	tx3927_sioptr(0)->cisr = 0x014;
+	tx3927_sioptr(0)->fcr = 0;
+	tx3927_sioptr(0)->flcr = 0x02;
+	tx3927_sioptr(0)->bgr = ((JMR3927_BASE_BAUD + baud / 2) / baud) |
+		TXx927_SIBGR_BCLK_T0;
+}
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
new file mode 100644
index 0000000..8bc1049
--- /dev/null
+++ b/arch/mips/txx9/jmr3927/prom.c
@@ -0,0 +1,98 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *    PROM library initialisation code, assuming a version of
+ *    pmon is the boot code.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *              ahennessy@mvista.com
+ *
+ * Based on arch/mips/au1000/common/prom.c
+ *
+ * This file was derived from Carsten Langgaard's
+ * arch/mips/mips-boards/xx files.
+ *
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/txx9/tx3927.h>
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+void  __init prom_init_cmdline(void)
+{
+	char *cp;
+	int actr;
+	int prom_argc = fw_arg0;
+	char **prom_argv = (char **) fw_arg1;
+
+	actr = 1; /* Always ignore argv[0] */
+
+	cp = &(arcs_cmdline[0]);
+	while(actr < prom_argc) {
+	        strcpy(cp, prom_argv[actr]);
+		cp += strlen(prom_argv[actr]);
+		*cp++ = ' ';
+		actr++;
+	}
+	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
+		--cp;
+	*cp = '\0';
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+#define TIMEOUT       0xffffff
+
+void
+prom_putchar(char c)
+{
+        int i = 0;
+
+        do {
+            i++;
+            if (i>TIMEOUT)
+                break;
+        } while (!(tx3927_sioptr(1)->cisr & TXx927_SICISR_TXALS));
+	tx3927_sioptr(1)->tfifo = c;
+	return;
+}
+
+void
+puts(const char *cp)
+{
+    while (*cp)
+	prom_putchar(*cp++);
+    prom_putchar('\r');
+    prom_putchar('\n');
+}
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
new file mode 100644
index 0000000..41e0f3b
--- /dev/null
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -0,0 +1,445 @@
+/*
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *              ahennessy@mvista.com
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#ifdef CONFIG_SERIAL_TXX9
+#include <linux/serial_core.h>
+#endif
+
+#include <asm/txx9tmr.h>
+#include <asm/txx9pio.h>
+#include <asm/reboot.h>
+#include <asm/txx9/jmr3927.h>
+#include <asm/mipsregs.h>
+
+extern void puts(const char *cp);
+
+/* don't enable - see errata */
+static int jmr3927_ccfg_toeon;
+
+static inline void do_reset(void)
+{
+#if 1	/* Resetting PCI bus */
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI, JMR3927_IOC_RESET_ADDR);
+	(void)jmr3927_ioc_reg_in(JMR3927_IOC_RESET_ADDR);	/* flush WB */
+	mdelay(1);
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+#endif
+	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_CPU, JMR3927_IOC_RESET_ADDR);
+}
+
+static void jmr3927_machine_restart(char *command)
+{
+	local_irq_disable();
+	puts("Rebooting...");
+	do_reset();
+}
+
+static void jmr3927_machine_halt(void)
+{
+	puts("JMR-TX3927 halted.\n");
+	while (1);
+}
+
+static void jmr3927_machine_power_off(void)
+{
+	puts("JMR-TX3927 halted. Please turn off the power.\n");
+	while (1);
+}
+
+void __init plat_time_init(void)
+{
+	txx9_clockevent_init(TX3927_TMR_REG(0),
+			     TXX9_IRQ_BASE + JMR3927_IRQ_IRC_TMR(0),
+			     JMR3927_IMCLK);
+	txx9_clocksource_init(TX3927_TMR_REG(1), JMR3927_IMCLK);
+}
+
+#define DO_WRITE_THROUGH
+#define DO_ENABLE_CACHE
+
+extern char * __init prom_getcmdline(void);
+static void jmr3927_board_init(void);
+extern struct resource pci_io_resource;
+extern struct resource pci_mem_resource;
+
+void __init plat_mem_setup(void)
+{
+	char *argptr;
+
+	set_io_port_base(JMR3927_PORT_BASE + JMR3927_PCIIO);
+
+	_machine_restart = jmr3927_machine_restart;
+	_machine_halt = jmr3927_machine_halt;
+	pm_power_off = jmr3927_machine_power_off;
+
+	/*
+	 * IO/MEM resources.
+	 */
+	ioport_resource.start = pci_io_resource.start;
+	ioport_resource.end = pci_io_resource.end;
+	iomem_resource.start = 0;
+	iomem_resource.end = 0xffffffff;
+
+	/* Reboot on panic */
+	panic_timeout = 180;
+
+	/* cache setup */
+	{
+		unsigned int conf;
+#ifdef DO_ENABLE_CACHE
+		int mips_ic_disable = 0, mips_dc_disable = 0;
+#else
+		int mips_ic_disable = 1, mips_dc_disable = 1;
+#endif
+#ifdef DO_WRITE_THROUGH
+		int mips_config_cwfon = 0;
+		int mips_config_wbon = 0;
+#else
+		int mips_config_cwfon = 1;
+		int mips_config_wbon = 1;
+#endif
+
+		conf = read_c0_conf();
+		conf &= ~(TX39_CONF_ICE | TX39_CONF_DCE | TX39_CONF_WBON | TX39_CONF_CWFON);
+		conf |= mips_ic_disable ? 0 : TX39_CONF_ICE;
+		conf |= mips_dc_disable ? 0 : TX39_CONF_DCE;
+		conf |= mips_config_wbon ? TX39_CONF_WBON : 0;
+		conf |= mips_config_cwfon ? TX39_CONF_CWFON : 0;
+
+		write_c0_conf(conf);
+		write_c0_cache(0);
+	}
+
+	/* initialize board */
+	jmr3927_board_init();
+
+	argptr = prom_getcmdline();
+
+	if ((argptr = strstr(argptr, "toeon")) != NULL)
+		jmr3927_ccfg_toeon = 1;
+	argptr = prom_getcmdline();
+	if ((argptr = strstr(argptr, "ip=")) == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " ip=bootp");
+	}
+
+#ifdef CONFIG_SERIAL_TXX9
+	{
+		extern int early_serial_txx9_setup(struct uart_port *port);
+		int i;
+		struct uart_port req;
+		for(i = 0; i < 2; i++) {
+			memset(&req, 0, sizeof(req));
+			req.line = i;
+			req.iotype = UPIO_MEM;
+			req.membase = (unsigned char __iomem *)TX3927_SIO_REG(i);
+			req.mapbase = TX3927_SIO_REG(i);
+			req.irq = i == 0 ?
+				JMR3927_IRQ_IRC_SIO0 : JMR3927_IRQ_IRC_SIO1;
+			if (i == 0)
+				req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+			req.uartclk = JMR3927_IMCLK;
+			early_serial_txx9_setup(&req);
+		}
+	}
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+	argptr = prom_getcmdline();
+	if ((argptr = strstr(argptr, "console=")) == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS1,115200");
+	}
+#endif
+#endif
+}
+
+static void tx3927_setup(void);
+
+static void __init jmr3927_board_init(void)
+{
+	tx3927_setup();
+
+	/* SIO0 DTR on */
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
+
+	jmr3927_led_set(0);
+
+	printk("JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
+	       jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
+	       jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
+	       jmr3927_dipsw1(), jmr3927_dipsw2(),
+	       jmr3927_dipsw3(), jmr3927_dipsw4());
+}
+
+static void __init tx3927_setup(void)
+{
+	int i;
+#ifdef CONFIG_PCI
+	unsigned long mips_pci_io_base = JMR3927_PCIIO;
+	unsigned long mips_pci_io_size = JMR3927_PCIIO_SIZE;
+	unsigned long mips_pci_mem_base = JMR3927_PCIMEM;
+	unsigned long mips_pci_mem_size = JMR3927_PCIMEM_SIZE;
+	/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
+	unsigned long mips_pci_io_pciaddr = 0;
+#endif
+
+	/* SDRAMC are configured by PROM */
+
+	/* ROMC */
+	tx3927_romcptr->cr[1] = JMR3927_ROMCE1 | 0x00030048;
+	tx3927_romcptr->cr[2] = JMR3927_ROMCE2 | 0x000064c8;
+	tx3927_romcptr->cr[3] = JMR3927_ROMCE3 | 0x0003f698;
+	tx3927_romcptr->cr[5] = JMR3927_ROMCE5 | 0x0000f218;
+
+	/* CCFG */
+	/* enable Timeout BusError */
+	if (jmr3927_ccfg_toeon)
+		tx3927_ccfgptr->ccfg |= TX3927_CCFG_TOE;
+
+	/* clear BusErrorOnWrite flag */
+	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_BEOW;
+	/* Disable PCI snoop */
+	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_PSNP;
+	/* do reset on watchdog */
+	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
+
+#ifdef DO_WRITE_THROUGH
+	/* Enable PCI SNOOP - with write through only */
+	tx3927_ccfgptr->ccfg |= TX3927_CCFG_PSNP;
+#endif
+
+	/* Pin selection */
+	tx3927_ccfgptr->pcfg &= ~TX3927_PCFG_SELALL;
+	tx3927_ccfgptr->pcfg |=
+		TX3927_PCFG_SELSIOC(0) | TX3927_PCFG_SELSIO_ALL |
+		(TX3927_PCFG_SELDMA_ALL & ~TX3927_PCFG_SELDMA(1));
+
+	printk("TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
+	       tx3927_ccfgptr->crir,
+	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
+
+	/* TMR */
+	for (i = 0; i < TX3927_NR_TMR; i++)
+		txx9_tmr_init(TX3927_TMR_REG(i));
+
+	/* DMA */
+	tx3927_dmaptr->mcr = 0;
+	for (i = 0; i < ARRAY_SIZE(tx3927_dmaptr->ch); i++) {
+		/* reset channel */
+		tx3927_dmaptr->ch[i].ccr = TX3927_DMA_CCR_CHRST;
+		tx3927_dmaptr->ch[i].ccr = 0;
+	}
+	/* enable DMA */
+#ifdef __BIG_ENDIAN
+	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN;
+#else
+	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN | TX3927_DMA_MCR_LE;
+#endif
+
+#ifdef CONFIG_PCI
+	/* PCIC */
+	printk("TX3927 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:",
+	       tx3927_pcicptr->did, tx3927_pcicptr->vid,
+	       tx3927_pcicptr->rid);
+	if (!(tx3927_ccfgptr->ccfg & TX3927_CCFG_PCIXARB)) {
+		printk("External\n");
+		/* XXX */
+	} else {
+		printk("Internal\n");
+
+		/* Reset PCI Bus */
+		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+		udelay(100);
+		jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI,
+				    JMR3927_IOC_RESET_ADDR);
+		udelay(100);
+		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
+
+
+		/* Disable External PCI Config. Access */
+		tx3927_pcicptr->lbc = TX3927_PCIC_LBC_EPCAD;
+#ifdef __BIG_ENDIAN
+		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_IBSE |
+			TX3927_PCIC_LBC_TIBSE |
+			TX3927_PCIC_LBC_TMFBSE | TX3927_PCIC_LBC_MSDSE;
+#endif
+		/* LB->PCI mappings */
+		tx3927_pcicptr->iomas = ~(mips_pci_io_size - 1);
+		tx3927_pcicptr->ilbioma = mips_pci_io_base;
+		tx3927_pcicptr->ipbioma = mips_pci_io_pciaddr;
+		tx3927_pcicptr->mmas = ~(mips_pci_mem_size - 1);
+		tx3927_pcicptr->ilbmma = mips_pci_mem_base;
+		tx3927_pcicptr->ipbmma = mips_pci_mem_base;
+		/* PCI->LB mappings */
+		tx3927_pcicptr->iobas = 0xffffffff;
+		tx3927_pcicptr->ioba = 0;
+		tx3927_pcicptr->tlbioma = 0;
+		tx3927_pcicptr->mbas = ~(mips_pci_mem_size - 1);
+		tx3927_pcicptr->mba = 0;
+		tx3927_pcicptr->tlbmma = 0;
+		/* Enable Direct mapping Address Space Decoder */
+		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_ILMDE | TX3927_PCIC_LBC_ILIDE;
+
+		/* Clear All Local Bus Status */
+		tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
+		/* Enable All Local Bus Interrupts */
+		tx3927_pcicptr->lbim = TX3927_PCIC_LBIM_ALL;
+		/* Clear All PCI Status Error */
+		tx3927_pcicptr->pcistat = TX3927_PCIC_PCISTATIM_ALL;
+		/* Enable All PCI Status Error Interrupts */
+		tx3927_pcicptr->pcistatim = TX3927_PCIC_PCISTATIM_ALL;
+
+		/* PCIC Int => IRC IRQ10 */
+		tx3927_pcicptr->il = TX3927_IR_PCI;
+		/* Target Control (per errata) */
+		tx3927_pcicptr->tc = TX3927_PCIC_TC_OF8E | TX3927_PCIC_TC_IF8E;
+
+		/* Enable Bus Arbiter */
+		tx3927_pcicptr->pbapmc = TX3927_PCIC_PBAPMC_PBAEN;
+
+		tx3927_pcicptr->pcicmd = PCI_COMMAND_MASTER |
+			PCI_COMMAND_MEMORY |
+			PCI_COMMAND_IO |
+			PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	}
+#endif /* CONFIG_PCI */
+
+	/* PIO */
+	/* PIO[15:12] connected to LEDs */
+	__raw_writel(0x0000f000, &tx3927_pioptr->dir);
+	__raw_writel(0, &tx3927_pioptr->maskcpu);
+	__raw_writel(0, &tx3927_pioptr->maskext);
+	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
+	gpio_request(11, "dipsw1");
+	gpio_request(10, "dipsw2");
+	{
+		unsigned int conf;
+
+	conf = read_c0_conf();
+               if (!(conf & TX39_CONF_ICE))
+                       printk("TX3927 I-Cache disabled.\n");
+               if (!(conf & TX39_CONF_DCE))
+                       printk("TX3927 D-Cache disabled.\n");
+               else if (!(conf & TX39_CONF_WBON))
+                       printk("TX3927 D-Cache WriteThrough.\n");
+               else if (!(conf & TX39_CONF_CWFON))
+                       printk("TX3927 D-Cache WriteBack.\n");
+               else
+                       printk("TX3927 D-Cache WriteBack (CWF) .\n");
+	}
+}
+
+/* This trick makes rtc-ds1742 driver usable as is. */
+unsigned long __swizzle_addr_b(unsigned long port)
+{
+	if ((port & 0xffff0000) != JMR3927_IOC_NVRAMB_ADDR)
+		return port;
+	port = (port & 0xffff0000) | (port & 0x7fff << 1);
+#ifdef __BIG_ENDIAN
+	return port;
+#else
+	return port | 1;
+#endif
+}
+EXPORT_SYMBOL(__swizzle_addr_b);
+
+static int __init jmr3927_rtc_init(void)
+{
+	static struct resource __initdata res = {
+		.start	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE,
+		.end	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev;
+	dev = platform_device_register_simple("rtc-ds1742", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(jmr3927_rtc_init);
+
+/* Watchdog support */
+
+static int __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("txx9wdt", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+
+static int __init jmr3927_wdt_init(void)
+{
+	return txx9_wdt_init(TX3927_TMR_REG(2));
+}
+device_initcall(jmr3927_wdt_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)JMR3927_IMCLK;
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/txx9/rbtx4927/Makefile b/arch/mips/txx9/rbtx4927/Makefile
new file mode 100644
index 0000000..f3e1f59
--- /dev/null
+++ b/arch/mips/txx9/rbtx4927/Makefile
@@ -0,0 +1,3 @@
+obj-y	+= prom.o setup.o irq.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
new file mode 100644
index 0000000..936e50e
--- /dev/null
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -0,0 +1,214 @@
+/*
+ * Toshiba RBTX4927 specific interrupt handlers
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2001-2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+/*
+IRQ  Device
+00   RBTX4927-ISA/00
+01   RBTX4927-ISA/01 PS2/Keyboard
+02   RBTX4927-ISA/02 Cascade RBTX4927-ISA (irqs 8-15)
+03   RBTX4927-ISA/03
+04   RBTX4927-ISA/04
+05   RBTX4927-ISA/05
+06   RBTX4927-ISA/06
+07   RBTX4927-ISA/07
+08   RBTX4927-ISA/08
+09   RBTX4927-ISA/09
+10   RBTX4927-ISA/10
+11   RBTX4927-ISA/11
+12   RBTX4927-ISA/12 PS2/Mouse (not supported at this time)
+13   RBTX4927-ISA/13
+14   RBTX4927-ISA/14 IDE
+15   RBTX4927-ISA/15
+
+16   TX4927-CP0/00 Software 0
+17   TX4927-CP0/01 Software 1
+18   TX4927-CP0/02 Cascade TX4927-CP0
+19   TX4927-CP0/03 Multiplexed -- do not use
+20   TX4927-CP0/04 Multiplexed -- do not use
+21   TX4927-CP0/05 Multiplexed -- do not use
+22   TX4927-CP0/06 Multiplexed -- do not use
+23   TX4927-CP0/07 CPU TIMER
+
+24   TX4927-PIC/00
+25   TX4927-PIC/01
+26   TX4927-PIC/02
+27   TX4927-PIC/03 Cascade RBTX4927-IOC
+28   TX4927-PIC/04
+29   TX4927-PIC/05 RBTX4927 RTL-8019AS ethernet
+30   TX4927-PIC/06
+31   TX4927-PIC/07
+32   TX4927-PIC/08 TX4927 SerialIO Channel 0
+33   TX4927-PIC/09 TX4927 SerialIO Channel 1
+34   TX4927-PIC/10
+35   TX4927-PIC/11
+36   TX4927-PIC/12
+37   TX4927-PIC/13
+38   TX4927-PIC/14
+39   TX4927-PIC/15
+40   TX4927-PIC/16 TX4927 PCI PCI-C
+41   TX4927-PIC/17
+42   TX4927-PIC/18
+43   TX4927-PIC/19
+44   TX4927-PIC/20
+45   TX4927-PIC/21
+46   TX4927-PIC/22 TX4927 PCI PCI-ERR
+47   TX4927-PIC/23 TX4927 PCI PCI-PMA (not used)
+48   TX4927-PIC/24
+49   TX4927-PIC/25
+50   TX4927-PIC/26
+51   TX4927-PIC/27
+52   TX4927-PIC/28
+53   TX4927-PIC/29
+54   TX4927-PIC/30
+55   TX4927-PIC/31
+
+56 RBTX4927-IOC/00 FPCIB0 PCI-D PJ4/A PJ5/B SB/C PJ6/D PJ7/A (SouthBridge/NotUsed)        [RTL-8139=PJ4]
+57 RBTX4927-IOC/01 FPCIB0 PCI-C PJ4/D PJ5/A SB/B PJ6/C PJ7/D (SouthBridge/NotUsed)        [RTL-8139=PJ5]
+58 RBTX4927-IOC/02 FPCIB0 PCI-B PJ4/C PJ5/D SB/A PJ6/B PJ7/C (SouthBridge/IDE/pin=1,INTR) [RTL-8139=NotSupported]
+59 RBTX4927-IOC/03 FPCIB0 PCI-A PJ4/B PJ5/C SB/D PJ6/A PJ7/B (SouthBridge/USB/pin=4)      [RTL-8139=PJ6]
+60 RBTX4927-IOC/04
+61 RBTX4927-IOC/05
+62 RBTX4927-IOC/06
+63 RBTX4927-IOC/07
+
+NOTES:
+SouthBridge/INTR is mapped to SouthBridge/A=PCI-B/#58
+SouthBridge/ISA/pin=0 no pci irq used by this device
+SouthBridge/IDE/pin=1 no pci irq used by this device, using INTR via ISA IRQ14
+SouthBridge/USB/pin=4 using pci irq SouthBridge/D=PCI-A=#59
+SouthBridge/PMC/pin=0 no pci irq used by this device
+SuperIO/PS2/Keyboard, using INTR via ISA IRQ1
+SuperIO/PS2/Mouse, using INTR via ISA IRQ12 (mouse not currently supported)
+JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthBridge, JP4, JP5, JP6
+*/
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+#ifdef CONFIG_TOSHIBA_FPCIB0
+#include <asm/i8259.h>
+#endif
+#include <asm/txx9/rbtx4927.h>
+
+#define TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG   0
+#define TOSHIBA_RBTX4927_IRQ_IOC_RAW_END   7
+
+#define TOSHIBA_RBTX4927_IRQ_IOC_BEG  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG)	/* 56 */
+#define TOSHIBA_RBTX4927_IRQ_IOC_END  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_END)	/* 63 */
+
+#define TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC TX4927_IRQ_NEST_EXT_ON_PIC
+#define TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC (TOSHIBA_RBTX4927_IRQ_IOC_BEG+2)
+
+extern int tx4927_using_backplane;
+
+static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
+static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
+
+#define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
+static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
+	.name = TOSHIBA_RBTX4927_IOC_NAME,
+	.ack = toshiba_rbtx4927_irq_ioc_disable,
+	.mask = toshiba_rbtx4927_irq_ioc_disable,
+	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
+	.unmask = toshiba_rbtx4927_irq_ioc_enable,
+};
+#define TOSHIBA_RBTX4927_IOC_INTR_ENAB (void __iomem *)0xbc002000UL
+#define TOSHIBA_RBTX4927_IOC_INTR_STAT (void __iomem *)0xbc002006UL
+
+int toshiba_rbtx4927_irq_nested(int sw_irq)
+{
+	u8 level3;
+
+	level3 = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
+	if (level3) {
+		sw_irq = TOSHIBA_RBTX4927_IRQ_IOC_BEG + fls(level3) - 1;
+#ifdef CONFIG_TOSHIBA_FPCIB0
+		if (sw_irq == TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC &&
+		    tx4927_using_backplane) {
+			int irq = i8259_irq();
+			if (irq >= 0)
+				sw_irq = irq;
+		}
+#endif
+	}
+	return (sw_irq);
+}
+
+static struct irqaction toshiba_rbtx4927_irq_ioc_action = {
+	.handler	= no_action,
+	.flags		= IRQF_SHARED,
+	.mask		= CPU_MASK_NONE,
+	.name		= TOSHIBA_RBTX4927_IOC_NAME
+};
+
+static void __init toshiba_rbtx4927_irq_ioc_init(void)
+{
+	int i;
+
+	for (i = TOSHIBA_RBTX4927_IRQ_IOC_BEG;
+	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++)
+		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
+					 handle_level_irq);
+
+	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC,
+		  &toshiba_rbtx4927_irq_ioc_action);
+}
+
+static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
+{
+	unsigned char v;
+
+	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	v |= (1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
+	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+}
+
+static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
+{
+	unsigned char v;
+
+	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	v &= ~(1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
+	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	mmiowb();
+}
+
+void __init arch_init_irq(void)
+{
+	extern void tx4927_irq_init(void);
+
+	tx4927_irq_init();
+	toshiba_rbtx4927_irq_ioc_init();
+#ifdef CONFIG_TOSHIBA_FPCIB0
+	if (tx4927_using_backplane)
+		init_i8259_irqs();
+#endif
+	/* Onboard 10M Ether: High Active */
+	set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
+}
diff --git a/arch/mips/txx9/rbtx4927/prom.c b/arch/mips/txx9/rbtx4927/prom.c
new file mode 100644
index 0000000..0020bbe
--- /dev/null
+++ b/arch/mips/txx9/rbtx4927/prom.c
@@ -0,0 +1,91 @@
+/*
+ * rbtx4927 specific prom routines
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2001-2002 MontaVista Software Inc.
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/txx9/tx4927.h>
+
+void __init prom_init_cmdline(void)
+{
+	int argc = (int) fw_arg0;
+	char **argv = (char **) fw_arg1;
+	int i;			/* Always ignore the "-c" at argv[0] */
+
+	/* ignore all built-in args if any f/w args given */
+	if (argc > 1) {
+		*arcs_cmdline = '\0';
+	}
+
+	for (i = 1; i < argc; i++) {
+		if (i != 1) {
+			strcat(arcs_cmdline, " ");
+		}
+		strcat(arcs_cmdline, argv[i]);
+	}
+}
+
+void __init prom_init(void)
+{
+	extern int tx4927_get_mem_size(void);
+	extern char* toshiba_name;
+	int msize;
+
+	prom_init_cmdline();
+
+	if ((read_c0_prid() & 0xff) == PRID_REV_TX4927) {
+		mips_machtype = MACH_TOSHIBA_RBTX4927;
+		toshiba_name  = "TX4927";
+	} else {
+		mips_machtype = MACH_TOSHIBA_RBTX4937;
+		toshiba_name  = "TX4937";
+	}
+
+	msize = tx4927_get_mem_size();
+	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+const char *get_system_type(void)
+{
+	return "Toshiba RBTX4927/RBTX4937";
+}
+
+char * __init prom_getcmdline(void)
+{
+        return &(arcs_cmdline[0]);
+}
+
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
new file mode 100644
index 0000000..df1b6e9
--- /dev/null
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -0,0 +1,703 @@
+/*
+ * Toshiba rbtx4927 specific setup
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2001-2002 MontaVista Software Inc.
+ *
+ * Copyright (C) 1996, 97, 2001, 04  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Author: RidgeRun, Inc.
+ *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ * Author: Michael Pruznick, michael_pruznick@mvista.com
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/txx9tmr.h>
+#ifdef CONFIG_TOSHIBA_FPCIB0
+#include <asm/txx9/smsc_fdc37m81x.h>
+#endif
+#include <asm/txx9/rbtx4927.h>
+#ifdef CONFIG_SERIAL_TXX9
+#include <linux/serial_core.h>
+#endif
+
+/* These functions are used for rebooting or halting the machine*/
+extern void toshiba_rbtx4927_restart(char *command);
+extern void toshiba_rbtx4927_halt(void);
+extern void toshiba_rbtx4927_power_off(void);
+
+int tx4927_using_backplane = 0;
+
+extern void toshiba_rbtx4927_irq_setup(void);
+
+char *prom_getcmdline(void);
+
+#ifdef CONFIG_PCI
+#undef TX4927_SUPPORT_COMMAND_IO
+#undef  TX4927_SUPPORT_PCI_66
+int tx4927_cpu_clock = 100000000;	/* 100MHz */
+unsigned long mips_pci_io_base;
+unsigned long mips_pci_io_size;
+unsigned long mips_pci_mem_base;
+unsigned long mips_pci_mem_size;
+/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
+unsigned long mips_pci_io_pciaddr = 0;
+unsigned long mips_memory_upper;
+static int tx4927_ccfg_toeon = 1;
+static int tx4927_pcic_trdyto = 0;	/* default: disabled */
+unsigned long tx4927_ce_base[8];
+int tx4927_pci66 = 0;		/* 0:auto */
+#endif
+
+char *toshiba_name = "";
+
+#ifdef CONFIG_PCI
+extern struct pci_controller tx4927_controller;
+
+static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
+				    int top_bus, int busnr, int devfn)
+{
+	static struct pci_dev dev;
+	static struct pci_bus bus;
+
+	dev.sysdata = (void *)hose;
+	dev.devfn = devfn;
+	bus.number = busnr;
+	bus.ops = hose->pci_ops;
+	bus.parent = NULL;
+	dev.bus = &bus;
+
+	return &dev;
+}
+
+#define EARLY_PCI_OP(rw, size, type)                                    \
+static int early_##rw##_config_##size(struct pci_controller *hose,      \
+        int top_bus, int bus, int devfn, int offset, type value)        \
+{                                                                       \
+        return pci_##rw##_config_##size(                                \
+                fake_pci_dev(hose, top_bus, bus, devfn),                \
+                offset, value);                                         \
+}
+
+EARLY_PCI_OP(read, byte, u8 *)
+EARLY_PCI_OP(read, dword, u32 *)
+EARLY_PCI_OP(write, byte, u8)
+EARLY_PCI_OP(write, dword, u32)
+
+static int __init tx4927_pcibios_init(void)
+{
+	unsigned int id;
+	u32 pci_devfn;
+	int devfn_start = 0;
+	int devfn_stop = 0xff;
+	int busno = 0; /* One bus on the Toshiba */
+	struct pci_controller *hose = &tx4927_controller;
+
+	for (pci_devfn = devfn_start; pci_devfn < devfn_stop; pci_devfn++) {
+		early_read_config_dword(hose, busno, busno, pci_devfn,
+					PCI_VENDOR_ID, &id);
+
+		if (id == 0xffffffff) {
+			continue;
+		}
+
+		if (id == 0x94601055) {
+			u8 v08_64;
+			u32 v32_b0;
+			u8 v08_e1;
+
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0x64, &v08_64);
+			early_read_config_dword(hose, busno, busno,
+						pci_devfn, 0xb0, &v32_b0);
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0xe1, &v08_e1);
+
+			/* serial irq control */
+			v08_64 = 0xd0;
+
+			/* serial irq pin */
+			v32_b0 |= 0x00010000;
+
+			/* ide irq on isa14 */
+			v08_e1 &= 0xf0;
+			v08_e1 |= 0x0d;
+
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0x64, v08_64);
+			early_write_config_dword(hose, busno, busno,
+						 pci_devfn, 0xb0, v32_b0);
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0xe1, v08_e1);
+		}
+
+		if (id == 0x91301055) {
+			u8 v08_04;
+			u8 v08_09;
+			u8 v08_41;
+			u8 v08_43;
+			u8 v08_5c;
+
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0x04, &v08_04);
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0x09, &v08_09);
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0x41, &v08_41);
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0x43, &v08_43);
+			early_read_config_byte(hose, busno, busno,
+					       pci_devfn, 0x5c, &v08_5c);
+
+			/* enable ide master/io */
+			v08_04 |= (PCI_COMMAND_MASTER | PCI_COMMAND_IO);
+
+			/* enable ide native mode */
+			v08_09 |= 0x05;
+
+			/* enable primary ide */
+			v08_41 |= 0x80;
+
+			/* enable secondary ide */
+			v08_43 |= 0x80;
+
+			/*
+			 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
+			 *
+			 * This line of code is intended to provide the user with a work
+			 * around solution to the anomalies cited in SMSC's anomaly sheet
+			 * entitled, "SLC90E66 Functional Rev.J_0.1 Anomalies"".
+			 *
+			 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
+			 */
+			v08_5c |= 0x01;
+
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0x5c, v08_5c);
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0x04, v08_04);
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0x09, v08_09);
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0x41, v08_41);
+			early_write_config_byte(hose, busno, busno,
+						pci_devfn, 0x43, v08_43);
+		}
+
+	}
+
+	register_pci_controller(&tx4927_controller);
+	return 0;
+}
+
+arch_initcall(tx4927_pcibios_init);
+
+extern struct resource pci_io_resource;
+extern struct resource pci_mem_resource;
+
+void __init tx4927_pci_setup(void)
+{
+	static int called = 0;
+	extern unsigned int tx4927_get_mem_size(void);
+
+	mips_memory_upper = tx4927_get_mem_size() << 20;
+	mips_memory_upper += KSEG0;
+	mips_pci_io_base = TX4927_PCIIO;
+	mips_pci_io_size = TX4927_PCIIO_SIZE;
+	mips_pci_mem_base = TX4927_PCIMEM;
+	mips_pci_mem_size = TX4927_PCIMEM_SIZE;
+
+	if (!called) {
+		printk
+		    ("%s PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
+		     toshiba_name,
+		     (unsigned short) (tx4927_pcicptr->pciid >> 16),
+		     (unsigned short) (tx4927_pcicptr->pciid & 0xffff),
+		     (unsigned short) (tx4927_pcicptr->pciccrev & 0xff),
+		     (!(tx4927_ccfgptr->
+			ccfg & TX4927_CCFG_PCIXARB)) ? "External" :
+		     "Internal");
+		called = 1;
+	}
+	printk("%s PCIC --%s PCICLK:", toshiba_name,
+	       (tx4927_ccfgptr->ccfg & TX4927_CCFG_PCI66) ? " PCI66" : "");
+	if (tx4927_ccfgptr->pcfg & TX4927_PCFG_PCICLKEN_ALL) {
+		int pciclk = 0;
+		if (mips_machtype == MACH_TOSHIBA_RBTX4937)
+			switch ((unsigned long) tx4927_ccfgptr->
+				ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
+			case TX4937_CCFG_PCIDIVMODE_4:
+				pciclk = tx4927_cpu_clock / 4;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_4_5:
+				pciclk = tx4927_cpu_clock * 2 / 9;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_5:
+				pciclk = tx4927_cpu_clock / 5;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_5_5:
+				pciclk = tx4927_cpu_clock * 2 / 11;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_8:
+				pciclk = tx4927_cpu_clock / 8;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_9:
+				pciclk = tx4927_cpu_clock / 9;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_10:
+				pciclk = tx4927_cpu_clock / 10;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_11:
+				pciclk = tx4927_cpu_clock / 11;
+				break;
+			}
+
+		else
+			switch ((unsigned long) tx4927_ccfgptr->
+				ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
+			case TX4927_CCFG_PCIDIVMODE_2_5:
+				pciclk = tx4927_cpu_clock * 2 / 5;
+				break;
+			case TX4927_CCFG_PCIDIVMODE_3:
+				pciclk = tx4927_cpu_clock / 3;
+				break;
+			case TX4927_CCFG_PCIDIVMODE_5:
+				pciclk = tx4927_cpu_clock / 5;
+				break;
+			case TX4927_CCFG_PCIDIVMODE_6:
+				pciclk = tx4927_cpu_clock / 6;
+				break;
+			}
+
+		printk("Internal(%dMHz)", pciclk / 1000000);
+	} else
+		printk("External");
+	printk("\n");
+
+	/* GB->PCI mappings */
+	tx4927_pcicptr->g2piomask = (mips_pci_io_size - 1) >> 4;
+	tx4927_pcicptr->g2piogbase = mips_pci_io_base |
+#ifdef __BIG_ENDIAN
+	    TX4927_PCIC_G2PIOGBASE_ECHG
+#else
+	    TX4927_PCIC_G2PIOGBASE_BSDIS
+#endif
+	    ;
+
+	tx4927_pcicptr->g2piopbase = 0;
+
+	tx4927_pcicptr->g2pmmask[0] = (mips_pci_mem_size - 1) >> 4;
+	tx4927_pcicptr->g2pmgbase[0] = mips_pci_mem_base |
+#ifdef __BIG_ENDIAN
+	    TX4927_PCIC_G2PMnGBASE_ECHG
+#else
+	    TX4927_PCIC_G2PMnGBASE_BSDIS
+#endif
+	    ;
+	tx4927_pcicptr->g2pmpbase[0] = mips_pci_mem_base;
+
+	tx4927_pcicptr->g2pmmask[1] = 0;
+	tx4927_pcicptr->g2pmgbase[1] = 0;
+	tx4927_pcicptr->g2pmpbase[1] = 0;
+	tx4927_pcicptr->g2pmmask[2] = 0;
+	tx4927_pcicptr->g2pmgbase[2] = 0;
+	tx4927_pcicptr->g2pmpbase[2] = 0;
+
+
+	/* PCI->GB mappings (I/O 256B) */
+	tx4927_pcicptr->p2giopbase = 0;	/* 256B */
+
+	/* PCI->GB mappings (MEM 512MB) M0 gets all of memory */
+	tx4927_pcicptr->p2gm0plbase = 0;
+	tx4927_pcicptr->p2gm0pubase = 0;
+	tx4927_pcicptr->p2gmgbase[0] = 0 | TX4927_PCIC_P2GMnGBASE_TMEMEN |
+#ifdef __BIG_ENDIAN
+	    TX4927_PCIC_P2GMnGBASE_TECHG
+#else
+	    TX4927_PCIC_P2GMnGBASE_TBSDIS
+#endif
+	    ;
+
+	/* PCI->GB mappings (MEM 16MB) -not used */
+	tx4927_pcicptr->p2gm1plbase = 0xffffffff;
+	tx4927_pcicptr->p2gm1pubase = 0xffffffff;
+	tx4927_pcicptr->p2gmgbase[1] = 0;
+
+	/* PCI->GB mappings (MEM 1MB) -not used */
+	tx4927_pcicptr->p2gm2pbase = 0xffffffff;
+	tx4927_pcicptr->p2gmgbase[2] = 0;
+
+
+	/* Enable Initiator Memory 0 Space, I/O Space, Config */
+	tx4927_pcicptr->pciccfg &= TX4927_PCIC_PCICCFG_LBWC_MASK;
+	tx4927_pcicptr->pciccfg |=
+	    TX4927_PCIC_PCICCFG_IMSE0 | TX4927_PCIC_PCICCFG_IISE |
+	    TX4927_PCIC_PCICCFG_ICAE | TX4927_PCIC_PCICCFG_ATR;
+
+
+	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
+	tx4927_pcicptr->pcicfg1 = 0;
+
+	if (tx4927_pcic_trdyto >= 0) {
+		tx4927_pcicptr->g2ptocnt &= ~0xff;
+		tx4927_pcicptr->g2ptocnt |= (tx4927_pcic_trdyto & 0xff);
+	}
+
+	/* Clear All Local Bus Status */
+	tx4927_pcicptr->pcicstatus = TX4927_PCIC_PCICSTATUS_ALL;
+	/* Enable All Local Bus Interrupts */
+	tx4927_pcicptr->pcicmask = TX4927_PCIC_PCICSTATUS_ALL;
+	/* Clear All Initiator Status */
+	tx4927_pcicptr->g2pstatus = TX4927_PCIC_G2PSTATUS_ALL;
+	/* Enable All Initiator Interrupts */
+	tx4927_pcicptr->g2pmask = TX4927_PCIC_G2PSTATUS_ALL;
+	/* Clear All PCI Status Error */
+	tx4927_pcicptr->pcistatus =
+	    (tx4927_pcicptr->pcistatus & 0x0000ffff) |
+	    (TX4927_PCIC_PCISTATUS_ALL << 16);
+	/* Enable All PCI Status Error Interrupts */
+	tx4927_pcicptr->pcimask = TX4927_PCIC_PCISTATUS_ALL;
+
+	/* PCIC Int => IRC IRQ16 */
+	tx4927_pcicptr->pcicfg2 =
+	    (tx4927_pcicptr->pcicfg2 & 0xffffff00) | TX4927_IR_PCIC;
+
+	if (!(tx4927_ccfgptr->ccfg & TX4927_CCFG_PCIXARB)) {
+		/* XXX */
+	} else {
+		/* Reset Bus Arbiter */
+		tx4927_pcicptr->pbacfg = TX4927_PCIC_PBACFG_RPBA;
+		/* Enable Bus Arbiter */
+		tx4927_pcicptr->pbacfg = TX4927_PCIC_PBACFG_PBAEN;
+	}
+
+	tx4927_pcicptr->pcistatus = PCI_COMMAND_MASTER |
+	    PCI_COMMAND_MEMORY |
+	    PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+}
+#endif /* CONFIG_PCI */
+
+static void __noreturn wait_forever(void)
+{
+	while (1)
+		if (cpu_wait)
+			(*cpu_wait)();
+}
+
+void toshiba_rbtx4927_restart(char *command)
+{
+	printk(KERN_NOTICE "System Rebooting...\n");
+
+	/* enable the s/w reset register */
+	writeb(RBTX4927_SW_RESET_ENABLE_SET, RBTX4927_SW_RESET_ENABLE);
+
+	/* wait for enable to be seen */
+	while ((readb(RBTX4927_SW_RESET_ENABLE) &
+		RBTX4927_SW_RESET_ENABLE_SET) == 0x00);
+
+	/* do a s/w reset */
+	writeb(RBTX4927_SW_RESET_DO_SET, RBTX4927_SW_RESET_DO);
+
+	/* do something passive while waiting for reset */
+	local_irq_disable();
+	wait_forever();
+	/* no return */
+}
+
+void toshiba_rbtx4927_halt(void)
+{
+	printk(KERN_NOTICE "System Halted\n");
+	local_irq_disable();
+	wait_forever();
+	/* no return */
+}
+
+void toshiba_rbtx4927_power_off(void)
+{
+	toshiba_rbtx4927_halt();
+	/* no return */
+}
+
+void __init plat_mem_setup(void)
+{
+	int i;
+	u32 cp0_config;
+	char *argptr;
+
+	printk("CPU is %s\n", toshiba_name);
+
+	/* f/w leaves this on at startup */
+	clear_c0_status(ST0_ERL);
+
+	/* enable caches -- HCP5 does this, pmon does not */
+	cp0_config = read_c0_config();
+	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
+	write_c0_config(cp0_config);
+
+	set_io_port_base(KSEG1 + TBTX4927_ISA_IO_OFFSET);
+
+	ioport_resource.end = 0xffffffff;
+	iomem_resource.end = 0xffffffff;
+
+	_machine_restart = toshiba_rbtx4927_restart;
+	_machine_halt = toshiba_rbtx4927_halt;
+	pm_power_off = toshiba_rbtx4927_power_off;
+
+	for (i = 0; i < TX4927_NR_TMR; i++)
+		txx9_tmr_init(TX4927_TMR_REG(0) & 0xfffffffffULL);
+
+#ifdef CONFIG_PCI
+
+	/* PCIC */
+	/*
+	   * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
+	   *
+	   * For TX4927:
+	   * PCIDIVMODE[12:11]'s initial value is given by S9[4:3] (ON:0, OFF:1).
+	   * CPU 166MHz: PCI 66MHz : PCIDIVMODE: 00 (1/2.5)
+	   * CPU 200MHz: PCI 66MHz : PCIDIVMODE: 01 (1/3)
+	   * CPU 166MHz: PCI 33MHz : PCIDIVMODE: 10 (1/5)
+	   * CPU 200MHz: PCI 33MHz : PCIDIVMODE: 11 (1/6)
+	   * i.e. S9[3]: ON (83MHz), OFF (100MHz)
+	   *
+	   * For TX4937:
+	   * PCIDIVMODE[12:11]'s initial value is given by S1[5:4] (ON:0, OFF:1)
+	   * PCIDIVMODE[10] is 0.
+	   * CPU 266MHz: PCI 33MHz : PCIDIVMODE: 000 (1/8)
+	   * CPU 266MHz: PCI 66MHz : PCIDIVMODE: 001 (1/4)
+	   * CPU 300MHz: PCI 33MHz : PCIDIVMODE: 010 (1/9)
+	   * CPU 300MHz: PCI 66MHz : PCIDIVMODE: 011 (1/4.5)
+	   * CPU 333MHz: PCI 33MHz : PCIDIVMODE: 100 (1/10)
+	   * CPU 333MHz: PCI 66MHz : PCIDIVMODE: 101 (1/5)
+	   *
+	 */
+	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
+		switch ((unsigned long)tx4927_ccfgptr->
+			ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
+		case TX4937_CCFG_PCIDIVMODE_8:
+		case TX4937_CCFG_PCIDIVMODE_4:
+			tx4927_cpu_clock = 266666666;	/* 266MHz */
+			break;
+		case TX4937_CCFG_PCIDIVMODE_9:
+		case TX4937_CCFG_PCIDIVMODE_4_5:
+			tx4927_cpu_clock = 300000000;	/* 300MHz */
+			break;
+		default:
+			tx4927_cpu_clock = 333333333;	/* 333MHz */
+		}
+	else
+		switch ((unsigned long)tx4927_ccfgptr->
+			ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
+		case TX4927_CCFG_PCIDIVMODE_2_5:
+		case TX4927_CCFG_PCIDIVMODE_5:
+			tx4927_cpu_clock = 166666666;	/* 166MHz */
+			break;
+		default:
+			tx4927_cpu_clock = 200000000;	/* 200MHz */
+		}
+
+	/* CCFG */
+	/* do reset on watchdog */
+	tx4927_ccfgptr->ccfg |= TX4927_CCFG_WR;
+	/* enable Timeout BusError */
+	if (tx4927_ccfg_toeon)
+		tx4927_ccfgptr->ccfg |= TX4927_CCFG_TOE;
+
+	tx4927_pci_setup();
+	if (tx4927_using_backplane == 1)
+		printk("backplane board IS installed\n");
+	else
+		printk("No Backplane \n");
+
+	/* this is on ISA bus behind PCI bus, so need PCI up first */
+#ifdef CONFIG_TOSHIBA_FPCIB0
+	if (tx4927_using_backplane) {
+		smsc_fdc37m81x_init(0x3f0);
+		smsc_fdc37m81x_config_beg();
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
+					  SMSC_FDC37M81X_KBD);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
+					  1);
+		smsc_fdc37m81x_config_end();
+	}
+#endif
+#endif /* CONFIG_PCI */
+
+#ifdef CONFIG_SERIAL_TXX9
+	{
+		extern int early_serial_txx9_setup(struct uart_port *port);
+		struct uart_port req;
+		for(i = 0; i < 2; i++) {
+			memset(&req, 0, sizeof(req));
+			req.line = i;
+			req.iotype = UPIO_MEM;
+			req.membase = (char *)(0xff1ff300 + i * 0x100);
+			req.mapbase = 0xff1ff300 + i * 0x100;
+			req.irq = TX4927_IRQ_PIC_BEG + 8 + i;
+			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+			req.uartclk = 50000000;
+			early_serial_txx9_setup(&req);
+		}
+	}
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "console=") == NULL) {
+                strcat(argptr, " console=ttyS0,38400");
+        }
+#endif
+#endif
+
+#ifdef CONFIG_ROOT_NFS
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "root=") == NULL) {
+                strcat(argptr, " root=/dev/nfs rw");
+        }
+#endif
+
+#ifdef CONFIG_IP_PNP
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "ip=") == NULL) {
+                strcat(argptr, " ip=any");
+        }
+#endif
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = tx4927_cpu_clock / 2;
+	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + 17,
+				     50000000);
+}
+
+static int __init toshiba_rbtx4927_rtc_init(void)
+{
+	static struct resource __initdata res = {
+		.start	= 0x1c010000,
+		.end	= 0x1c010000 + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("rtc-ds1742", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(toshiba_rbtx4927_rtc_init);
+
+static int __init rbtx4927_ne_init(void)
+{
+	static struct resource __initdata res[] = {
+		{
+			.start	= RBTX4927_RTL_8019_BASE,
+			.end	= RBTX4927_RTL_8019_BASE + 0x20 - 1,
+			.flags	= IORESOURCE_IO,
+		}, {
+			.start	= RBTX4927_RTL_8019_IRQ,
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("ne", -1,
+						res, ARRAY_SIZE(res));
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(rbtx4927_ne_init);
+
+/* Watchdog support */
+
+static int __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("txx9wdt", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+
+static int __init rbtx4927_wdt_init(void)
+{
+	return txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
+}
+device_initcall(rbtx4927_wdt_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)50000000;
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/txx9/rbtx4938/Makefile b/arch/mips/txx9/rbtx4938/Makefile
new file mode 100644
index 0000000..9dcc52a
--- /dev/null
+++ b/arch/mips/txx9/rbtx4938/Makefile
@@ -0,0 +1,3 @@
+obj-y	+= prom.o setup.o irq.o spi_eeprom.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/rbtx4938/irq.c b/arch/mips/txx9/rbtx4938/irq.c
new file mode 100644
index 0000000..f498482
--- /dev/null
+++ b/arch/mips/txx9/rbtx4938/irq.c
@@ -0,0 +1,159 @@
+/*
+ * Toshiba RBTX4938 specific interrupt handlers
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+/*
+IRQ  Device
+
+16   TX4938-CP0/00 Software 0
+17   TX4938-CP0/01 Software 1
+18   TX4938-CP0/02 Cascade TX4938-CP0
+19   TX4938-CP0/03 Multiplexed -- do not use
+20   TX4938-CP0/04 Multiplexed -- do not use
+21   TX4938-CP0/05 Multiplexed -- do not use
+22   TX4938-CP0/06 Multiplexed -- do not use
+23   TX4938-CP0/07 CPU TIMER
+
+24   TX4938-PIC/00
+25   TX4938-PIC/01
+26   TX4938-PIC/02 Cascade RBTX4938-IOC
+27   TX4938-PIC/03 RBTX4938 RTL-8019AS Ethernet
+28   TX4938-PIC/04
+29   TX4938-PIC/05 TX4938 ETH1
+30   TX4938-PIC/06 TX4938 ETH0
+31   TX4938-PIC/07
+32   TX4938-PIC/08 TX4938 SIO 0
+33   TX4938-PIC/09 TX4938 SIO 1
+34   TX4938-PIC/10 TX4938 DMA0
+35   TX4938-PIC/11 TX4938 DMA1
+36   TX4938-PIC/12 TX4938 DMA2
+37   TX4938-PIC/13 TX4938 DMA3
+38   TX4938-PIC/14
+39   TX4938-PIC/15
+40   TX4938-PIC/16 TX4938 PCIC
+41   TX4938-PIC/17 TX4938 TMR0
+42   TX4938-PIC/18 TX4938 TMR1
+43   TX4938-PIC/19 TX4938 TMR2
+44   TX4938-PIC/20
+45   TX4938-PIC/21
+46   TX4938-PIC/22 TX4938 PCIERR
+47   TX4938-PIC/23
+48   TX4938-PIC/24
+49   TX4938-PIC/25
+50   TX4938-PIC/26
+51   TX4938-PIC/27
+52   TX4938-PIC/28
+53   TX4938-PIC/29
+54   TX4938-PIC/30
+55   TX4938-PIC/31 TX4938 SPI
+
+56 RBTX4938-IOC/00 PCI-D
+57 RBTX4938-IOC/01 PCI-C
+58 RBTX4938-IOC/02 PCI-B
+59 RBTX4938-IOC/03 PCI-A
+60 RBTX4938-IOC/04 RTC
+61 RBTX4938-IOC/05 ATA
+62 RBTX4938-IOC/06 MODEM
+63 RBTX4938-IOC/07 SWINT
+*/
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/txx9/rbtx4938.h>
+
+static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
+static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq);
+
+#define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
+static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
+	.name = TOSHIBA_RBTX4938_IOC_NAME,
+	.ack = toshiba_rbtx4938_irq_ioc_disable,
+	.mask = toshiba_rbtx4938_irq_ioc_disable,
+	.mask_ack = toshiba_rbtx4938_irq_ioc_disable,
+	.unmask = toshiba_rbtx4938_irq_ioc_enable,
+};
+
+int
+toshiba_rbtx4938_irq_nested(int sw_irq)
+{
+	u8 level3;
+
+	level3 = readb(rbtx4938_imstat_addr);
+	if (level3)
+		/* must use fls so onboard ATA has priority */
+		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + fls(level3) - 1;
+
+	return sw_irq;
+}
+
+static struct irqaction toshiba_rbtx4938_irq_ioc_action = {
+	.handler = no_action,
+	.flags = 0,
+	.mask = CPU_MASK_NONE,
+	.name = TOSHIBA_RBTX4938_IOC_NAME,
+};
+
+/**********************************************************************************/
+/* Functions for ioc                                                              */
+/**********************************************************************************/
+static void __init
+toshiba_rbtx4938_irq_ioc_init(void)
+{
+	int i;
+
+	for (i = TOSHIBA_RBTX4938_IRQ_IOC_BEG;
+	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++)
+		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
+					 handle_level_irq);
+
+	setup_irq(RBTX4938_IRQ_IOCINT,
+		  &toshiba_rbtx4938_irq_ioc_action);
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
+{
+	unsigned char v;
+
+	v = readb(rbtx4938_imask_addr);
+	v |= (1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
+	writeb(v, rbtx4938_imask_addr);
+	mmiowb();
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
+{
+	unsigned char v;
+
+	v = readb(rbtx4938_imask_addr);
+	v &= ~(1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
+	writeb(v, rbtx4938_imask_addr);
+	mmiowb();
+}
+
+void __init arch_init_irq(void)
+{
+	extern void tx4938_irq_init(void);
+
+	/* Now, interrupt control disabled, */
+	/* all IRC interrupts are masked, */
+	/* all IRC interrupt mode are Low Active. */
+
+	/* mask all IOC interrupts */
+	writeb(0, rbtx4938_imask_addr);
+
+	/* clear SoftInt interrupts */
+	writeb(0, rbtx4938_softint_addr);
+	tx4938_irq_init();
+	toshiba_rbtx4938_irq_ioc_init();
+	/* Onboard 10M Ether: High Active */
+	set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
+}
diff --git a/arch/mips/txx9/rbtx4938/prom.c b/arch/mips/txx9/rbtx4938/prom.c
new file mode 100644
index 0000000..134fcc2
--- /dev/null
+++ b/arch/mips/txx9/rbtx4938/prom.c
@@ -0,0 +1,72 @@
+/*
+ * rbtx4938 specific prom routines
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/txx9/tx4938.h>
+
+void __init prom_init_cmdline(void)
+{
+	int argc = (int) fw_arg0;
+	char **argv = (char **) fw_arg1;
+	int i;
+
+	/* ignore all built-in args if any f/w args given */
+	if (argc > 1) {
+		*arcs_cmdline = '\0';
+	}
+
+	for (i = 1; i < argc; i++) {
+		if (i != 1) {
+			strcat(arcs_cmdline, " ");
+		}
+		strcat(arcs_cmdline, argv[i]);
+	}
+}
+
+void __init prom_init(void)
+{
+	extern int tx4938_get_mem_size(void);
+	int msize;
+#ifndef CONFIG_TX4938_NAND_BOOT
+	prom_init_cmdline();
+#endif
+
+	msize = tx4938_get_mem_size();
+	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
+
+	return;
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
+{
+	return;
+}
+
+const char *get_system_type(void)
+{
+	return "Toshiba RBTX4938";
+}
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
new file mode 100644
index 0000000..bbd572c
--- /dev/null
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -0,0 +1,1122 @@
+/*
+ * Setup pointers to hardware-dependent routines.
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/console.h>
+#include <linux/pci.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/txx9tmr.h>
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/txx9/rbtx4938.h>
+#ifdef CONFIG_SERIAL_TXX9
+#include <linux/serial_core.h>
+#endif
+#include <linux/spi/spi.h>
+#include <asm/txx9/spi.h>
+#include <asm/txx9pio.h>
+
+extern char * __init prom_getcmdline(void);
+static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
+
+/* These functions are used for rebooting or halting the machine*/
+extern void rbtx4938_machine_restart(char *command);
+extern void rbtx4938_machine_halt(void);
+extern void rbtx4938_machine_power_off(void);
+
+/* clocks */
+unsigned int txx9_master_clock;
+unsigned int txx9_cpu_clock;
+unsigned int txx9_gbus_clock;
+
+unsigned long rbtx4938_ce_base[8];
+unsigned long rbtx4938_ce_size[8];
+int txboard_pci66_mode;
+static int tx4938_pcic_trdyto;	/* default: disabled */
+static int tx4938_pcic_retryto;	/* default: disabled */
+static int tx4938_ccfg_toeon = 1;
+
+struct tx4938_pcic_reg *pcicptrs[4] = {
+       tx4938_pcicptr  /* default setting for TX4938 */
+};
+
+static struct {
+	unsigned long base;
+	unsigned long size;
+} phys_regions[16] __initdata;
+static int num_phys_regions  __initdata;
+
+#define PHYS_REGION_MINSIZE	0x10000
+
+void rbtx4938_machine_halt(void)
+{
+        printk(KERN_NOTICE "System Halted\n");
+	local_irq_disable();
+
+	while (1)
+		__asm__(".set\tmips3\n\t"
+			"wait\n\t"
+			".set\tmips0");
+}
+
+void rbtx4938_machine_power_off(void)
+{
+        rbtx4938_machine_halt();
+        /* no return */
+}
+
+void rbtx4938_machine_restart(char *command)
+{
+	local_irq_disable();
+
+	printk("Rebooting...");
+	writeb(1, rbtx4938_softresetlock_addr);
+	writeb(1, rbtx4938_sfvol_addr);
+	writeb(1, rbtx4938_softreset_addr);
+	while(1)
+		;
+}
+
+void __init
+txboard_add_phys_region(unsigned long base, unsigned long size)
+{
+	if (num_phys_regions >= ARRAY_SIZE(phys_regions)) {
+		printk("phys_region overflow\n");
+		return;
+	}
+	phys_regions[num_phys_regions].base = base;
+	phys_regions[num_phys_regions].size = size;
+	num_phys_regions++;
+}
+unsigned long __init
+txboard_find_free_phys_region(unsigned long begin, unsigned long end,
+			      unsigned long size)
+{
+	unsigned long base;
+	int i;
+
+	for (base = begin / size * size; base < end; base += size) {
+		for (i = 0; i < num_phys_regions; i++) {
+			if (phys_regions[i].size &&
+			    base <= phys_regions[i].base + (phys_regions[i].size - 1) &&
+			    base + (size - 1) >= phys_regions[i].base)
+				break;
+		}
+		if (i == num_phys_regions)
+			return base;
+	}
+	return 0;
+}
+unsigned long __init
+txboard_find_free_phys_region_shrink(unsigned long begin, unsigned long end,
+				     unsigned long *size)
+{
+	unsigned long sz, base;
+	for (sz = *size; sz >= PHYS_REGION_MINSIZE; sz /= 2) {
+		base = txboard_find_free_phys_region(begin, end, sz);
+		if (base) {
+			*size = sz;
+			return base;
+		}
+	}
+	return 0;
+}
+unsigned long __init
+txboard_request_phys_region_range(unsigned long begin, unsigned long end,
+				  unsigned long size)
+{
+	unsigned long base;
+	base = txboard_find_free_phys_region(begin, end, size);
+	if (base)
+		txboard_add_phys_region(base, size);
+	return base;
+}
+unsigned long __init
+txboard_request_phys_region(unsigned long size)
+{
+	unsigned long base;
+	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
+	base = txboard_find_free_phys_region(begin, end, size);
+	if (base)
+		txboard_add_phys_region(base, size);
+	return base;
+}
+unsigned long __init
+txboard_request_phys_region_shrink(unsigned long *size)
+{
+	unsigned long base;
+	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
+	base = txboard_find_free_phys_region_shrink(begin, end, size);
+	if (base)
+		txboard_add_phys_region(base, *size);
+	return base;
+}
+
+#ifdef CONFIG_PCI
+void __init
+tx4938_pcic_setup(struct tx4938_pcic_reg *pcicptr,
+		  struct pci_controller *channel,
+		  unsigned long pci_io_base,
+		  int extarb)
+{
+	int i;
+
+	/* Disable All Initiator Space */
+	pcicptr->pciccfg &= ~(TX4938_PCIC_PCICCFG_G2PMEN(0)|
+			      TX4938_PCIC_PCICCFG_G2PMEN(1)|
+			      TX4938_PCIC_PCICCFG_G2PMEN(2)|
+			      TX4938_PCIC_PCICCFG_G2PIOEN);
+
+	/* GB->PCI mappings */
+	pcicptr->g2piomask = (channel->io_resource->end - channel->io_resource->start) >> 4;
+	pcicptr->g2piogbase = pci_io_base |
+#ifdef __BIG_ENDIAN
+		TX4938_PCIC_G2PIOGBASE_ECHG
+#else
+		TX4938_PCIC_G2PIOGBASE_BSDIS
+#endif
+		;
+	pcicptr->g2piopbase = 0;
+	for (i = 0; i < 3; i++) {
+		pcicptr->g2pmmask[i] = 0;
+		pcicptr->g2pmgbase[i] = 0;
+		pcicptr->g2pmpbase[i] = 0;
+	}
+	if (channel->mem_resource->end) {
+		pcicptr->g2pmmask[0] = (channel->mem_resource->end - channel->mem_resource->start) >> 4;
+		pcicptr->g2pmgbase[0] = channel->mem_resource->start |
+#ifdef __BIG_ENDIAN
+			TX4938_PCIC_G2PMnGBASE_ECHG
+#else
+			TX4938_PCIC_G2PMnGBASE_BSDIS
+#endif
+			;
+		pcicptr->g2pmpbase[0] = channel->mem_resource->start;
+	}
+	/* PCI->GB mappings (I/O 256B) */
+	pcicptr->p2giopbase = 0; /* 256B */
+	pcicptr->p2giogbase = 0;
+	/* PCI->GB mappings (MEM 512MB (64MB on R1.x)) */
+	pcicptr->p2gm0plbase = 0;
+	pcicptr->p2gm0pubase = 0;
+	pcicptr->p2gmgbase[0] = 0 |
+		TX4938_PCIC_P2GMnGBASE_TMEMEN |
+#ifdef __BIG_ENDIAN
+		TX4938_PCIC_P2GMnGBASE_TECHG
+#else
+		TX4938_PCIC_P2GMnGBASE_TBSDIS
+#endif
+		;
+	/* PCI->GB mappings (MEM 16MB) */
+	pcicptr->p2gm1plbase = 0xffffffff;
+	pcicptr->p2gm1pubase = 0xffffffff;
+	pcicptr->p2gmgbase[1] = 0;
+	/* PCI->GB mappings (MEM 1MB) */
+	pcicptr->p2gm2pbase = 0xffffffff; /* 1MB */
+	pcicptr->p2gmgbase[2] = 0;
+
+	pcicptr->pciccfg &= TX4938_PCIC_PCICCFG_GBWC_MASK;
+	/* Enable Initiator Memory Space */
+	if (channel->mem_resource->end)
+		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PMEN(0);
+	/* Enable Initiator I/O Space */
+	if (channel->io_resource->end)
+		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PIOEN;
+	/* Enable Initiator Config */
+	pcicptr->pciccfg |=
+		TX4938_PCIC_PCICCFG_ICAEN |
+		TX4938_PCIC_PCICCFG_TCAR;
+
+	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
+	pcicptr->pcicfg1 = 0;
+
+	pcicptr->g2ptocnt &= ~0xffff;
+
+	if (tx4938_pcic_trdyto >= 0) {
+		pcicptr->g2ptocnt &= ~0xff;
+		pcicptr->g2ptocnt |= (tx4938_pcic_trdyto & 0xff);
+	}
+
+	if (tx4938_pcic_retryto >= 0) {
+		pcicptr->g2ptocnt &= ~0xff00;
+		pcicptr->g2ptocnt |= ((tx4938_pcic_retryto<<8) & 0xff00);
+	}
+
+	/* Clear All Local Bus Status */
+	pcicptr->pcicstatus = TX4938_PCIC_PCICSTATUS_ALL;
+	/* Enable All Local Bus Interrupts */
+	pcicptr->pcicmask = TX4938_PCIC_PCICSTATUS_ALL;
+	/* Clear All Initiator Status */
+	pcicptr->g2pstatus = TX4938_PCIC_G2PSTATUS_ALL;
+	/* Enable All Initiator Interrupts */
+	pcicptr->g2pmask = TX4938_PCIC_G2PSTATUS_ALL;
+	/* Clear All PCI Status Error */
+	pcicptr->pcistatus =
+		(pcicptr->pcistatus & 0x0000ffff) |
+		(TX4938_PCIC_PCISTATUS_ALL << 16);
+	/* Enable All PCI Status Error Interrupts */
+	pcicptr->pcimask = TX4938_PCIC_PCISTATUS_ALL;
+
+	if (!extarb) {
+		/* Reset Bus Arbiter */
+		pcicptr->pbacfg = TX4938_PCIC_PBACFG_RPBA;
+		pcicptr->pbabm = 0;
+		/* Enable Bus Arbiter */
+		pcicptr->pbacfg = TX4938_PCIC_PBACFG_PBAEN;
+	}
+
+      /* PCIC Int => IRC IRQ16 */
+	pcicptr->pcicfg2 =
+		    (pcicptr->pcicfg2 & 0xffffff00) | TX4938_IR_PCIC;
+
+	pcicptr->pcistatus = PCI_COMMAND_MASTER |
+		PCI_COMMAND_MEMORY |
+		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+}
+
+int __init
+tx4938_report_pciclk(void)
+{
+	unsigned long pcode = TX4938_REV_PCODE();
+	int pciclk = 0;
+	printk("TX%lx PCIC --%s PCICLK:",
+	       pcode,
+	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) ? " PCI66" : "");
+	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
+
+		switch ((unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK) {
+		case TX4938_CCFG_PCIDIVMODE_4:
+			pciclk = txx9_cpu_clock / 4; break;
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			pciclk = txx9_cpu_clock * 2 / 9; break;
+		case TX4938_CCFG_PCIDIVMODE_5:
+			pciclk = txx9_cpu_clock / 5; break;
+		case TX4938_CCFG_PCIDIVMODE_5_5:
+			pciclk = txx9_cpu_clock * 2 / 11; break;
+		case TX4938_CCFG_PCIDIVMODE_8:
+			pciclk = txx9_cpu_clock / 8; break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+			pciclk = txx9_cpu_clock / 9; break;
+		case TX4938_CCFG_PCIDIVMODE_10:
+			pciclk = txx9_cpu_clock / 10; break;
+		case TX4938_CCFG_PCIDIVMODE_11:
+			pciclk = txx9_cpu_clock / 11; break;
+		}
+		printk("Internal(%dMHz)", pciclk / 1000000);
+	} else {
+		printk("External");
+		pciclk = -1;
+	}
+	printk("\n");
+	return pciclk;
+}
+
+void __init set_tx4938_pcicptr(int ch, struct tx4938_pcic_reg *pcicptr)
+{
+	pcicptrs[ch] = pcicptr;
+}
+
+struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch)
+{
+       return pcicptrs[ch];
+}
+
+static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
+                                    int top_bus, int busnr, int devfn)
+{
+	static struct pci_dev dev;
+	static struct pci_bus bus;
+
+	dev.sysdata = bus.sysdata = hose;
+	dev.devfn = devfn;
+	bus.number = busnr;
+	bus.ops = hose->pci_ops;
+	bus.parent = NULL;
+	dev.bus = &bus;
+
+	return &dev;
+}
+
+#define EARLY_PCI_OP(rw, size, type)                                    \
+static int early_##rw##_config_##size(struct pci_controller *hose,      \
+        int top_bus, int bus, int devfn, int offset, type value)        \
+{                                                                       \
+        return pci_##rw##_config_##size(                                \
+                fake_pci_dev(hose, top_bus, bus, devfn),                \
+                offset, value);                                         \
+}
+
+EARLY_PCI_OP(read, word, u16 *)
+
+int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bus)
+{
+	u32 pci_devfn;
+	unsigned short vid;
+	int devfn_start = 0;
+	int devfn_stop = 0xff;
+	int cap66 = -1;
+	u16 stat;
+
+	printk("PCI: Checking 66MHz capabilities...\n");
+
+	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
+		if (early_read_config_word(hose, top_bus, current_bus,
+					   pci_devfn, PCI_VENDOR_ID,
+					   &vid) != PCIBIOS_SUCCESSFUL)
+			continue;
+
+		if (vid == 0xffff) continue;
+
+		/* check 66MHz capability */
+		if (cap66 < 0)
+			cap66 = 1;
+		if (cap66) {
+			early_read_config_word(hose, top_bus, current_bus, pci_devfn,
+					       PCI_STATUS, &stat);
+			if (!(stat & PCI_STATUS_66MHZ)) {
+				printk(KERN_DEBUG "PCI: %02x:%02x not 66MHz capable.\n",
+				       current_bus, pci_devfn);
+				cap66 = 0;
+				break;
+			}
+		}
+	}
+	return cap66 > 0;
+}
+
+int __init
+tx4938_pciclk66_setup(void)
+{
+	int pciclk;
+
+	/* Assert M66EN */
+	tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI66;
+	/* Double PCICLK (if possible) */
+	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
+		unsigned int pcidivmode =
+			tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK;
+		switch (pcidivmode) {
+		case TX4938_CCFG_PCIDIVMODE_8:
+		case TX4938_CCFG_PCIDIVMODE_4:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_4;
+			pciclk = txx9_cpu_clock / 4;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_4_5;
+			pciclk = txx9_cpu_clock * 2 / 9;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_10:
+		case TX4938_CCFG_PCIDIVMODE_5:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_5;
+			pciclk = txx9_cpu_clock / 5;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_11:
+		case TX4938_CCFG_PCIDIVMODE_5_5:
+		default:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_5_5;
+			pciclk = txx9_cpu_clock * 2 / 11;
+			break;
+		}
+		tx4938_ccfgptr->ccfg =
+			(tx4938_ccfgptr->ccfg & ~TX4938_CCFG_PCIDIVMODE_MASK)
+			| pcidivmode;
+		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
+		       (unsigned long)tx4938_ccfgptr->ccfg);
+	} else {
+		pciclk = -1;
+	}
+	return pciclk;
+}
+
+extern struct pci_controller tx4938_pci_controller[];
+static int __init tx4938_pcibios_init(void)
+{
+	unsigned long mem_base[2];
+	unsigned long mem_size[2] = {TX4938_PCIMEM_SIZE_0, TX4938_PCIMEM_SIZE_1}; /* MAX 128M,64K */
+	unsigned long io_base[2];
+	unsigned long io_size[2] = {TX4938_PCIIO_SIZE_0, TX4938_PCIIO_SIZE_1}; /* MAX 16M,64K */
+	/* TX4938 PCIC1: 64K MEM/IO is enough for ETH0,ETH1 */
+	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
+
+	PCIBIOS_MIN_IO = 0x00001000UL;
+
+	mem_base[0] = txboard_request_phys_region_shrink(&mem_size[0]);
+	io_base[0] = txboard_request_phys_region_shrink(&io_size[0]);
+
+	printk("TX4938 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
+	       (unsigned short)(tx4938_pcicptr->pciid >> 16),
+	       (unsigned short)(tx4938_pcicptr->pciid & 0xffff),
+	       (unsigned short)(tx4938_pcicptr->pciccrev & 0xff),
+	       extarb ? "External" : "Internal");
+
+	/* setup PCI area */
+	tx4938_pci_controller[0].io_resource->start = io_base[0];
+	tx4938_pci_controller[0].io_resource->end = (io_base[0] + io_size[0]) - 1;
+	tx4938_pci_controller[0].mem_resource->start = mem_base[0];
+	tx4938_pci_controller[0].mem_resource->end = mem_base[0] + mem_size[0] - 1;
+
+	set_tx4938_pcicptr(0, tx4938_pcicptr);
+
+	register_pci_controller(&tx4938_pci_controller[0]);
+
+	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) {
+		printk("TX4938_CCFG_PCI66 already configured\n");
+		txboard_pci66_mode = -1; /* already configured */
+	}
+
+	/* Reset PCI Bus */
+	writeb(0, rbtx4938_pcireset_addr);
+	/* Reset PCIC */
+	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
+	if (txboard_pci66_mode > 0)
+		tx4938_pciclk66_setup();
+	mdelay(10);
+	/* clear PCIC reset */
+	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
+	writeb(1, rbtx4938_pcireset_addr);
+	mmiowb();
+	tx4938_report_pcic_status1(tx4938_pcicptr);
+
+	tx4938_report_pciclk();
+	tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
+	if (txboard_pci66_mode == 0 &&
+	    txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
+		/* Reset PCI Bus */
+		writeb(0, rbtx4938_pcireset_addr);
+		/* Reset PCIC */
+		tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
+		tx4938_pciclk66_setup();
+		mdelay(10);
+		/* clear PCIC reset */
+		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
+		writeb(1, rbtx4938_pcireset_addr);
+		mmiowb();
+		/* Reinitialize PCIC */
+		tx4938_report_pciclk();
+		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
+	}
+
+	mem_base[1] = txboard_request_phys_region_shrink(&mem_size[1]);
+	io_base[1] = txboard_request_phys_region_shrink(&io_size[1]);
+	/* Reset PCIC1 */
+	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIC1RST;
+	/* PCI1DMD==0 => PCI1CLK==GBUSCLK/2 => PCI66 */
+	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD))
+		tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI1_66;
+	else
+		tx4938_ccfgptr->ccfg &= ~TX4938_CCFG_PCI1_66;
+	mdelay(10);
+	/* clear PCIC1 reset */
+	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
+	tx4938_report_pcic_status1(tx4938_pcic1ptr);
+
+	printk("TX4938 PCIC1 -- DID:%04x VID:%04x RID:%02x",
+	       (unsigned short)(tx4938_pcic1ptr->pciid >> 16),
+	       (unsigned short)(tx4938_pcic1ptr->pciid & 0xffff),
+	       (unsigned short)(tx4938_pcic1ptr->pciccrev & 0xff));
+	printk("%s PCICLK:%dMHz\n",
+	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1_66) ? " PCI66" : "",
+	       txx9_gbus_clock /
+	       ((tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD) ? 4 : 2) /
+	       1000000);
+
+	/* assumption: CPHYSADDR(mips_io_port_base) == io_base[0] */
+	tx4938_pci_controller[1].io_resource->start =
+		io_base[1] - io_base[0];
+	tx4938_pci_controller[1].io_resource->end =
+		io_base[1] - io_base[0] + io_size[1] - 1;
+	tx4938_pci_controller[1].mem_resource->start = mem_base[1];
+	tx4938_pci_controller[1].mem_resource->end =
+		mem_base[1] + mem_size[1] - 1;
+	set_tx4938_pcicptr(1, tx4938_pcic1ptr);
+
+	register_pci_controller(&tx4938_pci_controller[1]);
+
+	tx4938_pcic_setup(tx4938_pcic1ptr, &tx4938_pci_controller[1], io_base[1], extarb);
+
+	/* map ioport 0 to PCI I/O space address 0 */
+	set_io_port_base(KSEG1 + io_base[0]);
+
+	return 0;
+}
+
+arch_initcall(tx4938_pcibios_init);
+
+#endif /* CONFIG_PCI */
+
+/* SPI support */
+
+/* chip select for SPI devices */
+#define	SEEPROM1_CS	7	/* PIO7 */
+#define	SEEPROM2_CS	0	/* IOC */
+#define	SEEPROM3_CS	1	/* IOC */
+#define	SRTC_CS	2	/* IOC */
+
+#ifdef CONFIG_PCI
+static int __init rbtx4938_ethaddr_init(void)
+{
+	unsigned char dat[17];
+	unsigned char sum;
+	int i;
+
+	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
+	if (spi_eeprom_read(SEEPROM1_CS, 0, dat, sizeof(dat))) {
+		printk(KERN_ERR "seeprom: read error.\n");
+		return -ENODEV;
+	} else {
+		if (strcmp(dat, "MAC") != 0)
+			printk(KERN_WARNING "seeprom: bad signature.\n");
+		for (i = 0, sum = 0; i < sizeof(dat); i++)
+			sum += dat[i];
+		if (sum)
+			printk(KERN_WARNING "seeprom: bad checksum.\n");
+	}
+	for (i = 0; i < 2; i++) {
+		unsigned int id =
+			TXX9_IRQ_BASE + (i ? TX4938_IR_ETH1 : TX4938_IR_ETH0);
+		struct platform_device *pdev;
+		if (!(tx4938_ccfgptr->pcfg &
+		      (i ? TX4938_PCFG_ETH1_SEL : TX4938_PCFG_ETH0_SEL)))
+			continue;
+		pdev = platform_device_alloc("tc35815-mac", id);
+		if (!pdev ||
+		    platform_device_add_data(pdev, &dat[4 + 6 * i], 6) ||
+		    platform_device_add(pdev))
+			platform_device_put(pdev);
+	}
+	return 0;
+}
+device_initcall(rbtx4938_ethaddr_init);
+#endif /* CONFIG_PCI */
+
+static void __init rbtx4938_spi_setup(void)
+{
+	/* set SPI_SEL */
+	tx4938_ccfgptr->pcfg |= TX4938_PCFG_SPI_SEL;
+}
+
+static struct resource rbtx4938_fpga_resource;
+
+static char pcode_str[8];
+static struct resource tx4938_reg_resource = {
+	.start	= TX4938_REG_BASE,
+	.end	= TX4938_REG_BASE + TX4938_REG_SIZE,
+	.name	= pcode_str,
+	.flags	= IORESOURCE_MEM
+};
+
+void __init tx4938_board_setup(void)
+{
+	int i;
+	unsigned long divmode;
+	int cpuclk = 0;
+	unsigned long pcode = TX4938_REV_PCODE();
+
+	ioport_resource.start = 0x1000;
+	ioport_resource.end = 0xffffffff;
+	iomem_resource.start = 0x1000;
+	iomem_resource.end = 0xffffffff;	/* expand to 4GB */
+
+	sprintf(pcode_str, "TX%lx", pcode);
+	/* SDRAMC,EBUSC are configured by PROM */
+	for (i = 0; i < 8; i++) {
+		if (!(tx4938_ebuscptr->cr[i] & 0x8))
+			continue;	/* disabled */
+		rbtx4938_ce_base[i] = (unsigned long)TX4938_EBUSC_BA(i);
+		txboard_add_phys_region(rbtx4938_ce_base[i], TX4938_EBUSC_SIZE(i));
+	}
+
+	/* clocks */
+	if (txx9_master_clock) {
+		/* calculate gbus_clock and cpu_clock_freq from master_clock */
+		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_8:
+		case TX4938_CCFG_DIVMODE_10:
+		case TX4938_CCFG_DIVMODE_12:
+		case TX4938_CCFG_DIVMODE_16:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_gbus_clock = txx9_master_clock * 4; break;
+		default:
+			txx9_gbus_clock = txx9_master_clock;
+		}
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_2:
+		case TX4938_CCFG_DIVMODE_8:
+			cpuclk = txx9_gbus_clock * 2; break;
+		case TX4938_CCFG_DIVMODE_2_5:
+		case TX4938_CCFG_DIVMODE_10:
+			cpuclk = txx9_gbus_clock * 5 / 2; break;
+		case TX4938_CCFG_DIVMODE_3:
+		case TX4938_CCFG_DIVMODE_12:
+			cpuclk = txx9_gbus_clock * 3; break;
+		case TX4938_CCFG_DIVMODE_4:
+		case TX4938_CCFG_DIVMODE_16:
+			cpuclk = txx9_gbus_clock * 4; break;
+		case TX4938_CCFG_DIVMODE_4_5:
+		case TX4938_CCFG_DIVMODE_18:
+			cpuclk = txx9_gbus_clock * 9 / 2; break;
+		}
+		txx9_cpu_clock = cpuclk;
+	} else {
+		if (txx9_cpu_clock == 0) {
+			txx9_cpu_clock = 300000000;	/* 300MHz */
+		}
+		/* calculate gbus_clock and master_clock from cpu_clock_freq */
+		cpuclk = txx9_cpu_clock;
+		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_2:
+		case TX4938_CCFG_DIVMODE_8:
+			txx9_gbus_clock = cpuclk / 2; break;
+		case TX4938_CCFG_DIVMODE_2_5:
+		case TX4938_CCFG_DIVMODE_10:
+			txx9_gbus_clock = cpuclk * 2 / 5; break;
+		case TX4938_CCFG_DIVMODE_3:
+		case TX4938_CCFG_DIVMODE_12:
+			txx9_gbus_clock = cpuclk / 3; break;
+		case TX4938_CCFG_DIVMODE_4:
+		case TX4938_CCFG_DIVMODE_16:
+			txx9_gbus_clock = cpuclk / 4; break;
+		case TX4938_CCFG_DIVMODE_4_5:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_gbus_clock = cpuclk * 2 / 9; break;
+		}
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_8:
+		case TX4938_CCFG_DIVMODE_10:
+		case TX4938_CCFG_DIVMODE_12:
+		case TX4938_CCFG_DIVMODE_16:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_master_clock = txx9_gbus_clock / 4; break;
+		default:
+			txx9_master_clock = txx9_gbus_clock;
+		}
+	}
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
+	/* CCFG */
+	/* clear WatchDogReset,BusErrorOnWrite flag (W1C) */
+	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WDRST | TX4938_CCFG_BEOW;
+	/* do reset on watchdog */
+	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WR;
+	/* clear PCIC1 reset */
+	if (tx4938_ccfgptr->clkctr & TX4938_CLKCTR_PCIC1RST)
+		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
+
+	/* enable Timeout BusError */
+	if (tx4938_ccfg_toeon)
+		tx4938_ccfgptr->ccfg |= TX4938_CCFG_TOE;
+
+	/* DMA selection */
+	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_DMASEL_ALL;
+
+	/* Use external clock for external arbiter */
+	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB))
+		tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_PCICLKEN_ALL;
+
+	printk("%s -- %dMHz(M%dMHz) CRIR:%08lx CCFG:%Lx PCFG:%Lx\n",
+	       pcode_str,
+	       cpuclk / 1000000, txx9_master_clock / 1000000,
+	       (unsigned long)tx4938_ccfgptr->crir,
+	       tx4938_ccfgptr->ccfg,
+	       tx4938_ccfgptr->pcfg);
+
+	printk("%s SDRAMC --", pcode_str);
+	for (i = 0; i < 4; i++) {
+		unsigned long long cr = tx4938_sdramcptr->cr[i];
+		unsigned long ram_base, ram_size;
+		if (!((unsigned long)cr & 0x00000400))
+			continue;	/* disabled */
+		ram_base = (unsigned long)(cr >> 49) << 21;
+		ram_size = ((unsigned long)(cr >> 33) + 1) << 21;
+		if (ram_base >= 0x20000000)
+			continue;	/* high memory (ignore) */
+		printk(" CR%d:%016Lx", i, cr);
+		txboard_add_phys_region(ram_base, ram_size);
+	}
+	printk(" TR:%09Lx\n", tx4938_sdramcptr->tr);
+
+	/* SRAM */
+	if (pcode == 0x4938 && tx4938_sramcptr->cr & 1) {
+		unsigned int size = 0x800;
+		unsigned long base =
+			(tx4938_sramcptr->cr >> (39-11)) & ~(size - 1);
+		 txboard_add_phys_region(base, size);
+	}
+
+	/* TMR */
+	for (i = 0; i < TX4938_NR_TMR; i++)
+		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
+
+	/* enable DMA */
+	for (i = 0; i < 2; i++)
+		____raw_writeq(TX4938_DMA_MCR_MSTEN,
+			       (void __iomem *)(TX4938_DMA_REG(i) + 0x50));
+
+	/* PIO */
+	__raw_writel(0, &tx4938_pioptr->maskcpu);
+	__raw_writel(0, &tx4938_pioptr->maskext);
+
+	/* TX4938 internal registers */
+	if (request_resource(&iomem_resource, &tx4938_reg_resource))
+		printk("request resource for internal registers failed\n");
+}
+
+#ifdef CONFIG_PCI
+static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr)
+{
+	unsigned short pcistatus = (unsigned short)(pcicptr->pcistatus >> 16);
+	unsigned long g2pstatus = pcicptr->g2pstatus;
+	unsigned long pcicstatus = pcicptr->pcicstatus;
+	static struct {
+		unsigned long flag;
+		const char *str;
+	} pcistat_tbl[] = {
+		{ PCI_STATUS_DETECTED_PARITY,	"DetectedParityError" },
+		{ PCI_STATUS_SIG_SYSTEM_ERROR,	"SignaledSystemError" },
+		{ PCI_STATUS_REC_MASTER_ABORT,	"ReceivedMasterAbort" },
+		{ PCI_STATUS_REC_TARGET_ABORT,	"ReceivedTargetAbort" },
+		{ PCI_STATUS_SIG_TARGET_ABORT,	"SignaledTargetAbort" },
+		{ PCI_STATUS_PARITY,	"MasterParityError" },
+	}, g2pstat_tbl[] = {
+		{ TX4938_PCIC_G2PSTATUS_TTOE,	"TIOE" },
+		{ TX4938_PCIC_G2PSTATUS_RTOE,	"RTOE" },
+	}, pcicstat_tbl[] = {
+		{ TX4938_PCIC_PCICSTATUS_PME,	"PME" },
+		{ TX4938_PCIC_PCICSTATUS_TLB,	"TLB" },
+		{ TX4938_PCIC_PCICSTATUS_NIB,	"NIB" },
+		{ TX4938_PCIC_PCICSTATUS_ZIB,	"ZIB" },
+		{ TX4938_PCIC_PCICSTATUS_PERR,	"PERR" },
+		{ TX4938_PCIC_PCICSTATUS_SERR,	"SERR" },
+		{ TX4938_PCIC_PCICSTATUS_GBE,	"GBE" },
+		{ TX4938_PCIC_PCICSTATUS_IWB,	"IWB" },
+	};
+	int i;
+
+	printk("pcistat:%04x(", pcistatus);
+	for (i = 0; i < ARRAY_SIZE(pcistat_tbl); i++)
+		if (pcistatus & pcistat_tbl[i].flag)
+			printk("%s ", pcistat_tbl[i].str);
+	printk("), g2pstatus:%08lx(", g2pstatus);
+	for (i = 0; i < ARRAY_SIZE(g2pstat_tbl); i++)
+		if (g2pstatus & g2pstat_tbl[i].flag)
+			printk("%s ", g2pstat_tbl[i].str);
+	printk("), pcicstatus:%08lx(", pcicstatus);
+	for (i = 0; i < ARRAY_SIZE(pcicstat_tbl); i++)
+		if (pcicstatus & pcicstat_tbl[i].flag)
+			printk("%s ", pcicstat_tbl[i].str);
+	printk(")\n");
+}
+
+void tx4938_report_pcic_status(void)
+{
+	int i;
+	struct tx4938_pcic_reg *pcicptr;
+	for (i = 0; (pcicptr = get_tx4938_pcicptr(i)) != NULL; i++)
+		tx4938_report_pcic_status1(pcicptr);
+}
+
+#endif /* CONFIG_PCI */
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = txx9_cpu_clock / 2;
+	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4938_TMR_REG(0) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + TX4938_IR_TMR(0),
+				     txx9_gbus_clock / 2);
+}
+
+void __init plat_mem_setup(void)
+{
+	unsigned long long pcfg;
+	char *argptr;
+
+	iomem_resource.end = 0xffffffff;	/* 4GB */
+
+	if (txx9_master_clock == 0)
+		txx9_master_clock = 25000000; /* 25MHz */
+	tx4938_board_setup();
+#ifndef CONFIG_PCI
+	set_io_port_base(RBTX4938_ETHER_BASE);
+#endif
+
+#ifdef CONFIG_SERIAL_TXX9
+	{
+		extern int early_serial_txx9_setup(struct uart_port *port);
+		int i;
+		struct uart_port req;
+		for(i = 0; i < 2; i++) {
+			memset(&req, 0, sizeof(req));
+			req.line = i;
+			req.iotype = UPIO_MEM;
+			req.membase = (char *)(0xff1ff300 + i * 0x100);
+			req.mapbase = 0xff1ff300 + i * 0x100;
+			req.irq = RBTX4938_IRQ_IRC_SIO(i);
+			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+			req.uartclk = 50000000;
+			early_serial_txx9_setup(&req);
+		}
+	}
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "console=") == NULL) {
+                strcat(argptr, " console=ttyS0,38400");
+        }
+#endif
+#endif
+
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
+	printk("PIOSEL: disabling both ata and nand selection\n");
+	local_irq_disable();
+	tx4938_ccfgptr->pcfg &= ~(TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
+#endif
+
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
+	printk("PIOSEL: enabling nand selection\n");
+	tx4938_ccfgptr->pcfg |= TX4938_PCFG_NDF_SEL;
+	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_ATA_SEL;
+#endif
+
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
+	printk("PIOSEL: enabling ata selection\n");
+	tx4938_ccfgptr->pcfg |= TX4938_PCFG_ATA_SEL;
+	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_NDF_SEL;
+#endif
+
+#ifdef CONFIG_IP_PNP
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "ip=") == NULL) {
+		strcat(argptr, " ip=any");
+	}
+#endif
+
+
+#ifdef CONFIG_FB
+	{
+		conswitchp = &dummy_con;
+	}
+#endif
+
+	rbtx4938_spi_setup();
+	pcfg = tx4938_ccfgptr->pcfg;	/* updated */
+	/* fixup piosel */
+	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
+	    TX4938_PCFG_ATA_SEL)
+		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x04,
+		       rbtx4938_piosel_addr);
+	else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
+		 TX4938_PCFG_NDF_SEL)
+		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x08,
+		       rbtx4938_piosel_addr);
+	else
+		writeb(readb(rbtx4938_piosel_addr) & ~(0x08 | 0x04),
+		       rbtx4938_piosel_addr);
+
+	rbtx4938_fpga_resource.name = "FPGA Registers";
+	rbtx4938_fpga_resource.start = CPHYSADDR(RBTX4938_FPGA_REG_ADDR);
+	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
+	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	if (request_resource(&iomem_resource, &rbtx4938_fpga_resource))
+		printk("request resource for fpga failed\n");
+
+	_machine_restart = rbtx4938_machine_restart;
+	_machine_halt = rbtx4938_machine_halt;
+	pm_power_off = rbtx4938_machine_power_off;
+
+	writeb(0xff, rbtx4938_led_addr);
+	printk(KERN_INFO "RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
+	       readb(rbtx4938_fpga_rev_addr),
+	       readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
+}
+
+static int __init rbtx4938_ne_init(void)
+{
+	struct resource res[] = {
+		{
+			.start	= RBTX4938_RTL_8019_BASE,
+			.end	= RBTX4938_RTL_8019_BASE + 0x20 - 1,
+			.flags	= IORESOURCE_IO,
+		}, {
+			.start	= RBTX4938_RTL_8019_IRQ,
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("ne", -1,
+						res, ARRAY_SIZE(res));
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+device_initcall(rbtx4938_ne_init);
+
+/* GPIO support */
+
+int gpio_to_irq(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+
+static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
+
+static void rbtx4938_spi_gpio_set(struct gpio_chip *chip, unsigned int offset,
+				  int value)
+{
+	u8 val;
+	unsigned long flags;
+	spin_lock_irqsave(&rbtx4938_spi_gpio_lock, flags);
+	val = readb(rbtx4938_spics_addr);
+	if (value)
+		val |= 1 << offset;
+	else
+		val &= ~(1 << offset);
+	writeb(val, rbtx4938_spics_addr);
+	mmiowb();
+	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
+}
+
+static int rbtx4938_spi_gpio_dir_out(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	rbtx4938_spi_gpio_set(chip, offset, value);
+	return 0;
+}
+
+static struct gpio_chip rbtx4938_spi_gpio_chip = {
+	.set = rbtx4938_spi_gpio_set,
+	.direction_output = rbtx4938_spi_gpio_dir_out,
+	.label = "RBTX4938-SPICS",
+	.base = 16,
+	.ngpio = 3,
+};
+
+/* SPI support */
+
+static void __init txx9_spi_init(unsigned long base, int irq)
+{
+	struct resource res[] = {
+		{
+			.start	= base,
+			.end	= base + 0x20 - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= irq,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+	platform_device_register_simple("spi_txx9", 0,
+					res, ARRAY_SIZE(res));
+}
+
+static int __init rbtx4938_spi_init(void)
+{
+	struct spi_board_info srtc_info = {
+		.modalias = "rtc-rs5c348",
+		.max_speed_hz = 1000000, /* 1.0Mbps @ Vdd 2.0V */
+		.bus_num = 0,
+		.chip_select = 16 + SRTC_CS,
+		/* Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS  */
+		.mode = SPI_MODE_1 | SPI_CS_HIGH,
+	};
+	spi_register_board_info(&srtc_info, 1);
+	spi_eeprom_register(SEEPROM1_CS);
+	spi_eeprom_register(16 + SEEPROM2_CS);
+	spi_eeprom_register(16 + SEEPROM3_CS);
+	gpio_request(16 + SRTC_CS, "rtc-rs5c348");
+	gpio_direction_output(16 + SRTC_CS, 0);
+	gpio_request(SEEPROM1_CS, "seeprom1");
+	gpio_direction_output(SEEPROM1_CS, 1);
+	gpio_request(16 + SEEPROM2_CS, "seeprom2");
+	gpio_direction_output(16 + SEEPROM2_CS, 1);
+	gpio_request(16 + SEEPROM3_CS, "seeprom3");
+	gpio_direction_output(16 + SEEPROM3_CS, 1);
+	txx9_spi_init(TX4938_SPI_REG & 0xfffffffffULL, RBTX4938_IRQ_IRC_SPI);
+	return 0;
+}
+
+static int __init rbtx4938_arch_init(void)
+{
+	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, 16);
+	gpiochip_add(&rbtx4938_spi_gpio_chip);
+	return rbtx4938_spi_init();
+}
+arch_initcall(rbtx4938_arch_init);
+
+/* Watchdog support */
+
+static int __init txx9_wdt_init(unsigned long base)
+{
+	struct resource res = {
+		.start	= base,
+		.end	= base + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	struct platform_device *dev =
+		platform_device_register_simple("txx9wdt", -1, &res, 1);
+	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+}
+
+static int __init rbtx4938_wdt_init(void)
+{
+	return txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
+}
+device_initcall(rbtx4938_wdt_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "spi-baseclk"))
+		return (struct clk *)(txx9_gbus_clock / 2 / 4);
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)(txx9_gbus_clock / 2);
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/txx9/rbtx4938/spi_eeprom.c b/arch/mips/txx9/rbtx4938/spi_eeprom.c
new file mode 100644
index 0000000..a7ea8b0
--- /dev/null
+++ b/arch/mips/txx9/rbtx4938/spi_eeprom.c
@@ -0,0 +1,99 @@
+/*
+ * spi_eeprom.c
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
+#include <asm/txx9/spi.h>
+
+#define AT250X0_PAGE_SIZE	8
+
+/* register board information for at25 driver */
+int __init spi_eeprom_register(int chipid)
+{
+	static struct spi_eeprom eeprom = {
+		.name = "at250x0",
+		.byte_len = 128,
+		.page_size = AT250X0_PAGE_SIZE,
+		.flags = EE_ADDR1,
+	};
+	struct spi_board_info info = {
+		.modalias = "at25",
+		.max_speed_hz = 1500000,	/* 1.5Mbps */
+		.bus_num = 0,
+		.chip_select = chipid,
+		.platform_data = &eeprom,
+		/* Mode 0: High-Active, Sample-Then-Shift */
+	};
+
+	return spi_register_board_info(&info, 1);
+}
+
+/* simple temporary spi driver to provide early access to seeprom. */
+
+static struct read_param {
+	int chipid;
+	int address;
+	unsigned char *buf;
+	int len;
+} *read_param;
+
+static int __init early_seeprom_probe(struct spi_device *spi)
+{
+	int stat = 0;
+	u8 cmd[2];
+	int len = read_param->len;
+	char *buf = read_param->buf;
+	int address = read_param->address;
+
+	dev_info(&spi->dev, "spiclk %u KHz.\n",
+		 (spi->max_speed_hz + 500) / 1000);
+	if (read_param->chipid != spi->chip_select)
+		return -ENODEV;
+	while (len > 0) {
+		/* spi_write_then_read can only work with small chunk */
+		int c = len < AT250X0_PAGE_SIZE ? len : AT250X0_PAGE_SIZE;
+		cmd[0] = 0x03;	/* AT25_READ */
+		cmd[1] = address;
+		stat = spi_write_then_read(spi, cmd, sizeof(cmd), buf, c);
+		buf += c;
+		len -= c;
+		address += c;
+	}
+	return stat;
+}
+
+static struct spi_driver early_seeprom_driver __initdata = {
+	.driver = {
+		.name	= "at25",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= early_seeprom_probe,
+};
+
+int __init spi_eeprom_read(int chipid, int address,
+			   unsigned char *buf, int len)
+{
+	int ret;
+	struct read_param param = {
+		.chipid = chipid,
+		.address = address,
+		.buf = buf,
+		.len = len
+	};
+
+	read_param = &param;
+	ret = spi_register_driver(&early_seeprom_driver);
+	if (!ret)
+		spi_unregister_driver(&early_seeprom_driver);
+	return ret;
+}
diff --git a/include/asm-mips/jmr3927/jmr3927.h b/include/asm-mips/jmr3927/jmr3927.h
deleted file mode 100644
index a162268..0000000
--- a/include/asm-mips/jmr3927/jmr3927.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * Defines for the TJSYS JMR-TX3927
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- */
-#ifndef __ASM_TX3927_JMR3927_H
-#define __ASM_TX3927_JMR3927_H
-
-#include <asm/jmr3927/tx3927.h>
-#include <asm/addrspace.h>
-#include <asm/system.h>
-#include <asm/txx9irq.h>
-
-/* CS */
-#define JMR3927_ROMCE0	0x1fc00000	/* 4M */
-#define JMR3927_ROMCE1	0x1e000000	/* 4M */
-#define JMR3927_ROMCE2	0x14000000	/* 16M */
-#define JMR3927_ROMCE3	0x10000000	/* 64M */
-#define JMR3927_ROMCE5	0x1d000000	/* 4M */
-#define JMR3927_SDCS0	0x00000000	/* 32M */
-#define JMR3927_SDCS1	0x02000000	/* 32M */
-/* PCI Direct Mappings */
-
-#define JMR3927_PCIMEM	0x08000000
-#define JMR3927_PCIMEM_SIZE	0x08000000	/* 128M */
-#define JMR3927_PCIIO	0x15000000
-#define JMR3927_PCIIO_SIZE	0x01000000	/* 16M */
-
-#define JMR3927_SDRAM_SIZE	0x02000000	/* 32M */
-#define JMR3927_PORT_BASE	KSEG1
-
-/* Address map (virtual address) */
-#define JMR3927_ROM0_BASE	(KSEG1 + JMR3927_ROMCE0)
-#define JMR3927_ROM1_BASE	(KSEG1 + JMR3927_ROMCE1)
-#define JMR3927_IOC_BASE	(KSEG1 + JMR3927_ROMCE2)
-#define JMR3927_PCIMEM_BASE	(KSEG1 + JMR3927_PCIMEM)
-#define JMR3927_PCIIO_BASE	(KSEG1 + JMR3927_PCIIO)
-
-#define JMR3927_IOC_REV_ADDR	(JMR3927_IOC_BASE + 0x00000000)
-#define JMR3927_IOC_NVRAMB_ADDR	(JMR3927_IOC_BASE + 0x00010000)
-#define JMR3927_IOC_LED_ADDR	(JMR3927_IOC_BASE + 0x00020000)
-#define JMR3927_IOC_DIPSW_ADDR	(JMR3927_IOC_BASE + 0x00030000)
-#define JMR3927_IOC_BREV_ADDR	(JMR3927_IOC_BASE + 0x00040000)
-#define JMR3927_IOC_DTR_ADDR	(JMR3927_IOC_BASE + 0x00050000)
-#define JMR3927_IOC_INTS1_ADDR	(JMR3927_IOC_BASE + 0x00080000)
-#define JMR3927_IOC_INTS2_ADDR	(JMR3927_IOC_BASE + 0x00090000)
-#define JMR3927_IOC_INTM_ADDR	(JMR3927_IOC_BASE + 0x000a0000)
-#define JMR3927_IOC_INTP_ADDR	(JMR3927_IOC_BASE + 0x000b0000)
-#define JMR3927_IOC_RESET_ADDR	(JMR3927_IOC_BASE + 0x000f0000)
-
-/* Flash ROM */
-#define JMR3927_FLASH_BASE	(JMR3927_ROM0_BASE)
-#define JMR3927_FLASH_SIZE	0x00400000
-
-/* bits for IOC_REV/IOC_BREV (high byte) */
-#define JMR3927_IDT_MASK	0xfc
-#define JMR3927_REV_MASK	0x03
-#define JMR3927_IOC_IDT		0xe0
-
-/* bits for IOC_INTS1/IOC_INTS2/IOC_INTM/IOC_INTP (high byte) */
-#define JMR3927_IOC_INTB_PCIA	0
-#define JMR3927_IOC_INTB_PCIB	1
-#define JMR3927_IOC_INTB_PCIC	2
-#define JMR3927_IOC_INTB_PCID	3
-#define JMR3927_IOC_INTB_MODEM	4
-#define JMR3927_IOC_INTB_INT6	5
-#define JMR3927_IOC_INTB_INT7	6
-#define JMR3927_IOC_INTB_SOFT	7
-#define JMR3927_IOC_INTF_PCIA	(1 << JMR3927_IOC_INTF_PCIA)
-#define JMR3927_IOC_INTF_PCIB	(1 << JMR3927_IOC_INTB_PCIB)
-#define JMR3927_IOC_INTF_PCIC	(1 << JMR3927_IOC_INTB_PCIC)
-#define JMR3927_IOC_INTF_PCID	(1 << JMR3927_IOC_INTB_PCID)
-#define JMR3927_IOC_INTF_MODEM	(1 << JMR3927_IOC_INTB_MODEM)
-#define JMR3927_IOC_INTF_INT6	(1 << JMR3927_IOC_INTB_INT6)
-#define JMR3927_IOC_INTF_INT7	(1 << JMR3927_IOC_INTB_INT7)
-#define JMR3927_IOC_INTF_SOFT	(1 << JMR3927_IOC_INTB_SOFT)
-
-/* bits for IOC_RESET (high byte) */
-#define JMR3927_IOC_RESET_CPU	1
-#define JMR3927_IOC_RESET_PCI	2
-
-#if defined(__BIG_ENDIAN)
-#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)(a)) = (d))
-#define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)(a))
-#elif defined(__LITTLE_ENDIAN)
-#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)((a)^1)) = (d))
-#define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)((a)^1))
-#else
-#error "No Endian"
-#endif
-
-/* LED macro */
-#define jmr3927_led_set(n/*0-16*/)	jmr3927_ioc_reg_out(~(n), JMR3927_IOC_LED_ADDR)
-
-#define jmr3927_led_and_set(n/*0-16*/)	jmr3927_ioc_reg_out((~(n)) & jmr3927_ioc_reg_in(JMR3927_IOC_LED_ADDR), JMR3927_IOC_LED_ADDR)
-
-/* DIPSW4 macro */
-#define jmr3927_dipsw1()	(gpio_get_value(11) == 0)
-#define jmr3927_dipsw2()	(gpio_get_value(10) == 0)
-#define jmr3927_dipsw3()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 2) == 0)
-#define jmr3927_dipsw4()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 1) == 0)
-
-/*
- * IRQ mappings
- */
-
-/* These are the virtual IRQ numbers, we divide all IRQ's into
- * 'spaces', the 'space' determines where and how to enable/disable
- * that particular IRQ on an JMR machine.  Add new 'spaces' as new
- * IRQ hardware is supported.
- */
-#define JMR3927_NR_IRQ_IRC	16	/* On-Chip IRC */
-#define JMR3927_NR_IRQ_IOC	8	/* PCI/MODEM/INT[6:7] */
-
-#define JMR3927_IRQ_IRC	TXX9_IRQ_BASE
-#define JMR3927_IRQ_IOC	(JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC)
-#define JMR3927_IRQ_END	(JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC)
-
-#define JMR3927_IRQ_IRC_INT0	(JMR3927_IRQ_IRC + TX3927_IR_INT0)
-#define JMR3927_IRQ_IRC_INT1	(JMR3927_IRQ_IRC + TX3927_IR_INT1)
-#define JMR3927_IRQ_IRC_INT2	(JMR3927_IRQ_IRC + TX3927_IR_INT2)
-#define JMR3927_IRQ_IRC_INT3	(JMR3927_IRQ_IRC + TX3927_IR_INT3)
-#define JMR3927_IRQ_IRC_INT4	(JMR3927_IRQ_IRC + TX3927_IR_INT4)
-#define JMR3927_IRQ_IRC_INT5	(JMR3927_IRQ_IRC + TX3927_IR_INT5)
-#define JMR3927_IRQ_IRC_SIO0	(JMR3927_IRQ_IRC + TX3927_IR_SIO0)
-#define JMR3927_IRQ_IRC_SIO1	(JMR3927_IRQ_IRC + TX3927_IR_SIO1)
-#define JMR3927_IRQ_IRC_SIO(ch)	(JMR3927_IRQ_IRC + TX3927_IR_SIO(ch))
-#define JMR3927_IRQ_IRC_DMA	(JMR3927_IRQ_IRC + TX3927_IR_DMA)
-#define JMR3927_IRQ_IRC_PIO	(JMR3927_IRQ_IRC + TX3927_IR_PIO)
-#define JMR3927_IRQ_IRC_PCI	(JMR3927_IRQ_IRC + TX3927_IR_PCI)
-#define JMR3927_IRQ_IRC_TMR(ch)	(JMR3927_IRQ_IRC + TX3927_IR_TMR(ch))
-#define JMR3927_IRQ_IOC_PCIA	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIA)
-#define JMR3927_IRQ_IOC_PCIB	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIB)
-#define JMR3927_IRQ_IOC_PCIC	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIC)
-#define JMR3927_IRQ_IOC_PCID	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCID)
-#define JMR3927_IRQ_IOC_MODEM	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_MODEM)
-#define JMR3927_IRQ_IOC_INT6	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT6)
-#define JMR3927_IRQ_IOC_INT7	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT7)
-#define JMR3927_IRQ_IOC_SOFT	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_SOFT)
-
-/* IOC (PCI, MODEM) */
-#define JMR3927_IRQ_IOCINT	JMR3927_IRQ_IRC_INT1
-/* TC35815 100M Ether (JMR-TX3912:JPW4:2-3 Short) */
-#define JMR3927_IRQ_ETHER0	JMR3927_IRQ_IRC_INT3
-
-/* Clocks */
-#define JMR3927_CORECLK	132710400	/* 132.7MHz */
-#define JMR3927_GBUSCLK	(JMR3927_CORECLK / 2)	/* 66.35MHz */
-#define JMR3927_IMCLK	(JMR3927_CORECLK / 4)	/* 33.17MHz */
-
-/*
- * TX3927 Pin Configuration:
- *
- *	PCFG bits		Avail			Dead
- *	SELSIO[1:0]:11		RXD[1:0], TXD[1:0]	PIO[6:3]
- *	SELSIOC[0]:1		CTS[0], RTS[0]		INT[5:4]
- *	SELSIOC[1]:0,SELDSF:0,	GSDAO[0],GPCST[3]	CTS[1], RTS[1],DSF,
- *	  GDBGE*					  PIO[2:1]
- *	SELDMA[2]:1		DMAREQ[2],DMAACK[2]	PIO[13:12]
- *	SELTMR[2:0]:000					TIMER[1:0]
- *	SELCS:0,SELDMA[1]:0	PIO[11;10]		SDCS_CE[7:6],
- *							  DMAREQ[1],DMAACK[1]
- *	SELDMA[0]:1		DMAREQ[0],DMAACK[0]	PIO[9:8]
- *	SELDMA[3]:1		DMAREQ[3],DMAACK[3]	PIO[15:14]
- *	SELDONE:1		DMADONE			PIO[7]
- *
- * Usable pins are:
- *	RXD[1;0],TXD[1:0],CTS[0],RTS[0],
- *	DMAREQ[0,2,3],DMAACK[0,2,3],DMADONE,PIO[0,10,11]
- *	INT[3:0]
- */
-
-#endif /* __ASM_TX3927_JMR3927_H */
diff --git a/include/asm-mips/jmr3927/tx3927.h b/include/asm-mips/jmr3927/tx3927.h
deleted file mode 100644
index fb58033..0000000
--- a/include/asm-mips/jmr3927/tx3927.h
+++ /dev/null
@@ -1,319 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000 Toshiba Corporation
- */
-#ifndef __ASM_TX3927_H
-#define __ASM_TX3927_H
-
-#include <asm/jmr3927/txx927.h>
-
-#define TX3927_SDRAMC_REG	0xfffe8000
-#define TX3927_ROMC_REG		0xfffe9000
-#define TX3927_DMA_REG		0xfffeb000
-#define TX3927_IRC_REG		0xfffec000
-#define TX3927_PCIC_REG		0xfffed000
-#define TX3927_CCFG_REG		0xfffee000
-#define TX3927_NR_TMR	3
-#define TX3927_TMR_REG(ch)	(0xfffef000 + (ch) * 0x100)
-#define TX3927_NR_SIO	2
-#define TX3927_SIO_REG(ch)	(0xfffef300 + (ch) * 0x100)
-#define TX3927_PIO_REG		0xfffef500
-
-struct tx3927_sdramc_reg {
-	volatile unsigned long cr[8];
-	volatile unsigned long tr[3];
-	volatile unsigned long cmd;
-	volatile unsigned long smrs[2];
-};
-
-struct tx3927_romc_reg {
-	volatile unsigned long cr[8];
-};
-
-struct tx3927_dma_reg {
-	struct tx3927_dma_ch_reg {
-		volatile unsigned long cha;
-		volatile unsigned long sar;
-		volatile unsigned long dar;
-		volatile unsigned long cntr;
-		volatile unsigned long sair;
-		volatile unsigned long dair;
-		volatile unsigned long ccr;
-		volatile unsigned long csr;
-	} ch[4];
-	volatile unsigned long dbr[8];
-	volatile unsigned long tdhr;
-	volatile unsigned long mcr;
-	volatile unsigned long unused0;
-};
-
-#include <asm/byteorder.h>
-
-#ifdef __BIG_ENDIAN
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e1, e2
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned short e1;volatile unsigned char e2, e3
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned char e1, e2;volatile unsigned short e3
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e1, e2, e3, e4
-#else
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e2, e1
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned char e3, e2;volatile unsigned short e1
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned short e3;volatile unsigned char e2, e1
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e4, e3, e2, e1
-#endif
-
-struct tx3927_pcic_reg {
-	endian_def_s2(did, vid);
-	endian_def_s2(pcistat, pcicmd);
-	endian_def_b4(cc, scc, rpli, rid);
-	endian_def_b4(unused0, ht, mlt, cls);
-	volatile unsigned long ioba;		/* +10 */
-	volatile unsigned long mba;
-	volatile unsigned long unused1[5];
-	endian_def_s2(svid, ssvid);
-	volatile unsigned long unused2;		/* +30 */
-	endian_def_sb2(unused3, unused4, capptr);
-	volatile unsigned long unused5;
-	endian_def_b4(ml, mg, ip, il);
-	volatile unsigned long unused6;		/* +40 */
-	volatile unsigned long istat;
-	volatile unsigned long iim;
-	volatile unsigned long rrt;
-	volatile unsigned long unused7[3];		/* +50 */
-	volatile unsigned long ipbmma;
-	volatile unsigned long ipbioma;		/* +60 */
-	volatile unsigned long ilbmma;
-	volatile unsigned long ilbioma;
-	volatile unsigned long unused8[9];
-	volatile unsigned long tc;		/* +90 */
-	volatile unsigned long tstat;
-	volatile unsigned long tim;
-	volatile unsigned long tccmd;
-	volatile unsigned long pcirrt;		/* +a0 */
-	volatile unsigned long pcirrt_cmd;
-	volatile unsigned long pcirrdt;
-	volatile unsigned long unused9[3];
-	volatile unsigned long tlboap;
-	volatile unsigned long tlbiap;
-	volatile unsigned long tlbmma;		/* +c0 */
-	volatile unsigned long tlbioma;
-	volatile unsigned long sc_msg;
-	volatile unsigned long sc_be;
-	volatile unsigned long tbl;		/* +d0 */
-	volatile unsigned long unused10[3];
-	volatile unsigned long pwmng;		/* +e0 */
-	volatile unsigned long pwmngs;
-	volatile unsigned long unused11[6];
-	volatile unsigned long req_trace;		/* +100 */
-	volatile unsigned long pbapmc;
-	volatile unsigned long pbapms;
-	volatile unsigned long pbapmim;
-	volatile unsigned long bm;		/* +110 */
-	volatile unsigned long cpcibrs;
-	volatile unsigned long cpcibgs;
-	volatile unsigned long pbacs;
-	volatile unsigned long iobas;		/* +120 */
-	volatile unsigned long mbas;
-	volatile unsigned long lbc;
-	volatile unsigned long lbstat;
-	volatile unsigned long lbim;		/* +130 */
-	volatile unsigned long pcistatim;
-	volatile unsigned long ica;
-	volatile unsigned long icd;
-	volatile unsigned long iiadp;		/* +140 */
-	volatile unsigned long iscdp;
-	volatile unsigned long mmas;
-	volatile unsigned long iomas;
-	volatile unsigned long ipciaddr;		/* +150 */
-	volatile unsigned long ipcidata;
-	volatile unsigned long ipcibe;
-};
-
-struct tx3927_ccfg_reg {
-	volatile unsigned long ccfg;
-	volatile unsigned long crir;
-	volatile unsigned long pcfg;
-	volatile unsigned long tear;
-	volatile unsigned long pdcr;
-};
-
-/*
- * SDRAMC
- */
-
-/*
- * ROMC
- */
-
-/*
- * DMA
- */
-/* bits for MCR */
-#define TX3927_DMA_MCR_EIS(ch)	(0x10000000<<(ch))
-#define TX3927_DMA_MCR_DIS(ch)	(0x01000000<<(ch))
-#define TX3927_DMA_MCR_RSFIF	0x00000080
-#define TX3927_DMA_MCR_FIFUM(ch)	(0x00000008<<(ch))
-#define TX3927_DMA_MCR_LE	0x00000004
-#define TX3927_DMA_MCR_RPRT	0x00000002
-#define TX3927_DMA_MCR_MSTEN	0x00000001
-
-/* bits for CCRn */
-#define TX3927_DMA_CCR_DBINH	0x04000000
-#define TX3927_DMA_CCR_SBINH	0x02000000
-#define TX3927_DMA_CCR_CHRST	0x01000000
-#define TX3927_DMA_CCR_RVBYTE	0x00800000
-#define TX3927_DMA_CCR_ACKPOL	0x00400000
-#define TX3927_DMA_CCR_REQPL	0x00200000
-#define TX3927_DMA_CCR_EGREQ	0x00100000
-#define TX3927_DMA_CCR_CHDN	0x00080000
-#define TX3927_DMA_CCR_DNCTL	0x00060000
-#define TX3927_DMA_CCR_EXTRQ	0x00010000
-#define TX3927_DMA_CCR_INTRQD	0x0000e000
-#define TX3927_DMA_CCR_INTENE	0x00001000
-#define TX3927_DMA_CCR_INTENC	0x00000800
-#define TX3927_DMA_CCR_INTENT	0x00000400
-#define TX3927_DMA_CCR_CHNEN	0x00000200
-#define TX3927_DMA_CCR_XFACT	0x00000100
-#define TX3927_DMA_CCR_SNOP	0x00000080
-#define TX3927_DMA_CCR_DSTINC	0x00000040
-#define TX3927_DMA_CCR_SRCINC	0x00000020
-#define TX3927_DMA_CCR_XFSZ(order)	(((order) << 2) & 0x0000001c)
-#define TX3927_DMA_CCR_XFSZ_1W	TX3927_DMA_CCR_XFSZ(2)
-#define TX3927_DMA_CCR_XFSZ_4W	TX3927_DMA_CCR_XFSZ(4)
-#define TX3927_DMA_CCR_XFSZ_8W	TX3927_DMA_CCR_XFSZ(5)
-#define TX3927_DMA_CCR_XFSZ_16W	TX3927_DMA_CCR_XFSZ(6)
-#define TX3927_DMA_CCR_XFSZ_32W	TX3927_DMA_CCR_XFSZ(7)
-#define TX3927_DMA_CCR_MEMIO	0x00000002
-#define TX3927_DMA_CCR_ONEAD	0x00000001
-
-/* bits for CSRn */
-#define TX3927_DMA_CSR_CHNACT	0x00000100
-#define TX3927_DMA_CSR_ABCHC	0x00000080
-#define TX3927_DMA_CSR_NCHNC	0x00000040
-#define TX3927_DMA_CSR_NTRNFC	0x00000020
-#define TX3927_DMA_CSR_EXTDN	0x00000010
-#define TX3927_DMA_CSR_CFERR	0x00000008
-#define TX3927_DMA_CSR_CHERR	0x00000004
-#define TX3927_DMA_CSR_DESERR	0x00000002
-#define TX3927_DMA_CSR_SORERR	0x00000001
-
-/*
- * IRC
- */
-#define TX3927_IR_INT0	0
-#define TX3927_IR_INT1	1
-#define TX3927_IR_INT2	2
-#define TX3927_IR_INT3	3
-#define TX3927_IR_INT4	4
-#define TX3927_IR_INT5	5
-#define TX3927_IR_SIO0	6
-#define TX3927_IR_SIO1	7
-#define TX3927_IR_SIO(ch)	(6 + (ch))
-#define TX3927_IR_DMA	8
-#define TX3927_IR_PIO	9
-#define TX3927_IR_PCI	10
-#define TX3927_IR_TMR(ch)	(13 + (ch))
-#define TX3927_NUM_IR	16
-
-/*
- * PCIC
- */
-/* bits for PCICMD */
-/* see PCI_COMMAND_XXX in linux/pci.h */
-
-/* bits for PCISTAT */
-/* see PCI_STATUS_XXX in linux/pci.h */
-#define PCI_STATUS_NEW_CAP	0x0010
-
-/* bits for TC */
-#define TX3927_PCIC_TC_OF16E	0x00000020
-#define TX3927_PCIC_TC_IF8E	0x00000010
-#define TX3927_PCIC_TC_OF8E	0x00000008
-
-/* bits for IOBA/MBA */
-/* see PCI_BASE_ADDRESS_XXX in linux/pci.h */
-
-/* bits for PBAPMC */
-#define TX3927_PCIC_PBAPMC_RPBA	0x00000004
-#define TX3927_PCIC_PBAPMC_PBAEN	0x00000002
-#define TX3927_PCIC_PBAPMC_BMCEN	0x00000001
-
-/* bits for LBSTAT/LBIM */
-#define TX3927_PCIC_LBIM_ALL	0x0000003e
-
-/* bits for PCISTATIM (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX3927_PCIC_PCISTATIM_ALL	0x0000f900
-
-/* bits for LBC */
-#define TX3927_PCIC_LBC_IBSE	0x00004000
-#define TX3927_PCIC_LBC_TIBSE	0x00002000
-#define TX3927_PCIC_LBC_TMFBSE	0x00001000
-#define TX3927_PCIC_LBC_HRST	0x00000800
-#define TX3927_PCIC_LBC_SRST	0x00000400
-#define TX3927_PCIC_LBC_EPCAD	0x00000200
-#define TX3927_PCIC_LBC_MSDSE	0x00000100
-#define TX3927_PCIC_LBC_CRR	0x00000080
-#define TX3927_PCIC_LBC_ILMDE	0x00000040
-#define TX3927_PCIC_LBC_ILIDE	0x00000020
-
-#define TX3927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
-#define TX3927_PCIC_MAX_DEVNU	TX3927_PCIC_IDSEL_AD_TO_SLOT(32)
-
-/*
- * CCFG
- */
-/* CCFG : Chip Configuration */
-#define TX3927_CCFG_TLBOFF	0x00020000
-#define TX3927_CCFG_BEOW	0x00010000
-#define TX3927_CCFG_WR	0x00008000
-#define TX3927_CCFG_TOE	0x00004000
-#define TX3927_CCFG_PCIXARB	0x00002000
-#define TX3927_CCFG_PCI3	0x00001000
-#define TX3927_CCFG_PSNP	0x00000800
-#define TX3927_CCFG_PPRI	0x00000400
-#define TX3927_CCFG_PLLM	0x00000030
-#define TX3927_CCFG_ENDIAN	0x00000004
-#define TX3927_CCFG_HALT	0x00000002
-#define TX3927_CCFG_ACEHOLD	0x00000001
-
-/* PCFG : Pin Configuration */
-#define TX3927_PCFG_SYSCLKEN	0x08000000
-#define TX3927_PCFG_SDRCLKEN_ALL	0x07c00000
-#define TX3927_PCFG_SDRCLKEN(ch)	(0x00400000<<(ch))
-#define TX3927_PCFG_PCICLKEN_ALL	0x003c0000
-#define TX3927_PCFG_PCICLKEN(ch)	(0x00040000<<(ch))
-#define TX3927_PCFG_SELALL	0x0003ffff
-#define TX3927_PCFG_SELCS	0x00020000
-#define TX3927_PCFG_SELDSF	0x00010000
-#define TX3927_PCFG_SELSIOC_ALL	0x0000c000
-#define TX3927_PCFG_SELSIOC(ch)	(0x00004000<<(ch))
-#define TX3927_PCFG_SELSIO_ALL	0x00003000
-#define TX3927_PCFG_SELSIO(ch)	(0x00001000<<(ch))
-#define TX3927_PCFG_SELTMR_ALL	0x00000e00
-#define TX3927_PCFG_SELTMR(ch)	(0x00000200<<(ch))
-#define TX3927_PCFG_SELDONE	0x00000100
-#define TX3927_PCFG_INTDMA_ALL	0x000000f0
-#define TX3927_PCFG_INTDMA(ch)	(0x00000010<<(ch))
-#define TX3927_PCFG_SELDMA_ALL	0x0000000f
-#define TX3927_PCFG_SELDMA(ch)	(0x00000001<<(ch))
-
-#define tx3927_sdramcptr	((struct tx3927_sdramc_reg *)TX3927_SDRAMC_REG)
-#define tx3927_romcptr		((struct tx3927_romc_reg *)TX3927_ROMC_REG)
-#define tx3927_dmaptr		((struct tx3927_dma_reg *)TX3927_DMA_REG)
-#define tx3927_pcicptr		((struct tx3927_pcic_reg *)TX3927_PCIC_REG)
-#define tx3927_ccfgptr		((struct tx3927_ccfg_reg *)TX3927_CCFG_REG)
-#define tx3927_tmrptr(ch)	((struct txx927_tmr_reg *)TX3927_TMR_REG(ch))
-#define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
-#define tx3927_pioptr		((struct txx9_pio_reg __iomem *)TX3927_PIO_REG)
-
-#endif /* __ASM_TX3927_H */
diff --git a/include/asm-mips/jmr3927/txx927.h b/include/asm-mips/jmr3927/txx927.h
deleted file mode 100644
index 25dcf2f..0000000
--- a/include/asm-mips/jmr3927/txx927.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Common definitions for TX3927/TX4927
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000 Toshiba Corporation
- */
-#ifndef __ASM_TXX927_H
-#define __ASM_TXX927_H
-
-struct txx927_sio_reg {
-	volatile unsigned long lcr;
-	volatile unsigned long dicr;
-	volatile unsigned long disr;
-	volatile unsigned long cisr;
-	volatile unsigned long fcr;
-	volatile unsigned long flcr;
-	volatile unsigned long bgr;
-	volatile unsigned long tfifo;
-	volatile unsigned long rfifo;
-};
-
-/*
- * SIO
- */
-/* SILCR : Line Control */
-#define TXx927_SILCR_SCS_MASK	0x00000060
-#define TXx927_SILCR_SCS_IMCLK	0x00000000
-#define TXx927_SILCR_SCS_IMCLK_BG	0x00000020
-#define TXx927_SILCR_SCS_SCLK	0x00000040
-#define TXx927_SILCR_SCS_SCLK_BG	0x00000060
-#define TXx927_SILCR_UEPS	0x00000010
-#define TXx927_SILCR_UPEN	0x00000008
-#define TXx927_SILCR_USBL_MASK	0x00000004
-#define TXx927_SILCR_USBL_1BIT	0x00000004
-#define TXx927_SILCR_USBL_2BIT	0x00000000
-#define TXx927_SILCR_UMODE_MASK	0x00000003
-#define TXx927_SILCR_UMODE_8BIT	0x00000000
-#define TXx927_SILCR_UMODE_7BIT	0x00000001
-
-/* SIDICR : DMA/Int. Control */
-#define TXx927_SIDICR_TDE	0x00008000
-#define TXx927_SIDICR_RDE	0x00004000
-#define TXx927_SIDICR_TIE	0x00002000
-#define TXx927_SIDICR_RIE	0x00001000
-#define TXx927_SIDICR_SPIE	0x00000800
-#define TXx927_SIDICR_CTSAC	0x00000600
-#define TXx927_SIDICR_STIE_MASK	0x0000003f
-#define TXx927_SIDICR_STIE_OERS		0x00000020
-#define TXx927_SIDICR_STIE_CTSS		0x00000010
-#define TXx927_SIDICR_STIE_RBRKD	0x00000008
-#define TXx927_SIDICR_STIE_TRDY		0x00000004
-#define TXx927_SIDICR_STIE_TXALS	0x00000002
-#define TXx927_SIDICR_STIE_UBRKD	0x00000001
-
-/* SIDISR : DMA/Int. Status */
-#define TXx927_SIDISR_UBRK	0x00008000
-#define TXx927_SIDISR_UVALID	0x00004000
-#define TXx927_SIDISR_UFER	0x00002000
-#define TXx927_SIDISR_UPER	0x00001000
-#define TXx927_SIDISR_UOER	0x00000800
-#define TXx927_SIDISR_ERI	0x00000400
-#define TXx927_SIDISR_TOUT	0x00000200
-#define TXx927_SIDISR_TDIS	0x00000100
-#define TXx927_SIDISR_RDIS	0x00000080
-#define TXx927_SIDISR_STIS	0x00000040
-#define TXx927_SIDISR_RFDN_MASK	0x0000001f
-
-/* SICISR : Change Int. Status */
-#define TXx927_SICISR_OERS	0x00000020
-#define TXx927_SICISR_CTSS	0x00000010
-#define TXx927_SICISR_RBRKD	0x00000008
-#define TXx927_SICISR_TRDY	0x00000004
-#define TXx927_SICISR_TXALS	0x00000002
-#define TXx927_SICISR_UBRKD	0x00000001
-
-/* SIFCR : FIFO Control */
-#define TXx927_SIFCR_SWRST	0x00008000
-#define TXx927_SIFCR_RDIL_MASK	0x00000180
-#define TXx927_SIFCR_RDIL_1	0x00000000
-#define TXx927_SIFCR_RDIL_4	0x00000080
-#define TXx927_SIFCR_RDIL_8	0x00000100
-#define TXx927_SIFCR_RDIL_12	0x00000180
-#define TXx927_SIFCR_RDIL_MAX	0x00000180
-#define TXx927_SIFCR_TDIL_MASK	0x00000018
-#define TXx927_SIFCR_TDIL_MASK	0x00000018
-#define TXx927_SIFCR_TDIL_1	0x00000000
-#define TXx927_SIFCR_TDIL_4	0x00000001
-#define TXx927_SIFCR_TDIL_8	0x00000010
-#define TXx927_SIFCR_TDIL_MAX	0x00000010
-#define TXx927_SIFCR_TFRST	0x00000004
-#define TXx927_SIFCR_RFRST	0x00000002
-#define TXx927_SIFCR_FRSTE	0x00000001
-#define TXx927_SIO_TX_FIFO	8
-#define TXx927_SIO_RX_FIFO	16
-
-/* SIFLCR : Flow Control */
-#define TXx927_SIFLCR_RCS	0x00001000
-#define TXx927_SIFLCR_TES	0x00000800
-#define TXx927_SIFLCR_RTSSC	0x00000200
-#define TXx927_SIFLCR_RSDE	0x00000100
-#define TXx927_SIFLCR_TSDE	0x00000080
-#define TXx927_SIFLCR_RTSTL_MASK	0x0000001e
-#define TXx927_SIFLCR_RTSTL_MAX	0x0000001e
-#define TXx927_SIFLCR_TBRK	0x00000001
-
-/* SIBGR : Baudrate Control */
-#define TXx927_SIBGR_BCLK_MASK	0x00000300
-#define TXx927_SIBGR_BCLK_T0	0x00000000
-#define TXx927_SIBGR_BCLK_T2	0x00000100
-#define TXx927_SIBGR_BCLK_T4	0x00000200
-#define TXx927_SIBGR_BCLK_T6	0x00000300
-#define TXx927_SIBGR_BRD_MASK	0x000000ff
-
-/*
- * PIO
- */
-
-#endif /* __ASM_TXX927_H */
diff --git a/include/asm-mips/tx4927/smsc_fdc37m81x.h b/include/asm-mips/tx4927/smsc_fdc37m81x.h
deleted file mode 100644
index 5d93bab..0000000
--- a/include/asm-mips/tx4927/smsc_fdc37m81x.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * linux/include/asm-mips/tx4927/smsc_fdc37m81x.h
- *
- * Interface for smsc fdc48m81x Super IO chip
- *
- * Author: MontaVista Software, Inc. source@mvista.com
- *
- * 2001-2003 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Copyright (C) 2004 MontaVista Software Inc.
- * Manish Lachwani, mlachwani@mvista.com
- */
-
-#ifndef _SMSC_FDC37M81X_H_
-#define _SMSC_FDC37M81X_H_
-
-/* Common Registers */
-#define SMSC_FDC37M81X_CONFIG_INDEX  0x00
-#define SMSC_FDC37M81X_CONFIG_DATA   0x01
-#define SMSC_FDC37M81X_CONF          0x02
-#define SMSC_FDC37M81X_INDEX         0x03
-#define SMSC_FDC37M81X_DNUM          0x07
-#define SMSC_FDC37M81X_DID           0x20
-#define SMSC_FDC37M81X_DREV          0x21
-#define SMSC_FDC37M81X_PCNT          0x22
-#define SMSC_FDC37M81X_PMGT          0x23
-#define SMSC_FDC37M81X_OSC           0x24
-#define SMSC_FDC37M81X_CONFPA0       0x26
-#define SMSC_FDC37M81X_CONFPA1       0x27
-#define SMSC_FDC37M81X_TEST4         0x2B
-#define SMSC_FDC37M81X_TEST5         0x2C
-#define SMSC_FDC37M81X_TEST1         0x2D
-#define SMSC_FDC37M81X_TEST2         0x2E
-#define SMSC_FDC37M81X_TEST3         0x2F
-
-/* Logical device numbers */
-#define SMSC_FDC37M81X_FDD           0x00
-#define SMSC_FDC37M81X_PARALLEL      0x03
-#define SMSC_FDC37M81X_SERIAL1       0x04
-#define SMSC_FDC37M81X_SERIAL2       0x05
-#define SMSC_FDC37M81X_KBD           0x07
-#define SMSC_FDC37M81X_AUXIO         0x08
-#define SMSC_FDC37M81X_NONE          0xff
-
-/* Logical device Config Registers */
-#define SMSC_FDC37M81X_ACTIVE        0x30
-#define SMSC_FDC37M81X_BASEADDR0     0x60
-#define SMSC_FDC37M81X_BASEADDR1     0x61
-#define SMSC_FDC37M81X_INT           0x70
-#define SMSC_FDC37M81X_INT2          0x72
-#define SMSC_FDC37M81X_LDCR_F0       0xF0
-
-/* Chip Config Values */
-#define SMSC_FDC37M81X_CONFIG_ENTER  0x55
-#define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
-#define SMSC_FDC37M81X_CHIP_ID       0x4d
-
-unsigned long __init smsc_fdc37m81x_init(unsigned long port);
-
-void smsc_fdc37m81x_config_beg(void);
-
-void smsc_fdc37m81x_config_end(void);
-
-void smsc_fdc37m81x_config_set(u8 reg, u8 val);
-
-#endif
diff --git a/include/asm-mips/tx4927/toshiba_rbtx4927.h b/include/asm-mips/tx4927/toshiba_rbtx4927.h
deleted file mode 100644
index d6b32ac..0000000
--- a/include/asm-mips/tx4927/toshiba_rbtx4927.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#ifndef __ASM_TX4927_TOSHIBA_RBTX4927_H
-#define __ASM_TX4927_TOSHIBA_RBTX4927_H
-
-#include <asm/tx4927/tx4927.h>
-
-#ifdef CONFIG_PCI
-#define TBTX4927_ISA_IO_OFFSET TX4927_PCIIO
-#else
-#define TBTX4927_ISA_IO_OFFSET 0
-#endif
-
-#define RBTX4927_SW_RESET_DO         (void __iomem *)0xbc00f000UL
-#define RBTX4927_SW_RESET_DO_SET                0x01
-
-#define RBTX4927_SW_RESET_ENABLE     (void __iomem *)0xbc00f002UL
-#define RBTX4927_SW_RESET_ENABLE_SET            0x01
-
-#define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
-#define RBTX4927_RTL_8019_IRQ  (TX4927_IRQ_PIC_BEG + 5)
-
-int toshiba_rbtx4927_irq_nested(int sw_irq);
-
-#endif /* __ASM_TX4927_TOSHIBA_RBTX4927_H */
diff --git a/include/asm-mips/tx4927/tx4927.h b/include/asm-mips/tx4927/tx4927.h
deleted file mode 100644
index 1d4816f..0000000
--- a/include/asm-mips/tx4927/tx4927.h
+++ /dev/null
@@ -1,280 +0,0 @@
-/*
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * Copyright 2001-2006 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#ifndef __ASM_TX4927_TX4927_H
-#define __ASM_TX4927_TX4927_H
-
-#include <asm/txx9irq.h>
-
-#define TX4927_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
-#define TX4927_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
-
-#define TX4927_IRQ_PIC_BEG  TXX9_IRQ_BASE
-#define TX4927_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
-
-
-#define TX4927_IRQ_USER0	    (TX4927_IRQ_CP0_BEG+0)
-#define TX4927_IRQ_USER1	    (TX4927_IRQ_CP0_BEG+1)
-#define TX4927_IRQ_NEST_PIC_ON_CP0  (TX4927_IRQ_CP0_BEG+2)
-#define TX4927_IRQ_CPU_TIMER	    (TX4927_IRQ_CP0_BEG+7)
-
-#define TX4927_IRQ_NEST_EXT_ON_PIC  (TX4927_IRQ_PIC_BEG+3)
-
-#define TX4927_CCFG_TOE 0x00004000
-#define TX4927_CCFG_WR	0x00008000
-#define TX4927_CCFG_TINTDIS	0x01000000
-
-#define TX4927_PCIMEM	   0x08000000
-#define TX4927_PCIMEM_SIZE 0x08000000
-#define TX4927_PCIIO	   0x16000000
-#define TX4927_PCIIO_SIZE  0x01000000
-
-#define TX4927_SDRAMC_REG	0xff1f8000
-#define TX4927_EBUSC_REG	0xff1f9000
-#define TX4927_PCIC_REG		0xff1fd000
-#define TX4927_CCFG_REG		0xff1fe000
-#define TX4927_IRC_REG		0xff1ff600
-#define TX4927_NR_TMR	3
-#define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
-
-/* bits for ISTAT3/IMASK3/IMSTAT3 */
-#define TX4927_INT3B_PCID	0
-#define TX4927_INT3B_PCIC	1
-#define TX4927_INT3B_PCIB	2
-#define TX4927_INT3B_PCIA	3
-#define TX4927_INT3F_PCID	(1 << TX4927_INT3B_PCID)
-#define TX4927_INT3F_PCIC	(1 << TX4927_INT3B_PCIC)
-#define TX4927_INT3F_PCIB	(1 << TX4927_INT3B_PCIB)
-#define TX4927_INT3F_PCIA	(1 << TX4927_INT3B_PCIA)
-
-#define TX4927_NR_IRQ_LOCAL	TX4927_IRQ_PIC_BEG
-#define TX4927_NR_IRQ_IRC	32	/* On-Chip IRC */
-
-#define TX4927_IR_PCIC		16
-#define TX4927_IR_PCIERR	22
-#define TX4927_IR_PCIPMA	23
-#define TX4927_IRQ_IRC_PCIC	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIC)
-#define TX4927_IRQ_IRC_PCIERR	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIERR)
-#define TX4927_IRQ_IOC1		(TX4927_NR_IRQ_LOCAL + TX4927_NR_IRQ_IRC)
-#define TX4927_IRQ_IOC_PCID	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCID)
-#define TX4927_IRQ_IOC_PCIC	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIC)
-#define TX4927_IRQ_IOC_PCIB	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIB)
-#define TX4927_IRQ_IOC_PCIA	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIA)
-
-#ifdef _LANGUAGE_ASSEMBLY
-#define _CONST64(c)	c
-#else
-#define _CONST64(c)	c##ull
-
-#include <asm/byteorder.h>
-
-struct tx4927_sdramc_reg {
-	volatile unsigned long long cr[4];
-	volatile unsigned long long unused0[4];
-	volatile unsigned long long tr;
-	volatile unsigned long long unused1[2];
-	volatile unsigned long long cmd;
-};
-
-struct tx4927_ebusc_reg {
-	volatile unsigned long long cr[8];
-};
-
-struct tx4927_ccfg_reg {
-	volatile unsigned long long ccfg;
-	volatile unsigned long long crir;
-	volatile unsigned long long pcfg;
-	volatile unsigned long long tear;
-	volatile unsigned long long clkctr;
-	volatile unsigned long long unused0;
-	volatile unsigned long long garbc;
-	volatile unsigned long long unused1;
-	volatile unsigned long long unused2;
-	volatile unsigned long long ramp;
-};
-
-struct tx4927_pcic_reg {
-	volatile unsigned long pciid;
-	volatile unsigned long pcistatus;
-	volatile unsigned long pciccrev;
-	volatile unsigned long pcicfg1;
-	volatile unsigned long p2gm0plbase;		/* +10 */
-	volatile unsigned long p2gm0pubase;
-	volatile unsigned long p2gm1plbase;
-	volatile unsigned long p2gm1pubase;
-	volatile unsigned long p2gm2pbase;		/* +20 */
-	volatile unsigned long p2giopbase;
-	volatile unsigned long unused0;
-	volatile unsigned long pcisid;
-	volatile unsigned long unused1;		/* +30 */
-	volatile unsigned long pcicapptr;
-	volatile unsigned long unused2;
-	volatile unsigned long pcicfg2;
-	volatile unsigned long g2ptocnt;		/* +40 */
-	volatile unsigned long unused3[15];
-	volatile unsigned long g2pstatus;		/* +80 */
-	volatile unsigned long g2pmask;
-	volatile unsigned long pcisstatus;
-	volatile unsigned long pcimask;
-	volatile unsigned long p2gcfg;		/* +90 */
-	volatile unsigned long p2gstatus;
-	volatile unsigned long p2gmask;
-	volatile unsigned long p2gccmd;
-	volatile unsigned long unused4[24];		/* +a0 */
-	volatile unsigned long pbareqport;		/* +100 */
-	volatile unsigned long pbacfg;
-	volatile unsigned long pbastatus;
-	volatile unsigned long pbamask;
-	volatile unsigned long pbabm;		/* +110 */
-	volatile unsigned long pbacreq;
-	volatile unsigned long pbacgnt;
-	volatile unsigned long pbacstate;
-	volatile unsigned long long g2pmgbase[3];		/* +120 */
-	volatile unsigned long long g2piogbase;
-	volatile unsigned long g2pmmask[3];		/* +140 */
-	volatile unsigned long g2piomask;
-	volatile unsigned long long g2pmpbase[3];		/* +150 */
-	volatile unsigned long long g2piopbase;
-	volatile unsigned long pciccfg;		/* +170 */
-	volatile unsigned long pcicstatus;
-	volatile unsigned long pcicmask;
-	volatile unsigned long unused5;
-	volatile unsigned long long p2gmgbase[3];		/* +180 */
-	volatile unsigned long long p2giogbase;
-	volatile unsigned long g2pcfgadrs;		/* +1a0 */
-	volatile unsigned long g2pcfgdata;
-	volatile unsigned long unused6[8];
-	volatile unsigned long g2pintack;
-	volatile unsigned long g2pspc;
-	volatile unsigned long unused7[12];		/* +1d0 */
-	volatile unsigned long long pdmca;		/* +200 */
-	volatile unsigned long long pdmga;
-	volatile unsigned long long pdmpa;
-	volatile unsigned long long pdmcut;
-	volatile unsigned long long pdmcnt;		/* +220 */
-	volatile unsigned long long pdmsts;
-	volatile unsigned long long unused8[2];
-	volatile unsigned long long pdmdb[4];		/* +240 */
-	volatile unsigned long long pdmtdh;		/* +260 */
-	volatile unsigned long long pdmdms;
-};
-
-#endif /* _LANGUAGE_ASSEMBLY */
-
-/*
- * PCIC
- */
-
-/* bits for G2PSTATUS/G2PMASK */
-#define TX4927_PCIC_G2PSTATUS_ALL	0x00000003
-#define TX4927_PCIC_G2PSTATUS_TTOE	0x00000002
-#define TX4927_PCIC_G2PSTATUS_RTOE	0x00000001
-
-/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX4927_PCIC_PCISTATUS_ALL	0x0000f900
-
-/* bits for PBACFG */
-#define TX4927_PCIC_PBACFG_RPBA 0x00000004
-#define TX4927_PCIC_PBACFG_PBAEN	0x00000002
-#define TX4927_PCIC_PBACFG_BMCEN	0x00000001
-
-/* bits for G2PMnGBASE */
-#define TX4927_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for G2PIOGBASE */
-#define TX4927_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for PCICSTATUS/PCICMASK */
-#define TX4927_PCIC_PCICSTATUS_ALL	0x000007dc
-
-/* bits for PCICCFG */
-#define TX4927_PCIC_PCICCFG_LBWC_MASK	0x0fff0000
-#define TX4927_PCIC_PCICCFG_HRST	0x00000800
-#define TX4927_PCIC_PCICCFG_SRST	0x00000400
-#define TX4927_PCIC_PCICCFG_IRBER	0x00000200
-#define TX4927_PCIC_PCICCFG_IMSE0	0x00000100
-#define TX4927_PCIC_PCICCFG_IMSE1	0x00000080
-#define TX4927_PCIC_PCICCFG_IMSE2	0x00000040
-#define TX4927_PCIC_PCICCFG_IISE	0x00000020
-#define TX4927_PCIC_PCICCFG_ATR 0x00000010
-#define TX4927_PCIC_PCICCFG_ICAE	0x00000008
-
-/* bits for P2GMnGBASE */
-#define TX4927_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
-#define TX4927_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
-
-/* bits for P2GIOGBASE */
-#define TX4927_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
-#define TX4927_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4927_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
-
-#define TX4927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
-#define TX4927_PCIC_MAX_DEVNU	TX4927_PCIC_IDSEL_AD_TO_SLOT(32)
-
-/*
- * CCFG
- */
-/* CCFG : Chip Configuration */
-#define TX4927_CCFG_PCI66	0x00800000
-#define TX4927_CCFG_PCIMIDE	0x00400000
-#define TX4927_CCFG_PCIXARB	0x00002000
-#define TX4927_CCFG_PCIDIVMODE_MASK	0x00001800
-#define TX4927_CCFG_PCIDIVMODE_2_5	0x00000000
-#define TX4927_CCFG_PCIDIVMODE_3	0x00000800
-#define TX4927_CCFG_PCIDIVMODE_5	0x00001000
-#define TX4927_CCFG_PCIDIVMODE_6	0x00001800
-
-#define TX4937_CCFG_PCIDIVMODE_MASK	0x00001c00
-#define TX4937_CCFG_PCIDIVMODE_8	0x00000000
-#define TX4937_CCFG_PCIDIVMODE_4	0x00000400
-#define TX4937_CCFG_PCIDIVMODE_9	0x00000800
-#define TX4937_CCFG_PCIDIVMODE_4_5	0x00000c00
-#define TX4937_CCFG_PCIDIVMODE_10	0x00001000
-#define TX4937_CCFG_PCIDIVMODE_5	0x00001400
-#define TX4937_CCFG_PCIDIVMODE_11	0x00001800
-#define TX4937_CCFG_PCIDIVMODE_5_5	0x00001c00
-
-/* PCFG : Pin Configuration */
-#define TX4927_PCFG_PCICLKEN_ALL	0x003f0000
-#define TX4927_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
-
-/* CLKCTR : Clock Control */
-#define TX4927_CLKCTR_PCICKD	0x00400000
-#define TX4927_CLKCTR_PCIRST	0x00000040
-
-#ifndef _LANGUAGE_ASSEMBLY
-
-#define tx4927_sdramcptr	((struct tx4927_sdramc_reg *)TX4927_SDRAMC_REG)
-#define tx4927_pcicptr		((struct tx4927_pcic_reg *)TX4927_PCIC_REG)
-#define tx4927_ccfgptr		((struct tx4927_ccfg_reg *)TX4927_CCFG_REG)
-#define tx4927_ebuscptr		((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
-
-#endif /* _LANGUAGE_ASSEMBLY */
-
-#endif /* __ASM_TX4927_TX4927_H */
diff --git a/include/asm-mips/tx4938/rbtx4938.h b/include/asm-mips/tx4938/rbtx4938.h
deleted file mode 100644
index dfed7be..0000000
--- a/include/asm-mips/tx4938/rbtx4938.h
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
- * linux/include/asm-mips/tx4938/rbtx4938.h
- * Definitions for TX4937/TX4938
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#ifndef __ASM_TX_BOARDS_RBTX4938_H
-#define __ASM_TX_BOARDS_RBTX4938_H
-
-#include <asm/addrspace.h>
-#include <asm/tx4938/tx4938.h>
-#include <asm/txx9irq.h>
-
-/* CS */
-#define RBTX4938_CE0	0x1c000000	/* 64M */
-#define RBTX4938_CE2	0x17f00000	/* 1M */
-
-/* Address map */
-#define RBTX4938_FPGA_REG_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000000)
-#define RBTX4938_FPGA_REV_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000002)
-#define RBTX4938_CONFIG1_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000004)
-#define RBTX4938_CONFIG2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000006)
-#define RBTX4938_CONFIG3_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000008)
-#define RBTX4938_LED_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001000)
-#define RBTX4938_DIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001002)
-#define RBTX4938_BDIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001004)
-#define RBTX4938_IMASK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002000)
-#define RBTX4938_IMASK2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002002)
-#define RBTX4938_INTPOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002004)
-#define RBTX4938_ISTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002006)
-#define RBTX4938_ISTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002008)
-#define RBTX4938_IMSTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200a)
-#define RBTX4938_IMSTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200c)
-#define RBTX4938_SOFTINT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00003000)
-#define RBTX4938_PIOSEL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005000)
-#define RBTX4938_SPICS_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005002)
-#define RBTX4938_SFPWR_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005008)
-#define RBTX4938_SFVOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000500a)
-#define RBTX4938_SOFTRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007000)
-#define RBTX4938_SOFTRESETLOCK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007002)
-#define RBTX4938_PCIRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007004)
-#define RBTX4938_ETHER_BASE	(KSEG1 + RBTX4938_CE2 + 0x00020000)
-
-/* Ethernet port address (Jumperless Mode (W12:Open)) */
-#define RBTX4938_ETHER_ADDR	(RBTX4938_ETHER_BASE + 0x280)
-
-/* bits for ISTAT/IMASK/IMSTAT */
-#define RBTX4938_INTB_PCID	0
-#define RBTX4938_INTB_PCIC	1
-#define RBTX4938_INTB_PCIB	2
-#define RBTX4938_INTB_PCIA	3
-#define RBTX4938_INTB_RTC	4
-#define RBTX4938_INTB_ATA	5
-#define RBTX4938_INTB_MODEM	6
-#define RBTX4938_INTB_SWINT	7
-#define RBTX4938_INTF_PCID	(1 << RBTX4938_INTB_PCID)
-#define RBTX4938_INTF_PCIC	(1 << RBTX4938_INTB_PCIC)
-#define RBTX4938_INTF_PCIB	(1 << RBTX4938_INTB_PCIB)
-#define RBTX4938_INTF_PCIA	(1 << RBTX4938_INTB_PCIA)
-#define RBTX4938_INTF_RTC	(1 << RBTX4938_INTB_RTC)
-#define RBTX4938_INTF_ATA	(1 << RBTX4938_INTB_ATA)
-#define RBTX4938_INTF_MODEM	(1 << RBTX4938_INTB_MODEM)
-#define RBTX4938_INTF_SWINT	(1 << RBTX4938_INTB_SWINT)
-
-#define rbtx4938_fpga_rev_addr	((__u8 __iomem *)RBTX4938_FPGA_REV_ADDR)
-#define rbtx4938_led_addr	((__u8 __iomem *)RBTX4938_LED_ADDR)
-#define rbtx4938_dipsw_addr	((__u8 __iomem *)RBTX4938_DIPSW_ADDR)
-#define rbtx4938_bdipsw_addr	((__u8 __iomem *)RBTX4938_BDIPSW_ADDR)
-#define rbtx4938_imask_addr	((__u8 __iomem *)RBTX4938_IMASK_ADDR)
-#define rbtx4938_imask2_addr	((__u8 __iomem *)RBTX4938_IMASK2_ADDR)
-#define rbtx4938_intpol_addr	((__u8 __iomem *)RBTX4938_INTPOL_ADDR)
-#define rbtx4938_istat_addr	((__u8 __iomem *)RBTX4938_ISTAT_ADDR)
-#define rbtx4938_istat2_addr	((__u8 __iomem *)RBTX4938_ISTAT2_ADDR)
-#define rbtx4938_imstat_addr	((__u8 __iomem *)RBTX4938_IMSTAT_ADDR)
-#define rbtx4938_imstat2_addr	((__u8 __iomem *)RBTX4938_IMSTAT2_ADDR)
-#define rbtx4938_softint_addr	((__u8 __iomem *)RBTX4938_SOFTINT_ADDR)
-#define rbtx4938_piosel_addr	((__u8 __iomem *)RBTX4938_PIOSEL_ADDR)
-#define rbtx4938_spics_addr	((__u8 __iomem *)RBTX4938_SPICS_ADDR)
-#define rbtx4938_sfpwr_addr	((__u8 __iomem *)RBTX4938_SFPWR_ADDR)
-#define rbtx4938_sfvol_addr	((__u8 __iomem *)RBTX4938_SFVOL_ADDR)
-#define rbtx4938_softreset_addr	((__u8 __iomem *)RBTX4938_SOFTRESET_ADDR)
-#define rbtx4938_softresetlock_addr	\
-				((__u8 __iomem *)RBTX4938_SOFTRESETLOCK_ADDR)
-#define rbtx4938_pcireset_addr	((__u8 __iomem *)RBTX4938_PCIRESET_ADDR)
-
-/*
- * IRQ mappings
- */
-
-#define RBTX4938_SOFT_INT0	0	/* not used */
-#define RBTX4938_SOFT_INT1	1	/* not used */
-#define RBTX4938_IRC_INT	2
-#define RBTX4938_TIMER_INT	7
-
-/* These are the virtual IRQ numbers, we divide all IRQ's into
- * 'spaces', the 'space' determines where and how to enable/disable
- * that particular IRQ on an RBTX4938 machine.  Add new 'spaces' as new
- * IRQ hardware is supported.
- */
-#define RBTX4938_NR_IRQ_LOCAL	8
-#define RBTX4938_NR_IRQ_IRC	32	/* On-Chip IRC */
-#define RBTX4938_NR_IRQ_IOC	8
-
-#define TX4938_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
-#define TX4938_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
-
-#define TX4938_IRQ_PIC_BEG  TXX9_IRQ_BASE
-#define TX4938_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
-#define TX4938_IRQ_NEST_EXT_ON_PIC  (TX4938_IRQ_PIC_BEG+2)
-#define TX4938_IRQ_NEST_PIC_ON_CP0  (TX4938_IRQ_CP0_BEG+2)
-#define TX4938_IRQ_USER0            (TX4938_IRQ_CP0_BEG+0)
-#define TX4938_IRQ_USER1            (TX4938_IRQ_CP0_BEG+1)
-#define TX4938_IRQ_CPU_TIMER        (TX4938_IRQ_CP0_BEG+7)
-
-#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG   0
-#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_END   7
-
-#define TOSHIBA_RBTX4938_IRQ_IOC_BEG  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG) /* 56 */
-#define TOSHIBA_RBTX4938_IRQ_IOC_END  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_END) /* 63 */
-#define RBTX4938_IRQ_LOCAL	TX4938_IRQ_CP0_BEG
-#define RBTX4938_IRQ_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_NR_IRQ_LOCAL)
-#define RBTX4938_IRQ_IOC	(RBTX4938_IRQ_IRC + RBTX4938_NR_IRQ_IRC)
-#define RBTX4938_IRQ_END	(RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC)
-
-#define RBTX4938_IRQ_LOCAL_SOFT0	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT0)
-#define RBTX4938_IRQ_LOCAL_SOFT1	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT1)
-#define RBTX4938_IRQ_LOCAL_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_IRC_INT)
-#define RBTX4938_IRQ_LOCAL_TIMER	(RBTX4938_IRQ_LOCAL + RBTX4938_TIMER_INT)
-#define RBTX4938_IRQ_IRC_ECCERR	(RBTX4938_IRQ_IRC + TX4938_IR_ECCERR)
-#define RBTX4938_IRQ_IRC_WTOERR	(RBTX4938_IRQ_IRC + TX4938_IR_WTOERR)
-#define RBTX4938_IRQ_IRC_INT(n)	(RBTX4938_IRQ_IRC + TX4938_IR_INT(n))
-#define RBTX4938_IRQ_IRC_SIO(n)	(RBTX4938_IRQ_IRC + TX4938_IR_SIO(n))
-#define RBTX4938_IRQ_IRC_DMA(ch, n)	(RBTX4938_IRQ_IRC + TX4938_IR_DMA(ch, n))
-#define RBTX4938_IRQ_IRC_PIO	(RBTX4938_IRQ_IRC + TX4938_IR_PIO)
-#define RBTX4938_IRQ_IRC_PDMAC	(RBTX4938_IRQ_IRC + TX4938_IR_PDMAC)
-#define RBTX4938_IRQ_IRC_PCIC	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC)
-#define RBTX4938_IRQ_IRC_TMR(n)	(RBTX4938_IRQ_IRC + TX4938_IR_TMR(n))
-#define RBTX4938_IRQ_IRC_NDFMC	(RBTX4938_IRQ_IRC + TX4938_IR_NDFMC)
-#define RBTX4938_IRQ_IRC_PCIERR	(RBTX4938_IRQ_IRC + TX4938_IR_PCIERR)
-#define RBTX4938_IRQ_IRC_PCIPME	(RBTX4938_IRQ_IRC + TX4938_IR_PCIPME)
-#define RBTX4938_IRQ_IRC_ACLC	(RBTX4938_IRQ_IRC + TX4938_IR_ACLC)
-#define RBTX4938_IRQ_IRC_ACLCPME	(RBTX4938_IRQ_IRC + TX4938_IR_ACLCPME)
-#define RBTX4938_IRQ_IRC_PCIC1	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC1)
-#define RBTX4938_IRQ_IRC_SPI	(RBTX4938_IRQ_IRC + TX4938_IR_SPI)
-#define RBTX4938_IRQ_IOC_PCID	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCID)
-#define RBTX4938_IRQ_IOC_PCIC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIC)
-#define RBTX4938_IRQ_IOC_PCIB	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIB)
-#define RBTX4938_IRQ_IOC_PCIA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIA)
-#define RBTX4938_IRQ_IOC_RTC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_RTC)
-#define RBTX4938_IRQ_IOC_ATA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_ATA)
-#define RBTX4938_IRQ_IOC_MODEM	(RBTX4938_IRQ_IOC + RBTX4938_INTB_MODEM)
-#define RBTX4938_IRQ_IOC_SWINT	(RBTX4938_IRQ_IOC + RBTX4938_INTB_SWINT)
-
-
-/* IOC (PCI, etc) */
-#define RBTX4938_IRQ_IOCINT	(TX4938_IRQ_NEST_EXT_ON_PIC)
-/* Onboard 10M Ether */
-#define RBTX4938_IRQ_ETHER	(TX4938_IRQ_NEST_EXT_ON_PIC + 1)
-
-#define RBTX4938_RTL_8019_BASE (RBTX4938_ETHER_ADDR - mips_io_port_base)
-#define RBTX4938_RTL_8019_IRQ  (RBTX4938_IRQ_ETHER)
-
-#endif /* __ASM_TX_BOARDS_RBTX4938_H */
diff --git a/include/asm-mips/tx4938/spi.h b/include/asm-mips/tx4938/spi.h
deleted file mode 100644
index 6a60c83..0000000
--- a/include/asm-mips/tx4938/spi.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * linux/include/asm-mips/tx4938/spi.h
- * Definitions for TX4937/TX4938 SPI
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#ifndef __ASM_TX_BOARDS_TX4938_SPI_H
-#define __ASM_TX_BOARDS_TX4938_SPI_H
-
-extern int spi_eeprom_register(int chipid);
-extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
-
-#endif /* __ASM_TX_BOARDS_TX4938_SPI_H */
diff --git a/include/asm-mips/tx4938/tx4938.h b/include/asm-mips/tx4938/tx4938.h
deleted file mode 100644
index e8807f5..0000000
--- a/include/asm-mips/tx4938/tx4938.h
+++ /dev/null
@@ -1,628 +0,0 @@
-/*
- * linux/include/asm-mips/tx4938/tx4938.h
- * Definitions for TX4937/TX4938
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#ifndef __ASM_TX_BOARDS_TX4938_H
-#define __ASM_TX_BOARDS_TX4938_H
-
-#define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
-#define tx4938_write_nfmc(b, addr) (*(volatile unsigned int *)(addr)) = (b)
-
-#define TX4938_NR_IRQ_LOCAL     TX4938_IRQ_PIC_BEG
-
-#define TX4938_IRQ_IRC_PCIC     (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIC)
-#define TX4938_IRQ_IRC_PCIERR   (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIERR)
-
-#define TX4938_PCIIO_0 0x10000000
-#define TX4938_PCIIO_1 0x01010000
-#define TX4938_PCIMEM_0 0x08000000
-#define TX4938_PCIMEM_1 0x11000000
-
-#define TX4938_PCIIO_SIZE_0 0x01000000
-#define TX4938_PCIIO_SIZE_1 0x00010000
-#define TX4938_PCIMEM_SIZE_0 0x08000000
-#define TX4938_PCIMEM_SIZE_1 0x00010000
-
-#define TX4938_REG_BASE	0xff1f0000 /* == TX4937_REG_BASE */
-#define TX4938_REG_SIZE	0x00010000 /* == TX4937_REG_SIZE */
-
-/* NDFMC, SRAMC, PCIC1, SPIC: TX4938 only */
-#define TX4938_NDFMC_REG	(TX4938_REG_BASE + 0x5000)
-#define TX4938_SRAMC_REG	(TX4938_REG_BASE + 0x6000)
-#define TX4938_PCIC1_REG	(TX4938_REG_BASE + 0x7000)
-#define TX4938_SDRAMC_REG	(TX4938_REG_BASE + 0x8000)
-#define TX4938_EBUSC_REG	(TX4938_REG_BASE + 0x9000)
-#define TX4938_DMA_REG(ch)	(TX4938_REG_BASE + 0xb000 + (ch) * 0x800)
-#define TX4938_PCIC_REG		(TX4938_REG_BASE + 0xd000)
-#define TX4938_CCFG_REG		(TX4938_REG_BASE + 0xe000)
-#define TX4938_NR_TMR	3
-#define TX4938_TMR_REG(ch)	((TX4938_REG_BASE + 0xf000) + (ch) * 0x100)
-#define TX4938_NR_SIO	2
-#define TX4938_SIO_REG(ch)	((TX4938_REG_BASE + 0xf300) + (ch) * 0x100)
-#define TX4938_PIO_REG		(TX4938_REG_BASE + 0xf500)
-#define TX4938_IRC_REG		(TX4938_REG_BASE + 0xf600)
-#define TX4938_ACLC_REG		(TX4938_REG_BASE + 0xf700)
-#define TX4938_SPI_REG		(TX4938_REG_BASE + 0xf800)
-
-#ifdef __ASSEMBLY__
-#define _CONST64(c)	c
-#else
-#define _CONST64(c)	c##ull
-
-#include <asm/byteorder.h>
-
-#ifdef __BIG_ENDIAN
-#define endian_def_l2(e1, e2)	\
-	volatile unsigned long e1, e2
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e1, e2
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned short e1;volatile unsigned char e2, e3
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned char e1, e2;volatile unsigned short e3
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e1, e2, e3, e4
-#else
-#define endian_def_l2(e1, e2)	\
-	volatile unsigned long e2, e1
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e2, e1
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned char e3, e2;volatile unsigned short e1
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned short e3;volatile unsigned char e2, e1
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e4, e3, e2, e1
-#endif
-
-
-struct tx4938_sdramc_reg {
-	volatile unsigned long long cr[4];
-	volatile unsigned long long unused0[4];
-	volatile unsigned long long tr;
-	volatile unsigned long long unused1[2];
-	volatile unsigned long long cmd;
-	volatile unsigned long long sfcmd;
-};
-
-struct tx4938_ebusc_reg {
-	volatile unsigned long long cr[8];
-};
-
-struct tx4938_dma_reg {
-	struct tx4938_dma_ch_reg {
-		volatile unsigned long long cha;
-		volatile unsigned long long sar;
-		volatile unsigned long long dar;
-		endian_def_l2(unused0, cntr);
-		endian_def_l2(unused1, sair);
-		endian_def_l2(unused2, dair);
-		endian_def_l2(unused3, ccr);
-		endian_def_l2(unused4, csr);
-	} ch[4];
-	volatile unsigned long long dbr[8];
-	volatile unsigned long long tdhr;
-	volatile unsigned long long midr;
-	endian_def_l2(unused0, mcr);
-};
-
-struct tx4938_pcic_reg {
-	volatile unsigned long pciid;
-	volatile unsigned long pcistatus;
-	volatile unsigned long pciccrev;
-	volatile unsigned long pcicfg1;
-	volatile unsigned long p2gm0plbase;		/* +10 */
-	volatile unsigned long p2gm0pubase;
-	volatile unsigned long p2gm1plbase;
-	volatile unsigned long p2gm1pubase;
-	volatile unsigned long p2gm2pbase;		/* +20 */
-	volatile unsigned long p2giopbase;
-	volatile unsigned long unused0;
-	volatile unsigned long pcisid;
-	volatile unsigned long unused1;		/* +30 */
-	volatile unsigned long pcicapptr;
-	volatile unsigned long unused2;
-	volatile unsigned long pcicfg2;
-	volatile unsigned long g2ptocnt;		/* +40 */
-	volatile unsigned long unused3[15];
-	volatile unsigned long g2pstatus;		/* +80 */
-	volatile unsigned long g2pmask;
-	volatile unsigned long pcisstatus;
-	volatile unsigned long pcimask;
-	volatile unsigned long p2gcfg;		/* +90 */
-	volatile unsigned long p2gstatus;
-	volatile unsigned long p2gmask;
-	volatile unsigned long p2gccmd;
-	volatile unsigned long unused4[24];		/* +a0 */
-	volatile unsigned long pbareqport;		/* +100 */
-	volatile unsigned long pbacfg;
-	volatile unsigned long pbastatus;
-	volatile unsigned long pbamask;
-	volatile unsigned long pbabm;		/* +110 */
-	volatile unsigned long pbacreq;
-	volatile unsigned long pbacgnt;
-	volatile unsigned long pbacstate;
-	volatile unsigned long long g2pmgbase[3];		/* +120 */
-	volatile unsigned long long g2piogbase;
-	volatile unsigned long g2pmmask[3];		/* +140 */
-	volatile unsigned long g2piomask;
-	volatile unsigned long long g2pmpbase[3];		/* +150 */
-	volatile unsigned long long g2piopbase;
-	volatile unsigned long pciccfg;		/* +170 */
-	volatile unsigned long pcicstatus;
-	volatile unsigned long pcicmask;
-	volatile unsigned long unused5;
-	volatile unsigned long long p2gmgbase[3];		/* +180 */
-	volatile unsigned long long p2giogbase;
-	volatile unsigned long g2pcfgadrs;		/* +1a0 */
-	volatile unsigned long g2pcfgdata;
-	volatile unsigned long unused6[8];
-	volatile unsigned long g2pintack;
-	volatile unsigned long g2pspc;
-	volatile unsigned long unused7[12];		/* +1d0 */
-	volatile unsigned long long pdmca;		/* +200 */
-	volatile unsigned long long pdmga;
-	volatile unsigned long long pdmpa;
-	volatile unsigned long long pdmctr;
-	volatile unsigned long long pdmcfg;		/* +220 */
-	volatile unsigned long long pdmsts;
-};
-
-struct tx4938_aclc_reg {
-	volatile unsigned long acctlen;
-	volatile unsigned long acctldis;
-	volatile unsigned long acregacc;
-	volatile unsigned long unused0;
-	volatile unsigned long acintsts;
-	volatile unsigned long acintmsts;
-	volatile unsigned long acinten;
-	volatile unsigned long acintdis;
-	volatile unsigned long acsemaph;
-	volatile unsigned long unused1[7];
-	volatile unsigned long acgpidat;
-	volatile unsigned long acgpodat;
-	volatile unsigned long acslten;
-	volatile unsigned long acsltdis;
-	volatile unsigned long acfifosts;
-	volatile unsigned long unused2[11];
-	volatile unsigned long acdmasts;
-	volatile unsigned long acdmasel;
-	volatile unsigned long unused3[6];
-	volatile unsigned long acaudodat;
-	volatile unsigned long acsurrdat;
-	volatile unsigned long accentdat;
-	volatile unsigned long aclfedat;
-	volatile unsigned long acaudiat;
-	volatile unsigned long unused4;
-	volatile unsigned long acmodoat;
-	volatile unsigned long acmodidat;
-	volatile unsigned long unused5[15];
-	volatile unsigned long acrevid;
-};
-
-
-struct tx4938_tmr_reg {
-	volatile unsigned long tcr;
-	volatile unsigned long tisr;
-	volatile unsigned long cpra;
-	volatile unsigned long cprb;
-	volatile unsigned long itmr;
-	volatile unsigned long unused0[3];
-	volatile unsigned long ccdr;
-	volatile unsigned long unused1[3];
-	volatile unsigned long pgmr;
-	volatile unsigned long unused2[3];
-	volatile unsigned long wtmr;
-	volatile unsigned long unused3[43];
-	volatile unsigned long trr;
-};
-
-struct tx4938_sio_reg {
-	volatile unsigned long lcr;
-	volatile unsigned long dicr;
-	volatile unsigned long disr;
-	volatile unsigned long cisr;
-	volatile unsigned long fcr;
-	volatile unsigned long flcr;
-	volatile unsigned long bgr;
-	volatile unsigned long tfifo;
-	volatile unsigned long rfifo;
-};
-
-struct tx4938_ndfmc_reg {
-	endian_def_l2(unused0, dtr);
-	endian_def_l2(unused1, mcr);
-	endian_def_l2(unused2, sr);
-	endian_def_l2(unused3, isr);
-	endian_def_l2(unused4, imr);
-	endian_def_l2(unused5, spr);
-	endian_def_l2(unused6, rstr);
-};
-
-struct tx4938_spi_reg {
-	volatile unsigned long mcr;
-	volatile unsigned long cr0;
-	volatile unsigned long cr1;
-	volatile unsigned long fs;
-	volatile unsigned long unused1;
-	volatile unsigned long sr;
-	volatile unsigned long dr;
-	volatile unsigned long unused2;
-};
-
-struct tx4938_sramc_reg {
-	volatile unsigned long long cr;
-};
-
-struct tx4938_ccfg_reg {
-	volatile unsigned long long ccfg;
-	volatile unsigned long long crir;
-	volatile unsigned long long pcfg;
-	volatile unsigned long long tear;
-	volatile unsigned long long clkctr;
-	volatile unsigned long long unused0;
-	volatile unsigned long long garbc;
-	volatile unsigned long long unused1;
-	volatile unsigned long long unused2;
-	volatile unsigned long long ramp;
-	volatile unsigned long long unused3;
-	volatile unsigned long long jmpadr;
-};
-
-#undef endian_def_l2
-#undef endian_def_s2
-#undef endian_def_sb2
-#undef endian_def_b2s
-#undef endian_def_b4
-
-#endif /* __ASSEMBLY__ */
-
-/*
- * NDFMC
- */
-
-/* NDFMCR : NDFMC Mode Control */
-#define TX4938_NDFMCR_WE	0x80
-#define TX4938_NDFMCR_ECC_ALL	0x60
-#define TX4938_NDFMCR_ECC_RESET	0x60
-#define TX4938_NDFMCR_ECC_READ	0x40
-#define TX4938_NDFMCR_ECC_ON	0x20
-#define TX4938_NDFMCR_ECC_OFF	0x00
-#define TX4938_NDFMCR_CE	0x10
-#define TX4938_NDFMCR_BSPRT	0x04
-#define TX4938_NDFMCR_ALE	0x02
-#define TX4938_NDFMCR_CLE	0x01
-
-/* NDFMCR : NDFMC Status */
-#define TX4938_NDFSR_BUSY	0x80
-
-/* NDFMCR : NDFMC Reset */
-#define TX4938_NDFRSTR_RST	0x01
-
-/*
- * IRC
- */
-
-#define TX4938_IR_ECCERR	0
-#define TX4938_IR_WTOERR	1
-#define TX4938_NUM_IR_INT	6
-#define TX4938_IR_INT(n)	(2 + (n))
-#define TX4938_NUM_IR_SIO	2
-#define TX4938_IR_SIO(n)	(8 + (n))
-#define TX4938_NUM_IR_DMA	4
-#define TX4938_IR_DMA(ch, n)	((ch ? 27 : 10) + (n)) /* 10-13, 27-30 */
-#define TX4938_IR_PIO	14
-#define TX4938_IR_PDMAC	15
-#define TX4938_IR_PCIC	16
-#define TX4938_NUM_IR_TMR	3
-#define TX4938_IR_TMR(n)	(17 + (n))
-#define TX4938_IR_NDFMC	21
-#define TX4938_IR_PCIERR	22
-#define TX4938_IR_PCIPME	23
-#define TX4938_IR_ACLC	24
-#define TX4938_IR_ACLCPME	25
-#define TX4938_IR_PCIC1	26
-#define TX4938_IR_SPI	31
-#define TX4938_NUM_IR	32
-/* multiplex */
-#define TX4938_IR_ETH0	TX4938_IR_INT(4)
-#define TX4938_IR_ETH1	TX4938_IR_INT(3)
-
-/*
- * CCFG
- */
-/* CCFG : Chip Configuration */
-#define TX4938_CCFG_WDRST	_CONST64(0x0000020000000000)
-#define TX4938_CCFG_WDREXEN	_CONST64(0x0000010000000000)
-#define TX4938_CCFG_BCFG_MASK	_CONST64(0x000000ff00000000)
-#define TX4938_CCFG_TINTDIS	0x01000000
-#define TX4938_CCFG_PCI66	0x00800000
-#define TX4938_CCFG_PCIMODE	0x00400000
-#define TX4938_CCFG_PCI1_66	0x00200000
-#define TX4938_CCFG_DIVMODE_MASK	0x001e0000
-#define TX4938_CCFG_DIVMODE_2	(0x4 << 17)
-#define TX4938_CCFG_DIVMODE_2_5	(0xf << 17)
-#define TX4938_CCFG_DIVMODE_3	(0x5 << 17)
-#define TX4938_CCFG_DIVMODE_4	(0x6 << 17)
-#define TX4938_CCFG_DIVMODE_4_5	(0xd << 17)
-#define TX4938_CCFG_DIVMODE_8	(0x0 << 17)
-#define TX4938_CCFG_DIVMODE_10	(0xb << 17)
-#define TX4938_CCFG_DIVMODE_12	(0x1 << 17)
-#define TX4938_CCFG_DIVMODE_16	(0x2 << 17)
-#define TX4938_CCFG_DIVMODE_18	(0x9 << 17)
-#define TX4938_CCFG_BEOW	0x00010000
-#define TX4938_CCFG_WR	0x00008000
-#define TX4938_CCFG_TOE	0x00004000
-#define TX4938_CCFG_PCIXARB	0x00002000
-#define TX4938_CCFG_PCIDIVMODE_MASK	0x00001c00
-#define TX4938_CCFG_PCIDIVMODE_4	(0x1 << 10)
-#define TX4938_CCFG_PCIDIVMODE_4_5	(0x3 << 10)
-#define TX4938_CCFG_PCIDIVMODE_5	(0x5 << 10)
-#define TX4938_CCFG_PCIDIVMODE_5_5	(0x7 << 10)
-#define TX4938_CCFG_PCIDIVMODE_8	(0x0 << 10)
-#define TX4938_CCFG_PCIDIVMODE_9	(0x2 << 10)
-#define TX4938_CCFG_PCIDIVMODE_10	(0x4 << 10)
-#define TX4938_CCFG_PCIDIVMODE_11	(0x6 << 10)
-#define TX4938_CCFG_PCI1DMD	0x00000100
-#define TX4938_CCFG_SYSSP_MASK	0x000000c0
-#define TX4938_CCFG_ENDIAN	0x00000004
-#define TX4938_CCFG_HALT	0x00000002
-#define TX4938_CCFG_ACEHOLD	0x00000001
-
-/* PCFG : Pin Configuration */
-#define TX4938_PCFG_ETH0_SEL	_CONST64(0x8000000000000000)
-#define TX4938_PCFG_ETH1_SEL	_CONST64(0x4000000000000000)
-#define TX4938_PCFG_ATA_SEL	_CONST64(0x2000000000000000)
-#define TX4938_PCFG_ISA_SEL	_CONST64(0x1000000000000000)
-#define TX4938_PCFG_SPI_SEL	_CONST64(0x0800000000000000)
-#define TX4938_PCFG_NDF_SEL	_CONST64(0x0400000000000000)
-#define TX4938_PCFG_SDCLKDLY_MASK	0x30000000
-#define TX4938_PCFG_SDCLKDLY(d)	((d)<<28)
-#define TX4938_PCFG_SYSCLKEN	0x08000000
-#define TX4938_PCFG_SDCLKEN_ALL	0x07800000
-#define TX4938_PCFG_SDCLKEN(ch)	(0x00800000<<(ch))
-#define TX4938_PCFG_PCICLKEN_ALL	0x003f0000
-#define TX4938_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
-#define TX4938_PCFG_SEL2	0x00000200
-#define TX4938_PCFG_SEL1	0x00000100
-#define TX4938_PCFG_DMASEL_ALL	0x0000000f
-#define TX4938_PCFG_DMASEL0_DRQ0	0x00000000
-#define TX4938_PCFG_DMASEL0_SIO1	0x00000001
-#define TX4938_PCFG_DMASEL1_DRQ1	0x00000000
-#define TX4938_PCFG_DMASEL1_SIO1	0x00000002
-#define TX4938_PCFG_DMASEL2_DRQ2	0x00000000
-#define TX4938_PCFG_DMASEL2_SIO0	0x00000004
-#define TX4938_PCFG_DMASEL3_DRQ3	0x00000000
-#define TX4938_PCFG_DMASEL3_SIO0	0x00000008
-
-/* CLKCTR : Clock Control */
-#define TX4938_CLKCTR_NDFCKD	_CONST64(0x0001000000000000)
-#define TX4938_CLKCTR_NDFRST	_CONST64(0x0000000100000000)
-#define TX4938_CLKCTR_ETH1CKD	0x80000000
-#define TX4938_CLKCTR_ETH0CKD	0x40000000
-#define TX4938_CLKCTR_SPICKD	0x20000000
-#define TX4938_CLKCTR_SRAMCKD	0x10000000
-#define TX4938_CLKCTR_PCIC1CKD	0x08000000
-#define TX4938_CLKCTR_DMA1CKD	0x04000000
-#define TX4938_CLKCTR_ACLCKD	0x02000000
-#define TX4938_CLKCTR_PIOCKD	0x01000000
-#define TX4938_CLKCTR_DMACKD	0x00800000
-#define TX4938_CLKCTR_PCICKD	0x00400000
-#define TX4938_CLKCTR_TM0CKD	0x00100000
-#define TX4938_CLKCTR_TM1CKD	0x00080000
-#define TX4938_CLKCTR_TM2CKD	0x00040000
-#define TX4938_CLKCTR_SIO0CKD	0x00020000
-#define TX4938_CLKCTR_SIO1CKD	0x00010000
-#define TX4938_CLKCTR_ETH1RST	0x00008000
-#define TX4938_CLKCTR_ETH0RST	0x00004000
-#define TX4938_CLKCTR_SPIRST	0x00002000
-#define TX4938_CLKCTR_SRAMRST	0x00001000
-#define TX4938_CLKCTR_PCIC1RST	0x00000800
-#define TX4938_CLKCTR_DMA1RST	0x00000400
-#define TX4938_CLKCTR_ACLRST	0x00000200
-#define TX4938_CLKCTR_PIORST	0x00000100
-#define TX4938_CLKCTR_DMARST	0x00000080
-#define TX4938_CLKCTR_PCIRST	0x00000040
-#define TX4938_CLKCTR_TM0RST	0x00000010
-#define TX4938_CLKCTR_TM1RST	0x00000008
-#define TX4938_CLKCTR_TM2RST	0x00000004
-#define TX4938_CLKCTR_SIO0RST	0x00000002
-#define TX4938_CLKCTR_SIO1RST	0x00000001
-
-/* bits for G2PSTATUS/G2PMASK */
-#define TX4938_PCIC_G2PSTATUS_ALL	0x00000003
-#define TX4938_PCIC_G2PSTATUS_TTOE	0x00000002
-#define TX4938_PCIC_G2PSTATUS_RTOE	0x00000001
-
-/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX4938_PCIC_PCISTATUS_ALL	0x0000f900
-
-/* bits for PBACFG */
-#define TX4938_PCIC_PBACFG_FIXPA	0x00000008
-#define TX4938_PCIC_PBACFG_RPBA	0x00000004
-#define TX4938_PCIC_PBACFG_PBAEN	0x00000002
-#define TX4938_PCIC_PBACFG_BMCEN	0x00000001
-
-/* bits for G2PMnGBASE */
-#define TX4938_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for G2PIOGBASE */
-#define TX4938_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
-
-/* bits for PCICSTATUS/PCICMASK */
-#define TX4938_PCIC_PCICSTATUS_ALL	0x000007b8
-#define TX4938_PCIC_PCICSTATUS_PME	0x00000400
-#define TX4938_PCIC_PCICSTATUS_TLB	0x00000200
-#define TX4938_PCIC_PCICSTATUS_NIB	0x00000100
-#define TX4938_PCIC_PCICSTATUS_ZIB	0x00000080
-#define TX4938_PCIC_PCICSTATUS_PERR	0x00000020
-#define TX4938_PCIC_PCICSTATUS_SERR	0x00000010
-#define TX4938_PCIC_PCICSTATUS_GBE	0x00000008
-#define TX4938_PCIC_PCICSTATUS_IWB	0x00000002
-#define TX4938_PCIC_PCICSTATUS_E2PDONE	0x00000001
-
-/* bits for PCICCFG */
-#define TX4938_PCIC_PCICCFG_GBWC_MASK	0x0fff0000
-#define TX4938_PCIC_PCICCFG_HRST	0x00000800
-#define TX4938_PCIC_PCICCFG_SRST	0x00000400
-#define TX4938_PCIC_PCICCFG_IRBER	0x00000200
-#define TX4938_PCIC_PCICCFG_G2PMEN(ch)	(0x00000100>>(ch))
-#define TX4938_PCIC_PCICCFG_G2PM0EN	0x00000100
-#define TX4938_PCIC_PCICCFG_G2PM1EN	0x00000080
-#define TX4938_PCIC_PCICCFG_G2PM2EN	0x00000040
-#define TX4938_PCIC_PCICCFG_G2PIOEN	0x00000020
-#define TX4938_PCIC_PCICCFG_TCAR	0x00000010
-#define TX4938_PCIC_PCICCFG_ICAEN	0x00000008
-
-/* bits for P2GMnGBASE */
-#define TX4938_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
-#define TX4938_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
-
-/* bits for P2GIOGBASE */
-#define TX4938_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
-#define TX4938_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
-#define TX4938_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
-
-#define TX4938_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
-#define TX4938_PCIC_MAX_DEVNU	TX4938_PCIC_IDSEL_AD_TO_SLOT(32)
-
-/* bits for PDMCFG */
-#define TX4938_PCIC_PDMCFG_RSTFIFO	0x00200000
-#define TX4938_PCIC_PDMCFG_EXFER	0x00100000
-#define TX4938_PCIC_PDMCFG_REQDLY_MASK	0x00003800
-#define TX4938_PCIC_PDMCFG_REQDLY_NONE	(0 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_16	(1 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_32	(2 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_64	(3 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_128	(4 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_256	(5 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_512	(6 << 11)
-#define TX4938_PCIC_PDMCFG_REQDLY_1024	(7 << 11)
-#define TX4938_PCIC_PDMCFG_ERRIE	0x00000400
-#define TX4938_PCIC_PDMCFG_NCCMPIE	0x00000200
-#define TX4938_PCIC_PDMCFG_NTCMPIE	0x00000100
-#define TX4938_PCIC_PDMCFG_CHNEN	0x00000080
-#define TX4938_PCIC_PDMCFG_XFRACT	0x00000040
-#define TX4938_PCIC_PDMCFG_BSWAP	0x00000020
-#define TX4938_PCIC_PDMCFG_XFRSIZE_MASK	0x0000000c
-#define TX4938_PCIC_PDMCFG_XFRSIZE_1DW	0x00000000
-#define TX4938_PCIC_PDMCFG_XFRSIZE_1QW	0x00000004
-#define TX4938_PCIC_PDMCFG_XFRSIZE_4QW	0x00000008
-#define TX4938_PCIC_PDMCFG_XFRDIRC	0x00000002
-#define TX4938_PCIC_PDMCFG_CHRST	0x00000001
-
-/* bits for PDMSTS */
-#define TX4938_PCIC_PDMSTS_REQCNT_MASK	0x3f000000
-#define TX4938_PCIC_PDMSTS_FIFOCNT_MASK	0x00f00000
-#define TX4938_PCIC_PDMSTS_FIFOWP_MASK	0x000c0000
-#define TX4938_PCIC_PDMSTS_FIFORP_MASK	0x00030000
-#define TX4938_PCIC_PDMSTS_ERRINT	0x00000800
-#define TX4938_PCIC_PDMSTS_DONEINT	0x00000400
-#define TX4938_PCIC_PDMSTS_CHNEN	0x00000200
-#define TX4938_PCIC_PDMSTS_XFRACT	0x00000100
-#define TX4938_PCIC_PDMSTS_ACCMP	0x00000080
-#define TX4938_PCIC_PDMSTS_NCCMP	0x00000040
-#define TX4938_PCIC_PDMSTS_NTCMP	0x00000020
-#define TX4938_PCIC_PDMSTS_CFGERR	0x00000008
-#define TX4938_PCIC_PDMSTS_PCIERR	0x00000004
-#define TX4938_PCIC_PDMSTS_CHNERR	0x00000002
-#define TX4938_PCIC_PDMSTS_DATAERR	0x00000001
-#define TX4938_PCIC_PDMSTS_ALL_CMP	0x000000e0
-#define TX4938_PCIC_PDMSTS_ALL_ERR	0x0000000f
-
-/*
- * DMA
- */
-/* bits for MCR */
-#define TX4938_DMA_MCR_EIS(ch)	(0x10000000<<(ch))
-#define TX4938_DMA_MCR_DIS(ch)	(0x01000000<<(ch))
-#define TX4938_DMA_MCR_RSFIF	0x00000080
-#define TX4938_DMA_MCR_FIFUM(ch)	(0x00000008<<(ch))
-#define TX4938_DMA_MCR_RPRT	0x00000002
-#define TX4938_DMA_MCR_MSTEN	0x00000001
-
-/* bits for CCRn */
-#define TX4938_DMA_CCR_IMMCHN	0x20000000
-#define TX4938_DMA_CCR_USEXFSZ	0x10000000
-#define TX4938_DMA_CCR_LE	0x08000000
-#define TX4938_DMA_CCR_DBINH	0x04000000
-#define TX4938_DMA_CCR_SBINH	0x02000000
-#define TX4938_DMA_CCR_CHRST	0x01000000
-#define TX4938_DMA_CCR_RVBYTE	0x00800000
-#define TX4938_DMA_CCR_ACKPOL	0x00400000
-#define TX4938_DMA_CCR_REQPL	0x00200000
-#define TX4938_DMA_CCR_EGREQ	0x00100000
-#define TX4938_DMA_CCR_CHDN	0x00080000
-#define TX4938_DMA_CCR_DNCTL	0x00060000
-#define TX4938_DMA_CCR_EXTRQ	0x00010000
-#define TX4938_DMA_CCR_INTRQD	0x0000e000
-#define TX4938_DMA_CCR_INTENE	0x00001000
-#define TX4938_DMA_CCR_INTENC	0x00000800
-#define TX4938_DMA_CCR_INTENT	0x00000400
-#define TX4938_DMA_CCR_CHNEN	0x00000200
-#define TX4938_DMA_CCR_XFACT	0x00000100
-#define TX4938_DMA_CCR_SMPCHN	0x00000020
-#define TX4938_DMA_CCR_XFSZ(order)	(((order) << 2) & 0x0000001c)
-#define TX4938_DMA_CCR_XFSZ_1W	TX4938_DMA_CCR_XFSZ(2)
-#define TX4938_DMA_CCR_XFSZ_2W	TX4938_DMA_CCR_XFSZ(3)
-#define TX4938_DMA_CCR_XFSZ_4W	TX4938_DMA_CCR_XFSZ(4)
-#define TX4938_DMA_CCR_XFSZ_8W	TX4938_DMA_CCR_XFSZ(5)
-#define TX4938_DMA_CCR_XFSZ_16W	TX4938_DMA_CCR_XFSZ(6)
-#define TX4938_DMA_CCR_XFSZ_32W	TX4938_DMA_CCR_XFSZ(7)
-#define TX4938_DMA_CCR_MEMIO	0x00000002
-#define TX4938_DMA_CCR_SNGAD	0x00000001
-
-/* bits for CSRn */
-#define TX4938_DMA_CSR_CHNEN	0x00000400
-#define TX4938_DMA_CSR_STLXFER	0x00000200
-#define TX4938_DMA_CSR_CHNACT	0x00000100
-#define TX4938_DMA_CSR_ABCHC	0x00000080
-#define TX4938_DMA_CSR_NCHNC	0x00000040
-#define TX4938_DMA_CSR_NTRNFC	0x00000020
-#define TX4938_DMA_CSR_EXTDN	0x00000010
-#define TX4938_DMA_CSR_CFERR	0x00000008
-#define TX4938_DMA_CSR_CHERR	0x00000004
-#define TX4938_DMA_CSR_DESERR	0x00000002
-#define TX4938_DMA_CSR_SORERR	0x00000001
-
-#ifndef __ASSEMBLY__
-
-#define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
-#define tx4938_ebuscptr         ((struct tx4938_ebusc_reg *)TX4938_EBUSC_REG)
-#define tx4938_dmaptr(ch)	((struct tx4938_dma_reg *)TX4938_DMA_REG(ch))
-#define tx4938_ndfmcptr		((struct tx4938_ndfmc_reg *)TX4938_NDFMC_REG)
-#define tx4938_pcicptr		((struct tx4938_pcic_reg *)TX4938_PCIC_REG)
-#define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
-#define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
-#define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
-#define tx4938_pioptr		((struct txx9_pio_reg __iomem *)TX4938_PIO_REG)
-#define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
-#define tx4938_spiptr		((struct tx4938_spi_reg *)TX4938_SPI_REG)
-#define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
-
-
-#define TX4938_REV_MAJ_MIN()	((unsigned long)tx4938_ccfgptr->crir & 0x00ff)
-#define TX4938_REV_PCODE()	((unsigned long)tx4938_ccfgptr->crir >> 16)
-
-#define TX4938_SDRAMC_BA(ch)	((tx4938_sdramcptr->cr[ch] >> 49) << 21)
-#define TX4938_SDRAMC_SIZE(ch)	(((tx4938_sdramcptr->cr[ch] >> 33) + 1) << 21)
-
-#define TX4938_EBUSC_BA(ch)	((tx4938_ebuscptr->cr[ch] >> 48) << 20)
-#define TX4938_EBUSC_SIZE(ch)	\
-	(0x00100000 << ((unsigned long)(tx4938_ebuscptr->cr[ch] >> 8) & 0xf))
-
-
-#endif /* !__ASSEMBLY__ */
-
-#endif
diff --git a/include/asm-mips/txx9/jmr3927.h b/include/asm-mips/txx9/jmr3927.h
new file mode 100644
index 0000000..29e5498
--- /dev/null
+++ b/include/asm-mips/txx9/jmr3927.h
@@ -0,0 +1,177 @@
+/*
+ * Defines for the TJSYS JMR-TX3927
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ */
+#ifndef __ASM_TXX9_JMR3927_H
+#define __ASM_TXX9_JMR3927_H
+
+#include <asm/txx9/tx3927.h>
+#include <asm/addrspace.h>
+#include <asm/system.h>
+#include <asm/txx9irq.h>
+
+/* CS */
+#define JMR3927_ROMCE0	0x1fc00000	/* 4M */
+#define JMR3927_ROMCE1	0x1e000000	/* 4M */
+#define JMR3927_ROMCE2	0x14000000	/* 16M */
+#define JMR3927_ROMCE3	0x10000000	/* 64M */
+#define JMR3927_ROMCE5	0x1d000000	/* 4M */
+#define JMR3927_SDCS0	0x00000000	/* 32M */
+#define JMR3927_SDCS1	0x02000000	/* 32M */
+/* PCI Direct Mappings */
+
+#define JMR3927_PCIMEM	0x08000000
+#define JMR3927_PCIMEM_SIZE	0x08000000	/* 128M */
+#define JMR3927_PCIIO	0x15000000
+#define JMR3927_PCIIO_SIZE	0x01000000	/* 16M */
+
+#define JMR3927_SDRAM_SIZE	0x02000000	/* 32M */
+#define JMR3927_PORT_BASE	KSEG1
+
+/* Address map (virtual address) */
+#define JMR3927_ROM0_BASE	(KSEG1 + JMR3927_ROMCE0)
+#define JMR3927_ROM1_BASE	(KSEG1 + JMR3927_ROMCE1)
+#define JMR3927_IOC_BASE	(KSEG1 + JMR3927_ROMCE2)
+#define JMR3927_PCIMEM_BASE	(KSEG1 + JMR3927_PCIMEM)
+#define JMR3927_PCIIO_BASE	(KSEG1 + JMR3927_PCIIO)
+
+#define JMR3927_IOC_REV_ADDR	(JMR3927_IOC_BASE + 0x00000000)
+#define JMR3927_IOC_NVRAMB_ADDR	(JMR3927_IOC_BASE + 0x00010000)
+#define JMR3927_IOC_LED_ADDR	(JMR3927_IOC_BASE + 0x00020000)
+#define JMR3927_IOC_DIPSW_ADDR	(JMR3927_IOC_BASE + 0x00030000)
+#define JMR3927_IOC_BREV_ADDR	(JMR3927_IOC_BASE + 0x00040000)
+#define JMR3927_IOC_DTR_ADDR	(JMR3927_IOC_BASE + 0x00050000)
+#define JMR3927_IOC_INTS1_ADDR	(JMR3927_IOC_BASE + 0x00080000)
+#define JMR3927_IOC_INTS2_ADDR	(JMR3927_IOC_BASE + 0x00090000)
+#define JMR3927_IOC_INTM_ADDR	(JMR3927_IOC_BASE + 0x000a0000)
+#define JMR3927_IOC_INTP_ADDR	(JMR3927_IOC_BASE + 0x000b0000)
+#define JMR3927_IOC_RESET_ADDR	(JMR3927_IOC_BASE + 0x000f0000)
+
+/* Flash ROM */
+#define JMR3927_FLASH_BASE	(JMR3927_ROM0_BASE)
+#define JMR3927_FLASH_SIZE	0x00400000
+
+/* bits for IOC_REV/IOC_BREV (high byte) */
+#define JMR3927_IDT_MASK	0xfc
+#define JMR3927_REV_MASK	0x03
+#define JMR3927_IOC_IDT		0xe0
+
+/* bits for IOC_INTS1/IOC_INTS2/IOC_INTM/IOC_INTP (high byte) */
+#define JMR3927_IOC_INTB_PCIA	0
+#define JMR3927_IOC_INTB_PCIB	1
+#define JMR3927_IOC_INTB_PCIC	2
+#define JMR3927_IOC_INTB_PCID	3
+#define JMR3927_IOC_INTB_MODEM	4
+#define JMR3927_IOC_INTB_INT6	5
+#define JMR3927_IOC_INTB_INT7	6
+#define JMR3927_IOC_INTB_SOFT	7
+#define JMR3927_IOC_INTF_PCIA	(1 << JMR3927_IOC_INTF_PCIA)
+#define JMR3927_IOC_INTF_PCIB	(1 << JMR3927_IOC_INTB_PCIB)
+#define JMR3927_IOC_INTF_PCIC	(1 << JMR3927_IOC_INTB_PCIC)
+#define JMR3927_IOC_INTF_PCID	(1 << JMR3927_IOC_INTB_PCID)
+#define JMR3927_IOC_INTF_MODEM	(1 << JMR3927_IOC_INTB_MODEM)
+#define JMR3927_IOC_INTF_INT6	(1 << JMR3927_IOC_INTB_INT6)
+#define JMR3927_IOC_INTF_INT7	(1 << JMR3927_IOC_INTB_INT7)
+#define JMR3927_IOC_INTF_SOFT	(1 << JMR3927_IOC_INTB_SOFT)
+
+/* bits for IOC_RESET (high byte) */
+#define JMR3927_IOC_RESET_CPU	1
+#define JMR3927_IOC_RESET_PCI	2
+
+#if defined(__BIG_ENDIAN)
+#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)(a)) = (d))
+#define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)(a))
+#elif defined(__LITTLE_ENDIAN)
+#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)((a)^1)) = (d))
+#define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)((a)^1))
+#else
+#error "No Endian"
+#endif
+
+/* LED macro */
+#define jmr3927_led_set(n/*0-16*/)	jmr3927_ioc_reg_out(~(n), JMR3927_IOC_LED_ADDR)
+
+#define jmr3927_led_and_set(n/*0-16*/)	jmr3927_ioc_reg_out((~(n)) & jmr3927_ioc_reg_in(JMR3927_IOC_LED_ADDR), JMR3927_IOC_LED_ADDR)
+
+/* DIPSW4 macro */
+#define jmr3927_dipsw1()	(gpio_get_value(11) == 0)
+#define jmr3927_dipsw2()	(gpio_get_value(10) == 0)
+#define jmr3927_dipsw3()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 2) == 0)
+#define jmr3927_dipsw4()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 1) == 0)
+
+/*
+ * IRQ mappings
+ */
+
+/* These are the virtual IRQ numbers, we divide all IRQ's into
+ * 'spaces', the 'space' determines where and how to enable/disable
+ * that particular IRQ on an JMR machine.  Add new 'spaces' as new
+ * IRQ hardware is supported.
+ */
+#define JMR3927_NR_IRQ_IRC	16	/* On-Chip IRC */
+#define JMR3927_NR_IRQ_IOC	8	/* PCI/MODEM/INT[6:7] */
+
+#define JMR3927_IRQ_IRC	TXX9_IRQ_BASE
+#define JMR3927_IRQ_IOC	(JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC)
+#define JMR3927_IRQ_END	(JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC)
+
+#define JMR3927_IRQ_IRC_INT0	(JMR3927_IRQ_IRC + TX3927_IR_INT0)
+#define JMR3927_IRQ_IRC_INT1	(JMR3927_IRQ_IRC + TX3927_IR_INT1)
+#define JMR3927_IRQ_IRC_INT2	(JMR3927_IRQ_IRC + TX3927_IR_INT2)
+#define JMR3927_IRQ_IRC_INT3	(JMR3927_IRQ_IRC + TX3927_IR_INT3)
+#define JMR3927_IRQ_IRC_INT4	(JMR3927_IRQ_IRC + TX3927_IR_INT4)
+#define JMR3927_IRQ_IRC_INT5	(JMR3927_IRQ_IRC + TX3927_IR_INT5)
+#define JMR3927_IRQ_IRC_SIO0	(JMR3927_IRQ_IRC + TX3927_IR_SIO0)
+#define JMR3927_IRQ_IRC_SIO1	(JMR3927_IRQ_IRC + TX3927_IR_SIO1)
+#define JMR3927_IRQ_IRC_SIO(ch)	(JMR3927_IRQ_IRC + TX3927_IR_SIO(ch))
+#define JMR3927_IRQ_IRC_DMA	(JMR3927_IRQ_IRC + TX3927_IR_DMA)
+#define JMR3927_IRQ_IRC_PIO	(JMR3927_IRQ_IRC + TX3927_IR_PIO)
+#define JMR3927_IRQ_IRC_PCI	(JMR3927_IRQ_IRC + TX3927_IR_PCI)
+#define JMR3927_IRQ_IRC_TMR(ch)	(JMR3927_IRQ_IRC + TX3927_IR_TMR(ch))
+#define JMR3927_IRQ_IOC_PCIA	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIA)
+#define JMR3927_IRQ_IOC_PCIB	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIB)
+#define JMR3927_IRQ_IOC_PCIC	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCIC)
+#define JMR3927_IRQ_IOC_PCID	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_PCID)
+#define JMR3927_IRQ_IOC_MODEM	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_MODEM)
+#define JMR3927_IRQ_IOC_INT6	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT6)
+#define JMR3927_IRQ_IOC_INT7	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT7)
+#define JMR3927_IRQ_IOC_SOFT	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_SOFT)
+
+/* IOC (PCI, MODEM) */
+#define JMR3927_IRQ_IOCINT	JMR3927_IRQ_IRC_INT1
+/* TC35815 100M Ether (JMR-TX3912:JPW4:2-3 Short) */
+#define JMR3927_IRQ_ETHER0	JMR3927_IRQ_IRC_INT3
+
+/* Clocks */
+#define JMR3927_CORECLK	132710400	/* 132.7MHz */
+#define JMR3927_GBUSCLK	(JMR3927_CORECLK / 2)	/* 66.35MHz */
+#define JMR3927_IMCLK	(JMR3927_CORECLK / 4)	/* 33.17MHz */
+
+/*
+ * TX3927 Pin Configuration:
+ *
+ *	PCFG bits		Avail			Dead
+ *	SELSIO[1:0]:11		RXD[1:0], TXD[1:0]	PIO[6:3]
+ *	SELSIOC[0]:1		CTS[0], RTS[0]		INT[5:4]
+ *	SELSIOC[1]:0,SELDSF:0,	GSDAO[0],GPCST[3]	CTS[1], RTS[1],DSF,
+ *	  GDBGE*					  PIO[2:1]
+ *	SELDMA[2]:1		DMAREQ[2],DMAACK[2]	PIO[13:12]
+ *	SELTMR[2:0]:000					TIMER[1:0]
+ *	SELCS:0,SELDMA[1]:0	PIO[11;10]		SDCS_CE[7:6],
+ *							  DMAREQ[1],DMAACK[1]
+ *	SELDMA[0]:1		DMAREQ[0],DMAACK[0]	PIO[9:8]
+ *	SELDMA[3]:1		DMAREQ[3],DMAACK[3]	PIO[15:14]
+ *	SELDONE:1		DMADONE			PIO[7]
+ *
+ * Usable pins are:
+ *	RXD[1;0],TXD[1:0],CTS[0],RTS[0],
+ *	DMAREQ[0,2,3],DMAACK[0,2,3],DMADONE,PIO[0,10,11]
+ *	INT[3:0]
+ */
+
+#endif /* __ASM_TXX9_JMR3927_H */
diff --git a/include/asm-mips/txx9/rbtx4927.h b/include/asm-mips/txx9/rbtx4927.h
new file mode 100644
index 0000000..5531342
--- /dev/null
+++ b/include/asm-mips/txx9/rbtx4927.h
@@ -0,0 +1,49 @@
+/*
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2001-2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_TXX9_RBTX4927_H
+#define __ASM_TXX9_RBTX4927_H
+
+#include <asm/txx9/tx4927.h>
+
+#ifdef CONFIG_PCI
+#define TBTX4927_ISA_IO_OFFSET TX4927_PCIIO
+#else
+#define TBTX4927_ISA_IO_OFFSET 0
+#endif
+
+#define RBTX4927_SW_RESET_DO         (void __iomem *)0xbc00f000UL
+#define RBTX4927_SW_RESET_DO_SET                0x01
+
+#define RBTX4927_SW_RESET_ENABLE     (void __iomem *)0xbc00f002UL
+#define RBTX4927_SW_RESET_ENABLE_SET            0x01
+
+#define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
+#define RBTX4927_RTL_8019_IRQ  (TX4927_IRQ_PIC_BEG + 5)
+
+int toshiba_rbtx4927_irq_nested(int sw_irq);
+
+#endif /* __ASM_TXX9_RBTX4927_H */
diff --git a/include/asm-mips/txx9/rbtx4938.h b/include/asm-mips/txx9/rbtx4938.h
new file mode 100644
index 0000000..8450f73
--- /dev/null
+++ b/include/asm-mips/txx9/rbtx4938.h
@@ -0,0 +1,167 @@
+/*
+ * Definitions for TX4937/TX4938
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#ifndef __ASM_TXX9_RBTX4938_H
+#define __ASM_TXX9_RBTX4938_H
+
+#include <asm/addrspace.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9/tx4938.h>
+
+/* CS */
+#define RBTX4938_CE0	0x1c000000	/* 64M */
+#define RBTX4938_CE2	0x17f00000	/* 1M */
+
+/* Address map */
+#define RBTX4938_FPGA_REG_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000000)
+#define RBTX4938_FPGA_REV_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000002)
+#define RBTX4938_CONFIG1_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000004)
+#define RBTX4938_CONFIG2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000006)
+#define RBTX4938_CONFIG3_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000008)
+#define RBTX4938_LED_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001000)
+#define RBTX4938_DIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001002)
+#define RBTX4938_BDIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001004)
+#define RBTX4938_IMASK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002000)
+#define RBTX4938_IMASK2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002002)
+#define RBTX4938_INTPOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002004)
+#define RBTX4938_ISTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002006)
+#define RBTX4938_ISTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002008)
+#define RBTX4938_IMSTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200a)
+#define RBTX4938_IMSTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200c)
+#define RBTX4938_SOFTINT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00003000)
+#define RBTX4938_PIOSEL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005000)
+#define RBTX4938_SPICS_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005002)
+#define RBTX4938_SFPWR_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005008)
+#define RBTX4938_SFVOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000500a)
+#define RBTX4938_SOFTRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007000)
+#define RBTX4938_SOFTRESETLOCK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007002)
+#define RBTX4938_PCIRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007004)
+#define RBTX4938_ETHER_BASE	(KSEG1 + RBTX4938_CE2 + 0x00020000)
+
+/* Ethernet port address (Jumperless Mode (W12:Open)) */
+#define RBTX4938_ETHER_ADDR	(RBTX4938_ETHER_BASE + 0x280)
+
+/* bits for ISTAT/IMASK/IMSTAT */
+#define RBTX4938_INTB_PCID	0
+#define RBTX4938_INTB_PCIC	1
+#define RBTX4938_INTB_PCIB	2
+#define RBTX4938_INTB_PCIA	3
+#define RBTX4938_INTB_RTC	4
+#define RBTX4938_INTB_ATA	5
+#define RBTX4938_INTB_MODEM	6
+#define RBTX4938_INTB_SWINT	7
+#define RBTX4938_INTF_PCID	(1 << RBTX4938_INTB_PCID)
+#define RBTX4938_INTF_PCIC	(1 << RBTX4938_INTB_PCIC)
+#define RBTX4938_INTF_PCIB	(1 << RBTX4938_INTB_PCIB)
+#define RBTX4938_INTF_PCIA	(1 << RBTX4938_INTB_PCIA)
+#define RBTX4938_INTF_RTC	(1 << RBTX4938_INTB_RTC)
+#define RBTX4938_INTF_ATA	(1 << RBTX4938_INTB_ATA)
+#define RBTX4938_INTF_MODEM	(1 << RBTX4938_INTB_MODEM)
+#define RBTX4938_INTF_SWINT	(1 << RBTX4938_INTB_SWINT)
+
+#define rbtx4938_fpga_rev_addr	((__u8 __iomem *)RBTX4938_FPGA_REV_ADDR)
+#define rbtx4938_led_addr	((__u8 __iomem *)RBTX4938_LED_ADDR)
+#define rbtx4938_dipsw_addr	((__u8 __iomem *)RBTX4938_DIPSW_ADDR)
+#define rbtx4938_bdipsw_addr	((__u8 __iomem *)RBTX4938_BDIPSW_ADDR)
+#define rbtx4938_imask_addr	((__u8 __iomem *)RBTX4938_IMASK_ADDR)
+#define rbtx4938_imask2_addr	((__u8 __iomem *)RBTX4938_IMASK2_ADDR)
+#define rbtx4938_intpol_addr	((__u8 __iomem *)RBTX4938_INTPOL_ADDR)
+#define rbtx4938_istat_addr	((__u8 __iomem *)RBTX4938_ISTAT_ADDR)
+#define rbtx4938_istat2_addr	((__u8 __iomem *)RBTX4938_ISTAT2_ADDR)
+#define rbtx4938_imstat_addr	((__u8 __iomem *)RBTX4938_IMSTAT_ADDR)
+#define rbtx4938_imstat2_addr	((__u8 __iomem *)RBTX4938_IMSTAT2_ADDR)
+#define rbtx4938_softint_addr	((__u8 __iomem *)RBTX4938_SOFTINT_ADDR)
+#define rbtx4938_piosel_addr	((__u8 __iomem *)RBTX4938_PIOSEL_ADDR)
+#define rbtx4938_spics_addr	((__u8 __iomem *)RBTX4938_SPICS_ADDR)
+#define rbtx4938_sfpwr_addr	((__u8 __iomem *)RBTX4938_SFPWR_ADDR)
+#define rbtx4938_sfvol_addr	((__u8 __iomem *)RBTX4938_SFVOL_ADDR)
+#define rbtx4938_softreset_addr	((__u8 __iomem *)RBTX4938_SOFTRESET_ADDR)
+#define rbtx4938_softresetlock_addr	\
+				((__u8 __iomem *)RBTX4938_SOFTRESETLOCK_ADDR)
+#define rbtx4938_pcireset_addr	((__u8 __iomem *)RBTX4938_PCIRESET_ADDR)
+
+/*
+ * IRQ mappings
+ */
+
+#define RBTX4938_SOFT_INT0	0	/* not used */
+#define RBTX4938_SOFT_INT1	1	/* not used */
+#define RBTX4938_IRC_INT	2
+#define RBTX4938_TIMER_INT	7
+
+/* These are the virtual IRQ numbers, we divide all IRQ's into
+ * 'spaces', the 'space' determines where and how to enable/disable
+ * that particular IRQ on an RBTX4938 machine.  Add new 'spaces' as new
+ * IRQ hardware is supported.
+ */
+#define RBTX4938_NR_IRQ_LOCAL	8
+#define RBTX4938_NR_IRQ_IRC	32	/* On-Chip IRC */
+#define RBTX4938_NR_IRQ_IOC	8
+
+#define TX4938_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
+#define TX4938_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
+
+#define TX4938_IRQ_PIC_BEG  TXX9_IRQ_BASE
+#define TX4938_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
+#define TX4938_IRQ_NEST_EXT_ON_PIC  (TX4938_IRQ_PIC_BEG+2)
+#define TX4938_IRQ_NEST_PIC_ON_CP0  (TX4938_IRQ_CP0_BEG+2)
+#define TX4938_IRQ_USER0            (TX4938_IRQ_CP0_BEG+0)
+#define TX4938_IRQ_USER1            (TX4938_IRQ_CP0_BEG+1)
+#define TX4938_IRQ_CPU_TIMER        (TX4938_IRQ_CP0_BEG+7)
+
+#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG   0
+#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_END   7
+
+#define TOSHIBA_RBTX4938_IRQ_IOC_BEG  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG) /* 56 */
+#define TOSHIBA_RBTX4938_IRQ_IOC_END  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_END) /* 63 */
+#define RBTX4938_IRQ_LOCAL	TX4938_IRQ_CP0_BEG
+#define RBTX4938_IRQ_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_NR_IRQ_LOCAL)
+#define RBTX4938_IRQ_IOC	(RBTX4938_IRQ_IRC + RBTX4938_NR_IRQ_IRC)
+#define RBTX4938_IRQ_END	(RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC)
+
+#define RBTX4938_IRQ_LOCAL_SOFT0	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT0)
+#define RBTX4938_IRQ_LOCAL_SOFT1	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT1)
+#define RBTX4938_IRQ_LOCAL_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_IRC_INT)
+#define RBTX4938_IRQ_LOCAL_TIMER	(RBTX4938_IRQ_LOCAL + RBTX4938_TIMER_INT)
+#define RBTX4938_IRQ_IRC_ECCERR	(RBTX4938_IRQ_IRC + TX4938_IR_ECCERR)
+#define RBTX4938_IRQ_IRC_WTOERR	(RBTX4938_IRQ_IRC + TX4938_IR_WTOERR)
+#define RBTX4938_IRQ_IRC_INT(n)	(RBTX4938_IRQ_IRC + TX4938_IR_INT(n))
+#define RBTX4938_IRQ_IRC_SIO(n)	(RBTX4938_IRQ_IRC + TX4938_IR_SIO(n))
+#define RBTX4938_IRQ_IRC_DMA(ch, n)	(RBTX4938_IRQ_IRC + TX4938_IR_DMA(ch, n))
+#define RBTX4938_IRQ_IRC_PIO	(RBTX4938_IRQ_IRC + TX4938_IR_PIO)
+#define RBTX4938_IRQ_IRC_PDMAC	(RBTX4938_IRQ_IRC + TX4938_IR_PDMAC)
+#define RBTX4938_IRQ_IRC_PCIC	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC)
+#define RBTX4938_IRQ_IRC_TMR(n)	(RBTX4938_IRQ_IRC + TX4938_IR_TMR(n))
+#define RBTX4938_IRQ_IRC_NDFMC	(RBTX4938_IRQ_IRC + TX4938_IR_NDFMC)
+#define RBTX4938_IRQ_IRC_PCIERR	(RBTX4938_IRQ_IRC + TX4938_IR_PCIERR)
+#define RBTX4938_IRQ_IRC_PCIPME	(RBTX4938_IRQ_IRC + TX4938_IR_PCIPME)
+#define RBTX4938_IRQ_IRC_ACLC	(RBTX4938_IRQ_IRC + TX4938_IR_ACLC)
+#define RBTX4938_IRQ_IRC_ACLCPME	(RBTX4938_IRQ_IRC + TX4938_IR_ACLCPME)
+#define RBTX4938_IRQ_IRC_PCIC1	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC1)
+#define RBTX4938_IRQ_IRC_SPI	(RBTX4938_IRQ_IRC + TX4938_IR_SPI)
+#define RBTX4938_IRQ_IOC_PCID	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCID)
+#define RBTX4938_IRQ_IOC_PCIC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIC)
+#define RBTX4938_IRQ_IOC_PCIB	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIB)
+#define RBTX4938_IRQ_IOC_PCIA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIA)
+#define RBTX4938_IRQ_IOC_RTC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_RTC)
+#define RBTX4938_IRQ_IOC_ATA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_ATA)
+#define RBTX4938_IRQ_IOC_MODEM	(RBTX4938_IRQ_IOC + RBTX4938_INTB_MODEM)
+#define RBTX4938_IRQ_IOC_SWINT	(RBTX4938_IRQ_IOC + RBTX4938_INTB_SWINT)
+
+
+/* IOC (PCI, etc) */
+#define RBTX4938_IRQ_IOCINT	(TX4938_IRQ_NEST_EXT_ON_PIC)
+/* Onboard 10M Ether */
+#define RBTX4938_IRQ_ETHER	(TX4938_IRQ_NEST_EXT_ON_PIC + 1)
+
+#define RBTX4938_RTL_8019_BASE (RBTX4938_ETHER_ADDR - mips_io_port_base)
+#define RBTX4938_RTL_8019_IRQ  (RBTX4938_IRQ_ETHER)
+
+#endif /* __ASM_TXX9_RBTX4938_H */
diff --git a/include/asm-mips/txx9/smsc_fdc37m81x.h b/include/asm-mips/txx9/smsc_fdc37m81x.h
new file mode 100644
index 0000000..9375e4f
--- /dev/null
+++ b/include/asm-mips/txx9/smsc_fdc37m81x.h
@@ -0,0 +1,67 @@
+/*
+ * Interface for smsc fdc48m81x Super IO chip
+ *
+ * Author: MontaVista Software, Inc. source@mvista.com
+ *
+ * 2001-2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Manish Lachwani, mlachwani@mvista.com
+ */
+
+#ifndef _SMSC_FDC37M81X_H_
+#define _SMSC_FDC37M81X_H_
+
+/* Common Registers */
+#define SMSC_FDC37M81X_CONFIG_INDEX  0x00
+#define SMSC_FDC37M81X_CONFIG_DATA   0x01
+#define SMSC_FDC37M81X_CONF          0x02
+#define SMSC_FDC37M81X_INDEX         0x03
+#define SMSC_FDC37M81X_DNUM          0x07
+#define SMSC_FDC37M81X_DID           0x20
+#define SMSC_FDC37M81X_DREV          0x21
+#define SMSC_FDC37M81X_PCNT          0x22
+#define SMSC_FDC37M81X_PMGT          0x23
+#define SMSC_FDC37M81X_OSC           0x24
+#define SMSC_FDC37M81X_CONFPA0       0x26
+#define SMSC_FDC37M81X_CONFPA1       0x27
+#define SMSC_FDC37M81X_TEST4         0x2B
+#define SMSC_FDC37M81X_TEST5         0x2C
+#define SMSC_FDC37M81X_TEST1         0x2D
+#define SMSC_FDC37M81X_TEST2         0x2E
+#define SMSC_FDC37M81X_TEST3         0x2F
+
+/* Logical device numbers */
+#define SMSC_FDC37M81X_FDD           0x00
+#define SMSC_FDC37M81X_PARALLEL      0x03
+#define SMSC_FDC37M81X_SERIAL1       0x04
+#define SMSC_FDC37M81X_SERIAL2       0x05
+#define SMSC_FDC37M81X_KBD           0x07
+#define SMSC_FDC37M81X_AUXIO         0x08
+#define SMSC_FDC37M81X_NONE          0xff
+
+/* Logical device Config Registers */
+#define SMSC_FDC37M81X_ACTIVE        0x30
+#define SMSC_FDC37M81X_BASEADDR0     0x60
+#define SMSC_FDC37M81X_BASEADDR1     0x61
+#define SMSC_FDC37M81X_INT           0x70
+#define SMSC_FDC37M81X_INT2          0x72
+#define SMSC_FDC37M81X_LDCR_F0       0xF0
+
+/* Chip Config Values */
+#define SMSC_FDC37M81X_CONFIG_ENTER  0x55
+#define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
+#define SMSC_FDC37M81X_CHIP_ID       0x4d
+
+unsigned long __init smsc_fdc37m81x_init(unsigned long port);
+
+void smsc_fdc37m81x_config_beg(void);
+
+void smsc_fdc37m81x_config_end(void);
+
+void smsc_fdc37m81x_config_set(u8 reg, u8 val);
+
+#endif
diff --git a/include/asm-mips/txx9/spi.h b/include/asm-mips/txx9/spi.h
new file mode 100644
index 0000000..ddfb2a0
--- /dev/null
+++ b/include/asm-mips/txx9/spi.h
@@ -0,0 +1,19 @@
+/*
+ * Definitions for TX4937/TX4938 SPI
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#ifndef __ASM_TXX9_SPI_H
+#define __ASM_TXX9_SPI_H
+
+extern int spi_eeprom_register(int chipid);
+extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
+
+#endif /* __ASM_TXX9_SPI_H */
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
new file mode 100644
index 0000000..63b62d6
--- /dev/null
+++ b/include/asm-mips/txx9/tx3927.h
@@ -0,0 +1,319 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000 Toshiba Corporation
+ */
+#ifndef __ASM_TXX9_TX3927_H
+#define __ASM_TXX9_TX3927_H
+
+#include <asm/txx9/txx927.h>
+
+#define TX3927_SDRAMC_REG	0xfffe8000
+#define TX3927_ROMC_REG		0xfffe9000
+#define TX3927_DMA_REG		0xfffeb000
+#define TX3927_IRC_REG		0xfffec000
+#define TX3927_PCIC_REG		0xfffed000
+#define TX3927_CCFG_REG		0xfffee000
+#define TX3927_NR_TMR	3
+#define TX3927_TMR_REG(ch)	(0xfffef000 + (ch) * 0x100)
+#define TX3927_NR_SIO	2
+#define TX3927_SIO_REG(ch)	(0xfffef300 + (ch) * 0x100)
+#define TX3927_PIO_REG		0xfffef500
+
+struct tx3927_sdramc_reg {
+	volatile unsigned long cr[8];
+	volatile unsigned long tr[3];
+	volatile unsigned long cmd;
+	volatile unsigned long smrs[2];
+};
+
+struct tx3927_romc_reg {
+	volatile unsigned long cr[8];
+};
+
+struct tx3927_dma_reg {
+	struct tx3927_dma_ch_reg {
+		volatile unsigned long cha;
+		volatile unsigned long sar;
+		volatile unsigned long dar;
+		volatile unsigned long cntr;
+		volatile unsigned long sair;
+		volatile unsigned long dair;
+		volatile unsigned long ccr;
+		volatile unsigned long csr;
+	} ch[4];
+	volatile unsigned long dbr[8];
+	volatile unsigned long tdhr;
+	volatile unsigned long mcr;
+	volatile unsigned long unused0;
+};
+
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
+#define endian_def_s2(e1, e2)	\
+	volatile unsigned short e1, e2
+#define endian_def_sb2(e1, e2, e3)	\
+	volatile unsigned short e1;volatile unsigned char e2, e3
+#define endian_def_b2s(e1, e2, e3)	\
+	volatile unsigned char e1, e2;volatile unsigned short e3
+#define endian_def_b4(e1, e2, e3, e4)	\
+	volatile unsigned char e1, e2, e3, e4
+#else
+#define endian_def_s2(e1, e2)	\
+	volatile unsigned short e2, e1
+#define endian_def_sb2(e1, e2, e3)	\
+	volatile unsigned char e3, e2;volatile unsigned short e1
+#define endian_def_b2s(e1, e2, e3)	\
+	volatile unsigned short e3;volatile unsigned char e2, e1
+#define endian_def_b4(e1, e2, e3, e4)	\
+	volatile unsigned char e4, e3, e2, e1
+#endif
+
+struct tx3927_pcic_reg {
+	endian_def_s2(did, vid);
+	endian_def_s2(pcistat, pcicmd);
+	endian_def_b4(cc, scc, rpli, rid);
+	endian_def_b4(unused0, ht, mlt, cls);
+	volatile unsigned long ioba;		/* +10 */
+	volatile unsigned long mba;
+	volatile unsigned long unused1[5];
+	endian_def_s2(svid, ssvid);
+	volatile unsigned long unused2;		/* +30 */
+	endian_def_sb2(unused3, unused4, capptr);
+	volatile unsigned long unused5;
+	endian_def_b4(ml, mg, ip, il);
+	volatile unsigned long unused6;		/* +40 */
+	volatile unsigned long istat;
+	volatile unsigned long iim;
+	volatile unsigned long rrt;
+	volatile unsigned long unused7[3];		/* +50 */
+	volatile unsigned long ipbmma;
+	volatile unsigned long ipbioma;		/* +60 */
+	volatile unsigned long ilbmma;
+	volatile unsigned long ilbioma;
+	volatile unsigned long unused8[9];
+	volatile unsigned long tc;		/* +90 */
+	volatile unsigned long tstat;
+	volatile unsigned long tim;
+	volatile unsigned long tccmd;
+	volatile unsigned long pcirrt;		/* +a0 */
+	volatile unsigned long pcirrt_cmd;
+	volatile unsigned long pcirrdt;
+	volatile unsigned long unused9[3];
+	volatile unsigned long tlboap;
+	volatile unsigned long tlbiap;
+	volatile unsigned long tlbmma;		/* +c0 */
+	volatile unsigned long tlbioma;
+	volatile unsigned long sc_msg;
+	volatile unsigned long sc_be;
+	volatile unsigned long tbl;		/* +d0 */
+	volatile unsigned long unused10[3];
+	volatile unsigned long pwmng;		/* +e0 */
+	volatile unsigned long pwmngs;
+	volatile unsigned long unused11[6];
+	volatile unsigned long req_trace;		/* +100 */
+	volatile unsigned long pbapmc;
+	volatile unsigned long pbapms;
+	volatile unsigned long pbapmim;
+	volatile unsigned long bm;		/* +110 */
+	volatile unsigned long cpcibrs;
+	volatile unsigned long cpcibgs;
+	volatile unsigned long pbacs;
+	volatile unsigned long iobas;		/* +120 */
+	volatile unsigned long mbas;
+	volatile unsigned long lbc;
+	volatile unsigned long lbstat;
+	volatile unsigned long lbim;		/* +130 */
+	volatile unsigned long pcistatim;
+	volatile unsigned long ica;
+	volatile unsigned long icd;
+	volatile unsigned long iiadp;		/* +140 */
+	volatile unsigned long iscdp;
+	volatile unsigned long mmas;
+	volatile unsigned long iomas;
+	volatile unsigned long ipciaddr;		/* +150 */
+	volatile unsigned long ipcidata;
+	volatile unsigned long ipcibe;
+};
+
+struct tx3927_ccfg_reg {
+	volatile unsigned long ccfg;
+	volatile unsigned long crir;
+	volatile unsigned long pcfg;
+	volatile unsigned long tear;
+	volatile unsigned long pdcr;
+};
+
+/*
+ * SDRAMC
+ */
+
+/*
+ * ROMC
+ */
+
+/*
+ * DMA
+ */
+/* bits for MCR */
+#define TX3927_DMA_MCR_EIS(ch)	(0x10000000<<(ch))
+#define TX3927_DMA_MCR_DIS(ch)	(0x01000000<<(ch))
+#define TX3927_DMA_MCR_RSFIF	0x00000080
+#define TX3927_DMA_MCR_FIFUM(ch)	(0x00000008<<(ch))
+#define TX3927_DMA_MCR_LE	0x00000004
+#define TX3927_DMA_MCR_RPRT	0x00000002
+#define TX3927_DMA_MCR_MSTEN	0x00000001
+
+/* bits for CCRn */
+#define TX3927_DMA_CCR_DBINH	0x04000000
+#define TX3927_DMA_CCR_SBINH	0x02000000
+#define TX3927_DMA_CCR_CHRST	0x01000000
+#define TX3927_DMA_CCR_RVBYTE	0x00800000
+#define TX3927_DMA_CCR_ACKPOL	0x00400000
+#define TX3927_DMA_CCR_REQPL	0x00200000
+#define TX3927_DMA_CCR_EGREQ	0x00100000
+#define TX3927_DMA_CCR_CHDN	0x00080000
+#define TX3927_DMA_CCR_DNCTL	0x00060000
+#define TX3927_DMA_CCR_EXTRQ	0x00010000
+#define TX3927_DMA_CCR_INTRQD	0x0000e000
+#define TX3927_DMA_CCR_INTENE	0x00001000
+#define TX3927_DMA_CCR_INTENC	0x00000800
+#define TX3927_DMA_CCR_INTENT	0x00000400
+#define TX3927_DMA_CCR_CHNEN	0x00000200
+#define TX3927_DMA_CCR_XFACT	0x00000100
+#define TX3927_DMA_CCR_SNOP	0x00000080
+#define TX3927_DMA_CCR_DSTINC	0x00000040
+#define TX3927_DMA_CCR_SRCINC	0x00000020
+#define TX3927_DMA_CCR_XFSZ(order)	(((order) << 2) & 0x0000001c)
+#define TX3927_DMA_CCR_XFSZ_1W	TX3927_DMA_CCR_XFSZ(2)
+#define TX3927_DMA_CCR_XFSZ_4W	TX3927_DMA_CCR_XFSZ(4)
+#define TX3927_DMA_CCR_XFSZ_8W	TX3927_DMA_CCR_XFSZ(5)
+#define TX3927_DMA_CCR_XFSZ_16W	TX3927_DMA_CCR_XFSZ(6)
+#define TX3927_DMA_CCR_XFSZ_32W	TX3927_DMA_CCR_XFSZ(7)
+#define TX3927_DMA_CCR_MEMIO	0x00000002
+#define TX3927_DMA_CCR_ONEAD	0x00000001
+
+/* bits for CSRn */
+#define TX3927_DMA_CSR_CHNACT	0x00000100
+#define TX3927_DMA_CSR_ABCHC	0x00000080
+#define TX3927_DMA_CSR_NCHNC	0x00000040
+#define TX3927_DMA_CSR_NTRNFC	0x00000020
+#define TX3927_DMA_CSR_EXTDN	0x00000010
+#define TX3927_DMA_CSR_CFERR	0x00000008
+#define TX3927_DMA_CSR_CHERR	0x00000004
+#define TX3927_DMA_CSR_DESERR	0x00000002
+#define TX3927_DMA_CSR_SORERR	0x00000001
+
+/*
+ * IRC
+ */
+#define TX3927_IR_INT0	0
+#define TX3927_IR_INT1	1
+#define TX3927_IR_INT2	2
+#define TX3927_IR_INT3	3
+#define TX3927_IR_INT4	4
+#define TX3927_IR_INT5	5
+#define TX3927_IR_SIO0	6
+#define TX3927_IR_SIO1	7
+#define TX3927_IR_SIO(ch)	(6 + (ch))
+#define TX3927_IR_DMA	8
+#define TX3927_IR_PIO	9
+#define TX3927_IR_PCI	10
+#define TX3927_IR_TMR(ch)	(13 + (ch))
+#define TX3927_NUM_IR	16
+
+/*
+ * PCIC
+ */
+/* bits for PCICMD */
+/* see PCI_COMMAND_XXX in linux/pci.h */
+
+/* bits for PCISTAT */
+/* see PCI_STATUS_XXX in linux/pci.h */
+#define PCI_STATUS_NEW_CAP	0x0010
+
+/* bits for TC */
+#define TX3927_PCIC_TC_OF16E	0x00000020
+#define TX3927_PCIC_TC_IF8E	0x00000010
+#define TX3927_PCIC_TC_OF8E	0x00000008
+
+/* bits for IOBA/MBA */
+/* see PCI_BASE_ADDRESS_XXX in linux/pci.h */
+
+/* bits for PBAPMC */
+#define TX3927_PCIC_PBAPMC_RPBA	0x00000004
+#define TX3927_PCIC_PBAPMC_PBAEN	0x00000002
+#define TX3927_PCIC_PBAPMC_BMCEN	0x00000001
+
+/* bits for LBSTAT/LBIM */
+#define TX3927_PCIC_LBIM_ALL	0x0000003e
+
+/* bits for PCISTATIM (see also PCI_STATUS_XXX in linux/pci.h */
+#define TX3927_PCIC_PCISTATIM_ALL	0x0000f900
+
+/* bits for LBC */
+#define TX3927_PCIC_LBC_IBSE	0x00004000
+#define TX3927_PCIC_LBC_TIBSE	0x00002000
+#define TX3927_PCIC_LBC_TMFBSE	0x00001000
+#define TX3927_PCIC_LBC_HRST	0x00000800
+#define TX3927_PCIC_LBC_SRST	0x00000400
+#define TX3927_PCIC_LBC_EPCAD	0x00000200
+#define TX3927_PCIC_LBC_MSDSE	0x00000100
+#define TX3927_PCIC_LBC_CRR	0x00000080
+#define TX3927_PCIC_LBC_ILMDE	0x00000040
+#define TX3927_PCIC_LBC_ILIDE	0x00000020
+
+#define TX3927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
+#define TX3927_PCIC_MAX_DEVNU	TX3927_PCIC_IDSEL_AD_TO_SLOT(32)
+
+/*
+ * CCFG
+ */
+/* CCFG : Chip Configuration */
+#define TX3927_CCFG_TLBOFF	0x00020000
+#define TX3927_CCFG_BEOW	0x00010000
+#define TX3927_CCFG_WR	0x00008000
+#define TX3927_CCFG_TOE	0x00004000
+#define TX3927_CCFG_PCIXARB	0x00002000
+#define TX3927_CCFG_PCI3	0x00001000
+#define TX3927_CCFG_PSNP	0x00000800
+#define TX3927_CCFG_PPRI	0x00000400
+#define TX3927_CCFG_PLLM	0x00000030
+#define TX3927_CCFG_ENDIAN	0x00000004
+#define TX3927_CCFG_HALT	0x00000002
+#define TX3927_CCFG_ACEHOLD	0x00000001
+
+/* PCFG : Pin Configuration */
+#define TX3927_PCFG_SYSCLKEN	0x08000000
+#define TX3927_PCFG_SDRCLKEN_ALL	0x07c00000
+#define TX3927_PCFG_SDRCLKEN(ch)	(0x00400000<<(ch))
+#define TX3927_PCFG_PCICLKEN_ALL	0x003c0000
+#define TX3927_PCFG_PCICLKEN(ch)	(0x00040000<<(ch))
+#define TX3927_PCFG_SELALL	0x0003ffff
+#define TX3927_PCFG_SELCS	0x00020000
+#define TX3927_PCFG_SELDSF	0x00010000
+#define TX3927_PCFG_SELSIOC_ALL	0x0000c000
+#define TX3927_PCFG_SELSIOC(ch)	(0x00004000<<(ch))
+#define TX3927_PCFG_SELSIO_ALL	0x00003000
+#define TX3927_PCFG_SELSIO(ch)	(0x00001000<<(ch))
+#define TX3927_PCFG_SELTMR_ALL	0x00000e00
+#define TX3927_PCFG_SELTMR(ch)	(0x00000200<<(ch))
+#define TX3927_PCFG_SELDONE	0x00000100
+#define TX3927_PCFG_INTDMA_ALL	0x000000f0
+#define TX3927_PCFG_INTDMA(ch)	(0x00000010<<(ch))
+#define TX3927_PCFG_SELDMA_ALL	0x0000000f
+#define TX3927_PCFG_SELDMA(ch)	(0x00000001<<(ch))
+
+#define tx3927_sdramcptr	((struct tx3927_sdramc_reg *)TX3927_SDRAMC_REG)
+#define tx3927_romcptr		((struct tx3927_romc_reg *)TX3927_ROMC_REG)
+#define tx3927_dmaptr		((struct tx3927_dma_reg *)TX3927_DMA_REG)
+#define tx3927_pcicptr		((struct tx3927_pcic_reg *)TX3927_PCIC_REG)
+#define tx3927_ccfgptr		((struct tx3927_ccfg_reg *)TX3927_CCFG_REG)
+#define tx3927_tmrptr(ch)	((struct txx927_tmr_reg *)TX3927_TMR_REG(ch))
+#define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
+#define tx3927_pioptr		((struct txx9_pio_reg __iomem *)TX3927_PIO_REG)
+
+#endif /* __ASM_TXX9_TX3927_H */
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
new file mode 100644
index 0000000..f21a7b1
--- /dev/null
+++ b/include/asm-mips/txx9/tx4927.h
@@ -0,0 +1,280 @@
+/*
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2001-2006 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_TXX9_TX4927_H
+#define __ASM_TXX9_TX4927_H
+
+#include <asm/txx9irq.h>
+
+#define TX4927_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
+#define TX4927_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
+
+#define TX4927_IRQ_PIC_BEG  TXX9_IRQ_BASE
+#define TX4927_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
+
+
+#define TX4927_IRQ_USER0	    (TX4927_IRQ_CP0_BEG+0)
+#define TX4927_IRQ_USER1	    (TX4927_IRQ_CP0_BEG+1)
+#define TX4927_IRQ_NEST_PIC_ON_CP0  (TX4927_IRQ_CP0_BEG+2)
+#define TX4927_IRQ_CPU_TIMER	    (TX4927_IRQ_CP0_BEG+7)
+
+#define TX4927_IRQ_NEST_EXT_ON_PIC  (TX4927_IRQ_PIC_BEG+3)
+
+#define TX4927_CCFG_TOE 0x00004000
+#define TX4927_CCFG_WR	0x00008000
+#define TX4927_CCFG_TINTDIS	0x01000000
+
+#define TX4927_PCIMEM	   0x08000000
+#define TX4927_PCIMEM_SIZE 0x08000000
+#define TX4927_PCIIO	   0x16000000
+#define TX4927_PCIIO_SIZE  0x01000000
+
+#define TX4927_SDRAMC_REG	0xff1f8000
+#define TX4927_EBUSC_REG	0xff1f9000
+#define TX4927_PCIC_REG		0xff1fd000
+#define TX4927_CCFG_REG		0xff1fe000
+#define TX4927_IRC_REG		0xff1ff600
+#define TX4927_NR_TMR	3
+#define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
+
+/* bits for ISTAT3/IMASK3/IMSTAT3 */
+#define TX4927_INT3B_PCID	0
+#define TX4927_INT3B_PCIC	1
+#define TX4927_INT3B_PCIB	2
+#define TX4927_INT3B_PCIA	3
+#define TX4927_INT3F_PCID	(1 << TX4927_INT3B_PCID)
+#define TX4927_INT3F_PCIC	(1 << TX4927_INT3B_PCIC)
+#define TX4927_INT3F_PCIB	(1 << TX4927_INT3B_PCIB)
+#define TX4927_INT3F_PCIA	(1 << TX4927_INT3B_PCIA)
+
+#define TX4927_NR_IRQ_LOCAL	TX4927_IRQ_PIC_BEG
+#define TX4927_NR_IRQ_IRC	32	/* On-Chip IRC */
+
+#define TX4927_IR_PCIC		16
+#define TX4927_IR_PCIERR	22
+#define TX4927_IR_PCIPMA	23
+#define TX4927_IRQ_IRC_PCIC	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIC)
+#define TX4927_IRQ_IRC_PCIERR	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIERR)
+#define TX4927_IRQ_IOC1		(TX4927_NR_IRQ_LOCAL + TX4927_NR_IRQ_IRC)
+#define TX4927_IRQ_IOC_PCID	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCID)
+#define TX4927_IRQ_IOC_PCIC	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIC)
+#define TX4927_IRQ_IOC_PCIB	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIB)
+#define TX4927_IRQ_IOC_PCIA	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIA)
+
+#ifdef _LANGUAGE_ASSEMBLY
+#define _CONST64(c)	c
+#else
+#define _CONST64(c)	c##ull
+
+#include <asm/byteorder.h>
+
+struct tx4927_sdramc_reg {
+	volatile unsigned long long cr[4];
+	volatile unsigned long long unused0[4];
+	volatile unsigned long long tr;
+	volatile unsigned long long unused1[2];
+	volatile unsigned long long cmd;
+};
+
+struct tx4927_ebusc_reg {
+	volatile unsigned long long cr[8];
+};
+
+struct tx4927_ccfg_reg {
+	volatile unsigned long long ccfg;
+	volatile unsigned long long crir;
+	volatile unsigned long long pcfg;
+	volatile unsigned long long tear;
+	volatile unsigned long long clkctr;
+	volatile unsigned long long unused0;
+	volatile unsigned long long garbc;
+	volatile unsigned long long unused1;
+	volatile unsigned long long unused2;
+	volatile unsigned long long ramp;
+};
+
+struct tx4927_pcic_reg {
+	volatile unsigned long pciid;
+	volatile unsigned long pcistatus;
+	volatile unsigned long pciccrev;
+	volatile unsigned long pcicfg1;
+	volatile unsigned long p2gm0plbase;		/* +10 */
+	volatile unsigned long p2gm0pubase;
+	volatile unsigned long p2gm1plbase;
+	volatile unsigned long p2gm1pubase;
+	volatile unsigned long p2gm2pbase;		/* +20 */
+	volatile unsigned long p2giopbase;
+	volatile unsigned long unused0;
+	volatile unsigned long pcisid;
+	volatile unsigned long unused1;		/* +30 */
+	volatile unsigned long pcicapptr;
+	volatile unsigned long unused2;
+	volatile unsigned long pcicfg2;
+	volatile unsigned long g2ptocnt;		/* +40 */
+	volatile unsigned long unused3[15];
+	volatile unsigned long g2pstatus;		/* +80 */
+	volatile unsigned long g2pmask;
+	volatile unsigned long pcisstatus;
+	volatile unsigned long pcimask;
+	volatile unsigned long p2gcfg;		/* +90 */
+	volatile unsigned long p2gstatus;
+	volatile unsigned long p2gmask;
+	volatile unsigned long p2gccmd;
+	volatile unsigned long unused4[24];		/* +a0 */
+	volatile unsigned long pbareqport;		/* +100 */
+	volatile unsigned long pbacfg;
+	volatile unsigned long pbastatus;
+	volatile unsigned long pbamask;
+	volatile unsigned long pbabm;		/* +110 */
+	volatile unsigned long pbacreq;
+	volatile unsigned long pbacgnt;
+	volatile unsigned long pbacstate;
+	volatile unsigned long long g2pmgbase[3];		/* +120 */
+	volatile unsigned long long g2piogbase;
+	volatile unsigned long g2pmmask[3];		/* +140 */
+	volatile unsigned long g2piomask;
+	volatile unsigned long long g2pmpbase[3];		/* +150 */
+	volatile unsigned long long g2piopbase;
+	volatile unsigned long pciccfg;		/* +170 */
+	volatile unsigned long pcicstatus;
+	volatile unsigned long pcicmask;
+	volatile unsigned long unused5;
+	volatile unsigned long long p2gmgbase[3];		/* +180 */
+	volatile unsigned long long p2giogbase;
+	volatile unsigned long g2pcfgadrs;		/* +1a0 */
+	volatile unsigned long g2pcfgdata;
+	volatile unsigned long unused6[8];
+	volatile unsigned long g2pintack;
+	volatile unsigned long g2pspc;
+	volatile unsigned long unused7[12];		/* +1d0 */
+	volatile unsigned long long pdmca;		/* +200 */
+	volatile unsigned long long pdmga;
+	volatile unsigned long long pdmpa;
+	volatile unsigned long long pdmcut;
+	volatile unsigned long long pdmcnt;		/* +220 */
+	volatile unsigned long long pdmsts;
+	volatile unsigned long long unused8[2];
+	volatile unsigned long long pdmdb[4];		/* +240 */
+	volatile unsigned long long pdmtdh;		/* +260 */
+	volatile unsigned long long pdmdms;
+};
+
+#endif /* _LANGUAGE_ASSEMBLY */
+
+/*
+ * PCIC
+ */
+
+/* bits for G2PSTATUS/G2PMASK */
+#define TX4927_PCIC_G2PSTATUS_ALL	0x00000003
+#define TX4927_PCIC_G2PSTATUS_TTOE	0x00000002
+#define TX4927_PCIC_G2PSTATUS_RTOE	0x00000001
+
+/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
+#define TX4927_PCIC_PCISTATUS_ALL	0x0000f900
+
+/* bits for PBACFG */
+#define TX4927_PCIC_PBACFG_RPBA 0x00000004
+#define TX4927_PCIC_PBACFG_PBAEN	0x00000002
+#define TX4927_PCIC_PBACFG_BMCEN	0x00000001
+
+/* bits for G2PMnGBASE */
+#define TX4927_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for G2PIOGBASE */
+#define TX4927_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for PCICSTATUS/PCICMASK */
+#define TX4927_PCIC_PCICSTATUS_ALL	0x000007dc
+
+/* bits for PCICCFG */
+#define TX4927_PCIC_PCICCFG_LBWC_MASK	0x0fff0000
+#define TX4927_PCIC_PCICCFG_HRST	0x00000800
+#define TX4927_PCIC_PCICCFG_SRST	0x00000400
+#define TX4927_PCIC_PCICCFG_IRBER	0x00000200
+#define TX4927_PCIC_PCICCFG_IMSE0	0x00000100
+#define TX4927_PCIC_PCICCFG_IMSE1	0x00000080
+#define TX4927_PCIC_PCICCFG_IMSE2	0x00000040
+#define TX4927_PCIC_PCICCFG_IISE	0x00000020
+#define TX4927_PCIC_PCICCFG_ATR 0x00000010
+#define TX4927_PCIC_PCICCFG_ICAE	0x00000008
+
+/* bits for P2GMnGBASE */
+#define TX4927_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
+#define TX4927_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
+
+/* bits for P2GIOGBASE */
+#define TX4927_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
+#define TX4927_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
+
+#define TX4927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
+#define TX4927_PCIC_MAX_DEVNU	TX4927_PCIC_IDSEL_AD_TO_SLOT(32)
+
+/*
+ * CCFG
+ */
+/* CCFG : Chip Configuration */
+#define TX4927_CCFG_PCI66	0x00800000
+#define TX4927_CCFG_PCIMIDE	0x00400000
+#define TX4927_CCFG_PCIXARB	0x00002000
+#define TX4927_CCFG_PCIDIVMODE_MASK	0x00001800
+#define TX4927_CCFG_PCIDIVMODE_2_5	0x00000000
+#define TX4927_CCFG_PCIDIVMODE_3	0x00000800
+#define TX4927_CCFG_PCIDIVMODE_5	0x00001000
+#define TX4927_CCFG_PCIDIVMODE_6	0x00001800
+
+#define TX4937_CCFG_PCIDIVMODE_MASK	0x00001c00
+#define TX4937_CCFG_PCIDIVMODE_8	0x00000000
+#define TX4937_CCFG_PCIDIVMODE_4	0x00000400
+#define TX4937_CCFG_PCIDIVMODE_9	0x00000800
+#define TX4937_CCFG_PCIDIVMODE_4_5	0x00000c00
+#define TX4937_CCFG_PCIDIVMODE_10	0x00001000
+#define TX4937_CCFG_PCIDIVMODE_5	0x00001400
+#define TX4937_CCFG_PCIDIVMODE_11	0x00001800
+#define TX4937_CCFG_PCIDIVMODE_5_5	0x00001c00
+
+/* PCFG : Pin Configuration */
+#define TX4927_PCFG_PCICLKEN_ALL	0x003f0000
+#define TX4927_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
+
+/* CLKCTR : Clock Control */
+#define TX4927_CLKCTR_PCICKD	0x00400000
+#define TX4927_CLKCTR_PCIRST	0x00000040
+
+#ifndef _LANGUAGE_ASSEMBLY
+
+#define tx4927_sdramcptr	((struct tx4927_sdramc_reg *)TX4927_SDRAMC_REG)
+#define tx4927_pcicptr		((struct tx4927_pcic_reg *)TX4927_PCIC_REG)
+#define tx4927_ccfgptr		((struct tx4927_ccfg_reg *)TX4927_CCFG_REG)
+#define tx4927_ebuscptr		((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
+
+#endif /* _LANGUAGE_ASSEMBLY */
+
+#endif /* __ASM_TXX9_TX4927_H */
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
new file mode 100644
index 0000000..7f9cfef
--- /dev/null
+++ b/include/asm-mips/txx9/tx4938.h
@@ -0,0 +1,627 @@
+/*
+ * Definitions for TX4937/TX4938
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#ifndef __ASM_TXX9_TX4938_H
+#define __ASM_TXX9_TX4938_H
+
+#define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
+#define tx4938_write_nfmc(b, addr) (*(volatile unsigned int *)(addr)) = (b)
+
+#define TX4938_NR_IRQ_LOCAL     TX4938_IRQ_PIC_BEG
+
+#define TX4938_IRQ_IRC_PCIC     (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIC)
+#define TX4938_IRQ_IRC_PCIERR   (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIERR)
+
+#define TX4938_PCIIO_0 0x10000000
+#define TX4938_PCIIO_1 0x01010000
+#define TX4938_PCIMEM_0 0x08000000
+#define TX4938_PCIMEM_1 0x11000000
+
+#define TX4938_PCIIO_SIZE_0 0x01000000
+#define TX4938_PCIIO_SIZE_1 0x00010000
+#define TX4938_PCIMEM_SIZE_0 0x08000000
+#define TX4938_PCIMEM_SIZE_1 0x00010000
+
+#define TX4938_REG_BASE	0xff1f0000 /* == TX4937_REG_BASE */
+#define TX4938_REG_SIZE	0x00010000 /* == TX4937_REG_SIZE */
+
+/* NDFMC, SRAMC, PCIC1, SPIC: TX4938 only */
+#define TX4938_NDFMC_REG	(TX4938_REG_BASE + 0x5000)
+#define TX4938_SRAMC_REG	(TX4938_REG_BASE + 0x6000)
+#define TX4938_PCIC1_REG	(TX4938_REG_BASE + 0x7000)
+#define TX4938_SDRAMC_REG	(TX4938_REG_BASE + 0x8000)
+#define TX4938_EBUSC_REG	(TX4938_REG_BASE + 0x9000)
+#define TX4938_DMA_REG(ch)	(TX4938_REG_BASE + 0xb000 + (ch) * 0x800)
+#define TX4938_PCIC_REG		(TX4938_REG_BASE + 0xd000)
+#define TX4938_CCFG_REG		(TX4938_REG_BASE + 0xe000)
+#define TX4938_NR_TMR	3
+#define TX4938_TMR_REG(ch)	((TX4938_REG_BASE + 0xf000) + (ch) * 0x100)
+#define TX4938_NR_SIO	2
+#define TX4938_SIO_REG(ch)	((TX4938_REG_BASE + 0xf300) + (ch) * 0x100)
+#define TX4938_PIO_REG		(TX4938_REG_BASE + 0xf500)
+#define TX4938_IRC_REG		(TX4938_REG_BASE + 0xf600)
+#define TX4938_ACLC_REG		(TX4938_REG_BASE + 0xf700)
+#define TX4938_SPI_REG		(TX4938_REG_BASE + 0xf800)
+
+#ifdef __ASSEMBLY__
+#define _CONST64(c)	c
+#else
+#define _CONST64(c)	c##ull
+
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
+#define endian_def_l2(e1, e2)	\
+	volatile unsigned long e1, e2
+#define endian_def_s2(e1, e2)	\
+	volatile unsigned short e1, e2
+#define endian_def_sb2(e1, e2, e3)	\
+	volatile unsigned short e1;volatile unsigned char e2, e3
+#define endian_def_b2s(e1, e2, e3)	\
+	volatile unsigned char e1, e2;volatile unsigned short e3
+#define endian_def_b4(e1, e2, e3, e4)	\
+	volatile unsigned char e1, e2, e3, e4
+#else
+#define endian_def_l2(e1, e2)	\
+	volatile unsigned long e2, e1
+#define endian_def_s2(e1, e2)	\
+	volatile unsigned short e2, e1
+#define endian_def_sb2(e1, e2, e3)	\
+	volatile unsigned char e3, e2;volatile unsigned short e1
+#define endian_def_b2s(e1, e2, e3)	\
+	volatile unsigned short e3;volatile unsigned char e2, e1
+#define endian_def_b4(e1, e2, e3, e4)	\
+	volatile unsigned char e4, e3, e2, e1
+#endif
+
+
+struct tx4938_sdramc_reg {
+	volatile unsigned long long cr[4];
+	volatile unsigned long long unused0[4];
+	volatile unsigned long long tr;
+	volatile unsigned long long unused1[2];
+	volatile unsigned long long cmd;
+	volatile unsigned long long sfcmd;
+};
+
+struct tx4938_ebusc_reg {
+	volatile unsigned long long cr[8];
+};
+
+struct tx4938_dma_reg {
+	struct tx4938_dma_ch_reg {
+		volatile unsigned long long cha;
+		volatile unsigned long long sar;
+		volatile unsigned long long dar;
+		endian_def_l2(unused0, cntr);
+		endian_def_l2(unused1, sair);
+		endian_def_l2(unused2, dair);
+		endian_def_l2(unused3, ccr);
+		endian_def_l2(unused4, csr);
+	} ch[4];
+	volatile unsigned long long dbr[8];
+	volatile unsigned long long tdhr;
+	volatile unsigned long long midr;
+	endian_def_l2(unused0, mcr);
+};
+
+struct tx4938_pcic_reg {
+	volatile unsigned long pciid;
+	volatile unsigned long pcistatus;
+	volatile unsigned long pciccrev;
+	volatile unsigned long pcicfg1;
+	volatile unsigned long p2gm0plbase;		/* +10 */
+	volatile unsigned long p2gm0pubase;
+	volatile unsigned long p2gm1plbase;
+	volatile unsigned long p2gm1pubase;
+	volatile unsigned long p2gm2pbase;		/* +20 */
+	volatile unsigned long p2giopbase;
+	volatile unsigned long unused0;
+	volatile unsigned long pcisid;
+	volatile unsigned long unused1;		/* +30 */
+	volatile unsigned long pcicapptr;
+	volatile unsigned long unused2;
+	volatile unsigned long pcicfg2;
+	volatile unsigned long g2ptocnt;		/* +40 */
+	volatile unsigned long unused3[15];
+	volatile unsigned long g2pstatus;		/* +80 */
+	volatile unsigned long g2pmask;
+	volatile unsigned long pcisstatus;
+	volatile unsigned long pcimask;
+	volatile unsigned long p2gcfg;		/* +90 */
+	volatile unsigned long p2gstatus;
+	volatile unsigned long p2gmask;
+	volatile unsigned long p2gccmd;
+	volatile unsigned long unused4[24];		/* +a0 */
+	volatile unsigned long pbareqport;		/* +100 */
+	volatile unsigned long pbacfg;
+	volatile unsigned long pbastatus;
+	volatile unsigned long pbamask;
+	volatile unsigned long pbabm;		/* +110 */
+	volatile unsigned long pbacreq;
+	volatile unsigned long pbacgnt;
+	volatile unsigned long pbacstate;
+	volatile unsigned long long g2pmgbase[3];		/* +120 */
+	volatile unsigned long long g2piogbase;
+	volatile unsigned long g2pmmask[3];		/* +140 */
+	volatile unsigned long g2piomask;
+	volatile unsigned long long g2pmpbase[3];		/* +150 */
+	volatile unsigned long long g2piopbase;
+	volatile unsigned long pciccfg;		/* +170 */
+	volatile unsigned long pcicstatus;
+	volatile unsigned long pcicmask;
+	volatile unsigned long unused5;
+	volatile unsigned long long p2gmgbase[3];		/* +180 */
+	volatile unsigned long long p2giogbase;
+	volatile unsigned long g2pcfgadrs;		/* +1a0 */
+	volatile unsigned long g2pcfgdata;
+	volatile unsigned long unused6[8];
+	volatile unsigned long g2pintack;
+	volatile unsigned long g2pspc;
+	volatile unsigned long unused7[12];		/* +1d0 */
+	volatile unsigned long long pdmca;		/* +200 */
+	volatile unsigned long long pdmga;
+	volatile unsigned long long pdmpa;
+	volatile unsigned long long pdmctr;
+	volatile unsigned long long pdmcfg;		/* +220 */
+	volatile unsigned long long pdmsts;
+};
+
+struct tx4938_aclc_reg {
+	volatile unsigned long acctlen;
+	volatile unsigned long acctldis;
+	volatile unsigned long acregacc;
+	volatile unsigned long unused0;
+	volatile unsigned long acintsts;
+	volatile unsigned long acintmsts;
+	volatile unsigned long acinten;
+	volatile unsigned long acintdis;
+	volatile unsigned long acsemaph;
+	volatile unsigned long unused1[7];
+	volatile unsigned long acgpidat;
+	volatile unsigned long acgpodat;
+	volatile unsigned long acslten;
+	volatile unsigned long acsltdis;
+	volatile unsigned long acfifosts;
+	volatile unsigned long unused2[11];
+	volatile unsigned long acdmasts;
+	volatile unsigned long acdmasel;
+	volatile unsigned long unused3[6];
+	volatile unsigned long acaudodat;
+	volatile unsigned long acsurrdat;
+	volatile unsigned long accentdat;
+	volatile unsigned long aclfedat;
+	volatile unsigned long acaudiat;
+	volatile unsigned long unused4;
+	volatile unsigned long acmodoat;
+	volatile unsigned long acmodidat;
+	volatile unsigned long unused5[15];
+	volatile unsigned long acrevid;
+};
+
+
+struct tx4938_tmr_reg {
+	volatile unsigned long tcr;
+	volatile unsigned long tisr;
+	volatile unsigned long cpra;
+	volatile unsigned long cprb;
+	volatile unsigned long itmr;
+	volatile unsigned long unused0[3];
+	volatile unsigned long ccdr;
+	volatile unsigned long unused1[3];
+	volatile unsigned long pgmr;
+	volatile unsigned long unused2[3];
+	volatile unsigned long wtmr;
+	volatile unsigned long unused3[43];
+	volatile unsigned long trr;
+};
+
+struct tx4938_sio_reg {
+	volatile unsigned long lcr;
+	volatile unsigned long dicr;
+	volatile unsigned long disr;
+	volatile unsigned long cisr;
+	volatile unsigned long fcr;
+	volatile unsigned long flcr;
+	volatile unsigned long bgr;
+	volatile unsigned long tfifo;
+	volatile unsigned long rfifo;
+};
+
+struct tx4938_ndfmc_reg {
+	endian_def_l2(unused0, dtr);
+	endian_def_l2(unused1, mcr);
+	endian_def_l2(unused2, sr);
+	endian_def_l2(unused3, isr);
+	endian_def_l2(unused4, imr);
+	endian_def_l2(unused5, spr);
+	endian_def_l2(unused6, rstr);
+};
+
+struct tx4938_spi_reg {
+	volatile unsigned long mcr;
+	volatile unsigned long cr0;
+	volatile unsigned long cr1;
+	volatile unsigned long fs;
+	volatile unsigned long unused1;
+	volatile unsigned long sr;
+	volatile unsigned long dr;
+	volatile unsigned long unused2;
+};
+
+struct tx4938_sramc_reg {
+	volatile unsigned long long cr;
+};
+
+struct tx4938_ccfg_reg {
+	volatile unsigned long long ccfg;
+	volatile unsigned long long crir;
+	volatile unsigned long long pcfg;
+	volatile unsigned long long tear;
+	volatile unsigned long long clkctr;
+	volatile unsigned long long unused0;
+	volatile unsigned long long garbc;
+	volatile unsigned long long unused1;
+	volatile unsigned long long unused2;
+	volatile unsigned long long ramp;
+	volatile unsigned long long unused3;
+	volatile unsigned long long jmpadr;
+};
+
+#undef endian_def_l2
+#undef endian_def_s2
+#undef endian_def_sb2
+#undef endian_def_b2s
+#undef endian_def_b4
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * NDFMC
+ */
+
+/* NDFMCR : NDFMC Mode Control */
+#define TX4938_NDFMCR_WE	0x80
+#define TX4938_NDFMCR_ECC_ALL	0x60
+#define TX4938_NDFMCR_ECC_RESET	0x60
+#define TX4938_NDFMCR_ECC_READ	0x40
+#define TX4938_NDFMCR_ECC_ON	0x20
+#define TX4938_NDFMCR_ECC_OFF	0x00
+#define TX4938_NDFMCR_CE	0x10
+#define TX4938_NDFMCR_BSPRT	0x04
+#define TX4938_NDFMCR_ALE	0x02
+#define TX4938_NDFMCR_CLE	0x01
+
+/* NDFMCR : NDFMC Status */
+#define TX4938_NDFSR_BUSY	0x80
+
+/* NDFMCR : NDFMC Reset */
+#define TX4938_NDFRSTR_RST	0x01
+
+/*
+ * IRC
+ */
+
+#define TX4938_IR_ECCERR	0
+#define TX4938_IR_WTOERR	1
+#define TX4938_NUM_IR_INT	6
+#define TX4938_IR_INT(n)	(2 + (n))
+#define TX4938_NUM_IR_SIO	2
+#define TX4938_IR_SIO(n)	(8 + (n))
+#define TX4938_NUM_IR_DMA	4
+#define TX4938_IR_DMA(ch, n)	((ch ? 27 : 10) + (n)) /* 10-13, 27-30 */
+#define TX4938_IR_PIO	14
+#define TX4938_IR_PDMAC	15
+#define TX4938_IR_PCIC	16
+#define TX4938_NUM_IR_TMR	3
+#define TX4938_IR_TMR(n)	(17 + (n))
+#define TX4938_IR_NDFMC	21
+#define TX4938_IR_PCIERR	22
+#define TX4938_IR_PCIPME	23
+#define TX4938_IR_ACLC	24
+#define TX4938_IR_ACLCPME	25
+#define TX4938_IR_PCIC1	26
+#define TX4938_IR_SPI	31
+#define TX4938_NUM_IR	32
+/* multiplex */
+#define TX4938_IR_ETH0	TX4938_IR_INT(4)
+#define TX4938_IR_ETH1	TX4938_IR_INT(3)
+
+/*
+ * CCFG
+ */
+/* CCFG : Chip Configuration */
+#define TX4938_CCFG_WDRST	_CONST64(0x0000020000000000)
+#define TX4938_CCFG_WDREXEN	_CONST64(0x0000010000000000)
+#define TX4938_CCFG_BCFG_MASK	_CONST64(0x000000ff00000000)
+#define TX4938_CCFG_TINTDIS	0x01000000
+#define TX4938_CCFG_PCI66	0x00800000
+#define TX4938_CCFG_PCIMODE	0x00400000
+#define TX4938_CCFG_PCI1_66	0x00200000
+#define TX4938_CCFG_DIVMODE_MASK	0x001e0000
+#define TX4938_CCFG_DIVMODE_2	(0x4 << 17)
+#define TX4938_CCFG_DIVMODE_2_5	(0xf << 17)
+#define TX4938_CCFG_DIVMODE_3	(0x5 << 17)
+#define TX4938_CCFG_DIVMODE_4	(0x6 << 17)
+#define TX4938_CCFG_DIVMODE_4_5	(0xd << 17)
+#define TX4938_CCFG_DIVMODE_8	(0x0 << 17)
+#define TX4938_CCFG_DIVMODE_10	(0xb << 17)
+#define TX4938_CCFG_DIVMODE_12	(0x1 << 17)
+#define TX4938_CCFG_DIVMODE_16	(0x2 << 17)
+#define TX4938_CCFG_DIVMODE_18	(0x9 << 17)
+#define TX4938_CCFG_BEOW	0x00010000
+#define TX4938_CCFG_WR	0x00008000
+#define TX4938_CCFG_TOE	0x00004000
+#define TX4938_CCFG_PCIXARB	0x00002000
+#define TX4938_CCFG_PCIDIVMODE_MASK	0x00001c00
+#define TX4938_CCFG_PCIDIVMODE_4	(0x1 << 10)
+#define TX4938_CCFG_PCIDIVMODE_4_5	(0x3 << 10)
+#define TX4938_CCFG_PCIDIVMODE_5	(0x5 << 10)
+#define TX4938_CCFG_PCIDIVMODE_5_5	(0x7 << 10)
+#define TX4938_CCFG_PCIDIVMODE_8	(0x0 << 10)
+#define TX4938_CCFG_PCIDIVMODE_9	(0x2 << 10)
+#define TX4938_CCFG_PCIDIVMODE_10	(0x4 << 10)
+#define TX4938_CCFG_PCIDIVMODE_11	(0x6 << 10)
+#define TX4938_CCFG_PCI1DMD	0x00000100
+#define TX4938_CCFG_SYSSP_MASK	0x000000c0
+#define TX4938_CCFG_ENDIAN	0x00000004
+#define TX4938_CCFG_HALT	0x00000002
+#define TX4938_CCFG_ACEHOLD	0x00000001
+
+/* PCFG : Pin Configuration */
+#define TX4938_PCFG_ETH0_SEL	_CONST64(0x8000000000000000)
+#define TX4938_PCFG_ETH1_SEL	_CONST64(0x4000000000000000)
+#define TX4938_PCFG_ATA_SEL	_CONST64(0x2000000000000000)
+#define TX4938_PCFG_ISA_SEL	_CONST64(0x1000000000000000)
+#define TX4938_PCFG_SPI_SEL	_CONST64(0x0800000000000000)
+#define TX4938_PCFG_NDF_SEL	_CONST64(0x0400000000000000)
+#define TX4938_PCFG_SDCLKDLY_MASK	0x30000000
+#define TX4938_PCFG_SDCLKDLY(d)	((d)<<28)
+#define TX4938_PCFG_SYSCLKEN	0x08000000
+#define TX4938_PCFG_SDCLKEN_ALL	0x07800000
+#define TX4938_PCFG_SDCLKEN(ch)	(0x00800000<<(ch))
+#define TX4938_PCFG_PCICLKEN_ALL	0x003f0000
+#define TX4938_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
+#define TX4938_PCFG_SEL2	0x00000200
+#define TX4938_PCFG_SEL1	0x00000100
+#define TX4938_PCFG_DMASEL_ALL	0x0000000f
+#define TX4938_PCFG_DMASEL0_DRQ0	0x00000000
+#define TX4938_PCFG_DMASEL0_SIO1	0x00000001
+#define TX4938_PCFG_DMASEL1_DRQ1	0x00000000
+#define TX4938_PCFG_DMASEL1_SIO1	0x00000002
+#define TX4938_PCFG_DMASEL2_DRQ2	0x00000000
+#define TX4938_PCFG_DMASEL2_SIO0	0x00000004
+#define TX4938_PCFG_DMASEL3_DRQ3	0x00000000
+#define TX4938_PCFG_DMASEL3_SIO0	0x00000008
+
+/* CLKCTR : Clock Control */
+#define TX4938_CLKCTR_NDFCKD	_CONST64(0x0001000000000000)
+#define TX4938_CLKCTR_NDFRST	_CONST64(0x0000000100000000)
+#define TX4938_CLKCTR_ETH1CKD	0x80000000
+#define TX4938_CLKCTR_ETH0CKD	0x40000000
+#define TX4938_CLKCTR_SPICKD	0x20000000
+#define TX4938_CLKCTR_SRAMCKD	0x10000000
+#define TX4938_CLKCTR_PCIC1CKD	0x08000000
+#define TX4938_CLKCTR_DMA1CKD	0x04000000
+#define TX4938_CLKCTR_ACLCKD	0x02000000
+#define TX4938_CLKCTR_PIOCKD	0x01000000
+#define TX4938_CLKCTR_DMACKD	0x00800000
+#define TX4938_CLKCTR_PCICKD	0x00400000
+#define TX4938_CLKCTR_TM0CKD	0x00100000
+#define TX4938_CLKCTR_TM1CKD	0x00080000
+#define TX4938_CLKCTR_TM2CKD	0x00040000
+#define TX4938_CLKCTR_SIO0CKD	0x00020000
+#define TX4938_CLKCTR_SIO1CKD	0x00010000
+#define TX4938_CLKCTR_ETH1RST	0x00008000
+#define TX4938_CLKCTR_ETH0RST	0x00004000
+#define TX4938_CLKCTR_SPIRST	0x00002000
+#define TX4938_CLKCTR_SRAMRST	0x00001000
+#define TX4938_CLKCTR_PCIC1RST	0x00000800
+#define TX4938_CLKCTR_DMA1RST	0x00000400
+#define TX4938_CLKCTR_ACLRST	0x00000200
+#define TX4938_CLKCTR_PIORST	0x00000100
+#define TX4938_CLKCTR_DMARST	0x00000080
+#define TX4938_CLKCTR_PCIRST	0x00000040
+#define TX4938_CLKCTR_TM0RST	0x00000010
+#define TX4938_CLKCTR_TM1RST	0x00000008
+#define TX4938_CLKCTR_TM2RST	0x00000004
+#define TX4938_CLKCTR_SIO0RST	0x00000002
+#define TX4938_CLKCTR_SIO1RST	0x00000001
+
+/* bits for G2PSTATUS/G2PMASK */
+#define TX4938_PCIC_G2PSTATUS_ALL	0x00000003
+#define TX4938_PCIC_G2PSTATUS_TTOE	0x00000002
+#define TX4938_PCIC_G2PSTATUS_RTOE	0x00000001
+
+/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
+#define TX4938_PCIC_PCISTATUS_ALL	0x0000f900
+
+/* bits for PBACFG */
+#define TX4938_PCIC_PBACFG_FIXPA	0x00000008
+#define TX4938_PCIC_PBACFG_RPBA	0x00000004
+#define TX4938_PCIC_PBACFG_PBAEN	0x00000002
+#define TX4938_PCIC_PBACFG_BMCEN	0x00000001
+
+/* bits for G2PMnGBASE */
+#define TX4938_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for G2PIOGBASE */
+#define TX4938_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for PCICSTATUS/PCICMASK */
+#define TX4938_PCIC_PCICSTATUS_ALL	0x000007b8
+#define TX4938_PCIC_PCICSTATUS_PME	0x00000400
+#define TX4938_PCIC_PCICSTATUS_TLB	0x00000200
+#define TX4938_PCIC_PCICSTATUS_NIB	0x00000100
+#define TX4938_PCIC_PCICSTATUS_ZIB	0x00000080
+#define TX4938_PCIC_PCICSTATUS_PERR	0x00000020
+#define TX4938_PCIC_PCICSTATUS_SERR	0x00000010
+#define TX4938_PCIC_PCICSTATUS_GBE	0x00000008
+#define TX4938_PCIC_PCICSTATUS_IWB	0x00000002
+#define TX4938_PCIC_PCICSTATUS_E2PDONE	0x00000001
+
+/* bits for PCICCFG */
+#define TX4938_PCIC_PCICCFG_GBWC_MASK	0x0fff0000
+#define TX4938_PCIC_PCICCFG_HRST	0x00000800
+#define TX4938_PCIC_PCICCFG_SRST	0x00000400
+#define TX4938_PCIC_PCICCFG_IRBER	0x00000200
+#define TX4938_PCIC_PCICCFG_G2PMEN(ch)	(0x00000100>>(ch))
+#define TX4938_PCIC_PCICCFG_G2PM0EN	0x00000100
+#define TX4938_PCIC_PCICCFG_G2PM1EN	0x00000080
+#define TX4938_PCIC_PCICCFG_G2PM2EN	0x00000040
+#define TX4938_PCIC_PCICCFG_G2PIOEN	0x00000020
+#define TX4938_PCIC_PCICCFG_TCAR	0x00000010
+#define TX4938_PCIC_PCICCFG_ICAEN	0x00000008
+
+/* bits for P2GMnGBASE */
+#define TX4938_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
+#define TX4938_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
+
+/* bits for P2GIOGBASE */
+#define TX4938_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
+#define TX4938_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
+
+#define TX4938_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
+#define TX4938_PCIC_MAX_DEVNU	TX4938_PCIC_IDSEL_AD_TO_SLOT(32)
+
+/* bits for PDMCFG */
+#define TX4938_PCIC_PDMCFG_RSTFIFO	0x00200000
+#define TX4938_PCIC_PDMCFG_EXFER	0x00100000
+#define TX4938_PCIC_PDMCFG_REQDLY_MASK	0x00003800
+#define TX4938_PCIC_PDMCFG_REQDLY_NONE	(0 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_16	(1 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_32	(2 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_64	(3 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_128	(4 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_256	(5 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_512	(6 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_1024	(7 << 11)
+#define TX4938_PCIC_PDMCFG_ERRIE	0x00000400
+#define TX4938_PCIC_PDMCFG_NCCMPIE	0x00000200
+#define TX4938_PCIC_PDMCFG_NTCMPIE	0x00000100
+#define TX4938_PCIC_PDMCFG_CHNEN	0x00000080
+#define TX4938_PCIC_PDMCFG_XFRACT	0x00000040
+#define TX4938_PCIC_PDMCFG_BSWAP	0x00000020
+#define TX4938_PCIC_PDMCFG_XFRSIZE_MASK	0x0000000c
+#define TX4938_PCIC_PDMCFG_XFRSIZE_1DW	0x00000000
+#define TX4938_PCIC_PDMCFG_XFRSIZE_1QW	0x00000004
+#define TX4938_PCIC_PDMCFG_XFRSIZE_4QW	0x00000008
+#define TX4938_PCIC_PDMCFG_XFRDIRC	0x00000002
+#define TX4938_PCIC_PDMCFG_CHRST	0x00000001
+
+/* bits for PDMSTS */
+#define TX4938_PCIC_PDMSTS_REQCNT_MASK	0x3f000000
+#define TX4938_PCIC_PDMSTS_FIFOCNT_MASK	0x00f00000
+#define TX4938_PCIC_PDMSTS_FIFOWP_MASK	0x000c0000
+#define TX4938_PCIC_PDMSTS_FIFORP_MASK	0x00030000
+#define TX4938_PCIC_PDMSTS_ERRINT	0x00000800
+#define TX4938_PCIC_PDMSTS_DONEINT	0x00000400
+#define TX4938_PCIC_PDMSTS_CHNEN	0x00000200
+#define TX4938_PCIC_PDMSTS_XFRACT	0x00000100
+#define TX4938_PCIC_PDMSTS_ACCMP	0x00000080
+#define TX4938_PCIC_PDMSTS_NCCMP	0x00000040
+#define TX4938_PCIC_PDMSTS_NTCMP	0x00000020
+#define TX4938_PCIC_PDMSTS_CFGERR	0x00000008
+#define TX4938_PCIC_PDMSTS_PCIERR	0x00000004
+#define TX4938_PCIC_PDMSTS_CHNERR	0x00000002
+#define TX4938_PCIC_PDMSTS_DATAERR	0x00000001
+#define TX4938_PCIC_PDMSTS_ALL_CMP	0x000000e0
+#define TX4938_PCIC_PDMSTS_ALL_ERR	0x0000000f
+
+/*
+ * DMA
+ */
+/* bits for MCR */
+#define TX4938_DMA_MCR_EIS(ch)	(0x10000000<<(ch))
+#define TX4938_DMA_MCR_DIS(ch)	(0x01000000<<(ch))
+#define TX4938_DMA_MCR_RSFIF	0x00000080
+#define TX4938_DMA_MCR_FIFUM(ch)	(0x00000008<<(ch))
+#define TX4938_DMA_MCR_RPRT	0x00000002
+#define TX4938_DMA_MCR_MSTEN	0x00000001
+
+/* bits for CCRn */
+#define TX4938_DMA_CCR_IMMCHN	0x20000000
+#define TX4938_DMA_CCR_USEXFSZ	0x10000000
+#define TX4938_DMA_CCR_LE	0x08000000
+#define TX4938_DMA_CCR_DBINH	0x04000000
+#define TX4938_DMA_CCR_SBINH	0x02000000
+#define TX4938_DMA_CCR_CHRST	0x01000000
+#define TX4938_DMA_CCR_RVBYTE	0x00800000
+#define TX4938_DMA_CCR_ACKPOL	0x00400000
+#define TX4938_DMA_CCR_REQPL	0x00200000
+#define TX4938_DMA_CCR_EGREQ	0x00100000
+#define TX4938_DMA_CCR_CHDN	0x00080000
+#define TX4938_DMA_CCR_DNCTL	0x00060000
+#define TX4938_DMA_CCR_EXTRQ	0x00010000
+#define TX4938_DMA_CCR_INTRQD	0x0000e000
+#define TX4938_DMA_CCR_INTENE	0x00001000
+#define TX4938_DMA_CCR_INTENC	0x00000800
+#define TX4938_DMA_CCR_INTENT	0x00000400
+#define TX4938_DMA_CCR_CHNEN	0x00000200
+#define TX4938_DMA_CCR_XFACT	0x00000100
+#define TX4938_DMA_CCR_SMPCHN	0x00000020
+#define TX4938_DMA_CCR_XFSZ(order)	(((order) << 2) & 0x0000001c)
+#define TX4938_DMA_CCR_XFSZ_1W	TX4938_DMA_CCR_XFSZ(2)
+#define TX4938_DMA_CCR_XFSZ_2W	TX4938_DMA_CCR_XFSZ(3)
+#define TX4938_DMA_CCR_XFSZ_4W	TX4938_DMA_CCR_XFSZ(4)
+#define TX4938_DMA_CCR_XFSZ_8W	TX4938_DMA_CCR_XFSZ(5)
+#define TX4938_DMA_CCR_XFSZ_16W	TX4938_DMA_CCR_XFSZ(6)
+#define TX4938_DMA_CCR_XFSZ_32W	TX4938_DMA_CCR_XFSZ(7)
+#define TX4938_DMA_CCR_MEMIO	0x00000002
+#define TX4938_DMA_CCR_SNGAD	0x00000001
+
+/* bits for CSRn */
+#define TX4938_DMA_CSR_CHNEN	0x00000400
+#define TX4938_DMA_CSR_STLXFER	0x00000200
+#define TX4938_DMA_CSR_CHNACT	0x00000100
+#define TX4938_DMA_CSR_ABCHC	0x00000080
+#define TX4938_DMA_CSR_NCHNC	0x00000040
+#define TX4938_DMA_CSR_NTRNFC	0x00000020
+#define TX4938_DMA_CSR_EXTDN	0x00000010
+#define TX4938_DMA_CSR_CFERR	0x00000008
+#define TX4938_DMA_CSR_CHERR	0x00000004
+#define TX4938_DMA_CSR_DESERR	0x00000002
+#define TX4938_DMA_CSR_SORERR	0x00000001
+
+#ifndef __ASSEMBLY__
+
+#define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
+#define tx4938_ebuscptr         ((struct tx4938_ebusc_reg *)TX4938_EBUSC_REG)
+#define tx4938_dmaptr(ch)	((struct tx4938_dma_reg *)TX4938_DMA_REG(ch))
+#define tx4938_ndfmcptr		((struct tx4938_ndfmc_reg *)TX4938_NDFMC_REG)
+#define tx4938_pcicptr		((struct tx4938_pcic_reg *)TX4938_PCIC_REG)
+#define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
+#define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
+#define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
+#define tx4938_pioptr		((struct txx9_pio_reg __iomem *)TX4938_PIO_REG)
+#define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
+#define tx4938_spiptr		((struct tx4938_spi_reg *)TX4938_SPI_REG)
+#define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
+
+
+#define TX4938_REV_MAJ_MIN()	((unsigned long)tx4938_ccfgptr->crir & 0x00ff)
+#define TX4938_REV_PCODE()	((unsigned long)tx4938_ccfgptr->crir >> 16)
+
+#define TX4938_SDRAMC_BA(ch)	((tx4938_sdramcptr->cr[ch] >> 49) << 21)
+#define TX4938_SDRAMC_SIZE(ch)	(((tx4938_sdramcptr->cr[ch] >> 33) + 1) << 21)
+
+#define TX4938_EBUSC_BA(ch)	((tx4938_ebuscptr->cr[ch] >> 48) << 20)
+#define TX4938_EBUSC_SIZE(ch)	\
+	(0x00100000 << ((unsigned long)(tx4938_ebuscptr->cr[ch] >> 8) & 0xf))
+
+
+#endif /* !__ASSEMBLY__ */
+
+#endif
diff --git a/include/asm-mips/txx9/txx927.h b/include/asm-mips/txx9/txx927.h
new file mode 100644
index 0000000..97dd7ad
--- /dev/null
+++ b/include/asm-mips/txx9/txx927.h
@@ -0,0 +1,121 @@
+/*
+ * Common definitions for TX3927/TX4927
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000 Toshiba Corporation
+ */
+#ifndef __ASM_TXX9_TXX927_H
+#define __ASM_TXX9_TXX927_H
+
+struct txx927_sio_reg {
+	volatile unsigned long lcr;
+	volatile unsigned long dicr;
+	volatile unsigned long disr;
+	volatile unsigned long cisr;
+	volatile unsigned long fcr;
+	volatile unsigned long flcr;
+	volatile unsigned long bgr;
+	volatile unsigned long tfifo;
+	volatile unsigned long rfifo;
+};
+
+/*
+ * SIO
+ */
+/* SILCR : Line Control */
+#define TXx927_SILCR_SCS_MASK	0x00000060
+#define TXx927_SILCR_SCS_IMCLK	0x00000000
+#define TXx927_SILCR_SCS_IMCLK_BG	0x00000020
+#define TXx927_SILCR_SCS_SCLK	0x00000040
+#define TXx927_SILCR_SCS_SCLK_BG	0x00000060
+#define TXx927_SILCR_UEPS	0x00000010
+#define TXx927_SILCR_UPEN	0x00000008
+#define TXx927_SILCR_USBL_MASK	0x00000004
+#define TXx927_SILCR_USBL_1BIT	0x00000004
+#define TXx927_SILCR_USBL_2BIT	0x00000000
+#define TXx927_SILCR_UMODE_MASK	0x00000003
+#define TXx927_SILCR_UMODE_8BIT	0x00000000
+#define TXx927_SILCR_UMODE_7BIT	0x00000001
+
+/* SIDICR : DMA/Int. Control */
+#define TXx927_SIDICR_TDE	0x00008000
+#define TXx927_SIDICR_RDE	0x00004000
+#define TXx927_SIDICR_TIE	0x00002000
+#define TXx927_SIDICR_RIE	0x00001000
+#define TXx927_SIDICR_SPIE	0x00000800
+#define TXx927_SIDICR_CTSAC	0x00000600
+#define TXx927_SIDICR_STIE_MASK	0x0000003f
+#define TXx927_SIDICR_STIE_OERS		0x00000020
+#define TXx927_SIDICR_STIE_CTSS		0x00000010
+#define TXx927_SIDICR_STIE_RBRKD	0x00000008
+#define TXx927_SIDICR_STIE_TRDY		0x00000004
+#define TXx927_SIDICR_STIE_TXALS	0x00000002
+#define TXx927_SIDICR_STIE_UBRKD	0x00000001
+
+/* SIDISR : DMA/Int. Status */
+#define TXx927_SIDISR_UBRK	0x00008000
+#define TXx927_SIDISR_UVALID	0x00004000
+#define TXx927_SIDISR_UFER	0x00002000
+#define TXx927_SIDISR_UPER	0x00001000
+#define TXx927_SIDISR_UOER	0x00000800
+#define TXx927_SIDISR_ERI	0x00000400
+#define TXx927_SIDISR_TOUT	0x00000200
+#define TXx927_SIDISR_TDIS	0x00000100
+#define TXx927_SIDISR_RDIS	0x00000080
+#define TXx927_SIDISR_STIS	0x00000040
+#define TXx927_SIDISR_RFDN_MASK	0x0000001f
+
+/* SICISR : Change Int. Status */
+#define TXx927_SICISR_OERS	0x00000020
+#define TXx927_SICISR_CTSS	0x00000010
+#define TXx927_SICISR_RBRKD	0x00000008
+#define TXx927_SICISR_TRDY	0x00000004
+#define TXx927_SICISR_TXALS	0x00000002
+#define TXx927_SICISR_UBRKD	0x00000001
+
+/* SIFCR : FIFO Control */
+#define TXx927_SIFCR_SWRST	0x00008000
+#define TXx927_SIFCR_RDIL_MASK	0x00000180
+#define TXx927_SIFCR_RDIL_1	0x00000000
+#define TXx927_SIFCR_RDIL_4	0x00000080
+#define TXx927_SIFCR_RDIL_8	0x00000100
+#define TXx927_SIFCR_RDIL_12	0x00000180
+#define TXx927_SIFCR_RDIL_MAX	0x00000180
+#define TXx927_SIFCR_TDIL_MASK	0x00000018
+#define TXx927_SIFCR_TDIL_MASK	0x00000018
+#define TXx927_SIFCR_TDIL_1	0x00000000
+#define TXx927_SIFCR_TDIL_4	0x00000001
+#define TXx927_SIFCR_TDIL_8	0x00000010
+#define TXx927_SIFCR_TDIL_MAX	0x00000010
+#define TXx927_SIFCR_TFRST	0x00000004
+#define TXx927_SIFCR_RFRST	0x00000002
+#define TXx927_SIFCR_FRSTE	0x00000001
+#define TXx927_SIO_TX_FIFO	8
+#define TXx927_SIO_RX_FIFO	16
+
+/* SIFLCR : Flow Control */
+#define TXx927_SIFLCR_RCS	0x00001000
+#define TXx927_SIFLCR_TES	0x00000800
+#define TXx927_SIFLCR_RTSSC	0x00000200
+#define TXx927_SIFLCR_RSDE	0x00000100
+#define TXx927_SIFLCR_TSDE	0x00000080
+#define TXx927_SIFLCR_RTSTL_MASK	0x0000001e
+#define TXx927_SIFLCR_RTSTL_MAX	0x0000001e
+#define TXx927_SIFLCR_TBRK	0x00000001
+
+/* SIBGR : Baudrate Control */
+#define TXx927_SIBGR_BCLK_MASK	0x00000300
+#define TXx927_SIBGR_BCLK_T0	0x00000000
+#define TXx927_SIBGR_BCLK_T2	0x00000100
+#define TXx927_SIBGR_BCLK_T4	0x00000200
+#define TXx927_SIBGR_BCLK_T6	0x00000300
+#define TXx927_SIBGR_BRD_MASK	0x000000ff
+
+/*
+ * PIO
+ */
+
+#endif /* __ASM_TXX9_TXX927_H */
