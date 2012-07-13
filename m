Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:26:34 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2885 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903722Ab2GMQYh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:37 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:29 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:23:47 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0A4F39F9F5; Fri, 13
 Jul 2012 09:24:27 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:26 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 08/12] MIPS: Netlogic: Move serial ports to device tree
Date:   Fri, 13 Jul 2012 21:53:21 +0530
Message-ID: <1342196605-4260-9-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E940B3NK5403974-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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

Add the serial ports to the device tree and remove the platform
code for adding them.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/dts/xlp_evp.dts |   21 +++++++
 arch/mips/netlogic/xlp/Makefile    |    2 +-
 arch/mips/netlogic/xlp/platform.c  |  108 ------------------------------------
 3 files changed, 22 insertions(+), 109 deletions(-)
 delete mode 100644 arch/mips/netlogic/xlp/platform.c

diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/netlogic/dts/xlp_evp.dts
index 86a29ca..e14f423 100644
--- a/arch/mips/netlogic/dts/xlp_evp.dts
+++ b/arch/mips/netlogic/dts/xlp_evp.dts
@@ -22,6 +22,27 @@
 		compatible = "simple-bus";
 		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
 			  1 0  0 0x16000000  0x01000000>; // GBU chipselects
+
+		serial0: serial@30000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0 0x30100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <133333333>;
+			interrupt-parent = <&pic>;
+			interrupts = <17>;
+		};
+		serial1: serial@31000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0 0x31100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <133333333>;
+			interrupt-parent = <&pic>;
+			interrupts = <18>;
+		};
 		i2c0: ocores@32000 {
 			compatible = "opencores,i2c-ocores";
 			#address-cells = <1>;
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 5bd24b6..a84d6ed 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,3 +1,3 @@
-obj-y				+= setup.o platform.o nlm_hal.o
+obj-y				+= setup.o nlm_hal.o
 obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
diff --git a/arch/mips/netlogic/xlp/platform.c b/arch/mips/netlogic/xlp/platform.c
deleted file mode 100644
index 2c510d5..0000000
--- a/arch/mips/netlogic/xlp/platform.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/serial.h>
-#include <linux/serial_8250.h>
-#include <linux/pci.h>
-#include <linux/serial_reg.h>
-#include <linux/spinlock.h>
-
-#include <asm/time.h>
-#include <asm/addrspace.h>
-#include <asm/netlogic/haldefs.h>
-#include <asm/netlogic/xlp-hal/iomap.h>
-#include <asm/netlogic/xlp-hal/xlp.h>
-#include <asm/netlogic/xlp-hal/pic.h>
-#include <asm/netlogic/xlp-hal/uart.h>
-
-static unsigned int nlm_xlp_uart_in(struct uart_port *p, int offset)
-{
-	return nlm_read_reg(p->iobase, offset);
-}
-
-static void nlm_xlp_uart_out(struct uart_port *p, int offset, int value)
-{
-	nlm_write_reg(p->iobase, offset, value);
-}
-
-#define PORT(_irq)					\
-	{						\
-		.irq		= _irq,			\
-		.regshift	= 2,			\
-		.iotype		= UPIO_MEM32,		\
-		.flags		= (UPF_SKIP_TEST|UPF_FIXED_TYPE|\
-					UPF_BOOT_AUTOCONF),	\
-		.uartclk	= XLP_IO_CLK,		\
-		.type		= PORT_16550A,		\
-		.serial_in	= nlm_xlp_uart_in,	\
-		.serial_out	= nlm_xlp_uart_out,	\
-	}
-
-static struct plat_serial8250_port xlp_uart_data[] = {
-	PORT(PIC_UART_0_IRQ),
-	PORT(PIC_UART_1_IRQ),
-	{},
-};
-
-static struct platform_device uart_device = {
-	.name		= "serial8250",
-	.id		= PLAT8250_DEV_PLATFORM,
-	.dev = {
-		.platform_data = xlp_uart_data,
-	},
-};
-
-static int __init nlm_platform_uart_init(void)
-{
-	unsigned long mmio;
-
-	mmio = (unsigned long)nlm_get_uart_regbase(0, 0);
-	xlp_uart_data[0].iobase = mmio;
-	xlp_uart_data[0].membase = (void __iomem *)mmio;
-	xlp_uart_data[0].mapbase = mmio;
-
-	mmio = (unsigned long)nlm_get_uart_regbase(0, 1);
-	xlp_uart_data[1].iobase = mmio;
-	xlp_uart_data[1].membase = (void __iomem *)mmio;
-	xlp_uart_data[1].mapbase = mmio;
-
-	return platform_device_register(&uart_device);
-}
-
-arch_initcall(nlm_platform_uart_init);
-- 
1.7.9.5
