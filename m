Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 09:36:15 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58682 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819780Ab2KLIeoCHcmW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2012 09:34:44 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3805949pad.36
        for <multiple recipients>; Mon, 12 Nov 2012 00:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0clVjA/X/lXWLq8/eTDiFP19ZoZ3xsqKvlMs8NUC9NY=;
        b=t9zGQYVOk4fmpOeIyBhbMkgdI4nrsIYIAIu57KRRYZvKKLOunCKRQEyZMkQH1A4/Aj
         b7SU6Jj2AI3ZZngeMJHgH3sv9ItpMcCL+wsmnxQoCBhV6Pn3aEWPoWSMSmabCI0lTXyH
         RiW1z2saUKDtLa0fCY/MyrFwdk3BYglxtiPGh8qbGu+br461zc7lhjEeG1qjTImuIoKd
         RTDbvXbylJPoUyJQT0+vy7BFWdzAQTiTIyF5Tnu3nMdRAome0w1kmSXWWYWRq9xZudXA
         wZAyXOP1KeoqXgHk0KnbxGSKMUjTFT0EftQfEGyV6pf6P3REukhCpfIDmFwicNI4rtli
         qLDw==
Received: by 10.66.87.133 with SMTP id ay5mr47064813pab.59.1352709283073;
        Mon, 12 Nov 2012 00:34:43 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id k4sm3967393pax.7.2012.11.12.00.34.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 00:34:42 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V8 08/13] MIPS: Loongson 3: Add serial port support
Date:   Mon, 12 Nov 2012 16:32:44 +0800
Message-Id: <1352709169-3481-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
References: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34960
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
