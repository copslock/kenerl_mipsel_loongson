Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 15:15:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:59857 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029049AbXJXOPJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2007 15:15:09 +0100
Received: from localhost (p1200-ipad310funabasi.chiba.ocn.ne.jp [123.217.203.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 90836A375; Wed, 24 Oct 2007 23:15:02 +0900 (JST)
Date:	Wed, 24 Oct 2007 23:16:56 +0900 (JST)
Message-Id: <20071024.231656.72707756.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] cleanup tx39/tx49 setup code
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
X-archive-position: 17197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Remove some unnecessary codes, includes and files.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This can be applied after a patch titled:
"[PATCH] txx9tmr clockevent/clocksource driver"

 arch/mips/jmr3927/rbhma3100/setup.c                |    5 -
 arch/mips/tx4927/common/Makefile                   |    2 +-
 arch/mips/tx4927/common/tx4927_setup.c             |  186 --------------------
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   41 +----
 arch/mips/tx4938/common/Makefile                   |    2 +-
 arch/mips/tx4938/common/setup.c                    |   45 -----
 arch/mips/tx4938/toshiba_rbtx4938/setup.c          |    6 +-
 7 files changed, 7 insertions(+), 280 deletions(-)

diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 06e01c8..75cfe65 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -29,21 +29,16 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/kdev_t.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/ide.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #ifdef CONFIG_SERIAL_TXX9
-#include <linux/tty.h>
-#include <linux/serial.h>
 #include <linux/serial_core.h>
 #endif
 
-#include <asm/addrspace.h>
 #include <asm/txx9tmr.h>
 #include <asm/reboot.h>
 #include <asm/jmr3927/jmr3927.h>
diff --git a/arch/mips/tx4927/common/Makefile b/arch/mips/tx4927/common/Makefile
index 1837578..e4a5e46 100644
--- a/arch/mips/tx4927/common/Makefile
+++ b/arch/mips/tx4927/common/Makefile
@@ -6,7 +6,7 @@
 # unless it's something special (ie not a .c file).
 #
 
-obj-y	+= tx4927_prom.o tx4927_setup.o tx4927_irq.o
+obj-y	+= tx4927_prom.o tx4927_irq.o
 
 obj-$(CONFIG_TOSHIBA_FPCIB0)	   += smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)                 += tx4927_dbgio.o
