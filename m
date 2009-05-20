Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:55:01 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.248]:5964 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025179AbZETVyr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:54:47 +0100
Received: by rv-out-0708.google.com with SMTP id k29so232471rvb.24
        for <multiple recipients>; Wed, 20 May 2009 14:54:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/AkyraAMIMU3ssZ9dhjTVNs/vAM93Bd5T7/cHM5fc1Y=;
        b=aj48HUUOzHxNWB5LFRwnRbu+61v9gTl+nfgdPZixEhUDzqrjhkqN9+dRgAV9FHL/57
         fPYDKBPMUvRUM/R7DKhz5r9ErGEsV4KUDyq8r1DBODAgbUioLmqCEtqK8eQ6sHRTVfdJ
         WN29yulBHmb5X/ryMkVggQ6Wk9m7o5FOHVGrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g2+PpArz3rFyUrsAjTnE3N5VCBGjHQ1aodNo06embH5IbDNGvY0lbTbqMVACFoP+E0
         xySwoRl3Pw7BGU76GVZfztwqgMD8fbc+CQ06CDky1U4oswUPOKZgqsbOsexrhsVTUBvT
         oiZRCwmrNXyIWMYMtpxheu2U+cehtN795TqBg=
Received: by 10.141.37.8 with SMTP id p8mr843262rvj.154.1242856484571;
        Wed, 20 May 2009 14:54:44 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id b8sm4641910rvf.24.2009.05.20.14.54.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:54:43 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 11/27] split the loongson-specific part out
Date:	Thu, 21 May 2009 05:54:31 +0800
Message-Id: <5760e95a45f5dadadf2891fa19060012c0eaafd1.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

for sharing lots of loongson-specific source code among loongson-based
machines, there is a need to split the loongson-specific part out to a
common/ directory.

and the machine-specific files are put in the machine-name/ directory.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                              |   54 +++++-------
 arch/mips/Makefile                             |    5 +-
 arch/mips/include/asm/mach-loongson/loongson.h |   14 +++-
 arch/mips/loongson/Kconfig                     |   31 +++++++
 arch/mips/loongson/Makefile                    |   11 +++
 arch/mips/loongson/common/Makefile             |   20 +++++
 arch/mips/loongson/common/bonito-irq.c         |   69 +++++++++++++++
 arch/mips/loongson/common/cmdline.c            |   80 +++++++++++++++++
 arch/mips/loongson/common/early_printk.c       |   28 ++++++
 arch/mips/loongson/common/init.c               |   40 +++++++++
 arch/mips/loongson/common/irq.c                |  110 ++++++++++++++++++++++++
 arch/mips/loongson/common/mem.c                |   40 +++++++++
 arch/mips/loongson/common/misc.c               |   15 +++
 arch/mips/loongson/common/pci.c                |  101 ++++++++++++++++++++++
 arch/mips/loongson/common/reset.c              |   38 ++++++++
 arch/mips/loongson/common/rtc.c                |   54 ++++++++++++
 arch/mips/loongson/common/setup.c              |   74 ++++++++++++++++
 arch/mips/loongson/common/time.c               |   27 ++++++
 arch/mips/loongson/fuloong-2e/Makefile         |   17 +---
 arch/mips/loongson/fuloong-2e/bonito-irq.c     |   69 ---------------
 arch/mips/loongson/fuloong-2e/cmdline.c        |   77 -----------------
 arch/mips/loongson/fuloong-2e/early_printk.c   |   28 ------
 arch/mips/loongson/fuloong-2e/init.c           |   40 ---------
 arch/mips/loongson/fuloong-2e/irq.c            |   89 +------------------
 arch/mips/loongson/fuloong-2e/mem.c            |   40 ---------
 arch/mips/loongson/fuloong-2e/misc.c           |   15 ---
 arch/mips/loongson/fuloong-2e/pci.c            |  102 ----------------------
 arch/mips/loongson/fuloong-2e/reset.c          |   36 +++------
 arch/mips/loongson/fuloong-2e/rtc.c            |   55 ------------
 arch/mips/loongson/fuloong-2e/setup.c          |   74 ----------------
 arch/mips/loongson/fuloong-2e/time.c           |   27 ------
 31 files changed, 793 insertions(+), 687 deletions(-)
 create mode 100644 arch/mips/loongson/Kconfig
 create mode 100644 arch/mips/loongson/Makefile
 create mode 100644 arch/mips/loongson/common/Makefile
 create mode 100644 arch/mips/loongson/common/bonito-irq.c
 create mode 100644 arch/mips/loongson/common/cmdline.c
 create mode 100644 arch/mips/loongson/common/early_printk.c
 create mode 100644 arch/mips/loongson/common/init.c
 create mode 100644 arch/mips/loongson/common/irq.c
 create mode 100644 arch/mips/loongson/common/mem.c
 create mode 100644 arch/mips/loongson/common/misc.c
 create mode 100644 arch/mips/loongson/common/pci.c
 create mode 100644 arch/mips/loongson/common/reset.c
 create mode 100644 arch/mips/loongson/common/rtc.c
 create mode 100644 arch/mips/loongson/common/setup.c
 create mode 100644 arch/mips/loongson/common/time.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/bonito-irq.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/cmdline.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/early_printk.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/init.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/mem.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/misc.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/pci.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/rtc.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/setup.c
 delete mode 100644 arch/mips/loongson/fuloong-2e/time.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 974ce41..b5581d6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,7 +6,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
