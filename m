Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:28:49 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:6890 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22774247AbYLUI0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:30 +0000
Received: (qmail 3954 invoked from network); 21 Dec 2008 09:24:58 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:58 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 04/14] Alchemy: update core interrupt code.
Date:	Sun, 21 Dec 2008 09:26:17 +0100
Message-Id: <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

This patch attempts to modernize core Alchemy interrupt handling code.

- add irq_chips for irq controllers instead of irq type,
- add a set_type() hook to change irq trigger type during runtime,
- add a set_wake() hook to control GPIO0..7 based wakeup,
- use linux' IRQF_TRIGGER_ constants instead of homebrew ones,
- enable GENERIC_HARDIRQS_NO__DO_IRQ.
- simplify plat_irq_dispatch
- merge au1xxx_irqmap into irq.c file, the only place where its
  contents are referenced.
- board_init_irq() is now mandatory for every board; use it to register
  the remaining (gpio-based) interrupt sources; update all boards
  accordingly.

Run-tested on Db1200 and other Au1200 based platforms.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/Kconfig                        |    1 +
 arch/mips/alchemy/common/Makefile                |    2 +-
 arch/mips/alchemy/common/au1xxx_irqmap.c         |  205 ------
 arch/mips/alchemy/common/irq.c                   |  785 ++++++++++++----------
 arch/mips/alchemy/common/power.c                 |    6 +-
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   24 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c |    9 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |   16 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    5 -
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |    7 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   18 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   13 +-
 arch/mips/alchemy/mtx-1/irqmap.c                 |   18 +-
 arch/mips/alchemy/xxs1500/irqmap.c               |   31 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |   18 +-
 15 files changed, 514 insertions(+), 644 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/au1xxx_irqmap.c

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index e4a057d..4397d94 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -134,3 +134,4 @@ config SOC_AU1X00
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
+	select GENERIC_HARDIRQS_NO__DO_IRQ
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index df48fd6..28b8aeb 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
-	au1xxx_irqmap.o clocks.o platform.o power.o setup.o \
+	clocks.o platform.o power.o setup.o \
 	sleeper.o cputable.o dma.o dbdma.o gpio.o
 
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/mips/alchemy/common/au1xxx_irqmap.c b/arch/mips/alchemy/common/au1xxx_irqmap.c
deleted file mode 100644
index c7ca159..0000000
--- a/arch/mips/alchemy/common/au1xxx_irqmap.c
+++ /dev/null
@@ -1,205 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx processor specific IRQ tables
- *
- * Copyright 2004 Embedded Edge, LLC
- *	dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <au1000.h>
-
-/* The IC0 interrupt table.  This is processor, rather than
- * board dependent, so no reason to keep this info in the board
- * dependent files.
- *
- * Careful if you change match 2 request!
- * The interrupt handler is called directly from the low level dispatch code.
- */
-struct au1xxx_irqmap __initdata au1xxx_ic0_map[] = {
-
-#if defined(CONFIG_SOC_AU1000)
-	{ AU1000_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_UART2_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_SSI0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_SSI1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH2_INT, INTC_INT_RISE_EDGE, 1 },
-	{ AU1000_RTC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_IRDA_TX_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_IRDA_RX_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
-
-#elif defined(CONFIG_SOC_AU1500)
-
-	{ AU1500_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_PCI_INTA, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_PCI_INTB, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_PCI_INTC, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_PCI_INTD, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH2_INT, INTC_INT_RISE_EDGE, 1 },
-	{ AU1000_RTC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1500_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1500_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
-
-#elif defined(CONFIG_SOC_AU1100)
-
-	{ AU1100_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1100_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1100_SD_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1100_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_SSI0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_SSI1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+1, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+2, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+3, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+4, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+5, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+6, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_DMA_INT_BASE+7, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH2_INT, INTC_INT_RISE_EDGE, 1 },
-	{ AU1000_RTC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_IRDA_TX_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_IRDA_RX_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1100_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	/* { AU1000_GPIO215_208_INT, INTC_INT_HIGH_LEVEL, 0 }, */
-	{ AU1100_LCD_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
-
-#elif defined(CONFIG_SOC_AU1550)
-
-	{ AU1550_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_PCI_INTA, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_PCI_INTB, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_DDMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_CRYPTO_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_PCI_INTC, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_PCI_INTD, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_PCI_RST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_UART3_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_PSC0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_PSC1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_PSC2_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_PSC3_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH2_INT, INTC_INT_RISE_EDGE, 1 },
-	{ AU1000_RTC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1550_NAND_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1550_USB_DEV_REQ_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1550_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1550_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1550_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-
-#elif defined(CONFIG_SOC_AU1200)
-
-	{ AU1200_UART0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_SWT_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1200_SD_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_DDMA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_MAE_BE_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_UART1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_MAE_FE_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_PSC0_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_PSC1_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_AES_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_CAMERA_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1000_TOY_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_TOY_MATCH2_INT, INTC_INT_RISE_EDGE, 1 },
-	{ AU1000_RTC_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH0_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH1_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1000_RTC_MATCH2_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1200_NAND_INT, INTC_INT_RISE_EDGE, 0 },
-	{ AU1200_USB_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_LCD_INT, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1200_MAE_BOTH_INT, INTC_INT_HIGH_LEVEL, 0 },
-
-#else
-#error "Error: Unknown Alchemy SOC"
-#endif
-
-};
-
-int __initdata au1xxx_ic0_nr_irqs = ARRAY_SIZE(au1xxx_ic0_map);
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 40c6cec..c543847 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -24,6 +24,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -36,15 +37,174 @@
 #include <asm/mach-pb1x00/pb1000.h>
 #endif
 
-#define EXT_INTC0_REQ0 2 /* IP 2 */
-#define EXT_INTC0_REQ1 3 /* IP 3 */
-#define EXT_INTC1_REQ0 4 /* IP 4 */
-#define EXT_INTC1_REQ1 5 /* IP 5 */
-#define MIPS_TIMER_IP  7 /* IP 7 */
+static DEFINE_SPINLOCK(irq_lock);
 
-void (*board_init_irq)(void) __initdata = NULL;
+static int au1x_ic_settype(unsigned int irq, unsigned int flow_type);
+
+/* per-processor fixed function irqs */
+struct au1xxx_irqmap au1xxx_ic0_map[] __initdata = {
+
+#if defined(CONFIG_SOC_AU1000)
+	{ AU1000_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_UART2_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_SSI0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_SSI1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+1, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+2, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+3, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+4, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+5, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+6, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+7, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_MAC1_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_AC97C_INT, IRQ_TYPE_EDGE_RISING, 0 },
+
+#elif defined(CONFIG_SOC_AU1500)
+
+	{ AU1500_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_PCI_INTA, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1000_PCI_INTB, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1500_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_PCI_INTC, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1000_PCI_INTD, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1000_DMA_INT_BASE, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+1, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+2, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+3, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+4, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+5, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+6, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+7, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1500_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1500_MAC1_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_AC97C_INT, IRQ_TYPE_EDGE_RISING, 0 },
+
+#elif defined(CONFIG_SOC_AU1100)
+
+	{ AU1100_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1100_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1100_SD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1100_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_SSI0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_SSI1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+1, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+2, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+3, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+4, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+5, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+6, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_DMA_INT_BASE+7, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1100_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1100_LCD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_AC97C_INT, IRQ_TYPE_EDGE_RISING, 0 },
+
+#elif defined(CONFIG_SOC_AU1550)
+
+	{ AU1550_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_PCI_INTA, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1550_PCI_INTB, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1550_DDMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_CRYPTO_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_PCI_INTC, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1550_PCI_INTD, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1550_PCI_RST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1550_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_UART3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_PSC0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_PSC1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_PSC2_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_PSC3_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1550_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
+	{ AU1550_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_MAC1_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+
+#elif defined(CONFIG_SOC_AU1200)
+
+	{ AU1200_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_SWT_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_SD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_DDMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_MAE_BE_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_MAE_FE_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_PSC0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_PSC1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_AES_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_CAMERA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1200_USB_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_LCD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1200_MAE_BOTH_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+
+#else
+#error "Error: Unknown Alchemy SOC"
+#endif
+};
 
-static DEFINE_SPINLOCK(irq_lock);
 
 #ifdef CONFIG_PM
 
@@ -130,67 +290,47 @@ void restore_au1xxx_intctl(void)
 #endif /* CONFIG_PM */
 
 
-inline void local_enable_irq(unsigned int irq_nr)
+static void au1x_ic0_unmask(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
-
-	if (bit >= 32) {
-		au_writel(1 << (bit - 32), IC1_MASKSET);
-		au_writel(1 << (bit - 32), IC1_WAKESET);
-	} else {
-		au_writel(1 << bit, IC0_MASKSET);
-		au_writel(1 << bit, IC0_WAKESET);
-	}
+	au_writel(1 << bit, IC0_MASKSET);
+	au_writel(1 << bit, IC0_WAKESET);
 	au_sync();
 }
 
-
-inline void local_disable_irq(unsigned int irq_nr)
+static void au1x_ic1_unmask(unsigned int irq_nr)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	au_writel(1 << bit, IC1_MASKSET);
+	au_writel(1 << bit, IC1_WAKESET);
 
-	if (bit >= 32) {
-		au_writel(1 << (bit - 32), IC1_MASKCLR);
-		au_writel(1 << (bit - 32), IC1_WAKECLR);
-	} else {
-		au_writel(1 << bit, IC0_MASKCLR);
-		au_writel(1 << bit, IC0_WAKECLR);
-	}
+/* very hacky. does the pb1000 cpld auto-disable this int?
+ * nowhere in the current kernel sources is it disabled.	--mlau
+ */
+#if defined(CONFIG_MIPS_PB1000)
+	if (irq_nr == AU1000_GPIO_15)
+		au_writel(0x4000, PB1000_MDR); /* enable int */
+#endif
 	au_sync();
 }
 
-
-static inline void mask_and_ack_rise_edge_irq(unsigned int irq_nr)
+static void au1x_ic0_mask(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
-
-	if (bit >= 32) {
-		au_writel(1 << (bit - 32), IC1_RISINGCLR);
-		au_writel(1 << (bit - 32), IC1_MASKCLR);
-	} else {
-		au_writel(1 << bit, IC0_RISINGCLR);
-		au_writel(1 << bit, IC0_MASKCLR);
-	}
+	au_writel(1 << bit, IC0_MASKCLR);
+	au_writel(1 << bit, IC0_WAKECLR);
 	au_sync();
 }
 
-
-static inline void mask_and_ack_fall_edge_irq(unsigned int irq_nr)
+static void au1x_ic1_mask(unsigned int irq_nr)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
-
-	if (bit >= 32) {
-		au_writel(1 << (bit - 32), IC1_FALLINGCLR);
-		au_writel(1 << (bit - 32), IC1_MASKCLR);
-	} else {
-		au_writel(1 << bit, IC0_FALLINGCLR);
-		au_writel(1 << bit, IC0_MASKCLR);
-	}
+	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	au_writel(1 << bit, IC1_MASKCLR);
+	au_writel(1 << bit, IC1_WAKECLR);
 	au_sync();
 }
 
-
-static inline void mask_and_ack_either_edge_irq(unsigned int irq_nr)
+static void au1x_ic0_ack(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
 
@@ -198,349 +338,229 @@ static inline void mask_and_ack_either_edge_irq(unsigned int irq_nr)
 	 * This may assume that we don't get interrupts from
 	 * both edges at once, or if we do, that we don't care.
 	 */
-	if (bit >= 32) {
-		au_writel(1 << (bit - 32), IC1_FALLINGCLR);
-		au_writel(1 << (bit - 32), IC1_RISINGCLR);
-		au_writel(1 << (bit - 32), IC1_MASKCLR);
-	} else {
-		au_writel(1 << bit, IC0_FALLINGCLR);
-		au_writel(1 << bit, IC0_RISINGCLR);
-		au_writel(1 << bit, IC0_MASKCLR);
-	}
+	au_writel(1 << bit, IC0_FALLINGCLR);
+	au_writel(1 << bit, IC0_RISINGCLR);
 	au_sync();
 }
 
-static inline void mask_and_ack_level_irq(unsigned int irq_nr)
-{
-	local_disable_irq(irq_nr);
-	au_sync();
-#if defined(CONFIG_MIPS_PB1000)
-	if (irq_nr == AU1000_GPIO_15) {
-		au_writel(0x8000, PB1000_MDR); /* ack int */
-		au_sync();
-	}
-#endif
-}
-
-static void end_irq(unsigned int irq_nr)
+static void au1x_ic1_ack(unsigned int irq_nr)
 {
-	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		local_enable_irq(irq_nr);
-
-#if defined(CONFIG_MIPS_PB1000)
-	if (irq_nr == AU1000_GPIO_15) {
-		au_writel(0x4000, PB1000_MDR); /* enable int */
-		au_sync();
-	}
-#endif
-}
-
-unsigned long save_local_and_disable(int controller)
-{
-	int i;
-	unsigned long flags, mask;
-
-	spin_lock_irqsave(&irq_lock, flags);
-	if (controller) {
-		mask = au_readl(IC1_MASKSET);
-		for (i = 32; i < 64; i++)
-			local_disable_irq(i);
-	} else {
-		mask = au_readl(IC0_MASKSET);
-		for (i = 0; i < 32; i++)
-			local_disable_irq(i);
-	}
-	spin_unlock_irqrestore(&irq_lock, flags);
+	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
 
-	return mask;
+	/*
+	 * This may assume that we don't get interrupts from
+	 * both edges at once, or if we do, that we don't care.
+	 */
+	au_writel(1 << bit, IC1_FALLINGCLR);
+	au_writel(1 << bit, IC1_RISINGCLR);
+	au_sync();
 }
 
-void restore_local_and_enable(int controller, unsigned long mask)
+static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
 {
-	int i;
-	unsigned long flags, new_mask;
+	unsigned int bit = irq - AU1000_INTC1_INT_BASE;
+	unsigned long wakemsk, flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
-	for (i = 0; i < 32; i++)
-		if (mask & (1 << i)) {
-			if (controller)
-				local_enable_irq(i + 32);
-			else
-				local_enable_irq(i);
-		}
+	/* only GPIO 0-7 can act as wakeup source: */
+	if ((irq < AU1000_GPIO_0) || (irq > AU1000_GPIO_7))
+		return -EINVAL;
 
-	if (controller)
-		new_mask = au_readl(IC1_MASKSET);
+	local_irq_save(flags);
+	wakemsk = au_readl(SYS_WAKEMSK);
+	if (on)
+		wakemsk |= 1 << bit;
 	else
-		new_mask = au_readl(IC0_MASKSET);
+		wakemsk &= ~(1 << bit);
+	au_writel(wakemsk, SYS_WAKEMSK);
+	au_sync();
+	local_irq_restore(flags);
 
-	spin_unlock_irqrestore(&irq_lock, flags);
+	return 0;
 }
 
-
-static struct irq_chip rise_edge_irq_type = {
-	.name		= "Au1000 Rise Edge",
-	.ack		= mask_and_ack_rise_edge_irq,
-	.mask		= local_disable_irq,
-	.mask_ack	= mask_and_ack_rise_edge_irq,
-	.unmask		= local_enable_irq,
-	.end		= end_irq,
-};
-
-static struct irq_chip fall_edge_irq_type = {
-	.name		= "Au1000 Fall Edge",
-	.ack		= mask_and_ack_fall_edge_irq,
-	.mask		= local_disable_irq,
-	.mask_ack	= mask_and_ack_fall_edge_irq,
-	.unmask		= local_enable_irq,
-	.end		= end_irq,
-};
-
-static struct irq_chip either_edge_irq_type = {
-	.name		= "Au1000 Rise or Fall Edge",
-	.ack		= mask_and_ack_either_edge_irq,
-	.mask		= local_disable_irq,
-	.mask_ack	= mask_and_ack_either_edge_irq,
-	.unmask		= local_enable_irq,
-	.end		= end_irq,
+/*
+ * irq_chips for both ICs; this way the mask handlers can be
+ * as short as possible.
+ *
+ * NOTE: the ->ack() callback is used by the handle_edge_irq
+ *	 flowhandler only, the ->mask_ack() one by handle_level_irq,
+ *	 so no need for an irq_chip for each type of irq (level/edge).
+ */
+static struct irq_chip au1x_ic0_chip = {
+	.name		= "Alchemy-IC0",
+	.ack		= au1x_ic0_ack,		/* edge */
+	.mask		= au1x_ic0_mask,
+	.mask_ack	= au1x_ic0_mask,	/* level */
+	.unmask		= au1x_ic0_unmask,
+	.set_type	= au1x_ic_settype,
 };
 
-static struct irq_chip level_irq_type = {
-	.name		= "Au1000 Level",
-	.ack		= mask_and_ack_level_irq,
-	.mask		= local_disable_irq,
-	.mask_ack	= mask_and_ack_level_irq,
-	.unmask		= local_enable_irq,
-	.end		= end_irq,
+static struct irq_chip au1x_ic1_chip = {
+	.name		= "Alchemy-IC1",
+	.ack		= au1x_ic1_ack,		/* edge */
+	.mask		= au1x_ic1_mask,
+	.mask_ack	= au1x_ic1_mask,	/* level */
+	.unmask		= au1x_ic1_unmask,
+	.set_type	= au1x_ic_settype,
+	.set_wake	= au1x_ic1_setwake,
 };
 
-static void __init setup_local_irq(unsigned int irq_nr, int type, int int_req)
+static int au1x_ic_settype(unsigned int irq, unsigned int flow_type)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
-
-	if (irq_nr > AU1000_MAX_INTR)
-		return;
-
-	/* Config2[n], Config1[n], Config0[n] */
-	if (bit >= 32) {
-		switch (type) {
-		case INTC_INT_RISE_EDGE: /* 0:0:1 */
-			au_writel(1 << (bit - 32), IC1_CFG2CLR);
-			au_writel(1 << (bit - 32), IC1_CFG1CLR);
-			au_writel(1 << (bit - 32), IC1_CFG0SET);
-			set_irq_chip(irq_nr, &rise_edge_irq_type);
-			break;
-		case INTC_INT_FALL_EDGE: /* 0:1:0 */
-			au_writel(1 << (bit - 32), IC1_CFG2CLR);
-			au_writel(1 << (bit - 32), IC1_CFG1SET);
-			au_writel(1 << (bit - 32), IC1_CFG0CLR);
-			set_irq_chip(irq_nr, &fall_edge_irq_type);
-			break;
-		case INTC_INT_RISE_AND_FALL_EDGE: /* 0:1:1 */
-			au_writel(1 << (bit - 32), IC1_CFG2CLR);
-			au_writel(1 << (bit - 32), IC1_CFG1SET);
-			au_writel(1 << (bit - 32), IC1_CFG0SET);
-			set_irq_chip(irq_nr, &either_edge_irq_type);
-			break;
-		case INTC_INT_HIGH_LEVEL: /* 1:0:1 */
-			au_writel(1 << (bit - 32), IC1_CFG2SET);
-			au_writel(1 << (bit - 32), IC1_CFG1CLR);
-			au_writel(1 << (bit - 32), IC1_CFG0SET);
-			set_irq_chip(irq_nr, &level_irq_type);
-			break;
-		case INTC_INT_LOW_LEVEL: /* 1:1:0 */
-			au_writel(1 << (bit - 32), IC1_CFG2SET);
-			au_writel(1 << (bit - 32), IC1_CFG1SET);
-			au_writel(1 << (bit - 32), IC1_CFG0CLR);
-			set_irq_chip(irq_nr, &level_irq_type);
-			break;
-		case INTC_INT_DISABLED: /* 0:0:0 */
-			au_writel(1 << (bit - 32), IC1_CFG0CLR);
-			au_writel(1 << (bit - 32), IC1_CFG1CLR);
-			au_writel(1 << (bit - 32), IC1_CFG2CLR);
-			break;
-		default: /* disable the interrupt */
-			printk(KERN_WARNING "unexpected int type %d (irq %d)\n",
-			       type, irq_nr);
-			au_writel(1 << (bit - 32), IC1_CFG0CLR);
-			au_writel(1 << (bit - 32), IC1_CFG1CLR);
-			au_writel(1 << (bit - 32), IC1_CFG2CLR);
-			return;
-		}
-		if (int_req) /* assign to interrupt request 1 */
-			au_writel(1 << (bit - 32), IC1_ASSIGNCLR);
-		else	     /* assign to interrupt request 0 */
-			au_writel(1 << (bit - 32), IC1_ASSIGNSET);
-		au_writel(1 << (bit - 32), IC1_SRCSET);
-		au_writel(1 << (bit - 32), IC1_MASKCLR);
-		au_writel(1 << (bit - 32), IC1_WAKECLR);
+	struct irq_chip *chip;
+	unsigned long icr[6];
+	unsigned int bit, ic;
+	int ret;
+
+	if (irq >= AU1000_INTC1_INT_BASE) {
+		bit = irq - AU1000_INTC1_INT_BASE;
+		chip = &au1x_ic1_chip;
+		ic = 1;
 	} else {
-		switch (type) {
-		case INTC_INT_RISE_EDGE: /* 0:0:1 */
-			au_writel(1 << bit, IC0_CFG2CLR);
-			au_writel(1 << bit, IC0_CFG1CLR);
-			au_writel(1 << bit, IC0_CFG0SET);
-			set_irq_chip(irq_nr, &rise_edge_irq_type);
-			break;
-		case INTC_INT_FALL_EDGE: /* 0:1:0 */
-			au_writel(1 << bit, IC0_CFG2CLR);
-			au_writel(1 << bit, IC0_CFG1SET);
-			au_writel(1 << bit, IC0_CFG0CLR);
-			set_irq_chip(irq_nr, &fall_edge_irq_type);
-			break;
-		case INTC_INT_RISE_AND_FALL_EDGE: /* 0:1:1 */
-			au_writel(1 << bit, IC0_CFG2CLR);
-			au_writel(1 << bit, IC0_CFG1SET);
-			au_writel(1 << bit, IC0_CFG0SET);
-			set_irq_chip(irq_nr, &either_edge_irq_type);
-			break;
-		case INTC_INT_HIGH_LEVEL: /* 1:0:1 */
-			au_writel(1 << bit, IC0_CFG2SET);
-			au_writel(1 << bit, IC0_CFG1CLR);
-			au_writel(1 << bit, IC0_CFG0SET);
-			set_irq_chip(irq_nr, &level_irq_type);
-			break;
-		case INTC_INT_LOW_LEVEL: /* 1:1:0 */
-			au_writel(1 << bit, IC0_CFG2SET);
-			au_writel(1 << bit, IC0_CFG1SET);
-			au_writel(1 << bit, IC0_CFG0CLR);
-			set_irq_chip(irq_nr, &level_irq_type);
-			break;
-		case INTC_INT_DISABLED: /* 0:0:0 */
-			au_writel(1 << bit, IC0_CFG0CLR);
-			au_writel(1 << bit, IC0_CFG1CLR);
-			au_writel(1 << bit, IC0_CFG2CLR);
-			break;
-		default: /* disable the interrupt */
-			printk(KERN_WARNING "unexpected int type %d (irq %d)\n",
-			       type, irq_nr);
-			au_writel(1 << bit, IC0_CFG0CLR);
-			au_writel(1 << bit, IC0_CFG1CLR);
-			au_writel(1 << bit, IC0_CFG2CLR);
-			return;
-		}
-		if (int_req) /* assign to interrupt request 1 */
-			au_writel(1 << bit, IC0_ASSIGNCLR);
-		else	     /* assign to interrupt request 0 */
-			au_writel(1 << bit, IC0_ASSIGNSET);
-		au_writel(1 << bit, IC0_SRCSET);
-		au_writel(1 << bit, IC0_MASKCLR);
-		au_writel(1 << bit, IC0_WAKECLR);
+		bit = irq - AU1000_INTC0_INT_BASE;
+		chip = &au1x_ic0_chip;
+		ic = 0;
+	}
+
+	if (bit > 31)
+		return -EINVAL;
+
+	icr[0] = ic ? IC1_CFG0SET : IC0_CFG0SET;
+	icr[1] = ic ? IC1_CFG1SET : IC0_CFG1SET;
+	icr[2] = ic ? IC1_CFG2SET : IC0_CFG2SET;
+	icr[3] = ic ? IC1_CFG0CLR : IC0_CFG0CLR;
+	icr[4] = ic ? IC1_CFG1CLR : IC0_CFG1CLR;
+	icr[5] = ic ? IC1_CFG2CLR : IC0_CFG2CLR;
+
+	ret = 0;
+
+	switch (flow_type) {	/* cfgregs 2:1:0 */
+	case IRQ_TYPE_EDGE_RISING:	/* 0:0:1 */
+		au_writel(1 << bit, icr[5]);
+		au_writel(1 << bit, icr[4]);
+		au_writel(1 << bit, icr[0]);
+		set_irq_chip_and_handler_name(irq, chip,
+				handle_edge_irq, "riseedge");
+		break;
+	case IRQ_TYPE_EDGE_FALLING:	/* 0:1:0 */
+		au_writel(1 << bit, icr[5]);
+		au_writel(1 << bit, icr[1]);
+		au_writel(1 << bit, icr[3]);
+		set_irq_chip_and_handler_name(irq, chip,
+				handle_edge_irq, "falledge");
+		break;
+	case IRQ_TYPE_EDGE_BOTH:	/* 0:1:1 */
+		au_writel(1 << bit, icr[5]);
+		au_writel(1 << bit, icr[1]);
+		au_writel(1 << bit, icr[0]);
+		set_irq_chip_and_handler_name(irq, chip,
+				handle_edge_irq, "bothedge");
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:	/* 1:0:1 */
+		au_writel(1 << bit, icr[2]);
+		au_writel(1 << bit, icr[4]);
+		au_writel(1 << bit, icr[0]);
+		set_irq_chip_and_handler_name(irq, chip,
+				handle_level_irq, "hilevel");
+		break;
+	case IRQ_TYPE_LEVEL_LOW:	/* 1:1:0 */
+		au_writel(1 << bit, icr[2]);
+		au_writel(1 << bit, icr[1]);
+		au_writel(1 << bit, icr[3]);
+		set_irq_chip_and_handler_name(irq, chip,
+				handle_level_irq, "lowlevel");
+		break;
+	case IRQ_TYPE_NONE:		/* 0:0:0 */
+		au_writel(1 << bit, icr[5]);
+		au_writel(1 << bit, icr[4]);
+		au_writel(1 << bit, icr[3]);
+		/* set at least chip so we can call set_irq_type() on it */
+		set_irq_chip(irq, chip);
+		break;
+	default:
+		ret = -EINVAL;
 	}
 	au_sync();
-}
 
-/*
- * Interrupts are nested. Even if an interrupt handler is registered
- * as "fast", we might get another interrupt before we return from
- * intcX_reqX_irqdispatch().
- */
+	return ret;
+}
 
-static void intc0_req0_irqdispatch(void)
+asmlinkage void plat_irq_dispatch(void)
 {
-	static unsigned long intc0_req0;
-	unsigned int bit;
-
-	intc0_req0 |= au_readl(IC0_REQ0INT);
+	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned long s, off, bit;
 
-	if (!intc0_req0)
+	if (pending & CAUSEF_IP7) {
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
 		return;
-
+	} else if (pending & CAUSEF_IP2) {
+		s = IC0_REQ0INT;
+		off = AU1000_INTC0_INT_BASE;
+	} else if (pending & CAUSEF_IP3) {
+		s = IC0_REQ1INT;
+		off = AU1000_INTC0_INT_BASE;
+	} else if (pending & CAUSEF_IP4) {
+		s = IC1_REQ0INT;
+		off = AU1000_INTC1_INT_BASE;
+	} else if (pending & CAUSEF_IP5) {
+		s = IC1_REQ1INT;
+		off = AU1000_INTC1_INT_BASE;
+	} else
+		goto spurious;
+
+	bit = 0;
+	s = au_readl(s);
+	if (unlikely(!s)) {
+spurious:
+		spurious_interrupt();
+		return;
+	}
 #ifdef AU1000_USB_DEV_REQ_INT
 	/*
 	 * Because of the tight timing of SETUP token to reply
 	 * transactions, the USB devices-side packet complete
 	 * interrupt needs the highest priority.
 	 */
-	if ((intc0_req0 & (1 << AU1000_USB_DEV_REQ_INT))) {
-		intc0_req0 &= ~(1 << AU1000_USB_DEV_REQ_INT);
+	bit = 1 << (AU1000_USB_DEV_REQ_INT - AU1000_INTC0_INT_BASE);
+	if ((pending & CAUSEF_IP2) && (s & bit)) {
 		do_IRQ(AU1000_USB_DEV_REQ_INT);
 		return;
 	}
 #endif
-	bit = __ffs(intc0_req0);
-	intc0_req0 &= ~(1 << bit);
-	do_IRQ(AU1000_INTC0_INT_BASE + bit);
+	do_IRQ(__ffs(s) + off);
 }
 
-
-static void intc0_req1_irqdispatch(void)
+/* setup edge/level and assign request 0/1 */
+void __init au1xxx_setup_irqmap(struct au1xxx_irqmap *map, int count)
 {
-	static unsigned long intc0_req1;
-	unsigned int bit;
-
-	intc0_req1 |= au_readl(IC0_REQ1INT);
-
-	if (!intc0_req1)
-		return;
-
-	bit = __ffs(intc0_req1);
-	intc0_req1 &= ~(1 << bit);
-	do_IRQ(AU1000_INTC0_INT_BASE + bit);
-}
-
-
-/*
- * Interrupt Controller 1:
- * interrupts 32 - 63
- */
-static void intc1_req0_irqdispatch(void)
-{
-	static unsigned long intc1_req0;
-	unsigned int bit;
-
-	intc1_req0 |= au_readl(IC1_REQ0INT);
-
-	if (!intc1_req0)
-		return;
-
-	bit = __ffs(intc1_req0);
-	intc1_req0 &= ~(1 << bit);
-	do_IRQ(AU1000_INTC1_INT_BASE + bit);
-}
-
-
-static void intc1_req1_irqdispatch(void)
-{
-	static unsigned long intc1_req1;
-	unsigned int bit;
-
-	intc1_req1 |= au_readl(IC1_REQ1INT);
-
-	if (!intc1_req1)
-		return;
-
-	bit = __ffs(intc1_req1);
-	intc1_req1 &= ~(1 << bit);
-	do_IRQ(AU1000_INTC1_INT_BASE + bit);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned int bit, irq_nr;
+
+	while (count--) {
+		irq_nr = map[count].im_irq;
+
+		if (((irq_nr < AU1000_INTC0_INT_BASE) ||
+		     (irq_nr >= AU1000_INTC0_INT_BASE + 32)) &&
+		    ((irq_nr < AU1000_INTC1_INT_BASE) ||
+		     (irq_nr >= AU1000_INTC1_INT_BASE + 32)))
+			continue;
+
+		if (irq_nr >= AU1000_INTC1_INT_BASE) {
+			bit = irq_nr - AU1000_INTC1_INT_BASE;
+			if (map[count].im_request)
+				au_writel(1 << bit, IC1_ASSIGNCLR);
+		} else {
+			bit = irq_nr - AU1000_INTC0_INT_BASE;
+			if (map[count].im_request)
+				au_writel(1 << bit, IC0_ASSIGNCLR);
+		}
 
-	if (pending & CAUSEF_IP7)
-		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
-	else if (pending & CAUSEF_IP2)
-		intc0_req0_irqdispatch();
-	else if (pending & CAUSEF_IP3)
-		intc0_req1_irqdispatch();
-	else if (pending & CAUSEF_IP4)
-		intc1_req0_irqdispatch();
-	else if (pending  & CAUSEF_IP5)
-		intc1_req1_irqdispatch();
-	else
-		spurious_interrupt();
+		au1x_ic_settype(irq_nr, map[count].im_type);
+	}
 }
 
 void __init arch_init_irq(void)
 {
 	int i;
-	struct au1xxx_irqmap *imp;
-	extern struct au1xxx_irqmap au1xxx_irq_map[];
-	extern struct au1xxx_irqmap au1xxx_ic0_map[];
-	extern int au1xxx_nr_irqs;
-	extern int au1xxx_ic0_nr_irqs;
 
 	/*
 	 * Initialize interrupt controllers to a safe state.
@@ -569,28 +589,67 @@ void __init arch_init_irq(void)
 
 	mips_cpu_irq_init();
 
-	/*
-	 * Initialize IC0, which is fixed per processor.
+	/* register all 64 possible IC0+IC1 irq sources as type "none".
+	 * Use set_irq_type() to set edge/level behaviour at runtime.
 	 */
-	imp = au1xxx_ic0_map;
-	for (i = 0; i < au1xxx_ic0_nr_irqs; i++) {
-		setup_local_irq(imp->im_irq, imp->im_type, imp->im_request);
-		imp++;
-	}
+	for (i = AU1000_INTC0_INT_BASE;
+	     (i < AU1000_INTC0_INT_BASE + 32); i++)
+		au1x_ic_settype(i, IRQ_TYPE_NONE);
+
+	for (i = AU1000_INTC1_INT_BASE;
+	     (i < AU1000_INTC1_INT_BASE + 32); i++)
+		au1x_ic_settype(i, IRQ_TYPE_NONE);
 
 	/*
-	 * Now set up the irq mapping for the board.
+	 * Initialize IC0, which is fixed per processor.
 	 */
-	imp = au1xxx_irq_map;
-	for (i = 0; i < au1xxx_nr_irqs; i++) {
-		setup_local_irq(imp->im_irq, imp->im_type, imp->im_request);
-		imp++;
+	au1xxx_setup_irqmap(au1xxx_ic0_map, ARRAY_SIZE(au1xxx_ic0_map));
+
+	/* Boards can register additional (GPIO-based) IRQs.
+	*/
+	board_init_irq();
+
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+}
+
+unsigned long save_local_and_disable(int controller)
+{
+	int i;
+	unsigned long flags, mask;
+
+	spin_lock_irqsave(&irq_lock, flags);
+	if (controller) {
+		mask = au_readl(IC1_MASKSET);
+		for (i = 0; i < 32; i++)
+			au1x_ic1_mask(i + AU1000_INTC1_INT_BASE);
+	} else {
+		mask = au_readl(IC0_MASKSET);
+		for (i = 0; i < 32; i++)
+			au1x_ic0_mask(i + AU1000_INTC0_INT_BASE);
 	}
+	spin_unlock_irqrestore(&irq_lock, flags);
 
-	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4);
+	return mask;
+}
 
-	/* Board specific IRQ initialization.
-	*/
-	if (board_init_irq)
-		board_init_irq();
+void restore_local_and_enable(int controller, unsigned long mask)
+{
+	int i;
+	unsigned long flags, new_mask;
+
+	spin_lock_irqsave(&irq_lock, flags);
+	for (i = 0; i < 32; i++)
+		if (mask & (1 << i)) {
+			if (controller)
+				au1x_ic1_unmask(i + AU1000_INTC1_INT_BASE);
+			else
+				au1x_ic0_unmask(i + AU1000_INTC0_INT_BASE);
+		}
+
+	if (controller)
+		new_mask = au_readl(IC1_MASKSET);
+	else
+		new_mask = au_readl(IC0_MASKSET);
+
+	spin_unlock_irqrestore(&irq_lock, flags);
 }
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index bd854a6..33a3cdb 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -51,7 +51,6 @@ static void au1000_calibrate_delay(void);
 
 extern unsigned long save_local_and_disable(int controller);
 extern void restore_local_and_enable(int controller, unsigned long mask);
-extern void local_enable_irq(unsigned int irq_nr);
 
 static DEFINE_SPINLOCK(pm_lock);
 
@@ -364,7 +363,10 @@ static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
 	 */
 	intc0_mask = save_local_and_disable(0);
 	intc1_mask = save_local_and_disable(1);
-	local_enable_irq(AU1000_TOY_MATCH2_INT);
+	val = 1 << (AU1000_TOY_MATCH2_INT - AU1000_INTC0_INT_BASE);
+	au_writel(val, IC0_MASKSET);	/* unmask */
+	au_writel(val, IC0_WAKESET);	/* enable wake-from-sleep */
+	au_sync();
 	spin_unlock_irqrestore(&pm_lock, flags);
 	au1000_calibrate_delay();
 	restore_local_and_enable(0, intc0_mask);
diff --git a/arch/mips/alchemy/devboards/db1x00/irqmap.c b/arch/mips/alchemy/devboards/db1x00/irqmap.c
index 94c090e..0b09025 100644
--- a/arch/mips/alchemy/devboards/db1x00/irqmap.c
+++ b/arch/mips/alchemy/devboards/db1x00/irqmap.c
@@ -27,6 +27,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
@@ -66,21 +67,24 @@ struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 
 #ifndef CONFIG_MIPS_MIRAGE
 #ifdef CONFIG_MIPS_DB1550
-	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
-	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
+	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
+	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
 #else
-	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 Fully_Interted# */
-	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 STSCHG# */
-	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
+	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 Fully_Interted# */
+	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 STSCHG# */
+	{ AU1000_GPIO_2, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
 
-	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 Fully_Interted# */
-	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 STSCHG# */
-	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
+	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 Fully_Interted# */
+	{ AU1000_GPIO_4, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 STSCHG# */
+	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
 #endif
 #else
-	{ AU1000_GPIO_7, INTC_INT_RISE_EDGE, 0 }, /* touchscreen pen down */
+	{ AU1000_GPIO_7, IRQF_TRIGGER_RISING, 0 }, /* touchscreen pen down */
 #endif
 
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index 889c8fd..aed2fde 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -32,11 +32,9 @@
 
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_15, IRQF_TRIGGER_LOW, 0 },
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-
 
 const char *get_system_type(void)
 {
@@ -47,6 +45,11 @@ void board_reset(void)
 {
 }
 
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
+
 void __init board_setup(void)
 {
 	u32 pin_func, static_cfg0;
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index fbd211e..4df57fa 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
@@ -33,14 +34,12 @@
 
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
-	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card STSCHG# */
-	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card IRQ# */
-	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, /* DC_IRQ# */
+	{ AU1000_GPIO_9,  IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card Fully_Inserted# */
+	{ AU1000_GPIO_10, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card STSCHG# */
+	{ AU1000_GPIO_11, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card IRQ# */
+	{ AU1000_GPIO_13, IRQF_TRIGGER_LOW, 0 }, /* DC_IRQ# */
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-
 
 const char *get_system_type(void)
 {
@@ -53,6 +52,11 @@ void board_reset(void)
 	au_writel(0x00000000, PB1100_RST_VDDI);
 }
 
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
+
 void __init board_setup(void)
 {
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index b5585e4..94e6b7e 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -30,8 +30,6 @@
 #include <prom.h>
 #include <au1xxx.h>
 
-extern void _board_init_irq(void);
-extern void (*board_init_irq)(void);
 
 const char *get_system_type(void)
 {
@@ -131,9 +129,6 @@ void __init board_setup(void)
 #ifdef CONFIG_MIPS_DB1200
 	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
 #endif
-
-	/* Setup Pb1200 External Interrupt Controller */
-	board_init_irq = _board_init_irq;
 }
 
 int board_au1200fb_panel(void)
diff --git a/arch/mips/alchemy/devboards/pb1200/irqmap.c b/arch/mips/alchemy/devboards/pb1200/irqmap.c
index 2a505ad..1f92fec 100644
--- a/arch/mips/alchemy/devboards/pb1200/irqmap.c
+++ b/arch/mips/alchemy/devboards/pb1200/irqmap.c
@@ -40,10 +40,9 @@
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	/* This is external interrupt cascade */
-	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_7, IRQF_TRIGGER_LOW, 0 },
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
 
 /*
  * Support for External interrupts on the Pb1200 Development platform.
@@ -121,10 +120,12 @@ static struct irq_chip external_irq_type = {
 	.unmask   = pb1200_enable_irq,
 };
 
-void _board_init_irq(void)
+void __init board_init_irq(void)
 {
 	unsigned int irq;
 
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+
 #ifdef CONFIG_MIPS_PB1200
 	/* We have a problem with CPLD rev 3. */
 	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index dcb36a6..fed3b09 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
@@ -38,15 +39,13 @@ char irq_tab_alchemy[][5] __initdata = {
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
+	{ AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_203, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_205, IRQF_TRIGGER_LOW, 0 },
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-
 
 const char *get_system_type(void)
 {
@@ -59,6 +58,11 @@ void board_reset(void)
 	au_writel(0x00000000, PB1500_RST_VDDI);
 }
 
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
+
 void __init board_setup(void)
 {
 	u32 pin_func;
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index f462652..b6e9e7d 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
@@ -41,13 +42,10 @@ char irq_tab_alchemy[][5] __initdata = {
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 },
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-
-
 const char *get_system_type(void)
 {
 	return "Alchemy Pb1550";
@@ -59,6 +57,11 @@ void board_reset(void)
 	au_writew(au_readw(0xAF00001C) & ~BCSR_SYSTEM_RESET, 0xAF00001C);
 }
 
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
+
 void __init board_setup(void)
 {
 	u32 pin_func;
diff --git a/arch/mips/alchemy/mtx-1/irqmap.c b/arch/mips/alchemy/mtx-1/irqmap.c
index f2bf029..f1ab12a 100644
--- a/arch/mips/alchemy/mtx-1/irqmap.c
+++ b/arch/mips/alchemy/mtx-1/irqmap.c
@@ -27,7 +27,7 @@
  */
 
 #include <linux/init.h>
-
+#include <linux/interrupt.h>
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
@@ -42,11 +42,15 @@ char irq_tab_alchemy[][5] __initdata = {
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-       { AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
-       { AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
-       { AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
-       { AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
-       { AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
+       { AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
+       { AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
+       { AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
+       { AU1500_GPIO_203, IRQF_TRIGGER_LOW, 0 },
+       { AU1500_GPIO_205, IRQF_TRIGGER_LOW, 0 },
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
diff --git a/arch/mips/alchemy/xxs1500/irqmap.c b/arch/mips/alchemy/xxs1500/irqmap.c
index edf06ed..0f0f301 100644
--- a/arch/mips/alchemy/xxs1500/irqmap.c
+++ b/arch/mips/alchemy/xxs1500/irqmap.c
@@ -27,23 +27,26 @@
  */
 
 #include <linux/init.h>
-
+#include <linux/interrupt.h>
 #include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_207, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
+	{ AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_203, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_205, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_207, IRQF_TRIGGER_LOW, 0 },
 
-	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* CF interrupt */
-	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_2, IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_4, IRQF_TRIGGER_LOW, 0 }, /* CF interrupt */
+	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 },
 };
 
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+void __init board_init_irq(void)
+{
+	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
+}
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 0d302ba..a7ba352 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -109,10 +109,11 @@ struct au1xxx_irqmap {
 	int	im_request;
 };
 
-/*
- * init_IRQ looks for a table with this name.
- */
-extern struct au1xxx_irqmap au1xxx_irq_map[];
+/* core calls this function to let boards initialize other IRQ sources */
+void board_init_irq(void);
+
+/* boards call this to register additional (GPIO) interrupts */
+void au1xxx_setup_irqmap(struct au1xxx_irqmap *map, int count);
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
@@ -505,15 +506,6 @@ extern struct au1xxx_irqmap au1xxx_irq_map[];
 
 #define IC1_TESTBIT		0xB1800080
 
-/* Interrupt Configuration Modes */
-#define INTC_INT_DISABLED		0x0
-#define INTC_INT_RISE_EDGE		0x1
-#define INTC_INT_FALL_EDGE		0x2
-#define INTC_INT_RISE_AND_FALL_EDGE	0x3
-#define INTC_INT_HIGH_LEVEL		0x5
-#define INTC_INT_LOW_LEVEL		0x6
-#define INTC_INT_HIGH_AND_LOW_LEVEL	0x7
-
 /* Interrupt Numbers */
 /* Au1000 */
 #ifdef CONFIG_SOC_AU1000
-- 
1.6.0.4
