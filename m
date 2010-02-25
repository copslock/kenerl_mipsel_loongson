Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 15:52:32 +0100 (CET)
Received: from mail-yw0-f201.google.com ([209.85.211.201]:44521 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492276Ab0BYGb4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 07:31:56 +0100
Received: by ywh39 with SMTP id 39so3394121ywh.21
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2010 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=CvwFOXPGJ3pRzKZvS3bCjYaWJlbhE5bOegcOG8g6h/4=;
        b=ipgqgpV4spdFN58hjAq6f7J1MGim1/BHepqjOb9SIyqWdj4fL9KUwoMFA15jtrm1TU
         UudHbhqgwgyk+ea+bstdpQpTpYfaDEVVD22jaYkmapLwMwbYdRBrsvyDFDnUJGy6WnIx
         eEmWJpNS12ihTcTcUdS8BKWnI4pr5Tn4v2USk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=K7p0ixAfYr+3Sptjy2q7cSaVB11Y5p10pO8w0LjqqA7tM8ZnQhVhlYz3GUyUSVc8XK
         HvERsdExkYE2k4PKsKpk2u49du692iKR3YpPA/G1ZLZo9CKWkg4MYpWPHhG73F6AWi4y
         5UXCgSPsKMJfyAQqgN3oCj2QnEBLztVD+deKY=
Received: by 10.150.194.16 with SMTP id r16mr974007ybf.194.1267079509690;
        Wed, 24 Feb 2010 22:31:49 -0800 (PST)
Received: from ?10.0.0.13? (eth7090.sa.adsl.internode.on.net [150.101.58.177])
        by mx.google.com with ESMTPS id 34sm1094500yxf.11.2010.02.24.22.31.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 22:31:48 -0800 (PST)
Message-ID: <4B8618E4.80804@gmail.com>
Date:   Thu, 25 Feb 2010 16:59:56 +1030
From:   Graham Gower <graham.gower@gmail.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090820)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 1/3] Add XBurst JZ4730 support.
References: <4B861890.6090002@gmail.com>
In-Reply-To: <4B861890.6090002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26049
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips

Provides support for Ingenic's XBurst cpu. With initial support for
their JZ4730 SoC based PMP reference platform and Libra dev board.

Signed-off-by: Graham Gower <graham.gower@gmail.com>
---
 arch/mips/Kconfig                                |   13 +
 arch/mips/Makefile                               |   14 +-
 arch/mips/boot/Makefile                          |   15 +-
 arch/mips/include/asm/bootinfo.h                 |    7 +
 arch/mips/include/asm/cpu.h                      |    9 +
 arch/mips/include/asm/mach-generic/irq.h         |    2 +-
 arch/mips/include/asm/mach-xburst/clock-jz4730.h |   41 +++
 arch/mips/include/asm/mach-xburst/dma-jz4730.h   |  156 ++++++++++++
 arch/mips/include/asm/mach-xburst/irq-jz4730.h   |   33 +++
 arch/mips/include/asm/mach-xburst/uart-jz4730.h  |  141 +++++++++++
 arch/mips/include/asm/mach-xburst/war.h          |   25 ++
 arch/mips/include/asm/mach-xburst/xburst.h       |   20 ++
 arch/mips/include/asm/r5kcache.h                 |  240 ++++++++++++++++++
 arch/mips/kernel/cpu-probe.c                     |   21 ++
 arch/mips/mm/c-r4k.c                             |   30 +++
 arch/mips/mm/tlbex.c                             |    5 +
 arch/mips/xburst/Kconfig                         |   23 ++
 arch/mips/xburst/Makefile                        |    3 +
 arch/mips/xburst/jz4730/Makefile                 |   11 +
 arch/mips/xburst/jz4730/board-libra.c            |   32 +++
 arch/mips/xburst/jz4730/board-pmp.c              |   32 +++
 arch/mips/xburst/jz4730/clocks.c                 |  294 ++++++++++++++++++++++
 arch/mips/xburst/jz4730/irq.c                    |  104 ++++++++
 arch/mips/xburst/jz4730/platform.c               |   49 ++++
 arch/mips/xburst/jz4730/prom.c                   |  104 ++++++++
 arch/mips/xburst/jz4730/setup.c                  |  136 ++++++++++
 arch/mips/xburst/jz4730/time.c                   |  140 ++++++++++
 27 files changed, 1697 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-xburst/clock-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/dma-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/irq-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/uart-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/war.h
 create mode 100644 arch/mips/include/asm/mach-xburst/xburst.h
 create mode 100644 arch/mips/xburst/Kconfig
 create mode 100644 arch/mips/xburst/Makefile
 create mode 100644 arch/mips/xburst/jz4730/Makefile
 create mode 100644 arch/mips/xburst/jz4730/board-libra.c
 create mode 100644 arch/mips/xburst/jz4730/board-pmp.c
 create mode 100644 arch/mips/xburst/jz4730/clocks.c
 create mode 100644 arch/mips/xburst/jz4730/irq.c
 create mode 100644 arch/mips/xburst/jz4730/platform.c
 create mode 100644 arch/mips/xburst/jz4730/prom.c
 create mode 100644 arch/mips/xburst/jz4730/setup.c
 create mode 100644 arch/mips/xburst/jz4730/time.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8b5d174..ec5bd51 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -679,6 +679,18 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 		Hikari
 	  Say Y here for most Octeon reference boards.
 
+config XBURST
+	bool "Ingenic XBurst based machines"
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select SYS_HAS_EARLY_PRINTK
+	select BOOT_RAW
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
@@ -693,6 +705,7 @@ source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson/Kconfig"
+source "arch/mips/xburst/Kconfig"
 
 endmenu
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1893efd..f153e23 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -637,6 +637,13 @@ else
 load-$(CONFIG_CPU_CAVIUM_OCTEON) 	+= 0xffffffff81100000
 endif
 
+#
+# Ingenic XBurst
+#
+core-$(CONFIG_XBURST)	+= arch/mips/xburst/
+cflags-$(CONFIG_XBURST)	+= -I$(srctree)/arch/mips/include/asm/mach-xburst
+load-$(CONFIG_XBURST)	+= 0xffffffff80010000
+
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
@@ -711,7 +718,8 @@ vmlinux.32: vmlinux
 vmlinux.64: vmlinux
 	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 
-makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
+makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
+	  VMLINUX_LOAD_ADDRESS=$(load-y) $(1)
 makezboot =$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
 	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $(1)
 
@@ -738,6 +746,9 @@ vmlinux.ecoff: $(vmlinux-32)
 vmlinux.srec: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
+uImage: $(vmlinux-32)
+	+@$(call makeboot,$@)
+
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec
 
@@ -771,6 +782,7 @@ define archhelp
 	echo '  vmlinuz.ecoff        - ECOFF zboot image'
 	echo '  vmlinuz.bin          - Raw binary zboot image'
 	echo '  vmlinuz.srec         - SREC zboot image'
+	echo '  uImage               - U-Boot image'
 	echo
 	echo '  These will be default as apropriate for a configured platform.'
 endef
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index e39a08e..5215534 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -24,6 +24,7 @@ drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
 strip-flags	= $(addprefix --remove-section=,$(drop-sections))
 
 VMLINUX = vmlinux
+MKIMAGE := $(srctree)/scripts/mkuboot.sh
 
 all: vmlinux.ecoff vmlinux.srec
 
@@ -39,7 +40,19 @@ vmlinux.bin: $(VMLINUX)
 vmlinux.srec: $(VMLINUX)
 	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
 
+uImage: vmlinux.bin
+	rm -f $(obj)/vmlinux.bin.gz
+	gzip -9 $(obj)/vmlinux.bin
+	$(CONFIG_SHELL) $(MKIMAGE) \
+		-A mips -O linux -T kernel -C gzip \
+		-a $(VMLINUX_LOAD_ADDRESS) -e $(VMLINUX_LOAD_ADDRESS) \
+		-n 'Linux-$(KERNELRELEASE)' \
+		-d $(obj)/vmlinux.bin.gz \
+		$(obj)/uImage
+
 clean-files += elf2ecoff \
 	       vmlinux.bin \
+	       vmlinux.bin.gz \
 	       vmlinux.ecoff \
-	       vmlinux.srec
+	       vmlinux.srec \
+	       uImage
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 09eee09..e21c0fb 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -71,6 +71,13 @@
 #define MACH_LEMOTE_LL2F       7
 #define MACH_LOONGSON_END      8
 
+/*
+ * Valid machtype for XBurst
+ */
+#define MACH_XBURST_UNKNOWN	0
+#define MACH_XBURST_JZ4730	1
+#define MACH_XBURST_JZ4740	2
+
 extern char *system_type;
 const char *get_system_type(void);
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index cf373a9..dd91d72 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -34,6 +34,7 @@
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
 #define PRID_COMP_CAVIUM	0x0d0000
+#define PRID_COMP_INGENIC	0xd00000
 
 
 /*
@@ -133,6 +134,13 @@
 #define PRID_IMP_CAVIUM_CN52XX 0x0700
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_INGENIC
+ */
+
+#define PRID_IMP_XBURST 0x0200
+
+
+/*
  * Definitions for 7:0 on legacy processors
  */
 
@@ -219,6 +227,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
 	CPU_BCM6338, CPU_BCM6345, CPU_BCM6348, CPU_BCM6358,
+	CPU_XBURST,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/include/asm/mach-generic/irq.h b/arch/mips/include/asm/mach-generic/irq.h
index 70d9a25..73b7a83 100644
--- a/arch/mips/include/asm/mach-generic/irq.h
+++ b/arch/mips/include/asm/mach-generic/irq.h
@@ -9,7 +9,7 @@
 #define __ASM_MACH_GENERIC_IRQ_H
 
 #ifndef NR_IRQS
