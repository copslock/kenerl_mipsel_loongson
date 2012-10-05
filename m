Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2012 15:30:22 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58535 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870280Ab2JEN0i2qJ17 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2012 15:26:38 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so1955196pbc.36
        for <multiple recipients>; Fri, 05 Oct 2012 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0clVjA/X/lXWLq8/eTDiFP19ZoZ3xsqKvlMs8NUC9NY=;
        b=sxUfUCc0XZK5scLM0ZzjLbtXWxmem6FkqSHbk6+h+FWNI265xjp/mW0sUgR9ceTZyI
         vjEvFNkukkN+ip8ekrpfb9oQ+2A8Fxd0zw3a0qaG6cRmmXGWd1g2MyurHXXZxJ583bny
         HO0vJOblC7KiNpMhrOHWZcZuOajVBG+mcpkKa0emRRkg/xKan0YvItTtmOMbaJpX5OWc
         w1kupBFw7tqfBJhZn6m92CJE1nyFLIhuXiEcYzjGy46UkyRfvuWTqy0hP3whHWXtknjd
         HogFST9fj7EL60qLMkim6CIt/AAHYPHP2OSWaxNdPOYeJ9EiO01582PNKDzwTiUjw3X8
         Onow==
Received: by 10.66.85.227 with SMTP id k3mr18378439paz.79.1349443591956;
        Fri, 05 Oct 2012 06:26:31 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id op7sm270211pbc.52.2012.10.05.06.26.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:26:30 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V7 08/15] MIPS: Loongson 3: Add serial port support
Date:   Fri,  5 Oct 2012 21:25:05 +0800
Message-Id: <1349443512-18340-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
References: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Loongson family machines has three types of serial port: PCI UART, LPC
UART and CPU internal UART. Loongson-2E and parts of Loongson-2F based
machines use PCI UART; most Loongson-2F based machines use LPC UART;
Loongson-2G/3A has both LPC and CPU UART but usually use CPU UART.

Port address of UARTs:
CPU UART: REG_BASE + OFFSET;
LPC UART: LIO1_BASE + OFFSET;
PCI UART: PCIIO_BASE + OFFSET.

Since LPC UART are linked in "Local Bus", both CPU UART and LPC UART
are called "CPU provided serial port".

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/loongson/common/serial.c    |   26 +++++++++++++++-----------
 arch/mips/loongson/common/uart_base.c |    9 ++++++++-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 7580873..59c76b5 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -19,19 +19,19 @@
 #include <loongson.h>
 #include <machine.h>
 
-#define PORT(int)			\
+#define PORT(int, clk)			\
 {								\
 	.irq		= int,					\
-	.uartclk	= 1843200,				\
+	.uartclk	= clk,					\
 	.iotype		= UPIO_PORT,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
 	.regshift	= 0,					\
 }
 
-#define PORT_M(int)				\
+#define PORT_M(int, clk)				\
 {								\
 	.irq		= MIPS_CPU_IRQ_BASE + (int),		\
-	.uartclk	= 3686400,				\
+	.uartclk	= clk,					\
 	.iotype		= UPIO_MEM,				\
 	.membase	= (void __iomem *)NULL,			\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
@@ -40,13 +40,17 @@
 
 static struct plat_serial8250_port uart8250_data[][2] = {
 	[MACH_LOONGSON_UNKNOWN]         {},
-	[MACH_LEMOTE_FL2E]              {PORT(4), {} },
-	[MACH_LEMOTE_FL2F]              {PORT(3), {} },
-	[MACH_LEMOTE_ML2F7]             {PORT_M(3), {} },
-	[MACH_LEMOTE_YL2F89]            {PORT_M(3), {} },
-	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
-	[MACH_LEMOTE_NAS]               {PORT_M(3), {} },
-	[MACH_LEMOTE_LL2F]              {PORT(3), {} },
+	[MACH_LEMOTE_FL2E]              {PORT(4, 1843200), {} },
+	[MACH_LEMOTE_FL2F]              {PORT(3, 1843200), {} },
+	[MACH_LEMOTE_ML2F7]             {PORT_M(3, 3686400), {} },
+	[MACH_LEMOTE_YL2F89]            {PORT_M(3, 3686400), {} },
+	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3, 3686400), {} },
+	[MACH_LEMOTE_NAS]               {PORT_M(3, 3686400), {} },
+	[MACH_LEMOTE_LL2F]              {PORT(3, 1843200), {} },
+	[MACH_LEMOTE_A1004]             {PORT_M(2, 33177600), {} },
+	[MACH_LEMOTE_A1101]             {PORT_M(2, 25000000), {} },
+	[MACH_LEMOTE_A1201]             {PORT_M(2, 25000000), {} },
+	[MACH_LEMOTE_A1205]             {PORT_M(2, 25000000), {} },
 	[MACH_LOONGSON_END]             {},
 };
 
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index d69ea54..ea8b501 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -35,9 +35,16 @@ void prom_init_loongson_uart_base(void)
 	case MACH_DEXXON_GDIUM2F10:
 	case MACH_LEMOTE_NAS:
 	default:
-		/* The CPU provided serial port */
+		/* The CPU provided serial port (LPC) */
 		loongson_uart_base = LOONGSON_LIO1_BASE + 0x3f8;
 		break;
+	case MACH_LEMOTE_A1004:
+	case MACH_LEMOTE_A1101:
+	case MACH_LEMOTE_A1201:
+	case MACH_LEMOTE_A1205:
+		/* The CPU provided serial port (CPU) */
+		loongson_uart_base = LOONGSON_REG_BASE + 0x1e0;
+		break;
 	}
 
 	_loongson_uart_base =
-- 
1.7.7.3
