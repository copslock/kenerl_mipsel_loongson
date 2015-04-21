Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:53:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61573 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025952AbbDUOxp5apMv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:53:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 27D28A720D4EF;
        Tue, 21 Apr 2015 15:53:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:53:39 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:53:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v3 21/37] irqchip: move Ingenic SoC intc driver to drivers/irqchip
Date:   Tue, 21 Apr 2015 15:46:48 +0100
Message-ID: <1429627624-30525-22-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Move the driver for Ingenic SoC interrupt controllers into
drivers/irqchip where it belongs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
Changes in v3:
  - New patch.
---
 arch/mips/jz4740/Makefile                                 | 2 +-
 arch/mips/jz4740/gpio.c                                   | 3 +--
 drivers/irqchip/Kconfig                                   | 5 +++++
 drivers/irqchip/Makefile                                  | 1 +
 arch/mips/jz4740/irq.c => drivers/irqchip/irq-ingenic.c   | 5 ++---
 arch/mips/jz4740/irq.h => include/linux/irqchip/ingenic.h | 4 ++--
 6 files changed, 12 insertions(+), 8 deletions(-)
 rename arch/mips/jz4740/irq.c => drivers/irqchip/irq-ingenic.c (98%)
 rename arch/mips/jz4740/irq.h => include/linux/irqchip/ingenic.h (90%)

diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 28e5535..6cf5dd4 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y += prom.o irq.o time.o reset.o setup.o \
+obj-y += prom.o time.o reset.o setup.o \
 	gpio.o clock.o platform.o timer.o serial.o
 
 obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 994a7df..54c80d4 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/ingenic.h>
 #include <linux/bitops.h>
 
 #include <linux/debugfs.h>
@@ -28,8 +29,6 @@
 
 #include <asm/mach-jz4740/base.h>
 
-#include "irq.h"
-
 #define JZ4740_GPIO_BASE_A (32*0)
 #define JZ4740_GPIO_BASE_B (32*1)
 #define JZ4740_GPIO_BASE_C (32*2)
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6de62a9..1378aca 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -158,3 +158,8 @@ config KEYSTONE_IRQ
 config MIPS_GIC
 	bool
 	select MIPS_CM
+
+config INGENIC_IRQ
+	bool
+	depends on MACH_INGENIC
+	default y
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..982eb84 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
+obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
diff --git a/arch/mips/jz4740/irq.c b/drivers/irqchip/irq-ingenic.c
similarity index 98%
rename from arch/mips/jz4740/irq.c
rename to drivers/irqchip/irq-ingenic.c
index 5f4ec08..1578c51 100644
--- a/arch/mips/jz4740/irq.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/irqchip/ingenic.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/timex.h>
@@ -27,9 +28,7 @@
 #include <asm/io.h>
 #include <asm/mach-jz4740/irq.h>
 
-#include "irq.h"
-
-#include "../../drivers/irqchip/irqchip.h"
+#include "irqchip.h"
 
 struct ingenic_intc_data {
 	void __iomem *base;
diff --git a/arch/mips/jz4740/irq.h b/include/linux/irqchip/ingenic.h
similarity index 90%
rename from arch/mips/jz4740/irq.h
rename to include/linux/irqchip/ingenic.h
index 601d527..0ee319a 100644
--- a/arch/mips/jz4740/irq.h
+++ b/include/linux/irqchip/ingenic.h
@@ -12,8 +12,8 @@
  *
  */
 
-#ifndef __MIPS_JZ4740_IRQ_H__
-#define __MIPS_JZ4740_IRQ_H__
+#ifndef __LINUX_IRQCHIP_INGENIC_H__
+#define __LINUX_IRQCHIP_INGENIC_H__
 
 #include <linux/irq.h>
 
-- 
2.3.5