-#define NR_IRQS	128
+#define NR_IRQS	256
 #endif
 
 #ifdef CONFIG_I8259
diff --git a/arch/mips/include/asm/mach-xburst/clock-jz4730.h b/arch/mips/include/asm/mach-xburst/clock-jz4730.h
new file mode 100644
index 0000000..884738c
--- /dev/null
+++ b/arch/mips/include/asm/mach-xburst/clock-jz4730.h
@@ -0,0 +1,41 @@
+/*
+ *  JZ4730 clocks definition.
+ *
+ *  Copyright (C) 2006 - 2007 Ingenic Semiconductor Inc.
+ *
+ *  Author: <jlwei@ingenic.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_XBURST_CLOCK_JZ4730_H__
+#define __ASM_MACH_XBURST_CLOCK_JZ4730_H__
+
+/*
+ * JZ4730 clocks structure
+ */
+struct jz_clocks {
+	unsigned int extal;
+	unsigned int extal2;
+
+	unsigned int iclk;	/* CPU core clock */
+	unsigned int sclk;	/* AHB bus clock */
+	unsigned int mclk;	/* Memory bus clock */
+	unsigned int pclk;	/* APB bus clock */
+	unsigned int devclk;	/* Devcie clock to specific modules */
+	unsigned int rtcclk;	/* RTC module clock */
+	unsigned int uartclk;	/* UART module clock */
+	unsigned int lcdclk;	/* LCD module clock */
+	unsigned int pixclk;	/* LCD pixel clock */
+	unsigned int usbclk;	/* USB module clock */
+	unsigned int i2sclk;	/* I2S module clock */
+	unsigned int mscclk;	/* MMC/SD module clock */
+};
+
+extern struct jz_clocks jz_clocks;
+
+void jz_cpm_set_usbclk(int external);
+
+#endif /* __ASM_MACH_XBURST_CLOCK_JZ4730_H__ */
diff --git a/arch/mips/include/asm/mach-xburst/dma-jz4730.h b/arch/mips/include/asm/mach-xburst/dma-jz4730.h
new file mode 100644
index 0000000..d02b443
--- /dev/null
+++ b/arch/mips/include/asm/mach-xburst/dma-jz4730.h
@@ -0,0 +1,156 @@
+
+#ifndef __ASM_MACH_XBURST_DMA_JZ4730_H
+#define __ASM_MACH_XBURST_DMA_JZ4730_H
+
+#define	DMAC_BASE	0xB3020000
+
+#define DMAC_DSAR(n)	(DMAC_BASE + (0x00 + (n) * 0x20))
+#define DMAC_DDAR(n)	(DMAC_BASE + (0x04 + (n) * 0x20))
+#define DMAC_DTCR(n)	(DMAC_BASE + (0x08 + (n) * 0x20))
+#define DMAC_DRSR(n)	(DMAC_BASE + (0x0c + (n) * 0x20))
+#define DMAC_DCCSR(n)	(DMAC_BASE + (0x10 + (n) * 0x20))
+#define DMAC_DMAIPR	(DMAC_BASE + 0xf8)
+#define DMAC_DMACR	(DMAC_BASE + 0xfc)
+
+#define DMAC_DRSR_RS_BIT	0
+#define DMAC_DRSR_RS_MASK	(0x1f << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_EXTREXTR		(0 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_PCMCIAOUT	(4 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_PCMCIAIN		(5 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_AUTO		(8 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_DESOUT		(10 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_DESIN		(11 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART3OUT		(14 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART3IN		(15 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART2OUT		(16 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART2IN		(17 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART1OUT		(18 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART1IN		(19 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART0OUT		(20 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_UART0IN		(21 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_SSIOUT		(22 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_SSIIN		(23 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_AICOUT		(24 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_AICIN		(25 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_MSCOUT		(26 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_MSCIN		(27 << DMAC_DRSR_RS_BIT)
+  #define DMAC_DRSR_RS_OST2		(28 << DMAC_DRSR_RS_BIT)
+
+#define DMAC_DCCSR_EACKS	(1 << 31)
+#define DMAC_DCCSR_EACKM	(1 << 30)
+#define DMAC_DCCSR_ERDM_BIT	28
+#define DMAC_DCCSR_ERDM_MASK	(0x03 << DMAC_DCCSR_ERDM_BIT)
+  #define DMAC_DCCSR_ERDM_LLEVEL	(0 << DMAC_DCCSR_ERDM_BIT)
+  #define DMAC_DCCSR_ERDM_FEDGE		(1 << DMAC_DCCSR_ERDM_BIT)
+  #define DMAC_DCCSR_ERDM_HLEVEL	(2 << DMAC_DCCSR_ERDM_BIT)
+  #define DMAC_DCCSR_ERDM_REDGE		(3 << DMAC_DCCSR_ERDM_BIT)
+#define DMAC_DCCSR_EOPM		(1 << 27)
+#define DMAC_DCCSR_SAM		(1 << 23)
+#define DMAC_DCCSR_DAM		(1 << 22)
+#define DMAC_DCCSR_RDIL_BIT	16
+#define DMAC_DCCSR_RDIL_MASK	(0x0f << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_IGN	(0 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_2	(1 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_4	(2 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_8	(3 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_12	(4 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_16	(5 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_20	(6 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_24	(7 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_28	(8 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_32	(9 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_48	(10 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_60	(11 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_64	(12 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_124	(13 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_128	(14 << DMAC_DCCSR_RDIL_BIT)
+  #define DMAC_DCCSR_RDIL_200	(15 << DMAC_DCCSR_RDIL_BIT)
+#define DMAC_DCCSR_SWDH_BIT	14
+#define DMAC_DCCSR_SWDH_MASK	(0x03 << DMAC_DCCSR_SWDH_BIT)
+  #define DMAC_DCCSR_SWDH_32	(0 << DMAC_DCCSR_SWDH_BIT)
+  #define DMAC_DCCSR_SWDH_8	(1 << DMAC_DCCSR_SWDH_BIT)
+  #define DMAC_DCCSR_SWDH_16	(2 << DMAC_DCCSR_SWDH_BIT)
+#define DMAC_DCCSR_DWDH_BIT	12
+#define DMAC_DCCSR_DWDH_MASK	(0x03 << DMAC_DCCSR_DWDH_BIT)
+  #define DMAC_DCCSR_DWDH_32	(0 << DMAC_DCCSR_DWDH_BIT)
+  #define DMAC_DCCSR_DWDH_8	(1 << DMAC_DCCSR_DWDH_BIT)
+  #define DMAC_DCCSR_DWDH_16	(2 << DMAC_DCCSR_DWDH_BIT)
+#define DMAC_DCCSR_DS_BIT	8
+#define DMAC_DCCSR_DS_MASK	(0x07 << DMAC_DCCSR_DS_BIT)
+  #define DMAC_DCCSR_DS_32b	(0 << DMAC_DCCSR_DS_BIT)
+  #define DMAC_DCCSR_DS_8b	(1 << DMAC_DCCSR_DS_BIT)
+  #define DMAC_DCCSR_DS_16b	(2 << DMAC_DCCSR_DS_BIT)
+  #define DMAC_DCCSR_DS_16B	(3 << DMAC_DCCSR_DS_BIT)
+  #define DMAC_DCCSR_DS_32B	(4 << DMAC_DCCSR_DS_BIT)
+#define DMAC_DCCSR_TM		(1 << 7)
+#define DMAC_DCCSR_AR		(1 << 4)
+#define DMAC_DCCSR_TC		(1 << 3)
+#define DMAC_DCCSR_HLT		(1 << 2)
+#define DMAC_DCCSR_TCIE		(1 << 1)
+#define DMAC_DCCSR_CHDE		(1 << 0)
+
+#define DMAC_DMAIPR_CINT_BIT	8
+#define DMAC_DMAIPR_CINT_MASK	(0xff << DMAC_DMAIPR_CINT_BIT)
+
+#define DMAC_DMACR_PR_BIT	8
+#define DMAC_DMACR_PR_MASK	(0x03 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_01234567	(0 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_02314675	(1 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_20136457	(2 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_ROUNDROBIN	(3 << DMAC_DMACR_PR_BIT)
+#define DMAC_DMACR_HTR		(1 << 3)
+#define DMAC_DMACR_AER		(1 << 2)
+#define DMAC_DMACR_DME		(1 << 0)
+
+#define IRQ_DMA_0	32
+#define NUM_DMA		6
+
+#define DMAC_DSAR0      DMAC_DSAR(0)
+#define DMAC_DDAR0      DMAC_DDAR(0)
+#define DMAC_DTCR0      DMAC_DTCR(0)
+#define DMAC_DRSR0      DMAC_DRSR(0)
+#define DMAC_DCCSR0     DMAC_DCCSR(0)
+
+#define DMAC_DSAR1      DMAC_DSAR(1)
+#define DMAC_DDAR1      DMAC_DDAR(1)
+#define DMAC_DTCR1      DMAC_DTCR(1)
+#define DMAC_DRSR1      DMAC_DRSR(1)
+#define DMAC_DCCSR1     DMAC_DCCSR(1)
+
+#define DMAC_DSAR2      DMAC_DSAR(2)
+#define DMAC_DDAR2      DMAC_DDAR(2)
+#define DMAC_DTCR2      DMAC_DTCR(2)
+#define DMAC_DRSR2      DMAC_DRSR(2)
+#define DMAC_DCCSR2     DMAC_DCCSR(2)
+
+#define DMAC_DSAR3      DMAC_DSAR(3)
+#define DMAC_DDAR3      DMAC_DDAR(3)
+#define DMAC_DTCR3      DMAC_DTCR(3)
+#define DMAC_DRSR3      DMAC_DRSR(3)
+#define DMAC_DCCSR3     DMAC_DCCSR(3)
+
+#define DMAC_DSAR4      DMAC_DSAR(4)
+#define DMAC_DDAR4      DMAC_DDAR(4)
+#define DMAC_DTCR4      DMAC_DTCR(4)
+#define DMAC_DRSR4      DMAC_DRSR(4)
+#define DMAC_DCCSR4     DMAC_DCCSR(4)
+
+#define DMAC_DSAR5      DMAC_DSAR(5)
+#define DMAC_DDAR5      DMAC_DDAR(5)
+#define DMAC_DTCR5      DMAC_DTCR(5)
+#define DMAC_DRSR5      DMAC_DRSR(5)
+#define DMAC_DCCSR5     DMAC_DCCSR(5)
+
+#define DMAC_DSAR6      DMAC_DSAR(6)
+#define DMAC_DDAR6      DMAC_DDAR(6)
+#define DMAC_DTCR6      DMAC_DTCR(6)
+#define DMAC_DRSR6      DMAC_DRSR(6)
+#define DMAC_DCCSR6     DMAC_DCCSR(6)
+
+#define DMAC_DSAR7      DMAC_DSAR(7)
+#define DMAC_DDAR7      DMAC_DDAR(7)
+#define DMAC_DTCR7      DMAC_DTCR(7)
+#define DMAC_DRSR7      DMAC_DRSR(7)
+#define DMAC_DCCSR7     DMAC_DCCSR(7)
+
+#endif /* __ASM_MACH_XBURST_DMA_JZ4730_H */
diff --git a/arch/mips/include/asm/mach-xburst/irq-jz4730.h b/arch/mips/include/asm/mach-xburst/irq-jz4730.h
new file mode 100644
index 0000000..087b99e
--- /dev/null
+++ b/arch/mips/include/asm/mach-xburst/irq-jz4730.h
@@ -0,0 +1,33 @@
+#ifndef __ASM_MACH_XBURST_IRQ_JZ4730_H
+#define __ASM_MACH_XBURST_IRQ_JZ4730_H
+
+#define IRQ_I2C		1
+#define IRQ_PS2		2
+#define IRQ_UPRT	3
+#define IRQ_CORE	4
+#define IRQ_UART3	6
+#define IRQ_UART2	7
+#define IRQ_UART1	8
+#define IRQ_UART0	9
+#define IRQ_SCC1	10
+#define IRQ_SCC0	11
+#define IRQ_UDC		12
+#define IRQ_UHC		13
+#define IRQ_MSC		14
+#define IRQ_RTC		15
+#define IRQ_FIR		16
+#define IRQ_SSI		17
+#define IRQ_CIM		18
+#define IRQ_ETH		19
+#define IRQ_AIC		20
+#define IRQ_DMAC	21
+#define IRQ_OST2	22
+#define IRQ_OST1	23
+#define IRQ_OST0	24
+#define IRQ_GPIO3	25
+#define IRQ_GPIO2	26
+#define IRQ_GPIO1	27
+#define IRQ_GPIO0	28
+#define IRQ_LCD		30
+
+#endif /* __ASM_MACH_XBURST_IRQ_JZ4730_H */
diff --git a/arch/mips/include/asm/mach-xburst/uart-jz4730.h b/arch/mips/include/asm/mach-xburst/uart-jz4730.h
new file mode 100644
index 0000000..f7f6fcd
--- /dev/null
+++ b/arch/mips/include/asm/mach-xburst/uart-jz4730.h
@@ -0,0 +1,141 @@
+/*
+ *  UART registers for jz4730.
+ *
+ *  Copyright (C) 2006 - 2007 Ingenic Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_XBURST_UART_JZ4730_H
+#define __ASM_MACH_XBURST_UART_JZ4730_H
+
+#define	UART0_BASE	0xB0030000
+#define	UART1_BASE	0xB0031000
+#define	UART2_BASE	0xB0032000
+#define	UART3_BASE	0xB0033000
+
+/* register offset */
+#define OFF_RDR		0x00	/* R  8b H'xx */
+#define OFF_TDR		0x00	/* W  8b H'xx */
+#define OFF_DLLR	0x00	/* RW 8b H'00 */
+#define OFF_DLHR	0x04	/* RW 8b H'00 */
+#define OFF_IER		0x04	/* RW 8b H'00 */
+#define OFF_ISR		0x08	/* R  8b H'01 */
+#define OFF_FCR		0x08	/* W  8b H'00 */
+#define OFF_LCR		0x0C	/* RW 8b H'00 */
+#define OFF_MCR		0x10	/* RW 8b H'00 */
+#define OFF_LSR		0x14	/* R  8b H'00 */
+#define OFF_MSR		0x18	/* R  8b H'00 */
+#define OFF_SPR		0x1C	/* RW 8b H'00 */
+#define OFF_MCR		0x10	/* RW 8b H'00 */
+#define OFF_SIRCR	0x20	/* RW 8b H'00, UART0 */
+
+/*
+ * Define macros for UARTIER
+ * UART Interrupt Enable Register
+ */
+#define UARTIER_RIE	(1 << 0)	/* 0: receive fifo "full" interrupt disable */
+#define UARTIER_TIE	(1 << 1)	/* 0: transmit fifo "empty" interrupt disable */
+#define UARTIER_RLIE	(1 << 2)	/* 0: receive line status interrupt disable */
+#define UARTIER_MIE	(1 << 3)	/* 0: modem status interrupt disable */
+#define UARTIER_RTIE	(1 << 4)	/* 0: receive timeout interrupt disable */
+
+/*
+ * Define macros for UARTISR
+ * UART Interrupt Status Register
+ */
+#define UARTISR_IP	(1 << 0)	/* 0: interrupt is pending  1: no interrupt */
+#define UARTISR_IID	(7 << 1)	/* Source of Interrupt */
+#define UARTISR_IID_MSI		(0 << 1)	/* Modem status interrupt */
+#define UARTISR_IID_THRI	(1 << 1)	/* Transmitter holding register empty */
+#define UARTISR_IID_RDI		(2 << 1)	/* Receiver data interrupt */
+#define UARTISR_IID_RLSI	(3 << 1)	/* Receiver line status interrupt */
+#define UARTISR_FFMS	(3 << 6)	/* FIFO mode select, set when UARTFCR.FE is set to 1 */
+#define UARTISR_FFMS_NO_FIFO	(0 << 6)
+#define UARTISR_FFMS_FIFO_MODE	(3 << 6)
+
+/*
+ * Define macros for UARTFCR
+ * UART FIFO Control Register
+ */
+#define UARTFCR_FE	(1 << 0)	/* 0: non-FIFO mode  1: FIFO mode */
+#define UARTFCR_RFLS	(1 << 1)	/* write 1 to flush receive FIFO */
+#define UARTFCR_TFLS	(1 << 2)	/* write 1 to flush transmit FIFO */
+#define UARTFCR_DMS	(1 << 3)	/* 0: disable DMA mode */
+#define UARTFCR_UUE	(1 << 4)	/* 0: disable UART */
+#define UARTFCR_RTRG	(3 << 6)	/* Receive FIFO Data Trigger */
+#define UARTFCR_RTRG_1	(0 << 6)
+#define UARTFCR_RTRG_4	(1 << 6)
+#define UARTFCR_RTRG_8	(2 << 6)
+#define UARTFCR_RTRG_15	(3 << 6)
+
+/*
+ * Define macros for UARTLCR
+ * UART Line Control Register
+ */
+#define UARTLCR_WLEN	(3 << 0)	/* word length */
+#define UARTLCR_WLEN_5	(0 << 0)
+#define UARTLCR_WLEN_6	(1 << 0)
+#define UARTLCR_WLEN_7	(2 << 0)
+#define UARTLCR_WLEN_8	(3 << 0)
+#define UARTLCR_STOP	(1 << 2)	/* 0: 1 stop bit when word length is 5,6,7,8
+					   1: 1.5 stop bits when 5; 2 stop bits when 6,7,8 */
+#define UARTLCR_PE	(1 << 3)	/* 0: parity disable */
+#define UARTLCR_PROE	(1 << 4)	/* 0: even parity  1: odd parity */
+#define UARTLCR_SPAR	(1 << 5)	/* 0: sticky parity disable */
+#define UARTLCR_SBRK	(1 << 6)	/* write 0 normal, write 1 send break */
+#define UARTLCR_DLAB	(1 << 7)	/* 0: access UARTRDR/TDR/IER  1: access UARTDLLR/DLHR */
+
+/*
+ * Define macros for UARTLSR
+ * UART Line Status Register
+ */
+#define UARTLSR_DR	(1 << 0)	/* 0: receive FIFO is empty  1: receive data is ready */
+#define UARTLSR_ORER	(1 << 1)	/* 0: no overrun error */
+#define UARTLSR_PER	(1 << 2)	/* 0: no parity error */
+#define UARTLSR_FER	(1 << 3)	/* 0; no framing error */
+#define UARTLSR_BRK	(1 << 4)	/* 0: no break detected  1: receive a break signal */
+#define UARTLSR_TDRQ	(1 << 5)	/* 1: transmit FIFO half "empty" */
+#define UARTLSR_TEMT	(1 << 6)	/* 1: transmit FIFO and shift registers empty */
+#define UARTLSR_RFER	(1 << 7)	/* 0: no receive error  1: receive error in FIFO mode */
+
+/*
+ * Define macros for UARTMCR
+ * UART Modem Control Register
+ */
+#define UARTMCR_DTR	(1 << 0)	/* 0: DTR_ ouput high */
+#define UARTMCR_RTS	(1 << 1)	/* 0: RTS_ output high */
+#define UARTMCR_OUT1	(1 << 2)	/* 0: UARTMSR.RI is set to 0 and RI_ input high */
+#define UARTMCR_OUT2	(1 << 3)	/* 0: UARTMSR.DCD is set to 0 and DCD_ input high */
+#define UARTMCR_LOOP	(1 << 4)	/* 0: normal  1: loopback mode */
+#define UARTMCR_MCE	(1 << 7)	/* 0: modem function is disable */
+
+/*
+ * Define macros for UARTMSR
+ * UART Modem Status Register
+ */
+#define UARTMSR_DCTS	(1 << 0)	/* 0: no change on CTS_ pin since last read of UARTMSR */
+#define UARTMSR_DDSR	(1 << 1)	/* 0: no change on DSR_ pin since last read of UARTMSR */
+#define UARTMSR_DRI	(1 << 2)	/* 0: no change on RI_ pin since last read of UARTMSR */
+#define UARTMSR_DDCD	(1 << 3)	/* 0: no change on DCD_ pin since last read of UARTMSR */
+#define UARTMSR_CTS	(1 << 4)	/* 0: CTS_ pin is high */
+#define UARTMSR_DSR	(1 << 5)	/* 0: DSR_ pin is high */
+#define UARTMSR_RI	(1 << 6)	/* 0: RI_ pin is high */
+#define UARTMSR_DCD	(1 << 7)	/* 0: DCD_ pin is high */
+
+/*
+ * Define macros for SIRCR
+ * Slow IrDA Control Register
+ */
+#define SIRCR_TSIRE	(1 << 0)	/* 0: transmitter is in UART mode  1: IrDA mode */
+#define SIRCR_RSIRE	(1 << 1)	/* 0: receiver is in UART mode  1: IrDA mode */
+#define SIRCR_TPWS	(1 << 2)	/* 0: transmit 0 pulse width is 3/16 of bit length
+					   1: 0 pulse width is 1.6us for 115.2Kbps */
+#define SIRCR_TXPL	(1 << 3)	/* 0: encoder generates a positive pulse for 0 */
+#define SIRCR_RXPL	(1 << 4)	/* 0: decoder interprets positive pulse as 0 */
+
+
+
+#endif /* __ASM_MACH_XBURST_UART_JZ4730_H */
diff --git a/arch/mips/include/asm/mach-xburst/war.h b/arch/mips/include/asm/mach-xburst/war.h
new file mode 100644
index 0000000..5acdf58
--- /dev/null
+++ b/arch/mips/include/asm/mach-xburst/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MACH_XBURST_WAR_H
+#define __ASM_MACH_XBURST_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MACH_XBURST_WAR_H */
diff --git a/arch/mips/include/asm/mach-xburst/xburst.h b/arch/mips/include/asm/mach-xburst/xburst.h
new file mode 100644
index 0000000..4b2c40c
--- /dev/null
+++ b/arch/mips/include/asm/mach-xburst/xburst.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_XBURST_H
+#define __ASM_XBURST_H
+
+#ifdef CONFIG_XBURST_JZ4730
+#include "clock-jz4730.h"
+#include "irq-jz4730.h"
+#include "uart-jz4730.h"
+#endif
+
+void jz_usb0_set_function(int host);
+
+#endif /* __ASM_XBURST_H */
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 387bf59..f0bb7c3 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -17,6 +17,59 @@
 #include <asm/cpu-features.h>
 #include <asm/mipsmtregs.h>
 