-	select RTC_LIB if !LEMOTE_FULOONG2E
+	select RTC_LIB if !LOONGSON_SYSTEMS
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
@@ -156,31 +156,16 @@ config LASAT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
-config LEMOTE_FULOONG2E
-	bool "Lemote Fuloong(2e) mini-PC"
-	select ARCH_SPARSEMEM_ENABLE
-	select CEVT_R4K
-	select CSRC_R4K
-	select SYS_HAS_CPU_LOONGSON2
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select BOARD_SCACHE
-	select HAVE_STD_PC_SERIAL_PORT
-	select HW_HAS_PCI
-	select I8259
-	select ISA
-	select IRQ_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_HAS_EARLY_PRINTK
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GENERIC_ISA_DMA_SUPPORT_BROKEN
-	select CPU_HAS_WB
+config LOONGSON_SYSTEMS
+	bool "Loongson Based Machines"
 	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
-	  an FPGA northbridge
+	  This enables the support of Loongson based machines.
+
+	  Loongson is a family of general-purpose MIPS-compatible CPUs.
+	  developed at Institute of Computing Technology (ICT),
+	  Chinese Academy of Sciences (CAS) in the People's Republic
+	  of China. The chief architect is Professor Weiwu Hu.
+
 
 config MIPS_MALTA
 	bool "MIPS Malta board"
@@ -649,6 +634,7 @@ source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
+source "arch/mips/loongson/Kconfig"
 
 endmenu
 
@@ -1014,12 +1000,10 @@ choice
 	prompt "CPU type"
 	default CPU_R4X00
 
-config CPU_LOONGSON2
-	bool "Loongson 2"
-	depends on SYS_HAS_CPU_LOONGSON2
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_SUPPORTS_64BIT_KERNEL
-	select CPU_SUPPORTS_HIGHMEM
+config CPU_LOONGSON2E
+	bool "Loongson 2E"
+	depends on SYS_HAS_CPU_LOONGSON2E
+	select CPU_LOONGSON2
 	help
 	  The Loongson 2E processor implements the MIPS III instruction set
 	  with many extensions.
@@ -1262,7 +1246,13 @@ config CPU_CAVIUM_OCTEON
 
 endchoice
 
-config SYS_HAS_CPU_LOONGSON2
+config CPU_LOONGSON2
+	bool
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+
+config SYS_HAS_CPU_LOONGSON2E
 	bool
 
 config SYS_HAS_CPU_MIPS32_R1
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7afec0b..6cbfc22 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -306,9 +306,10 @@ load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
 #
 # lemote fulong mini-PC board
 #
-core-$(CONFIG_LEMOTE_FULOONG2E) +=arch/mips/loongson/fuloong-2e/
+core-$(CONFIG_LOONGSON_SYSTEMS) +=arch/mips/loongson/
+cflags-$(CONFIG_LOONGSON_SYSTEMS) += -I$(srctree)/arch/mips/include/asm/mach-loongson \
+					-mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
-cflags-$(CONFIG_LEMOTE_FULOONG2E) += -I$(srctree)/arch/mips/include/asm/mach-loongson
 
 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 5ad629e..29c9730 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -20,7 +20,7 @@
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
 
-/* command line */
+/* command line arguments */
 extern unsigned long bus_clock, cpu_clock_freq;
 extern unsigned long memsize, highmemsize;
 
@@ -31,6 +31,18 @@ extern void loongson_reboot_setup(void);
 extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
 
