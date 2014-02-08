Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Feb 2014 05:42:27 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60364 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827312AbaBHEk5oeBYN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Feb 2014 05:40:57 +0100
Received: by mail-pa0-f52.google.com with SMTP id bj1so4019590pad.25
        for <multiple recipients>; Fri, 07 Feb 2014 20:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8bTrhv2I5wlQVOk9nTB4qgvjMmvFTreuBr2hFPuh6E8=;
        b=EsJUmPqPx6pelszVaJN7uRI2K0kBVEV+7n2ZOUSZFqZN99K4lxJsOb4AouOIsIJ4Zh
         G7xawvVcKavcboQKDQRKEdY1ayVcalwcq0HXJMjY3dryQ7bd7IMOaIYXhOY0+blwfiha
         hv3nk2dXpR6ZwIPFfFFIb9nBYwstVSVo4om7Jhq5hrv7KVT7loVlw+kuF8lHha/MUHvo
         lbm43peRWaywViZcyEm4YAsU5/B1GBMI5tePzwAlUosZlGKtgirgXpcFQgNHduM7uXsg
         wD2Xl/5zZbSRp3aHw9cfWiqKdJefiv+ZOJeatEs7iLn5HpsA+nFapNyNcoWaX8Zlo5RF
         xbVw==
X-Received: by 10.66.243.103 with SMTP id wx7mr12144829pac.107.1391834451462;
        Fri, 07 Feb 2014 20:40:51 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id qq5sm19189505pbb.24.2014.02.07.20.40.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 20:40:50 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V17 08/13] MIPS: Loongson 3: Add serial port support
Date:   Sat,  8 Feb 2014 12:38:57 +0800
Message-Id: <1391834342-8177-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1391834342-8177-1-git-send-email-chenhc@lemote.com>
References: <1391834342-8177-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39245
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
