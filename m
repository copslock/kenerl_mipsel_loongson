Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:42:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6223 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011723AbbARWmCUqQbG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:42:02 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D69A0E077CE89;
        Sun, 18 Jan 2015 22:41:51 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:41:55 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:41:48 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 28/36] MIPS: jz4740: use jz47xx-uart & DT for UART output
Date:   Sun, 18 Jan 2015 14:41:46 -0800
Message-ID: <1421620906-25284-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45277
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

Remove the serial support from arch/mips/jz4740 & make use of the new
jz47xx-uart driver. This is done for both regular & early console
output.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/Kconfig                            |  1 -
 arch/mips/boot/dts/jz4740.dtsi               | 22 ++++++++++++++
 arch/mips/boot/dts/qi_lb60.dts               |  4 +++
 arch/mips/include/asm/mach-jz4740/platform.h |  2 --
 arch/mips/include/asm/mach-jz4740/serial.h   | 25 ++++++++++++++++
 arch/mips/jz4740/Makefile                    |  2 +-
 arch/mips/jz4740/board-qi_lb60.c             |  2 --
 arch/mips/jz4740/platform.c                  | 44 ----------------------------
 arch/mips/jz4740/prom.c                      | 13 --------
 arch/mips/jz4740/serial.c                    | 33 ---------------------
 arch/mips/jz4740/serial.h                    | 23 ---------------
 11 files changed, 52 insertions(+), 119 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-jz4740/serial.h
 delete mode 100644 arch/mips/jz4740/serial.c
 delete mode 100644 arch/mips/jz4740/serial.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ef82cd3..622d0aa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -285,7 +285,6 @@ config MACH_JZ4740
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ARCH_REQUIRE_GPIOLIB
-	select SYS_HAS_EARLY_PRINTK
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
index ef679b4..c52d92d 100644
--- a/arch/mips/boot/dts/jz4740.dtsi
+++ b/arch/mips/boot/dts/jz4740.dtsi
@@ -43,4 +43,26 @@
 
 		#clock-cells = <1>;
 	};
+
+	uart0: serial@10030000 {
+		compatible = "ingenic,jz4740-uart";
+		reg = <0x10030000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <9>;
+
+		clocks = <&ext>, <&cgu JZ4740_CLK_UART0>;
+		clock-names = "baud", "module";
+	};
+
+	uart1: serial@10031000 {
+		compatible = "ingenic,jz4740-uart";
+		reg = <0x10031000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <8>;
+
+		clocks = <&ext>, <&cgu JZ4740_CLK_UART1>;
+		clock-names = "baud", "module";
+	};
 };