diff --git a/arch/mips/tx4927/common/tx4927_setup.c b/arch/mips/tx4927/common/tx4927_setup.c
deleted file mode 100644
index 36c5f20..0000000
--- a/arch/mips/tx4927/common/tx4927_setup.c
+++ /dev/null
@@ -1,186 +0,0 @@
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
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/irq.h>
-#include <linux/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/tx4927/tx4927.h>
-
-
-#undef DEBUG
-
-void dump_cp0(char *key);
-
-
-void __init plat_mem_setup(void)
-{
-#ifdef CONFIG_TOSHIBA_RBTX4927
-	{
-		extern void toshiba_rbtx4927_setup(void);
-		toshiba_rbtx4927_setup();
-	}
-#endif
-}
-
-void __init plat_time_init(void)
-{
-#ifdef CONFIG_TOSHIBA_RBTX4927
-	{
-		extern void toshiba_rbtx4927_time_init(void);
-		toshiba_rbtx4927_time_init();
-	}
-#endif
-}
-
-#ifdef DEBUG
-void print_cp0(char *key, int num, char *name, u32 val)
-{
-	printk("%s cp0:%02d:%s=0x%08x\n", key, num, name, val);
-	return;
-}
-
-void
-dump_cp0(char *key)
-{
-	if (key == NULL)
-		key = "";
-
-	print_cp0(key, 0, "INDEX   ", read_c0_index());
-	print_cp0(key, 2, "ENTRYLO1", read_c0_entrylo0());
-	print_cp0(key, 3, "ENTRYLO2", read_c0_entrylo1());
-	print_cp0(key, 4, "CONTEXT ", read_c0_context());
-	print_cp0(key, 5, "PAGEMASK", read_c0_pagemask());
-	print_cp0(key, 6, "WIRED   ", read_c0_wired());
-	//print_cp0(key, 8, "BADVADDR",  read_c0_badvaddr());
-	print_cp0(key, 9, "COUNT   ", read_c0_count());
-	print_cp0(key, 10, "ENTRYHI ", read_c0_entryhi());
-	print_cp0(key, 11, "COMPARE ", read_c0_compare());
-	print_cp0(key, 12, "STATUS  ", read_c0_status());
-	print_cp0(key, 13, "CAUSE   ", read_c0_cause() & 0xffff87ff);
-	print_cp0(key, 16, "CONFIG  ", read_c0_config());
-	return;
-}
-
-void print_pic(char *key, unsigned long reg, char *name)
-{
-	printk(KERN_INFO "%s pic:0x%08lx:%s=0x%08x\n", key, reg, name,
-	       __raw_readl((void __iomem *)reg));
-	return;
-}
-
-
-void dump_pic(char *key)
-{
-	if (key == NULL)
-		key = "";
-
-	print_pic(key, 0xff1ff600, "IRDEN    ");
-	print_pic(key, 0xff1ff604, "IRDM0    ");
-	print_pic(key, 0xff1ff608, "IRDM1    ");
-
-	print_pic(key, 0xff1ff610, "IRLVL0   ");
-	print_pic(key, 0xff1ff614, "IRLVL1   ");
-	print_pic(key, 0xff1ff618, "IRLVL2   ");
-	print_pic(key, 0xff1ff61c, "IRLVL3   ");
-	print_pic(key, 0xff1ff620, "IRLVL4   ");
-	print_pic(key, 0xff1ff624, "IRLVL5   ");
-	print_pic(key, 0xff1ff628, "IRLVL6   ");
-	print_pic(key, 0xff1ff62c, "IRLVL7   ");
-
-	print_pic(key, 0xff1ff640, "IRMSK    ");
-	print_pic(key, 0xff1ff660, "IREDC    ");
-	print_pic(key, 0xff1ff680, "IRPND    ");
-	print_pic(key, 0xff1ff6a0, "IRCS     ");
-
-	print_pic(key, 0xff1ff514, "IRFLAG1  ");	/* don't read IRLAG0 -- it hangs system */
-
-	print_pic(key, 0xff1ff518, "IRPOL    ");
-	print_pic(key, 0xff1ff51c, "IRRCNT   ");
-	print_pic(key, 0xff1ff520, "IRMASKINT");
-	print_pic(key, 0xff1ff524, "IRMASKEXT");
-
-	return;
-}
-
-
-void print_addr(char *hdr, char *key, unsigned long addr)
-{
-	printk(KERN_INFO "%s %s:0x%08lx=0x%08x\n", hdr, key, addr,
-	       __raw_readl((void __iomem *)addr));
-	return;
-}
-
-
-void dump_180(char *key)
-{
-	u32 i;
-
-	for (i = 0x80000180; i < 0x80000180 + 0x80; i += 4) {
-		print_addr("180", key, i);
-	}
-	return;
-}
-
-
-void dump_eh0(char *key)
-{
-	int i;
-	extern unsigned long exception_handlers[];
-
-	for (i = (int) exception_handlers;
-	     i < (int) (exception_handlers + 20); i += 4) {
-		print_addr("eh0", key, i);
-	}
-
-	return;
-}
-
-void pk0(void)
-{
-	volatile u32 val;
-
-	__asm__ __volatile__("ori %0, $26, 0":"=r"(val)
-	    );
-	printk("k0=[0x%08x]\n", val);
-}
-#endif
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 0299595..c29a528 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -45,27 +45,18 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <linux/timex.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 
 #include <asm/bootinfo.h>
-#include <asm/page.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/irq_regs.h>
 #include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/txx9tmr.h>
-#include <linux/bootmem.h>
-#include <linux/blkdev.h>
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
@@ -73,42 +64,26 @@
 #ifdef CONFIG_PCI
 #include <asm/tx4927/tx4927_pci.h>
 #endif
-#ifdef CONFIG_BLK_DEV_IDEPCI
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-#endif
 #ifdef CONFIG_SERIAL_TXX9
-#include <linux/tty.h>
-#include <linux/serial.h>
 #include <linux/serial_core.h>
 #endif
 
 #undef TOSHIBA_RBTX4927_SETUP_DEBUG
 
 #ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-#define TOSHIBA_RBTX4927_SETUP_NONE        0x00000000
-
-#define TOSHIBA_RBTX4927_SETUP_INFO        ( 1 <<  0 )
-#define TOSHIBA_RBTX4927_SETUP_WARN        ( 1 <<  1 )
-#define TOSHIBA_RBTX4927_SETUP_EROR        ( 1 <<  2 )
-
-#define TOSHIBA_RBTX4927_SETUP_EFWFU       ( 1 <<  3 )
 #define TOSHIBA_RBTX4927_SETUP_SETUP       ( 1 <<  4 )
 #define TOSHIBA_RBTX4927_SETUP_PCIBIOS     ( 1 <<  7 )
 #define TOSHIBA_RBTX4927_SETUP_PCI1        ( 1 <<  8 )
 #define TOSHIBA_RBTX4927_SETUP_PCI2        ( 1 <<  9 )