+#ifdef CONFIG_XBURST
+
+#define K0_TO_K1()				\
+do {						\
+	unsigned long __k0_addr;		\
+						\
+	__asm__ __volatile__(			\
+	"la %0, 1f\n\t"				\
+	"or	%0, %0, %1\n\t"			\
+	"jr	%0\n\t"				\
+	"nop\n\t"				\
+	"1: nop\n"				\
+	: "=&r"(__k0_addr)			\
+	: "r" (0x20000000) );			\
+} while(0)
+
+#define K1_TO_K0()				\
+do {						\
+	unsigned long __k0_addr;		\
+	__asm__ __volatile__(			\
+	"nop;nop;nop;nop;nop;nop;nop\n\t"	\
+	"la %0, 1f\n\t"				\
+	"jr	%0\n\t"				\
+	"nop\n\t"				\
+	"1:	nop\n"				\
+	: "=&r" (__k0_addr));			\
+} while (0)
+
+#define INVALIDATE_BTB()			\
+do {						\
+	unsigned long tmp;			\
+	__asm__ __volatile__(			\
+	".set mips32\n\t"			\
+	"mfc0 %0, $16, 7\n\t"			\
+	"nop\n\t"				\
+	"ori %0, 2\n\t"				\
+	"mtc0 %0, $16, 7\n\t"			\
+	"nop\n\t"				\
+	: "=&r" (tmp));				\
+} while (0)
+
+#define SYNC_WB() __asm__ __volatile__ ("sync")
+
+#else /* CONFIG_XBURST */
+
+#define K0_TO_K1() do { } while (0)
+#define K1_TO_K0() do { } while (0)
+#define INVALIDATE_BTB() do { } while (0)
+#define SYNC_WB() do { } while (0)
+
+#endif /* CONFIG_XBURST */
+
+
 /*
  * This macro return a properly sign-extended address suitable as base address
  * for indexed cache operations.  Two issues here:
@@ -144,6 +197,7 @@ static inline void flush_icache_line_indexed(unsigned long addr)
 {
 	__iflush_prologue
 	cache_op(Index_Invalidate_I, addr);
+	INVALIDATE_BTB();
 	__iflush_epilogue
 }
 
@@ -151,6 +205,7 @@ static inline void flush_dcache_line_indexed(unsigned long addr)
 {
 	__dflush_prologue
 	cache_op(Index_Writeback_Inv_D, addr);
+	SYNC_WB();
 	__dflush_epilogue
 }
 
@@ -163,6 +218,7 @@ static inline void flush_icache_line(unsigned long addr)
 {
 	__iflush_prologue
 	cache_op(Hit_Invalidate_I, addr);
+	INVALIDATE_BTB();
 	__iflush_epilogue
 }
 
@@ -170,6 +226,7 @@ static inline void flush_dcache_line(unsigned long addr)
 {
 	__dflush_prologue
 	cache_op(Hit_Writeback_Inv_D, addr);
+	SYNC_WB();
 	__dflush_epilogue
 }
 
@@ -177,6 +234,7 @@ static inline void invalidate_dcache_line(unsigned long addr)
 {
 	__dflush_prologue
 	cache_op(Hit_Invalidate_D, addr);
+	SYNC_WB();
 	__dflush_epilogue
 }
 
@@ -209,6 +267,7 @@ static inline void flush_scache_line(unsigned long addr)
 static inline void protected_flush_icache_line(unsigned long addr)
 {
 	protected_cache_op(Hit_Invalidate_I, addr);
+	INVALIDATE_BTB();
 }
 
 /*
@@ -220,6 +279,7 @@ static inline void protected_flush_icache_line(unsigned long addr)
 static inline void protected_writeback_dcache_line(unsigned long addr)
 {
 	protected_cache_op(Hit_Writeback_Inv_D, addr);
+	SYNC_WB();
 }
 
 static inline void protected_writeback_scache_line(unsigned long addr)
@@ -396,8 +456,12 @@ static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page)
 __BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 16)
 __BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16)
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
+
+#ifndef CONFIG_XBURST
 __BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 32)
 __BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32)
+#endif
+
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
 __BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64)
 __BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
@@ -405,12 +469,124 @@ __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
 
 __BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16)
+
+#ifndef CONFIG_XBURST
 __BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 32)
+#endif
+
 __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 16)
 __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32)
 __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64)
 __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128)
 
+#ifdef CONFIG_XBURST
+
+static inline void blast_dcache32(void)
+{
+	unsigned long start = INDEX_BASE;
+	unsigned long end = start + current_cpu_data.dcache.waysize;
+	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
+	unsigned long ws_end = current_cpu_data.dcache.ways <<
+	                       current_cpu_data.dcache.waybit;
+	unsigned long ws, addr;
+
+	for (ws = 0; ws < ws_end; ws += ws_inc)
+		for (addr = start; addr < end; addr += 0x400)
+			cache32_unroll32(addr|ws,Index_Writeback_Inv_D);
+
+	SYNC_WB();
+}
+
+static inline void blast_dcache32_page(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = page + PAGE_SIZE;
+
+	do {
+		cache32_unroll32(start,Hit_Writeback_Inv_D);
+		start += 0x400;
+	} while (start < end);
+
+	SYNC_WB();
+}
+
+static inline void blast_dcache32_page_indexed(unsigned long page)
+{
+	unsigned long indexmask = current_cpu_data.dcache.waysize - 1;
+	unsigned long start = INDEX_BASE + (page & indexmask);
+	unsigned long end = start + PAGE_SIZE;
+	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
+	unsigned long ws_end = current_cpu_data.dcache.ways <<
+	                       current_cpu_data.dcache.waybit;
+	unsigned long ws, addr;
+
+	for (ws = 0; ws < ws_end; ws += ws_inc)
+		for (addr = start; addr < end; addr += 0x400)
+			cache32_unroll32(addr|ws,Index_Writeback_Inv_D);
+
+	SYNC_WB();
+}
+
+static inline void blast_icache32(void)
+{
+	unsigned long start = INDEX_BASE;
+	unsigned long end = start + current_cpu_data.icache.waysize;
+	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
+	unsigned long ws_end = current_cpu_data.icache.ways <<
+	                       current_cpu_data.icache.waybit;
+	unsigned long ws, addr;
+
+	K0_TO_K1();
+
+	for (ws = 0; ws < ws_end; ws += ws_inc)
+		for (addr = start; addr < end; addr += 0x400)
+			cache32_unroll32(addr|ws,Index_Invalidate_I);
+
+	INVALIDATE_BTB();
+
+	K1_TO_K0();
+}
+
+static inline void blast_icache32_page(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = page + PAGE_SIZE;
+
+	K0_TO_K1();
+
+	do {
+		cache32_unroll32(start,Hit_Invalidate_I);
+		start += 0x400;
+	} while (start < end);
+
+	INVALIDATE_BTB();
+
+	K1_TO_K0();
+}
+
+static inline void blast_icache32_page_indexed(unsigned long page)
+{
+	unsigned long indexmask = current_cpu_data.icache.waysize - 1;
+	unsigned long start = INDEX_BASE + (page & indexmask);
+	unsigned long end = start + PAGE_SIZE;
+	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
+	unsigned long ws_end = current_cpu_data.icache.ways <<
+	                       current_cpu_data.icache.waybit;
+	unsigned long ws, addr;
+
+	K0_TO_K1();
+
+	for (ws = 0; ws < ws_end; ws += ws_inc)
+		for (addr = start; addr < end; addr += 0x400)
+			cache32_unroll32(addr|ws,Index_Invalidate_I);
+
+	INVALIDATE_BTB();
+
+	K1_TO_K0();
+}
+
+#endif /* CONFIG_XBURST */
+
 /* build blast_xxx_range, protected_blast_xxx_range */
 #define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot) \
 static inline void prot##blast_##pfx##cache##_range(unsigned long start, \