diff --git a/arch/mips/boot/dts/qi_lb60.dts b/arch/mips/boot/dts/qi_lb60.dts
index 106d13c..2414d63 100644
--- a/arch/mips/boot/dts/qi_lb60.dts
+++ b/arch/mips/boot/dts/qi_lb60.dts
@@ -4,6 +4,10 @@
 
 / {
 	compatible = "qi,lb60", "ingenic,jz4740";
+
+	chosen {
+		stdout-path = &uart0;
+	};
 };
 
 &ext {
diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
index 069b43a..32cfbe6 100644
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -35,6 +35,4 @@ extern struct platform_device jz4740_wdt_device;
 extern struct platform_device jz4740_pwm_device;
 extern struct platform_device jz4740_dma_device;
 
-void jz4740_serial_device_register(void);
-
 #endif
diff --git a/arch/mips/include/asm/mach-jz4740/serial.h b/arch/mips/include/asm/mach-jz4740/serial.h
new file mode 100644
index 0000000..4e4db4b
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4740/serial.h
@@ -0,0 +1,25 @@
+/*
+* Copyright (c) 2015 Imagination Technologies
+*
+* This program is free software; you can redistribute it and/or
+* modify it under the terms of the GNU General Public License as
+* published by the Free Software Foundation; either version 2 of
+* the License, or (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+* MA 02111-1307 USA
+*/
+
+#ifndef __JZ4740_SERIAL_H__
+#define __JZ4740_SERIAL_H__
+
+#define BASE_BAUD (12000000 / 16)
+
+#endif /* __JZ4740_SERIAL_H__ */
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 340dc16..ae72346 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y += prom.o irq.o time.o reset.o setup.o \
-	gpio.o platform.o timer.o serial.o
+	gpio.o platform.o timer.o
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 0fbb2d8..f84526d 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -473,8 +473,6 @@ static int __init qi_lb60_init_platform_devices(void)
 
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
 
-	jz4740_serial_device_register();
-
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 2a5c7c7..8226a36 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -280,50 +280,6 @@ struct platform_device jz4740_adc_device = {
 	.resource	= jz4740_adc_resources,
 };
 
-/* Serial */
-#define JZ4740_UART_DATA(_id) \
-	{ \
-		.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE, \
-		.iotype = UPIO_MEM, \
-		.regshift = 2, \
-		.serial_out = jz4740_serial_out, \
-		.type = PORT_16550, \
-		.mapbase = JZ4740_UART ## _id ## _BASE_ADDR, \
-		.irq = JZ4740_IRQ_UART ## _id, \
-	}
-
-static struct plat_serial8250_port jz4740_uart_data[] = {
-	JZ4740_UART_DATA(0),
-	JZ4740_UART_DATA(1),
-	{},
-};
-
-static struct platform_device jz4740_uart_device = {
-	.name = "serial8250",
-	.id = 0,
-	.dev = {
-		.platform_data = jz4740_uart_data,
-	},
-};
-
-void jz4740_serial_device_register(void)
-{
-	struct plat_serial8250_port *p;
-	struct clk *ext_clk;
-	unsigned long ext_rate;
-
-	ext_clk = clk_get(NULL, "ext");
-	if (IS_ERR(ext_clk))
-		panic("unable to get ext clock");
-	ext_rate = clk_get_rate(ext_clk);
-	clk_put(ext_clk);
-
-	for (p = jz4740_uart_data; p->flags != 0; ++p)
-		p->uartclk = ext_rate;
-
-	platform_device_register(&jz4740_uart_device);
-}
-
 /* Watchdog */
 static struct resource jz4740_wdt_resources[] = {
 	{
diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 5a93f38..6984683 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -53,16 +53,3 @@ void __init prom_init(void)
 void __init prom_free_prom_memory(void)
 {
 }
-
-#define UART_REG(_reg) ((void __iomem *)CKSEG1ADDR(JZ4740_UART0_BASE_ADDR + (_reg << 2)))
-
-void prom_putchar(char c)
-{
-	uint8_t lsr;
-
-	do {
-		lsr = readb(UART_REG(UART_LSR));
-	} while ((lsr & UART_LSR_TEMT) == 0);
-
-	writeb(c, UART_REG(UART_TX));
-}
diff --git a/arch/mips/jz4740/serial.c b/arch/mips/jz4740/serial.c
deleted file mode 100644
index d23de45..0000000
--- a/arch/mips/jz4740/serial.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 serial support
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/io.h>
-#include <linux/serial_core.h>
-#include <linux/serial_reg.h>
-
-void jz4740_serial_out(struct uart_port *p, int offset, int value)
-{
-	switch (offset) {
-	case UART_FCR:
-		value |= 0x10; /* Enable uart module */
-		break;
-	case UART_IER:
-		value |= (value & 0x4) << 2;
-		break;
-	default:
-		break;
-	}
-	writeb(value, p->membase + (offset << p->regshift));
-}
diff --git a/arch/mips/jz4740/serial.h b/arch/mips/jz4740/serial.h
deleted file mode 100644
index 8eb715b..0000000
--- a/arch/mips/jz4740/serial.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 serial support
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef __MIPS_JZ4740_SERIAL_H__
-#define __MIPS_JZ4740_SERIAL_H__
-
-struct uart_port;
-
-void jz4740_serial_out(struct uart_port *p, int offset, int value);
-
-#endif
-- 
2.2.1