+/* irq operation functions */
+extern void bonito_irqdispatch(void);
+extern void i8259_irqdispatch(void);
+extern void __init bonito_irq_init(void);
+extern void __init set_irq_trigger_mode(void);
+extern inline int mach_i8259_irq(void);
+extern inline void mach_irq_dispatch(unsigned int pending);
+
+/* machine-specific reboot/halt operation */
+extern void mach_prepare_reboot(void);
+extern void mach_prepare_shutdown(void);
+
 #define LOONGSON_REG(x) \
 	(*(u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
 #define LOONGSON_IRQ_BASE	32
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
new file mode 100644
index 0000000..5874bf6
--- /dev/null
+++ b/arch/mips/loongson/Kconfig
@@ -0,0 +1,31 @@
+choice
+	prompt "Machine Type"
+	depends on LOONGSON_SYSTEMS
+
+config LEMOTE_FULOONG2E
+	bool "Lemote Fuloong(2e) mini-PC"
+	select ARCH_SPARSEMEM_ENABLE
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON2E
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HAVE_STD_PC_SERIAL_PORT
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select CPU_HAS_WB
+	help
+	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
+	  an FPGA northbridge
+
+endchoice
diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
new file mode 100644
index 0000000..cc9f1c8
--- /dev/null
+++ b/arch/mips/loongson/Makefile
@@ -0,0 +1,11 @@
+#
+# Common code for all Loongson based systems
+#
+
+obj-$(CONFIG_LOONGSON_SYSTEMS) += common/
+
+#
+# Lemote Fuloong mini-PC (Loongson 2E-based)
+#
+
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fuloong-2e/
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
new file mode 100644
index 0000000..79b2736
--- /dev/null
+++ b/arch/mips/loongson/common/Makefile
@@ -0,0 +1,20 @@
+#
+# Makefile for loongson based machines.
+#
+
+obj-y += setup.o init.o cmdline.o time.o reset.o irq.o \
+	pci.o bonito-irq.o mem.o misc.o
+
+#
+# Early printk support
+#
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+
+#
+# Enable RTC Class support
+#
+# please enable CONFIG_RTC_DRV_CMOS
+#
+obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/common/bonito-irq.c b/arch/mips/loongson/common/bonito-irq.c
new file mode 100644
index 0000000..1f43447
--- /dev/null
+++ b/arch/mips/loongson/common/bonito-irq.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
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
+ *
+ */
+
+#include <linux/interrupt.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+static inline void bonito_irq_enable(unsigned int irq)
+{
+	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
+	mmiowb();
+}
+
+static inline void bonito_irq_disable(unsigned int irq)
+{
+	LOONGSON_INTENCLR = (1 << (irq - LOONGSON_IRQ_BASE));
+	mmiowb();
+}
+
+static struct irq_chip bonito_irq_type = {
+	.name	= "bonito_irq",
+	.ack	= bonito_irq_disable,
+	.mask	= bonito_irq_disable,
+	.mask_ack = bonito_irq_disable,
+	.unmask	= bonito_irq_enable,
+};
+
+static struct irqaction dma_timeout_irqaction = {
+	.handler	= no_action,
+	.name		= "dma_timeout",
+};
+
+void bonito_irq_init(void)
+{
+	u32 i;
+
+	for (i = LOONGSON_IRQ_BASE; i < LOONGSON_IRQ_BASE + 32; i++)
+		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
+
+	setup_irq(LOONGSON_DMATIMEOUT_IRQ, &dma_timeout_irqaction);
+}
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
new file mode 100644
index 0000000..6f603ac
--- /dev/null
+++ b/arch/mips/loongson/common/cmdline.c
@@ -0,0 +1,80 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+
+unsigned long bus_clock, cpu_clock_freq;
+unsigned long memsize, highmemsize;
+
+int prom_argc;
+/* pmon passes arguments in 32bit pointers */
+int *_prom_argv, *_prom_envp;
+
+#define parse_even_earlier(res, option, p)				\
+do {									\
+	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
+			strict_strtol((char *)p + strlen(option"="),	\
+					10, &res);			\
+} while (0)
+
+void __init prom_init_cmdline(void)
+{
+	int i;
+	long l;
+	prom_argc = fw_arg0;
+	_prom_argv = (int *)fw_arg1;
+	_prom_envp = (int *)fw_arg2;
+
+	/* arg[0] is "g", the rest is boot parameters */
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < prom_argc; i++) {
+		l = (long)_prom_argv[i];
+		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, ((char *)l));
+		strcat(arcs_cmdline, " ");
+	}
+
+	/* handle console, root, busclock, cpuclock, memsize, highmemsize
+	arguments */
+
+	if ((strstr(arcs_cmdline, "console=")) == NULL)
+		strcat(arcs_cmdline, " console=ttyS0,115200");
+	if ((strstr(arcs_cmdline, "root=")) == NULL)
+		strcat(arcs_cmdline, " root=/dev/hda1");
+
+	l = (long)*_prom_envp;
+	while (l != 0) {
+		parse_even_earlier(bus_clock, "busclock", l);
+		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
+		parse_even_earlier(memsize, "memsize", l);
+		parse_even_earlier(highmemsize, "highmemsize", l);
+		_prom_envp++;
+		l = (long)*_prom_envp;
+	}
+	if (memsize == 0)
+		memsize = 256;
+
+	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
+		bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
diff --git a/arch/mips/loongson/common/early_printk.c b/arch/mips/loongson/common/early_printk.c
new file mode 100644
index 0000000..9f4b881
--- /dev/null
+++ b/arch/mips/loongson/common/early_printk.c
@@ -0,0 +1,28 @@
+/*  early printk support
+ *
+ *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+void prom_putchar(char c)
+{
+	int timeout;
+	phys_addr_t uart_base =
+	    (phys_addr_t) ioremap_nocache(LOONGSON_UART_BASE, 8);
+	char reg = readb((u8 *) (uart_base + UART_LSR)) & UART_LSR_THRE;
+
+	for (timeout = 1024; reg == 0 && timeout > 0; timeout--)
+		reg = readb((u8 *) (uart_base + UART_LSR)) & UART_LSR_THRE;
+
+	writeb(c, (u8 *) (uart_base + UART_TX));
+}
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
new file mode 100644
index 0000000..76e6fda
--- /dev/null
+++ b/arch/mips/loongson/common/init.c
@@ -0,0 +1,40 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+
+#include <loongson.h>
+
+void __init prom_init(void)
+{
+	/* init mach type, does we need to init it?? */
+	mips_machtype = PRID_IMP_LOONGSON2;
+
+	/* init several base address */
+	set_io_port_base((unsigned long)
+			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
+
+	prom_init_cmdline();
+	prom_init_memory();
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
new file mode 100644
index 0000000..79ae697
--- /dev/null
+++ b/arch/mips/loongson/common/irq.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+/*
+ * the first level int-handler will jump here if it is a loongson irq
+ */
+void bonito_irqdispatch(void)
+{
+	u32 int_status;
+	int i;
+
+	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
+	int_status = LOONGSON_INTISR;
+	while (int_status & (1 << 10)) {
+		udelay(1);
+		int_status = LOONGSON_INTISR;
+	}
+
+	/* Get pending sources, masked by current enables */
+	int_status = LOONGSON_INTISR & LOONGSON_INTEN;
+
+	if (int_status != 0) {
+		i = __ffs(int_status);
+		int_status &= ~(1 << i);
+		do_IRQ(LOONGSON_IRQ_BASE + i);
+	}
+}
+
+void i8259_irqdispatch(void)
+{
+	int irq;
+
+	irq = mach_i8259_irq();
+	if (irq < 0)
+		spurious_interrupt();
+	else
+		do_IRQ(irq);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+	mach_irq_dispatch(pending);
+}
+
+
+static struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.mask = CPU_MASK_NONE,
+	.name = "cascade",
+};
+
+void __init arch_init_irq(void)
+{
+	/*
+	 * Clear all of the interrupts while we change the able around a bit.
+	 * int-handler is not on bootstrap
+	 */
+	clear_c0_status(ST0_IM | ST0_BEV);
+	local_irq_disable();
+
+	/* setting irq trigger mode */
+	set_irq_trigger_mode();
+
+	/* no steer */
+	LOONGSON_INTSTEER = 0;
+
+	/*
+	 * Mask out all interrupt by writing "1" to all bit position in
+	 * the interrupt reset reg.
+	 */
+	LOONGSON_INTENCLR = ~0;
+
+	/* init all controller
+	 *   0-15         ------> i8259 interrupt
+	 *   16-23        ------> mips cpu interrupt
+	 *   32-63        ------> bonito irq
+	 */
+
+	/* Sets the first-level interrupt dispatcher. */
+	mips_cpu_irq_init();
+	init_i8259_irqs();
+	bonito_irq_init();
+
+	/* setup north bridge irq (bonito) */
+	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &cascade_irqaction);
+	/* setup source bridge irq (i8259) */
+	setup_irq(LOONGSON_SOUTH_BRIDGE_IRQ, &cascade_irqaction);
+}
diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
new file mode 100644
index 0000000..17a7278
--- /dev/null
+++ b/arch/mips/loongson/common/mem.c
@@ -0,0 +1,40 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+#include <mem.h>
+
+void __init prom_init_memory(void)
+{
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+#ifdef CONFIG_64BIT
+	if (highmemsize > 0) {
+		add_memory_region(LOONGSON_HIGHMEM_START,
+				  highmemsize << 20, BOOT_MEM_RAM);
+	}
+#endif				/* CONFIG_64BIT */
+}
+
+/* override of arch/mips/mm/cache.c: __uncached_access */
+int __uncached_access(struct file *file, unsigned long addr)
+{
+	if (file->f_flags & O_SYNC)
+		return 1;
+
+	/*
+	 * On the Lemote Loongson 2e system, the peripheral registers
+	 * reside between 0x1000:0000 and 0x2000:0000.
+	 */
+	return addr >= __pa(high_memory) ||
+		((addr >= LOONGSON_MMIO_MEM_START) && \
+			(addr < LOONGSON_MMIO_MEM_END));
+}
diff --git a/arch/mips/loongson/common/misc.c b/arch/mips/loongson/common/misc.c
new file mode 100644
index 0000000..1b8044c
--- /dev/null
+++ b/arch/mips/loongson/common/misc.c
@@ -0,0 +1,15 @@
+/* Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <machine.h>
+
+const char *get_system_type(void)
+{
+	return MACH_NAME;
+}
diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson/common/pci.c
new file mode 100644
index 0000000..e97c845
--- /dev/null
+++ b/arch/mips/loongson/common/pci.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
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
+ *
+ */
+
+#include <linux/pci.h>
+
+#include <loongson.h>
+#include <pci.h>
+
+static struct resource loongson_pci_mem_resource = {
+	.name   = "LOONGSON PCI MEM",
+	.start  = LOONGSON_PCI_MEM_START,
+	.end    = LOONGSON_PCI_MEM_END,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct resource loongson_pci_io_resource = {
+	.name   = "LOONGSON PCI IO MEM",
+	.start  = LOONGSON_PCI_IO_START,
+	.end    = IO_SPACE_LIMIT,
+	.flags  = IORESOURCE_IO,
+};
+
+static struct pci_controller  loongson_pci_controller = {
+	.pci_ops        = &loongson_pci_ops,
+	.io_resource    = &loongson_pci_io_resource,
+	.mem_resource   = &loongson_pci_mem_resource,
+	.mem_offset     = 0x00000000UL,
+	.io_offset      = 0x00000000UL,
+};
+
+static void __init ict_pcimap(void)
+{
+	/*
+	 * local to PCI mapping for CPU accessing PCI space
+	 *
+	 * CPU address space [256M,448M] is window for accessing pci space
+	 * we set pcimap_lo[0,1,2] to map it to pci space[0M,64M], [320M,448M]
+	 *
+	 * pcimap: PCI_MAP2  PCI_Mem_Lo2 PCI_Mem_Lo1 PCI_Mem_Lo0
+	 *           [<2G]   [384M,448M] [320M,384M] [0M,64M]
+	 */
+	LOONGSON_PCIMAP = LOONGSON_PCIMAP_PCIMAP_2 |
+	    LOONGSON_PCIMAP_WIN(2, 0x18000000) |
+	    LOONGSON_PCIMAP_WIN(1, 0x14000000) |
+	    LOONGSON_PCIMAP_WIN(0, 0);
+
+	/*
+	 * PCI-DMA to local mapping: [2G,2G+256M] -> [0M,256M]
+	 */
+	LOONGSON_PCIBASE0 = 0x80000000ul;	/* base: 2G -> mmap: 0M */
+	/* size: 256M, burst transmission, pre-fetch enable, 64bit */
+	LOONGSON_PCI_HIT0_SEL_L = 0xc000000cul;
+	LOONGSON_PCI_HIT0_SEL_H = 0xfffffffful;
+	LOONGSON_PCI_HIT1_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
+	LOONGSON_PCI_HIT1_SEL_H = 0x00000000ul;
+	LOONGSON_PCI_HIT2_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
+	LOONGSON_PCI_HIT2_SEL_H = 0x00000000ul;
+
+	/* avoid deadlock of PCI reading/writing lock operation */
+	LOONGSON_PCI_ISR4C = 0xd2000001ul;
+
+	/* can not change gnt to break pci transfer when device's gnt not
+	deassert for some broken device */
+	LOONGSON_PXARB_CFG = 0x00fe0105ul;
+}
+
+static int __init pcibios_init(void)
+{
+	ict_pcimap();
+
+	loongson_pci_controller.io_map_base = mips_io_port_base;
+
+	register_pci_controller(&loongson_pci_controller);
+
+	return 0;
+}
+
+arch_initcall(pcibios_init);
diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
new file mode 100644
index 0000000..c3431fb
--- /dev/null
+++ b/arch/mips/loongson/common/reset.c
@@ -0,0 +1,38 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ */
+
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+
+#include <loongson.h>
+
+static void loongson_restart(char *command)
+{
+	/* perform board-specific pre-reboot operations */
+	mach_prepare_reboot();
+
+	/* reboot via jumping to 0xbfc00000 */
+	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
+}
+
+static void loongson_halt(void)
+{
+	mach_prepare_shutdown();
+	while (1)
+		;
+}
+
+void __init loongson_reboot_setup(void)
+{
+	_machine_restart = loongson_restart;
+	_machine_halt = loongson_halt;
+	pm_power_off = loongson_halt;
+}
diff --git a/arch/mips/loongson/common/rtc.c b/arch/mips/loongson/common/rtc.c
new file mode 100644
index 0000000..1eb39b4
--- /dev/null
+++ b/arch/mips/loongson/common/rtc.c
@@ -0,0 +1,54 @@
+/*
+ *  Registration of Cobalt RTC platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ *  MA  02110-1301  USA
+ */
+
+#include <linux/ioport.h>
+#include <linux/mc146818rtc.h>
+#include <linux/platform_device.h>
+
+static struct resource rtc_cmos_resource[] = {
+	{
+		.start	= RTC_PORT(0),
+		.end	= RTC_PORT(1),
+		.flags	= IORESOURCE_IO,
+	},
+	{
+		.start	= RTC_IRQ,
+		.end	= RTC_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device rtc_cmos_device = {
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(rtc_cmos_resource),
+	.resource	= rtc_cmos_resource
+};
+
+static __init int rtc_cmos_init(void)
+{
+	platform_device_register(&rtc_cmos_device);
+
+	return 0;
+}
+
+device_initcall(rtc_cmos_init);
diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson/common/setup.c
new file mode 100644
index 0000000..4fcbe48
--- /dev/null
+++ b/arch/mips/loongson/common/setup.c
@@ -0,0 +1,74 @@
+/*
+ * board dependent setup routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+
+#include <asm/wbflush.h>
+
+#include <loongson.h>
+
+void (*__wbflush) (void);
+EXPORT_SYMBOL(__wbflush);
+
+static void loongson_wbflush(void)
+{
+	asm(".set\tpush\n\t"
+	    ".set\tnoreorder\n\t"
+	    ".set mips3\n\t"
+	    "sync\n\t"
+	    "nop\n\t"
+	    ".set\tpop\n\t"
+	    ".set mips0\n\t");
+}
+
+void __init loongson_wbflush_setup(void)
+{
+	__wbflush = loongson_wbflush;
+}
+
+#if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
+#include <linux/screen_info.h>
+
+void __init loongson_screeninfo_setup(void)
+{
+	screen_info = (struct screen_info) {
+		    0,		/* orig-x */
+		    25,		/* orig-y */
+		    0,		/* unused */
+		    0,		/* orig-video-page */
+		    0,		/* orig-video-mode */
+		    80,		/* orig-video-cols */
+		    0,		/* ega_ax */
+		    0,		/* ega_bx */
+		    0,		/* ega_cx */
+		    25,		/* orig-video-lines */
+		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
+		    16		/* orig-video-points */
+	};
+}
+#else
+void __init loongson_screeninfo_setup(void)
+{
+}
+#endif
+
+void __init plat_mem_setup(void)
+{
+	loongson_reboot_setup();
+
+	loongson_wbflush_setup();
+
+	loongson_screeninfo_setup();
+}
diff --git a/arch/mips/loongson/common/time.c b/arch/mips/loongson/common/time.c
new file mode 100644
index 0000000..231f0c2
--- /dev/null
+++ b/arch/mips/loongson/common/time.c
@@ -0,0 +1,27 @@
+/*
+ * board dependent boot routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <asm/mc146818-time.h>
+#include <asm/time.h>
+
+#include <loongson.h>
+
+unsigned long read_persistent_clock(void)
+{
+	return mc146818_get_cmos_time();
+}
+
+void __init plat_time_init(void)
+{
+	/* setup mips r4k timer */
+	mips_hpt_frequency = cpu_clock_freq / 2;
+}
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
index 76904da..1ee57a1 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -1,20 +1,7 @@
 #