@@ -432,13 +608,77 @@ static inline void prot##blast_##pfx##cache##_range(unsigned long start, \
 	__##pfx##flush_epilogue						\
 }
 
+#ifndef CONFIG_XBURST
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, protected_)
+#endif
+
 __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_)
+
+#ifndef CONFIG_XBURST
 __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_)
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, )
+#endif
+
 __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, )
 /* blast_inv_dcache_range */
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, )
 __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, )
 
+
+#ifdef CONFIG_XBURST
+
+static inline void protected_blast_dcache_range(unsigned long start,
+						unsigned long end)
+{
+	unsigned long lsize = cpu_dcache_line_size();
+	unsigned long addr = start & ~(lsize - 1);
+	unsigned long aend = (end - 1) & ~(lsize - 1);
+
+	while (1) {
+		protected_cache_op(Hit_Writeback_Inv_D, addr);
+		if (addr == aend)
+			break;
+		addr += lsize;
+	}
+	SYNC_WB();
+}
+
+static inline void protected_blast_icache_range(unsigned long start,
+						unsigned long end)
+{
+	unsigned long lsize = cpu_icache_line_size();
+	unsigned long addr = start & ~(lsize - 1);
+	unsigned long aend = (end - 1) & ~(lsize - 1);
+
+	K0_TO_K1();
+
+	while (1) {
+		protected_cache_op(Hit_Invalidate_I, addr);
+		if (addr == aend)
+			break;
+		addr += lsize;
+	}
+	INVALIDATE_BTB();
+
+	K1_TO_K0();
+}
+
+static inline void blast_dcache_range(unsigned long start,
+				      unsigned long end)
+{
+	unsigned long lsize = cpu_dcache_line_size();
+	unsigned long addr = start & ~(lsize - 1);
+	unsigned long aend = (end - 1) & ~(lsize - 1);
+
+	while (1) {
+		cache_op(Hit_Writeback_Inv_D, addr);
+		if (addr == aend)
+			break;
+		addr += lsize;
+	}
+	SYNC_WB();
+}
+
+#endif /* CONFIG_XBURST */
+
 #endif /* _ASM_R4KCACHE_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 758ad42..89a9468 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -162,6 +162,7 @@ void __init check_wait(void)
 	case CPU_BCM6348:
 	case CPU_BCM6358:
 	case CPU_CAVIUM_OCTEON:
+	case CPU_XBURST:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -913,6 +914,23 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
+{
+	decode_configs(c);
+	c->options &= ~MIPS_CPU_COUNTER; /* XBurst has no CP0 counter. */
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_XBURST:
+		c->cputype = CPU_XBURST;
+		c->isa_level = MIPS_CPU_ISA_M32R1;
+		c->tlbsize = 32;
+		__cpu_name[cpu] = "Ingenic XBurst";
+		break;
+	default:
+		panic("Unknown Ingenic Processor ID!");
+		break;
+	}
+}
+
 const char *__cpu_name[NR_CPUS];
 
 __cpuinit void cpu_probe(void)
@@ -950,6 +968,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_CAVIUM:
 		cpu_probe_cavium(c, cpu);
 		break;
+	case PRID_COMP_INGENIC:
+		cpu_probe_ingenic(c, cpu);
+		break;
 	}
 
 	BUG_ON(!__cpu_name[cpu]);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6721ee2..8cae4e3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -928,6 +928,36 @@ static void __cpuinit probe_pcache(void)
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_XBURST:
+		config1 = read_c0_config1();
+		config1 = (config1 >> 22) & 0x07;
+		if (config1 == 0x07)
+			config1 = 10;
+		else
+			config1 = config1 + 11;
+		config1 += 2;
+		icache_size = (1 << config1);
+		c->icache.linesz = 32;
+		c->icache.ways = 4;
+		c->icache.waybit = __ffs(icache_size / c->icache.ways);
+
+		config1 = read_c0_config1();
+		config1 = (config1 >> 13) & 0x07;
+		if (config1 == 0x07)
+			config1 = 10;
+		else
+			config1 = config1 + 11;
+		config1 += 2;
+		dcache_size = (1 << config1);
+		c->dcache.linesz = 32;
+		c->dcache.ways = 4;
+		c->dcache.waybit = __ffs(dcache_size / c->dcache.ways);
+
+		c->dcache.flags = 0;
+		c->options |= MIPS_CPU_PREFETCH;
+
+		break;
+
 	default:
 		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index badcf5e..34ef8c9 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -390,6 +390,11 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		tlbw(p);
 		break;
 
+	case CPU_XBURST:
+		tlbw(p);
+		uasm_i_nop(p);
+		break;
+
 	default:
 		panic("No TLB refill handler yet (CPU type: %d)",
 		      current_cpu_data.cputype);