-#define TOSHIBA_RBTX4927_SETUP_PCI66       ( 1 << 10 )
 
 #define TOSHIBA_RBTX4927_SETUP_ALL         0xffffffff
 #endif
 
 #ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
 static const u32 toshiba_rbtx4927_setup_debug_flag =
-    (TOSHIBA_RBTX4927_SETUP_NONE | TOSHIBA_RBTX4927_SETUP_INFO |
-     TOSHIBA_RBTX4927_SETUP_WARN | TOSHIBA_RBTX4927_SETUP_EROR |
-     TOSHIBA_RBTX4927_SETUP_EFWFU | TOSHIBA_RBTX4927_SETUP_SETUP |
+    (TOSHIBA_RBTX4927_SETUP_SETUP |
      | TOSHIBA_RBTX4927_SETUP_PCIBIOS | TOSHIBA_RBTX4927_SETUP_PCI1 |
-     TOSHIBA_RBTX4927_SETUP_PCI2 | TOSHIBA_RBTX4927_SETUP_PCI66);
+     TOSHIBA_RBTX4927_SETUP_PCI2);
 #endif
 
 #ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
@@ -718,7 +693,7 @@ void toshiba_rbtx4927_power_off(void)
 	/* no return */
 }
 
-void __init toshiba_rbtx4927_setup(void)
+void __init plat_mem_setup(void)
 {
 	int i;
 	u32 cp0_config;
@@ -741,13 +716,6 @@ void __init toshiba_rbtx4927_setup(void)
 	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
 	write_c0_config(cp0_config);
 
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-	{
-		extern void dump_cp0(char *);
-		dump_cp0("toshiba_rbtx4927_early_fw_fixup");
-	}
-#endif
-
 	set_io_port_base(KSEG1 + TBTX4927_ISA_IO_OFFSET);
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       ":mips_io_port_base=0x%08lx\n",
@@ -936,8 +904,7 @@ void __init toshiba_rbtx4927_setup(void)
 			       "+\n");
 }
 
-void __init
-toshiba_rbtx4927_time_init(void)
+void __init plat_time_init(void)
 {
 	mips_hpt_frequency = tx4927_cpu_clock / 2;
 	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
diff --git a/arch/mips/tx4938/common/Makefile b/arch/mips/tx4938/common/Makefile
index 8352eca..c5c6cea 100644
--- a/arch/mips/tx4938/common/Makefile
+++ b/arch/mips/tx4938/common/Makefile
@@ -6,7 +6,7 @@
 # unless it's something special (ie not a .c file).
 #
 
-obj-y	+= prom.o setup.o irq.o
+obj-y	+= prom.o irq.o
 obj-$(CONFIG_KGDB) += dbgio.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/tx4938/common/setup.c b/arch/mips/tx4938/common/setup.c
deleted file mode 100644
index 3ba4101..0000000
--- a/arch/mips/tx4938/common/setup.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * linux/arch/mips/tx4938/common/setup.c
- *
- * common tx4938 setup routines
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/irq.h>
-#include <linux/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/tx4938/rbtx4938.h>
-
-extern void toshiba_rbtx4938_setup(void);
-
-void __init tx4938_setup(void);
-void dump_cp0(char *key);
-
-void __init
-plat_mem_setup(void)
-{
-	toshiba_rbtx4938_setup();
-}
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 4a81523..d13af99 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -24,16 +24,12 @@
 
 #include <asm/wbflush.h>
 #include <asm/reboot.h>
-#include <asm/irq.h>
 #include <asm/time.h>
 #include <asm/txx9tmr.h>
-#include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/bootinfo.h>
 #include <asm/tx4938/rbtx4938.h>
 #ifdef CONFIG_SERIAL_TXX9
-#include <linux/tty.h>
-#include <linux/serial.h>
 #include <linux/serial_core.h>
 #endif
 #include <linux/spi/spi.h>
@@ -855,7 +851,7 @@ void __init plat_time_init(void)
 				     txx9_gbus_clock / 2);
 }
 
-void __init toshiba_rbtx4938_setup(void)
+void __init plat_mem_setup(void)
 {
 	unsigned long long pcfg;
 	char *argptr;