-# Makefile for Lemote Fulong mini-PC board.
+# Makefile for fuloong-2e
 #
 
-obj-y += setup.o init.o cmdline.o time.o reset.o irq.o \
-	pci.o bonito-irq.o mem.o misc.o
-
-#
-# Early printk support
-#
-obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
-
-#
-# Enable RTC Class support
-#
-# please enable CONFIG_RTC_DRV_CMOS
-#
-obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
+obj-y += irq.o reset.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c b/arch/mips/loongson/fuloong-2e/bonito-irq.c
deleted file mode 100644
index 1f43447..0000000
--- a/arch/mips/loongson/fuloong-2e/bonito-irq.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
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
- *
- */
-
-#include <linux/interrupt.h>
-
-#include <loongson.h>
-#include <machine.h>
-
-static inline void bonito_irq_enable(unsigned int irq)
-{
-	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
-	mmiowb();
-}
-
-static inline void bonito_irq_disable(unsigned int irq)
-{
-	LOONGSON_INTENCLR = (1 << (irq - LOONGSON_IRQ_BASE));
-	mmiowb();
-}
-
-static struct irq_chip bonito_irq_type = {
-	.name	= "bonito_irq",
-	.ack	= bonito_irq_disable,
-	.mask	= bonito_irq_disable,
-	.mask_ack = bonito_irq_disable,
-	.unmask	= bonito_irq_enable,
-};
-
-static struct irqaction dma_timeout_irqaction = {
-	.handler	= no_action,
-	.name		= "dma_timeout",
-};
-
-void bonito_irq_init(void)
-{
-	u32 i;
-
-	for (i = LOONGSON_IRQ_BASE; i < LOONGSON_IRQ_BASE + 32; i++)
-		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
-
-	setup_irq(LOONGSON_DMATIMEOUT_IRQ, &dma_timeout_irqaction);
-}
diff --git a/arch/mips/loongson/fuloong-2e/cmdline.c b/arch/mips/loongson/fuloong-2e/cmdline.c
deleted file mode 100644
index 01e30db..0000000
--- a/arch/mips/loongson/fuloong-2e/cmdline.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Based on Ocelot Linux port, which is
- * Copyright 2001 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * Copyright 2003 ICT CAS
- * Author: Michael Guo <guoyi@ict.ac.cn>
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/bootmem.h>
-
-#include <asm/bootinfo.h>
-
-unsigned long bus_clock, cpu_clock_freq;
-unsigned long memsize, highmemsize;
-
-int prom_argc;
-/* pmon passes arguments in 32bit pointers */
-int *_prom_argv, *_prom_envp;
-
-#define parse_even_earlier(res, option, p)				\
-do {									\
-	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-			strict_strtol((char *)p + strlen(option"="),	\
-				    10, &res);				\
-} while (0)
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-	long l;
-	prom_argc = fw_arg0;
-	_prom_argv = (int *)fw_arg1;
-	_prom_envp = (int *)fw_arg2;
-
-	/* arg[0] is "g", the rest is boot parameters */
-	arcs_cmdline[0] = '\0';
-	for (i = 1; i < prom_argc; i++) {
-		l = (long)_prom_argv[i];
-		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
-		    >= sizeof(arcs_cmdline))
-			break;
-		strcat(arcs_cmdline, ((char *)l));
-		strcat(arcs_cmdline, " ");
-	}
-
-	if ((strstr(arcs_cmdline, "console=")) == NULL)
-		strcat(arcs_cmdline, " console=ttyS0,115200");
-	if ((strstr(arcs_cmdline, "root=")) == NULL)
-		strcat(arcs_cmdline, " root=/dev/hda1");
-
-	l = (long)*_prom_envp;
-	while (l != 0) {
-		parse_even_earlier(bus_clock, "busclock", l);
-		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
-		parse_even_earlier(memsize, "memsize", l);
-		parse_even_earlier(highmemsize, "highmemsize", l);
-		_prom_envp++;
-		l = (long)*_prom_envp;
-	}
-	if (memsize == 0)
-		memsize = 256;
-
-	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
-	       bus_clock, cpu_clock_freq, memsize, highmemsize);
-}
diff --git a/arch/mips/loongson/fuloong-2e/early_printk.c b/arch/mips/loongson/fuloong-2e/early_printk.c
deleted file mode 100644
index 9f4b881..0000000
--- a/arch/mips/loongson/fuloong-2e/early_printk.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/*  early printk support
- *
- *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include <loongson.h>
-#include <machine.h>
-
-void prom_putchar(char c)
-{
-	int timeout;
-	phys_addr_t uart_base =
-	    (phys_addr_t) ioremap_nocache(LOONGSON_UART_BASE, 8);
-	char reg = readb((u8 *) (uart_base + UART_LSR)) & UART_LSR_THRE;
-
-	for (timeout = 1024; reg == 0 && timeout > 0; timeout--)
-		reg = readb((u8 *) (uart_base + UART_LSR)) & UART_LSR_THRE;
-
-	writeb(c, (u8 *) (uart_base + UART_TX));
-}
diff --git a/arch/mips/loongson/fuloong-2e/init.c b/arch/mips/loongson/fuloong-2e/init.c
deleted file mode 100644
index 76e6fda..0000000
--- a/arch/mips/loongson/fuloong-2e/init.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Based on Ocelot Linux port, which is
- * Copyright 2001 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * Copyright 2003 ICT CAS
- * Author: Michael Guo <guoyi@ict.ac.cn>
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/bootmem.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-
-#include <loongson.h>
-
-void __init prom_init(void)
-{
-	/* init mach type, does we need to init it?? */
-	mips_machtype = PRID_IMP_LOONGSON2;
-
-	/* init several base address */
-	set_io_port_base((unsigned long)
-			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
-
-	prom_init_cmdline();
-	prom_init_memory();
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index e04ff30..00e95ad 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -24,57 +24,20 @@
  *
  */
 
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 
-#include <asm/irq_cpu.h>
 #include <asm/i8259.h>
 
 #include <loongson.h>
 #include <machine.h>
 
-/*
- * the first level int-handler will jump here if it is a bonito irq
- */
-static void bonito_irqdispatch(void)
-{
-	u32 int_status;
-	int i;
-
-	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
-	int_status = LOONGSON_INTISR;
-	if (int_status & (1 << 10)) {
-		while (int_status & (1 << 10)) {
-			udelay(1);
-			int_status = LOONGSON_INTISR;
-		}
-	}
-
-	/* Get pending sources, masked by current enables */
-	int_status = LOONGSON_INTISR & LOONGSON_INTEN;
-
-	if (int_status != 0) {
-		i = __ffs(int_status);
-		int_status &= ~(1 << i);
-		do_IRQ(LOONGSON_IRQ_BASE + i);
-	}
-}
-
-static void i8259_irqdispatch(void)
+inline int mach_i8259_irq(void)
 {
-	int irq;
-
-	irq = i8259_irq();
-	if (irq >= 0)
-		do_IRQ(irq);
-	else
-		spurious_interrupt();
+	return i8259_irq();
 }
 
-asmlinkage void plat_irq_dispatch(void)
+inline void mach_irq_dispatch(unsigned int pending)
 {
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
 	else if (pending & CAUSEF_IP5)
@@ -85,53 +48,9 @@ asmlinkage void plat_irq_dispatch(void)
 		spurious_interrupt();
 }
 
-static struct irqaction cascade_irqaction = {
-	.handler = no_action,
-	.mask = CPU_MASK_NONE,
-	.name = "cascade",
-};
-
-void __init arch_init_irq(void)
+void __init set_irq_trigger_mode(void)
 {
-	/*
-	 * Clear all of the interrupts while we change the able around a bit.
-	 * int-handler is not on bootstrap
-	 */
-	clear_c0_status(ST0_IM | ST0_BEV);
-	local_irq_disable();
-
 	/* most bonito irq should be level triggered */
 	LOONGSON_INTEDGE = LOONGSON_ICU_SYSTEMERR | LOONGSON_ICU_MASTERERR |
 		LOONGSON_ICU_RETRYERR | LOONGSON_ICU_MBOXES;
-	LOONGSON_INTSTEER = 0;
-
-	/*
-	 * Mask out all interrupt by writing "1" to all bit position in
-	 * the interrupt reset reg.
-	 */
-	LOONGSON_INTENCLR = ~0;
-
-	/* init all controller
-	 *   0-15         ------> i8259 interrupt
-	 *   16-23        ------> mips cpu interrupt
-	 *   32-63        ------> bonito irq
-	 */
-
-	/* Sets the first-level interrupt dispatcher. */
-	mips_cpu_irq_init();
-	init_i8259_irqs();
-	bonito_irq_init();
-
-	/*
-	printk("GPIODATA=%x, GPIOIE=%x\n", LOONGSON_GPIODATA, LOONGSON_GPIOIE);
-	printk("INTEN=%x, INTSET=%x, INTCLR=%x, INTISR=%x\n",
-			LOONGSON_INTEN, LOONGSON_INTENSET,
-			LOONGSON_INTENCLR, LOONGSON_INTISR);
-	*/
-
-	/* bonito irq at IP2 */
-	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &cascade_irqaction);
-	/* 8259 irq at IP5 */
-	setup_irq(LOONGSON_SOUTH_BRIDGE_IRQ, &cascade_irqaction);
-
 }