diff --git a/arch/mips/xburst/Kconfig b/arch/mips/xburst/Kconfig
new file mode 100644
index 0000000..fc12741
--- /dev/null
+++ b/arch/mips/xburst/Kconfig
@@ -0,0 +1,23 @@
+choice
+	prompt "XBurst SoC Type"
+	depends on XBURST
+
+config XBURST_JZ4730
+	bool "Ingenic JZ4730"
+
+#config XBURST_JZ4740
+#	bool "Ingenic JZ4740"
+
+endchoice
+
+choice
+	prompt "JZ4730 board"
+	depends on XBURST_JZ4730
+
+config JZ4730_PMP
+	bool "Ingenic PMP reference board"
+
+config JZ4730_LIBRA
+	bool "Ingenic Libra dev board"
+
+endchoice
diff --git a/arch/mips/xburst/Makefile b/arch/mips/xburst/Makefile
new file mode 100644
index 0000000..a96d462
--- /dev/null
+++ b/arch/mips/xburst/Makefile
@@ -0,0 +1,3 @@
+#
+# jz4730 SoC based systems
+obj-$(CONFIG_XBURST_JZ4730) += jz4730/
diff --git a/arch/mips/xburst/jz4730/Makefile b/arch/mips/xburst/jz4730/Makefile
new file mode 100644
index 0000000..100c64b
--- /dev/null
+++ b/arch/mips/xburst/jz4730/Makefile
@@ -0,0 +1,11 @@
+#
+# JZ4730 SoC based systems.
+#
+
+obj-y += irq.o prom.o setup.o time.o clocks.o platform.o
+
+# Ingenic's Libra dev board
+obj-$(CONFIG_JZ4730_LIBRA)	+= board-libra.o
+
+# Ingenic's Portable Media Player reference platform
+obj-$(CONFIG_JZ4730_PMP)	+= board-pmp.o
diff --git a/arch/mips/xburst/jz4730/board-libra.c b/arch/mips/xburst/jz4730/board-libra.c
new file mode 100644
index 0000000..795bdd5
--- /dev/null
+++ b/arch/mips/xburst/jz4730/board-libra.c
@@ -0,0 +1,32 @@
+/*
+ * board-libra.c
+ *
+ * Copyright (C) 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <xburst.h>
+
+void __init
+jz_board_get_extal(struct jz_clocks *cks)
+{
+	cks->extal = 3686400;	/* 3.6864 MHz */
+	cks->extal2 = 32768;	/* 32.768 KHz */
+}
+
+void __init
+jz_board_setup(void)
+{
+	/*
+	 * USB is much more reliable using the external USB clock,
+	 * not the PLL divider.
+	 */
+	jz_cpm_set_usbclk(1);
+
+	/* USB0 as host. */
+	jz_usb0_set_function(1);
+}
diff --git a/arch/mips/xburst/jz4730/board-pmp.c b/arch/mips/xburst/jz4730/board-pmp.c
new file mode 100644
index 0000000..90c5692
--- /dev/null
+++ b/arch/mips/xburst/jz4730/board-pmp.c
@@ -0,0 +1,32 @@
+/*
+ * board-pmp.c
+ *
+ * Copyright (C) 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <xburst.h>
+
+void __init
+jz_board_get_extal(struct jz_clocks *cks)
+{
+	cks->extal = 12000000;	/* 12 MHz */
+	cks->extal2 = 32768;	/* 32.768 KHz */
+}
+
+void __init
+jz_board_setup(void)
+{
+	/*
+	 * USB is much more reliable using the external USB clock,
+	 * not the PLL divider.
+	 */
+	jz_cpm_set_usbclk(1);
+
+	/* USB0 as device. */
+	jz_usb0_set_function(0);
+}
diff --git a/arch/mips/xburst/jz4730/clocks.c b/arch/mips/xburst/jz4730/clocks.c
new file mode 100644
index 0000000..abc887f
--- /dev/null
+++ b/arch/mips/xburst/jz4730/clocks.c
@@ -0,0 +1,294 @@
+/*
+ * Copyright (C) 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *
+ * Copyright (C) 2006 - 2007 Ingenic Semiconductor Inc.
+ * Author: <jlwei@ingenic.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <xburst.h>
+
+extern void __init jz_board_get_extal(struct jz_clocks *);
+
+struct jz_clocks jz_clocks;
+EXPORT_SYMBOL(jz_clocks);
+
+static void __iomem *cpm_base;
+
+#define	CPM_BASE	0x10000000
+
+#define CPM_CFCR	0x00
+#define CPM_LPCR	0x04
+#define CPM_RSTR	0x08
+#define CPM_PLCR1	0x10
+#define CPM_OCR		0x1c
+#define CPM_MSCR	0x20
+#define CPM_SCR		0x24
+#define CPM_WRER	0x28
+#define CPM_WFER	0x2c
+#define CPM_WER		0x30
+#define CPM_WSR		0x34
+#define CPM_GSR0	0x38
+#define CPM_GSR1	0x3c
+#define CPM_GSR2	0x40
+#define CPM_SPR		0x44
+#define CPM_GSR3	0x48
+#define CPM_CFCR2	0x60
+
+#define CPM_CFCR_SSI		(1 << 31)
+#define CPM_CFCR_LCD		(1 << 30)
+#define CPM_CFCR_I2S		(1 << 29)
+#define CPM_CFCR_UCS		(1 << 28)
+#define CPM_CFCR_UFR_BIT	25
+#define CPM_CFCR_UFR_MASK	(0x07 << CPM_CFCR_UFR_BIT)
+#define CPM_CFCR_MSC		(1 << 24)
+#define CPM_CFCR_CKOEN2		(1 << 23)
+#define CPM_CFCR_CKOEN1		(1 << 22)
+#define CPM_CFCR_UPE		(1 << 20)
+#define CPM_CFCR_MFR_BIT	16
+#define CPM_CFCR_MFR_MASK	(0x0f << CPM_CFCR_MFR_BIT)
+#define CPM_CFCR_LFR_BIT	12
+#define CPM_CFCR_LFR_MASK	(0x0f << CPM_CFCR_LFR_BIT)
+#define CPM_CFCR_PFR_BIT	8
+#define CPM_CFCR_PFR_MASK	(0x0f << CPM_CFCR_PFR_BIT)
+#define CPM_CFCR_SFR_BIT	4
+#define CPM_CFCR_SFR_MASK	(0x0f << CPM_CFCR_SFR_BIT)
+#define CPM_CFCR_IFR_BIT	0
+#define CPM_CFCR_IFR_MASK	(0x0f << CPM_CFCR_IFR_BIT)
+
+#define CPM_PLCR1_PLL1FD_BIT	23
+#define CPM_PLCR1_PLL1FD_MASK	(0x1ff << CPM_PLCR1_PLL1FD_BIT)
+#define CPM_PLCR1_PLL1RD_BIT	18
+#define CPM_PLCR1_PLL1RD_MASK	(0x1f << CPM_PLCR1_PLL1RD_BIT)
+#define CPM_PLCR1_PLL1OD_BIT	16
+#define CPM_PLCR1_PLL1OD_MASK	(0x03 << CPM_PLCR1_PLL1OD_BIT)
+#define CPM_PLCR1_PLL1S		(1 << 10)
+#define CPM_PLCR1_PLL1BP	(1 << 9)
+#define CPM_PLCR1_PLL1EN	(1 << 8)
+#define CPM_PLCR1_PLL1ST_BIT	0
+#define CPM_PLCR1_PLL1ST_MASK	(0xff << CPM_PLCR1_PLL1ST_BIT)
+
+#define CPM_LPCR_DUTY_BIT	3
+#define CPM_LPCR_DUTY_MASK	(0x1f << CPM_LPCR_DUTY_BIT)
+#define CPM_LPCR_DOZE		(1 << 2)
+#define CPM_LPCR_LPM_BIT	0
+#define CPM_LPCR_LPM_MASK	(0x03 << CPM_LPCR_LPM_BIT)
+  #define CPM_LPCR_LPM_IDLE		(0 << CPM_LPCR_LPM_BIT)
+  #define CPM_LPCR_LPM_SLEEP		(1 << CPM_LPCR_LPM_BIT)
+  #define CPM_LPCR_LPM_HIBERNATE	(2 << CPM_LPCR_LPM_BIT)
+
+
+static __inline__ unsigned int
+cpm_get_pllout(void)
+{
+	unsigned int nf, nr, no, pllout;
+	unsigned long plcr = readl(cpm_base + CPM_PLCR1);
+	unsigned long od[4] = {1, 2, 2, 4};
+	if (plcr & CPM_PLCR1_PLL1EN) {
+		nf = (plcr & CPM_PLCR1_PLL1FD_MASK) >> CPM_PLCR1_PLL1FD_BIT;
+		nr = (plcr & CPM_PLCR1_PLL1RD_MASK) >> CPM_PLCR1_PLL1RD_BIT;
+		no = od[((plcr & CPM_PLCR1_PLL1OD_MASK) >> CPM_PLCR1_PLL1OD_BIT)];
+		pllout = (jz_clocks.extal) / ((nr+2) * no) * (nf+2);
+	} else
+		pllout = jz_clocks.extal;
+	return pllout;
+}
+
+static __inline__ unsigned int
+cpm_get_iclk(void)
+{
+	unsigned int iclk;
+	int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32};
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	unsigned long plcr = readl(cpm_base + CPM_PLCR1);
+	if (plcr & CPM_PLCR1_PLL1EN)
+		iclk = cpm_get_pllout() /
+		       div[(cfcr & CPM_CFCR_IFR_MASK) >> CPM_CFCR_IFR_BIT];
+	else
+		iclk = jz_clocks.extal;
+	return iclk;
+}
+
+static __inline__ unsigned int
+cpm_get_sclk(void)
+{
+	unsigned int sclk;
+	int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32};
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	unsigned long plcr = readl(cpm_base + CPM_PLCR1);
+	if (plcr & CPM_PLCR1_PLL1EN)
+		sclk = cpm_get_pllout() /
+		       div[(cfcr & CPM_CFCR_SFR_MASK) >> CPM_CFCR_SFR_BIT];
+	else
+		sclk = jz_clocks.extal;
+	return sclk;
+}
+
+static __inline__ unsigned int
+cpm_get_mclk(void)
+{
+	unsigned int mclk;
+	int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32};
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	unsigned long plcr = readl(cpm_base + CPM_PLCR1);
+	if (plcr & CPM_PLCR1_PLL1EN)
+		mclk = cpm_get_pllout() /
+		       div[(cfcr & CPM_CFCR_MFR_MASK) >> CPM_CFCR_MFR_BIT];
+	else
+		mclk = jz_clocks.extal;
+	return mclk;
+}
+
+static __inline__ unsigned int
+cpm_get_pclk(void)
+{
+	unsigned int devclk;
+	int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32};
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	unsigned long plcr = readl(cpm_base + CPM_PLCR1);
+	if (plcr & CPM_PLCR1_PLL1EN)
+		devclk = cpm_get_pllout() /
+			 div[(cfcr & CPM_CFCR_PFR_MASK) >> CPM_CFCR_PFR_BIT];
+	else
+		devclk = jz_clocks.extal;
+	return devclk;
+}
+
+static __inline__ unsigned int
+cpm_get_lcdclk(void)
+{
+	unsigned int lcdclk;
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	unsigned long plcr = readl(cpm_base + CPM_PLCR1);
+	if (plcr & CPM_PLCR1_PLL1EN)
+		lcdclk = cpm_get_pllout() /
+			(((cfcr & CPM_CFCR_LFR_MASK) >> CPM_CFCR_LFR_BIT) + 1);
+	else
+		lcdclk = jz_clocks.extal;
+	return lcdclk;
+}
+
+static __inline__ unsigned int
+cpm_get_pixclk(void)
+{
+	unsigned int pixclk;
+	unsigned long cfcr2 = readl(cpm_base + CPM_CFCR2);
+	pixclk = cpm_get_pllout() / (cfcr2 + 1);
+	return pixclk;
+}
+
+static __inline__ unsigned int
+cpm_get_devclk(void)
+{
+	return jz_clocks.extal;
+}
+
+static __inline__ unsigned int
+cpm_get_rtcclk(void)
+{
+	return jz_clocks.extal2;
+}
+
+static __inline__ unsigned int
+cpm_get_uartclk(void)
+{
+	return jz_clocks.extal;
+}
+
+static __inline__ unsigned int
+cpm_get_usbclk(void)
+{
+	unsigned int usbclk;
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	if (cfcr & CPM_CFCR_UCS)
+		usbclk = 48000000;
+	else
+		usbclk = cpm_get_pllout() /
+			(((cfcr &CPM_CFCR_UFR_MASK) >> CPM_CFCR_UFR_BIT) + 1);
+	return usbclk;
+}
+
+static __inline__ unsigned int
+cpm_get_i2sclk(void)
+{
+	unsigned int i2sclk;
+	unsigned long cfcr = readl(cpm_base + CPM_CFCR);
+	i2sclk = cpm_get_pllout() /
+		((cfcr & CPM_CFCR_I2S) ? 2: 1);
+	return i2sclk;
+}
+
+static __inline__ unsigned int
+cpm_get_mscclk(void)
+{
+	if (readl(cpm_base + CPM_CFCR) & CPM_CFCR_MSC)
+		return 24000000;
+	else
+		return 16000000;
+}
+
+
+void
+jz_cpm_set_usbclk(int external)
+{
+	u32 cfcr = readl(cpm_base + CPM_CFCR);
+
+	if (external)
+		cfcr |= CPM_CFCR_UCS;
+	else
+		cfcr &= ~CPM_CFCR_UCS;
+
+	writel(cfcr, cpm_base + CPM_CFCR);
+
+	jz_clocks.usbclk = cpm_get_usbclk();
+}
+
+void __init
+jz_cpm_setup(void)
+{
+	u32 lcr, cfcr;
+
+	cpm_base = ioremap_nocache(CPM_BASE, 0xfff);
+	if (cpm_base == NULL) {
+		panic(KERN_ERR "Couldn't map CPM_BASE(0x%x)\n", CPM_BASE);
+	}
+
+	/* Enter idle mode when sleep instruction is executed. */
+	lcr = readl(cpm_base + CPM_LPCR) & ~CPM_LPCR_LPM_MASK;
+	lcr |= CPM_LPCR_LPM_IDLE;
+	writel(lcr, cpm_base + CPM_LPCR);
+
+	/* Enable SDRAM clock. */
+	cfcr = readl(cpm_base + CPM_CFCR) | CPM_CFCR_CKOEN1;
+	writel(cfcr, cpm_base + CPM_CFCR);
+
+	/* Enable all clocks. */
+	writel(0, cpm_base + CPM_MSCR);
+
+	/* Fill in jz_extal, jz_extal2. */
+	jz_board_get_extal(&jz_clocks);
+
+	jz_clocks.iclk = cpm_get_iclk();
+	jz_clocks.sclk = cpm_get_sclk();
+	jz_clocks.mclk = cpm_get_mclk();
+	jz_clocks.pclk = cpm_get_pclk();
+	jz_clocks.devclk = cpm_get_devclk();
+	jz_clocks.rtcclk = cpm_get_rtcclk();
+	jz_clocks.uartclk = cpm_get_uartclk();
+	jz_clocks.lcdclk = cpm_get_lcdclk();
+	jz_clocks.pixclk = cpm_get_pixclk();
+	jz_clocks.usbclk = cpm_get_usbclk();
+	jz_clocks.i2sclk = cpm_get_i2sclk();
+	jz_clocks.mscclk = cpm_get_mscclk();
+
+	printk("CPU clock: %dMHz, System clock: %dMHz, Memory clock: %dMHz, Peripheral clock: %dMHz\n",
+		(jz_clocks.iclk + 500000) / 1000000,
+		(jz_clocks.sclk + 500000) / 1000000,
+		(jz_clocks.mclk + 500000) / 1000000,
+		(jz_clocks.pclk + 500000) / 1000000);
+}
diff --git a/arch/mips/xburst/jz4730/irq.c b/arch/mips/xburst/jz4730/irq.c
new file mode 100644
index 0000000..7e12e69
--- /dev/null
+++ b/arch/mips/xburst/jz4730/irq.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *
+ * Copyright (c) 2006-2007  Ingenic Semiconductor Inc.
+ * Author: <jlwei@ingenic.cn>
+ *
+ * This program is free software; you can redistribute	 it and/or modify it
+ * under  the terms of	 the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the	License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/irq_cpu.h>
+#include <asm/system.h>
+#include <xburst.h>
+
+#define	INTC_BASE	0x10001000
+
+#define INTC_ISR	0x00
+#define INTC_IMR	0x04
+#define INTC_IMSR	0x08
+#define INTC_IMCR	0x0c
+#define INTC_IPR	0x10
+
+static void __iomem *intc_base;
+
+static void
+mask_intc_irq(unsigned int irq)
+{
+	writel(1<<irq, intc_base + INTC_IMSR);
+}
+
+static void
+unmask_intc_irq(unsigned int irq)
+{
+	writel(1<<irq, intc_base + INTC_IMCR);
+}
+
+static void
+ack_intc_irq(unsigned int irq)
+{
+	writel(1<<irq, intc_base + INTC_IPR);
+}
+
+static void
+end_intc_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
+		unmask_intc_irq(irq);
+	}
+}
+
+static struct irq_chip intc_irq_type = {
+	.name = "INTC",
+	.mask = mask_intc_irq,
+	.unmask = unmask_intc_irq,
+	.ack = ack_intc_irq,
+	.end = end_intc_irq,
+};
+
+asmlinkage void
+plat_irq_dispatch(void)
+{
+	int irq;
+	static u32 pending = 0;
+
+	pending |= readl(intc_base + INTC_IPR);
+
+	if (!pending)
+		return;
+
+	irq = ffs(pending) - 1;
+	pending &= ~(1<<irq);
+
+	switch (irq) {
+		case IRQ_GPIO0:
+		case IRQ_GPIO1:
+		case IRQ_GPIO2:
+		case IRQ_GPIO3:
+		case IRQ_DMAC:
+			/* unhandled for now */
+			printk(KERN_WARNING "%s: %d unhandled\n", __FUNCTION__,
+					irq);
+			return;
+	}
+
+	generic_handle_irq(irq);
+}
+
+void __init
+arch_init_irq(void)
+{
+	int i;
+
+	intc_base = ioremap_nocache(INTC_BASE, 0xfff);
+
+	for (i=0; i<32; i++) {
+		mask_intc_irq(i);
+		set_irq_chip_and_handler(i, &intc_irq_type, handle_level_irq);
+	}
+}
+
diff --git a/arch/mips/xburst/jz4730/platform.c b/arch/mips/xburst/jz4730/platform.c
new file mode 100644
index 0000000..cff660a
--- /dev/null
+++ b/arch/mips/xburst/jz4730/platform.c
@@ -0,0 +1,49 @@
+/*
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <xburst.h>
+
+#define	ETH_BASE	0x13100000
+
+static struct resource jz_eth_resources[] = {
+	[0] = {
+		.start	= ETH_BASE,
+		.end	= ETH_BASE + 0xffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_ETH,
+		.end	= IRQ_ETH,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 jz_eth_dmamask = ~(u32)0;
+
+static struct platform_device jz_eth_device = {
+	.name	= "jz-eth",
+	.id	= 0,
+	.dev = {
+		.dma_mask		= &jz_eth_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(jz_eth_resources),
+	.resource	= jz_eth_resources,
+};
+
+static struct platform_device *jz4730_devices[] __initdata = {
+	&jz_eth_device,
+};
+
+static int __init
+jz4730_platform_init(void)
+{
+	return platform_add_devices(jz4730_devices, ARRAY_SIZE(jz4730_devices));
+}
+
+arch_initcall(jz4730_platform_init);
diff --git a/arch/mips/xburst/jz4730/prom.c b/arch/mips/xburst/jz4730/prom.c
new file mode 100644
index 0000000..60c46bc
--- /dev/null
+++ b/arch/mips/xburst/jz4730/prom.c
@@ -0,0 +1,104 @@
+/*
+ *
+ * BRIEF MODULE DESCRIPTION
+ *    PROM library initialisation code, supports YAMON and U-Boot.
+ *
+ * Copyright 2000, 2001, 2006 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *         	ppopov@mvista.com or source@mvista.com
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
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <xburst.h>
+
+int prom_argc;
+char **prom_argv, **prom_envp;
+
+char *prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+void prom_init_cmdline(void)
+{
+	char *cp;
+	int actr;
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
+	if (prom_argc > 1)
+		*cp = '\0';
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void __init prom_init(void)
+{
+	prom_argc = (int) fw_arg0;
+	prom_argv = (char **) fw_arg1;
+	prom_envp = (char **) fw_arg2;
+
+	mips_machtype = MACH_XBURST_JZ4730;
+
+	prom_init_cmdline();
+	add_memory_region(0, 0x04000000, BOOT_MEM_RAM);
+}
+
+/* used by early printk */
+void prom_putchar(char c)
+{
+	volatile u8 *uart_lsr = (volatile u8 *)(UART3_BASE + OFF_LSR);
+	volatile u8 *uart_tdr = (volatile u8 *)(UART3_BASE + OFF_TDR);
+
+	/* Wait for fifo to shift out some bytes */
+	while ( !((*uart_lsr & (UARTLSR_TDRQ | UARTLSR_TEMT)) == 0x60) );
+
+	*uart_tdr = (u8)c;
+}
+
+const char *get_system_type(void)
+{
+        return "JZ4730";
+}
diff --git a/arch/mips/xburst/jz4730/setup.c b/arch/mips/xburst/jz4730/setup.c
new file mode 100644
index 0000000..777ac27
--- /dev/null
+++ b/arch/mips/xburst/jz4730/setup.c
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2010 Ubiq Technologies <graham.gower@gmail.com>
+ *
+ * Copyright (C) 2006-2007  Ingenic Semiconductor Inc.
+ * Author: <jlwei@ingenic.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <asm/mips-boards/prom.h>
+#include <xburst.h>
+
+extern void __init jz_board_setup(void);
+extern void __init jz_cpm_setup(void);
+
+/* System Bus Arbiter control*/
+#define	SBA_CNTL	0x13000000
+void __iomem *sba_cntl;
+
+#define	DMAC_BASE	0x13020000
+#define DMAC_DMACR	0xfc
+#define DMAC_DMACR_PR_BIT	8
+#define DMAC_DMACR_PR_MASK	(0x03 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_01234567	(0 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_02314675	(1 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_20136457	(2 << DMAC_DMACR_PR_BIT)
+  #define DMAC_DMACR_PR_ROUNDROBIN	(3 << DMAC_DMACR_PR_BIT)
+#define DMAC_DMACR_HTR		(1 << 3)
+#define DMAC_DMACR_AER		(1 << 2)
+#define DMAC_DMACR_DME		(1 << 0)
+
+
+static void __init
+jz_serial_setup(void)
+{
+#ifdef CONFIG_SERIAL_8250
+	struct uart_port s;
+
+	memset(&s, 0, sizeof(s));
+
+	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	s.iotype = UPIO_MEM;
+	s.regshift = 2;
+	s.uartclk = jz_clocks.uartclk;
+
+	s.line = 0;
+	s.membase = (u8 *)UART0_BASE;
+	s.irq = IRQ_UART0;
+	if (early_serial_setup(&s) != 0) {
+		printk(KERN_ERR "Serial ttyS0 setup failed!\n");
+	}
+
+	s.line = 1;
+	s.membase = (u8 *)UART1_BASE;
+	s.irq = IRQ_UART1;
+	if (early_serial_setup(&s) != 0) {
+		printk(KERN_ERR "Serial ttyS1 setup failed!\n");
+	}
+
+	s.line = 2;
+	s.membase = (u8 *)UART2_BASE;
+	s.irq = IRQ_UART2;
+	if (early_serial_setup(&s) != 0) {
+		printk(KERN_ERR "Serial ttyS2 setup failed!\n");
+	}
+
+	s.line = 3;
+	s.membase = (u8 *)UART3_BASE;
+	s.irq = IRQ_UART3;
+	if (early_serial_setup(&s) != 0) {
+		printk(KERN_ERR "Serial ttyS3 setup failed!\n");
+	}
+#endif
+}
+
+static void __init
+jz_dma_setup(void)
+{
+	void __iomem *dmac_base;
+	u32 dmacr;
+
+	dmac_base = ioremap_nocache(DMAC_BASE, 0xffff);
+	if (dmac_base == NULL) {
+		panic(KERN_ERR "Couldn't map DMAC_BASE(0x%x)\n", DMAC_BASE);
+	}
+
+	/* Set DMA priority and enable all channels. */
+	dmacr = readl(dmac_base + DMAC_DMACR);
+	dmacr |= DMAC_DMACR_DME | DMAC_DMACR_PR_ROUNDROBIN;
+	writel(dmacr, dmac_base + DMAC_DMACR);
+
+}
+
+void
+jz_usb0_set_function(int host)
+{
+	u32 sba = readl(sba_cntl);
+
+	if (host)
+		sba |= (1<<7);
+	else /* device */
+		sba &= ~(1<<7);
+
+	writel(sba, sba_cntl);
+}
+
+void __init
+plat_mem_setup(void)
+{
+	/* IO/MEM resources. */
+	set_io_port_base(0);
+	ioport_resource.start = 0x00000000;
+	ioport_resource.end = 0xffffffff;
+	iomem_resource.start = 0x00000000;
+	iomem_resource.end = 0xffffffff;
+
+	jz_cpm_setup();
+
+	sba_cntl = ioremap_nocache(SBA_CNTL, 0xffff);
+	if (sba_cntl == NULL) {
+		panic(KERN_ERR "Couldn't map SBA_CNTL(0x%x)\n", SBA_CNTL);
+	}
+
+	/* Set bus priority: DMAC > LCD > CIM > ETH > USB > CIM */
+	writel((readl(sba_cntl) & 0xfffffff0) | 0x08, sba_cntl);
+
+	jz_serial_setup();
+	jz_dma_setup();
+	jz_board_setup();
+}
diff --git a/arch/mips/xburst/jz4730/time.c b/arch/mips/xburst/jz4730/time.c
new file mode 100644
index 0000000..c3bd06a
--- /dev/null
+++ b/arch/mips/xburst/jz4730/time.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2010 Ubiq Technologies. <graham.gower@gmail.com>
+ *
+ * Copyright (c) 2006-2008  Ingenic Semiconductor Inc.
+ * Author: <jlwei@ingenic.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/clockchips.h>
+
+#include <xburst.h>
+
+#define	OST_BASE	0x10002000
+#define OST_TER		0x00	/* 8bit reg */
+#define OST_TRDR0	0x10
+#define OST_TCNT0	0x14
+#define OST_TCSR0	0x18	/* 16bit reg */
+#define OST_TCRB0	0x1c
+
+#define OST_TCSR_BUSY		(1 << 7)
+#define OST_TCSR_UF		(1 << 6)
+#define OST_TCSR_UIE		(1 << 5)
+#define OST_TCSR_CKS_BIT	0
+#define OST_TCSR_CKS_MASK	(0x07 << OST_TCSR_CKS_BIT)
+  #define OST_TCSR_CKS_PCLK_4	(0 << OST_TCSR_CKS_BIT)
+  #define OST_TCSR_CKS_PCLK_16	(1 << OST_TCSR_CKS_BIT)
+  #define OST_TCSR_CKS_PCLK_64	(2 << OST_TCSR_CKS_BIT)
+  #define OST_TCSR_CKS_PCLK_256	(3 << OST_TCSR_CKS_BIT)
+  #define OST_TCSR_CKS_RTCCLK	(4 << OST_TCSR_CKS_BIT)
+  #define OST_TCSR_CKS_EXTAL	(5 << OST_TCSR_CKS_BIT)
+
+static void __iomem *ost_base;
+static u32 timer_max;
+
+static cycle_t
+jz_get_cycles(struct clocksource *cs)
+{
+	u32 cnt;
+
+	cnt = readl(ost_base + OST_TCNT0);
+
+	/* Wait for clock sync. */
+	while ((readw(ost_base + OST_TCSR0) & OST_TCSR_BUSY))
+		;
+
+	cnt = readl(ost_base + OST_TCRB0);
+
+	return jiffies*(jz_clocks.extal/HZ) + (timer_max - cnt);
+}
+
+static void
+jz_set_mode(enum clock_event_mode mode,
+		struct clock_event_device *evt)
+{
+}
+
+static irqreturn_t
+jz_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = dev_id;
+	u16 tcsr0;
+
+	/* ACK timer */
+	tcsr0 = readw(ost_base + OST_TCSR0);
+	tcsr0 &= ~OST_TCSR_UF;
+	writew(tcsr0, ost_base + OST_TCSR0);
+
+	cd->event_handler(cd);
+	return IRQ_HANDLED;
+}
+
+static struct clocksource jz_clocksource = {
+	.name	= "jz4730-ost0",
+	.rating	= 300,
+	.read	= jz_get_cycles,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.shift	= 10,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static struct clock_event_device jz_clockevent_device = {
+	.name		= "jz4730-ckevent-ost0",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.rating		= 300,
+	.irq		= IRQ_OST0,
+	.set_mode	= jz_set_mode,
+};
+
+static struct irqaction jz_irqaction = {
+	.name		= "jz4730-irq-ost0",
+	.handler	= jz_timer_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
+};
+
+void __init
+plat_time_init(void)
+{
+	ost_base = ioremap_nocache(OST_BASE, 0xfff);
+	if (ost_base == NULL) {
+		panic(KERN_ERR "Couldn't map OST_BASE(0x%x)\n", OST_BASE);
+	}
+
+	jz_clockevent_device.cpumask = cpumask_of(0);
+	clockevents_register_device(&jz_clockevent_device);
+
+	jz_irqaction.dev_id = &jz_clockevent_device;
+	setup_irq(IRQ_OST0, &jz_irqaction);
+
+	jz_clocksource.mult = clocksource_hz2mult(jz_clocks.extal,
+					jz_clocksource.shift);
+	clocksource_register(&jz_clocksource);
+
+	timer_max = (jz_clocks.extal + (HZ>>1)) / HZ;
+
+	/* Disable timers. */
+	writeb(0, ost_base + OST_TER);
+
+	/* Use extal as the clock source, interrupt when timer 0 underflows. */
+	writew(OST_TCSR_CKS_EXTAL|OST_TCSR_UIE, ost_base + OST_TCSR0);
+
+	/* Set timer 0's reset value upon underflow. */
+	writel(timer_max, ost_base + OST_TRDR0);
+
+	/* Set timer 0's initial value. */
+	writel(timer_max, ost_base + OST_TCNT0);
+
+	/* Wait for clock sync. */
+	while ((readw(ost_base + OST_TCSR0) & OST_TCSR_BUSY))
+		;
+
+	/* Enable timer 0.*/
+	writeb(0x1, ost_base + OST_TER);
+
+}
-- 
1.6.4
