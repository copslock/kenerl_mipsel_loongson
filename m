Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 11:19:19 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56875 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825623Ab3IYJRCD8SL5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 11:17:02 +0200
Received: by mail-pb0-f50.google.com with SMTP id uo5so5721758pbc.23
        for <multiple recipients>; Wed, 25 Sep 2013 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8bTrhv2I5wlQVOk9nTB4qgvjMmvFTreuBr2hFPuh6E8=;
        b=BkmQ6BKO+ZyU6YnYcdmaiwTkk/NXodSH5F964z/1/ZWXEp+YRouhF8Ut1JartGthvY
         HRyW6lxv9jhqpzp5y8k2mEqYPSmy333LObnI4VuA569a4gK6HK+aOqsKV7+R+lSZ54iV
         5iOuzRvlobOvZHAL2QZcHzfCrAYqfPgx122EUzmCV7nODZSeAjZYgVhiEVnNnW0uBfaj
         VOojCqt9IUb8TBcRg6uKNIUgGShU0NExjVhuJL5IjlGFY44ctZOF4AWi0EMOu9g00sTI
         QNMxQK+ulBa1aDB4QWgZXEj3l0tJNWawUcaGsQSWZU5hxA6IltfMPhHbha8oFQxVS2ls
         fvaw==
X-Received: by 10.68.211.202 with SMTP id ne10mr10165418pbc.168.1380100615742;
        Wed, 25 Sep 2013 02:16:55 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ef10sm51851181pac.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 02:16:54 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V12 07/12] MIPS: Loongson 3: Add serial port support
Date:   Wed, 25 Sep 2013 17:15:41 +0800
Message-Id: <1380100546-8302-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1380100546-8302-1-git-send-email-chenhc@lemote.com>
References: <1380100546-8302-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37963
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
index 5f2b78a..bd2b709 100644
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
 	[MACH_LOONGSON_UNKNOWN]		{},
-	[MACH_LEMOTE_FL2E]		{PORT(4), {} },
-	[MACH_LEMOTE_FL2F]		{PORT(3), {} },
-	[MACH_LEMOTE_ML2F7]		{PORT_M(3), {} },
-	[MACH_LEMOTE_YL2F89]		{PORT_M(3), {} },
-	[MACH_DEXXON_GDIUM2F10]		{PORT_M(3), {} },
-	[MACH_LEMOTE_NAS]		{PORT_M(3), {} },
-	[MACH_LEMOTE_LL2F]		{PORT(3), {} },
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
 	[MACH_LOONGSON_END]		{},
 };
 
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index e192ad0..1e1eeea 100644
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