diff --git a/arch/mips/loongson/fuloong-2e/mem.c b/arch/mips/loongson/fuloong-2e/mem.c
deleted file mode 100644
index 7f6ee37..0000000
--- a/arch/mips/loongson/fuloong-2e/mem.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/fs.h>
-#include <linux/mm.h>
-
-#include <asm/bootinfo.h>
-
-#include <loongson.h>
-#include <mem.h>
-
-void __init prom_init_memory(void)
-{
-	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
-#ifdef CONFIG_64BIT
-	if (highmemsize > 0) {
-		add_memory_region(LOONGSON_HIGHMEM_START,
-				  highmemsize << 20, BOOT_MEM_RAM);
-	}
-#endif				/* CONFIG_64BIT */
-}
-
-/* override of arch/mips/mm/cache.c: __uncached_access */
-int __uncached_access(struct file *file, unsigned long addr)
-{
-	if (file->f_flags & O_SYNC)
-		return 1;
-
-	/*
-	 * On the Lemote Loongson 2e system, the peripheral registers
-	 * reside between 0x1000:0000 and 0x2000:0000.
-	 */
-	return addr >= __pa(high_memory) || \
-		((addr >= LOONGSON_MMIO_MEM_START) && \
-			(addr < LOONGSON_MMIO_MEM_END));
-}
diff --git a/arch/mips/loongson/fuloong-2e/misc.c b/arch/mips/loongson/fuloong-2e/misc.c
deleted file mode 100644
index 1b8044c..0000000
--- a/arch/mips/loongson/fuloong-2e/misc.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/* Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <machine.h>
-
-const char *get_system_type(void)
-{
-	return MACH_NAME;
-}
diff --git a/arch/mips/loongson/fuloong-2e/pci.c b/arch/mips/loongson/fuloong-2e/pci.c
deleted file mode 100644
index 89bc1af..0000000
--- a/arch/mips/loongson/fuloong-2e/pci.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * pci.c
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
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
- *
- */
-#include <linux/pci.h>
-
-#include <loongson.h>
-#include <pci.h>
-
-static struct resource loongson_pci_mem_resource = {
-	.name   = "LOONGSON PCI MEM",
-	.start  = LOONGSON_PCI_MEM_START,
-	.end    = LOONGSON_PCI_MEM_END,
-	.flags  = IORESOURCE_MEM,
-};
-
-static struct resource loongson_pci_io_resource = {
-	.name   = "LOONGSON PCI IO MEM",
-	.start  = LOONGSON_PCI_IO_START,
-	.end    = IO_SPACE_LIMIT,
-	.flags  = IORESOURCE_IO,
-};
-
-static struct pci_controller  loongson_pci_controller = {
-	.pci_ops        = &loongson_pci_ops,
-	.io_resource    = &loongson_pci_io_resource,
-	.mem_resource   = &loongson_pci_mem_resource,
-	.mem_offset     = 0x00000000UL,
-	.io_offset      = 0x00000000UL,
-};
-
-static void __init ict_pcimap(void)
-{
-	/*
-	 * local to PCI mapping for CPU accessing PCI space
-	 *
-	 * CPU address space [256M,448M] is window for accessing pci space
-	 * we set pcimap_lo[0,1,2] to map it to pci space[0M, 64M], [320M,448M]
-	 *
-	 * pcimap:  PCI_MAP2  PCI_Mem_Lo2 PCI_Mem_Lo1 PCI_Mem_Lo0
-	 *            [<2G]   [384M,448M] [320M,384M] [0M,64M]
-	 */
-	LOONGSON_PCIMAP = LOONGSON_PCIMAP_PCIMAP_2 |
-	    LOONGSON_PCIMAP_WIN(2, 0x18000000) |
-	    LOONGSON_PCIMAP_WIN(1, 0x14000000) |
-	    LOONGSON_PCIMAP_WIN(0, 0);
-
-	/*
-	 * PCI-DMA to local mapping: [2G,2G+256M] -> [0M,256M]
-	 */
-	LOONGSON_PCIBASE0 = 0x80000000ul;	/* base: 2G -> mmap: 0M */
-	/* size: 256M, burst transmission, pre-fetch enable, 64bit */
-	LOONGSON_PCI_HIT0_SEL_L = 0xc000000cul;
-	LOONGSON_PCI_HIT0_SEL_H = 0xfffffffful;
-	LOONGSON_PCI_HIT1_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
-	LOONGSON_PCI_HIT1_SEL_H = 0x00000000ul;
-	LOONGSON_PCI_HIT2_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
-	LOONGSON_PCI_HIT2_SEL_H = 0x00000000ul;
-
-	/* avoid deadlock of PCI reading/writing lock operation */
-	LOONGSON_PCI_ISR4C = 0xd2000001ul;
-
-	/* can not change gnt to break pci transfer when device's gnt not
-	deassert for some broken device */
-	LOONGSON_PXARB_CFG = 0x00fe0105ul;
-}
-
-static int __init pcibios_init(void)
-{
-	ict_pcimap();
-
-	loongson_pci_controller.io_map_base = mips_io_port_base;
-
-	register_pci_controller(&loongson_pci_controller);
-
-	return 0;
-}
-
-arch_initcall(pcibios_init);
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson/fuloong-2e/reset.c
index 87244a1..4ad0923 100644
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -1,40 +1,26 @@
-/*
+/* Board-specific reboot/shutdown routines
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
- *
- * Copyright (c) 2009 Lemote, Inc. & Institute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
  */
