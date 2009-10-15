Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 18:49:36 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.144]:28226 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492837AbZJOQta (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 18:49:30 +0200
Received: by ey-out-1920.google.com with SMTP id 13so224164eye.52
        for <multiple recipients>; Thu, 15 Oct 2009 09:49:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+XL8qFs5c52Y42gaf0oFhK53jsO4AVedL/2bR5aTVaE=;
        b=CXw52X769ZCdS5nHj/nA0Rr730B2HgMpFARyMMRpYUwd54qm3rzKXl5UpV9SrYDTsj
         pmBGBqVQYCiLjIdlhfqJSBNGlzxgsBMp/AtwqTy/yCOQtxbtse0PVPuPdqgzXQN7mC7J
         /j3sJEvherfshdEFBPFCdXMcf7es1sEnso5Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=e/Tf8N5Xfvjz32vRUFb998KL25mPY/iTYlRbqZg+qL4wC6BYSFJDXj1OhA7OXmqTUN
         U/XWQiTIgDMLXpVDr+nbEwawLqh79SuiigRtieVbXm7FxuXV4lrmLuGBG+ymICtgjIZP
         d9pEY6t5aiv/Xha3oCVR6XC/bUgQi0SNh4F+k=
Received: by 10.216.89.76 with SMTP id b54mr83845wef.105.1255625369672;
        Thu, 15 Oct 2009 09:49:29 -0700 (PDT)
Received: from localhost.localdomain (p5496E392.dip.t-dialin.net [84.150.227.146])
        by mx.google.com with ESMTPS id i6sm560209gve.17.2009.10.15.09.49.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 09:49:28 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: prom_putchar is board dependent
Date:	Thu, 15 Oct 2009 18:49:27 +0200
Message-Id: <1255625367-3150-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This patch replaces the general alchemy prom_putchar() implementation
in favor of board-specific versions:  The UART where the output of
prom_putchar is directed to really depends on the board, the current
implementation hardcodes this on a per-SoC basis which is just wrong.

So a generic uart tx function is provided in the alchemy headers,
and the boards can provide their own prom_putchar with custom
destination uart, and all in-kernel alchemy boards support
early printk.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
I kept the original implementation of prom_putchar with all the
slowdowns, I don't know why it was there, probably to fix issues
in the early socs.

Boots fine on the DB1200.

 arch/mips/alchemy/Kconfig                  |   14 ++++++
 arch/mips/alchemy/common/Makefile          |    2 +-
 arch/mips/alchemy/common/puts.c            |   68 ----------------------------
 arch/mips/alchemy/devboards/prom.c         |    5 ++
 arch/mips/alchemy/mtx-1/init.c             |    6 +++
 arch/mips/alchemy/xxs1500/init.c           |    6 +++
 arch/mips/include/asm/mach-au1x00/au1000.h |   19 ++++++++
 7 files changed, 51 insertions(+), 69 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/puts.c

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 00b498e..22f4ff5 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -20,12 +20,14 @@ config MIPS_MTX1
 	select HW_HAS_PCI
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_BOSPORUS
 	bool "Alchemy Bosporus board"
 	select SOC_AU1500
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1000
 	bool "Alchemy DB1000 board"
@@ -33,12 +35,14 @@ config MIPS_DB1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1100
 	bool "Alchemy DB1100 board"
 	select SOC_AU1100
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1200
 	bool "Alchemy DB1200 board"
@@ -46,6 +50,7 @@ config MIPS_DB1200
 	select DMA_COHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1500
 	bool "Alchemy DB1500 board"
@@ -55,6 +60,7 @@ config MIPS_DB1500
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1550
 	bool "Alchemy DB1550 board"
@@ -63,12 +69,14 @@ config MIPS_DB1550
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_MIRAGE
 	bool "Alchemy Mirage board"
 	select DMA_NONCOHERENT
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_PB1000
 	bool "Alchemy PB1000 board"
@@ -77,6 +85,7 @@ config MIPS_PB1000
 	select HW_HAS_PCI
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_PB1100
 	bool "Alchemy PB1100 board"
@@ -85,6 +94,7 @@ config MIPS_PB1100
 	select HW_HAS_PCI
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_PB1200
 	bool "Alchemy PB1200 board"
@@ -92,6 +102,7 @@ config MIPS_PB1200
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_PB1500
 	bool "Alchemy PB1500 board"
@@ -99,6 +110,7 @@ config MIPS_PB1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_PB1550
 	bool "Alchemy PB1550 board"
@@ -107,12 +119,14 @@ config MIPS_PB1550
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_XXS1500
 	bool "MyCable XXS1500 board"
 	select DMA_NONCOHERENT
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
 
 endchoice
 
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index b67fb51..abf0eb1 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -5,7 +5,7 @@
 # Makefile for the Alchemy Au1xx0 CPUs, generic files.
 #
 
-obj-y += prom.o irq.o puts.o time.o reset.o \
+obj-y += prom.o irq.o time.o reset.o \
 	clocks.o platform.o power.o setup.o \
 	sleeper.o dma.o dbdma.o
 
diff --git a/arch/mips/alchemy/common/puts.c b/arch/mips/alchemy/common/puts.c
deleted file mode 100644
index 55bbe24..0000000
--- a/arch/mips/alchemy/common/puts.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Low level UART routines to directly access Alchemy UART.
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
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
-#include <asm/mach-au1x00/au1000.h>
-
-#define SERIAL_BASE   UART_BASE
-#define SER_CMD       0x7
-#define SER_DATA      0x1
-#define TX_BUSY       0x20
-
-#define TIMEOUT       0xffffff
-#define SLOW_DOWN
-
-static volatile unsigned long * const com1 = (unsigned long *)SERIAL_BASE;
-
-#ifdef SLOW_DOWN
-static inline void slow_down(void)
-{
-	int k;
-
-	for (k = 0; k < 10000; k++);
-}
-#else
-#define slow_down()
-#endif
-
-void
-prom_putchar(const unsigned char c)
-{
-	unsigned char ch;
-	int i = 0;
-
-	do {
-		ch = com1[SER_CMD];
-		slow_down();
-		i++;
-		if (i > TIMEOUT)
-			break;
-	} while (0 == (ch & TX_BUSY));
-
-	com1[SER_DATA] = c;
-}
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 0042bd6..b30df5c 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -60,3 +60,8 @@ void __init prom_init(void)
 		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
+
+void prom_putchar(unsigned char c)
+{
+    alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+}
diff --git a/arch/mips/alchemy/mtx-1/init.c b/arch/mips/alchemy/mtx-1/init.c
index 5e871c8..f8d2557 100644
--- a/arch/mips/alchemy/mtx-1/init.c
+++ b/arch/mips/alchemy/mtx-1/init.c
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 
 #include <asm/bootinfo.h>
+#include <asm/mach-au1x00/au1000.h>
 
 #include <prom.h>
 
@@ -58,3 +59,8 @@ void __init prom_init(void)
 		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
+
+void prom_putchar(unsigned char c)
+{
+	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+}
diff --git a/arch/mips/alchemy/xxs1500/init.c b/arch/mips/alchemy/xxs1500/init.c
index 456fa14..15125c2 100644
--- a/arch/mips/alchemy/xxs1500/init.c
+++ b/arch/mips/alchemy/xxs1500/init.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 
 #include <asm/bootinfo.h>
+#include <asm/mach-au1x00/au1000.h>
 
 #include <prom.h>
 
@@ -56,3 +57,8 @@ void __init prom_init(void)
 		strict_strtoul(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
+
+void prom_putchar(unsigned char c)
+{
+	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+}
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 16ea5ad..4918e64 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -160,6 +160,25 @@ static inline int alchemy_get_cputype(void)
 	return ALCHEMY_CPU_UNKNOWN;
 }
 
+static inline void alchemy_uart_putchar(u32 uart_phys, u8 c)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(uart_phys);
+	int timeout, i;
+
+	/* check LSR TX_EMPTY bit */
+	timeout = 0xffffff;
+	do {
+		if (__raw_readl(base + 0x1c) & 0x20)
+			break;
+		/* slow down */
+		for (i = 10000; i; i--)
+			asm volatile ("nop");
+	} while (--timeout);
+
+	__raw_writel(c, base + 0x04);	/* tx */
+	wmb();
+}
+
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
-- 
1.6.5.rc2