-#include <linux/pm.h>
 
-#include <asm/reboot.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+
 #include <loongson.h>
 
-static void loongson_restart(char *command)
+void mach_prepare_reboot(void)
 {
 	LOONGSON_GENCFG &= ~LOONGSON_GENCFG_CPUSELFRESET;
 	LOONGSON_GENCFG |= LOONGSON_GENCFG_CPUSELFRESET;
-
-	/* reboot via jumping to 0xbfc00000 */
-	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
-}
-
-static void loongson_halt(void)
-{
-	while (1)
-		;
 }
 
-void loongson_reboot_setup(void)
+void mach_prepare_shutdown(void)
 {
-	_machine_restart = loongson_restart;
-	_machine_halt = loongson_halt;
-	pm_power_off = loongson_halt;
 }
diff --git a/arch/mips/loongson/fuloong-2e/rtc.c b/arch/mips/loongson/fuloong-2e/rtc.c
deleted file mode 100644
index 469ada8..0000000
--- a/arch/mips/loongson/fuloong-2e/rtc.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- *  Registration of Cobalt RTC platform device.
- *
- *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
- *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- *  MA 02110-1301 USA
- */
-
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/mc146818rtc.h>
-#include <linux/platform_device.h>
-
-static struct resource rtc_cmos_resource[] = {
-	{
-		.start	= RTC_PORT(0),
-		.end	= RTC_PORT(1),
-		.flags	= IORESOURCE_IO,
-	},
-	{
-		.start	= RTC_IRQ,
-		.end	= RTC_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device rtc_cmos_device = {
-	.name		= "rtc_cmos",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(rtc_cmos_resource),
-	.resource	= rtc_cmos_resource
-};
-
-static __init int rtc_cmos_init(void)
-{
-	platform_device_register(&rtc_cmos_device);
-
-	return 0;
-}
-
-device_initcall(rtc_cmos_init);
diff --git a/arch/mips/loongson/fuloong-2e/setup.c b/arch/mips/loongson/fuloong-2e/setup.c
deleted file mode 100644
index 4fcbe48..0000000
--- a/arch/mips/loongson/fuloong-2e/setup.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * board dependent setup routines
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/module.h>
-
-#include <asm/wbflush.h>
-
-#include <loongson.h>
-
-void (*__wbflush) (void);
-EXPORT_SYMBOL(__wbflush);
-
-static void loongson_wbflush(void)
-{
-	asm(".set\tpush\n\t"
-	    ".set\tnoreorder\n\t"
-	    ".set mips3\n\t"
-	    "sync\n\t"
-	    "nop\n\t"
-	    ".set\tpop\n\t"
-	    ".set mips0\n\t");
-}
-
-void __init loongson_wbflush_setup(void)
-{
-	__wbflush = loongson_wbflush;
-}
-
-#if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
-#include <linux/screen_info.h>
-
-void __init loongson_screeninfo_setup(void)
-{
-	screen_info = (struct screen_info) {
-		    0,		/* orig-x */
-		    25,		/* orig-y */
-		    0,		/* unused */
-		    0,		/* orig-video-page */
-		    0,		/* orig-video-mode */
-		    80,		/* orig-video-cols */
-		    0,		/* ega_ax */
-		    0,		/* ega_bx */
-		    0,		/* ega_cx */
-		    25,		/* orig-video-lines */
-		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
-		    16		/* orig-video-points */
-	};
-}
-#else
-void __init loongson_screeninfo_setup(void)
-{
-}
-#endif
-
-void __init plat_mem_setup(void)
-{
-	loongson_reboot_setup();
-
-	loongson_wbflush_setup();
-
-	loongson_screeninfo_setup();
-}
diff --git a/arch/mips/loongson/fuloong-2e/time.c b/arch/mips/loongson/fuloong-2e/time.c
deleted file mode 100644
index 231f0c2..0000000
--- a/arch/mips/loongson/fuloong-2e/time.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * board dependent boot routines
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <asm/mc146818-time.h>
-#include <asm/time.h>
-
-#include <loongson.h>
-
-unsigned long read_persistent_clock(void)
-{
-	return mc146818_get_cmos_time();
-}
-
-void __init plat_time_init(void)
-{
-	/* setup mips r4k timer */
-	mips_hpt_frequency = cpu_clock_freq / 2;
-}
-- 
1.6.2.1
