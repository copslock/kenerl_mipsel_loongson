Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:14:44 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:63454 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835001Ab3FRTNNeqHLx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:13:13 +0200
Received: by mail-pd0-f182.google.com with SMTP id r10so4214417pdi.27
        for <multiple recipients>; Tue, 18 Jun 2013 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IFXAT4heaS/2FmAOp5Ap3LaUJr0lfB/y85UUmsO5jh0=;
        b=KRmZIiMXZ+9JGjQeFS5hG6rN4r4iPHCu1c6rDzYXcxiBuLY6BQnHBygbQMwtx0okwP
         VE2ItHFjGeMvvHRsI8VSBJUBBZoUgMiNHpmrKUTgOS6CcC9GUIOrlRRAtGo3W7iVhL+O
         HjLHmvkZLtMR4KVZyg9nhrFi+FG+B5jh+sxFCl2JZL237ka78K+N/QGwcow5fm3p6irw
         hJ5WNxNFKS/jSZE8jwn8iAacb2euvS/nkxf0py4EXgnjwHu2wvZorXu0hFDfc62ID37O
         dQxH3sKTHO6xvRfy/dYzGIbZv3Y4YIzmwmRXYYOTwWG6k5Eh1Qj4zkqjFcH68n9ljt1a
         IgWA==
X-Received: by 10.68.180.228 with SMTP id dr4mr18120162pbc.212.1371582787042;
        Tue, 18 Jun 2013 12:13:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ve3sm5815513pbc.14.2013.06.18.12.13.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 12:13:05 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5IJD21T012196;
        Tue, 18 Jun 2013 12:13:02 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5IJD23S012195;
        Tue, 18 Jun 2013 12:13:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 4/5] MIPS: OCTEON: Remove custom serial setup code.
Date:   Tue, 18 Jun 2013 12:12:54 -0700
Message-Id: <1371582775-12141-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

We will use 8250_dw instead.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Makefile |   2 +-
 arch/mips/cavium-octeon/serial.c | 109 ---------------------------------------
 2 files changed, 1 insertion(+), 110 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/serial.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index e3fd50c..4e95204 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -12,7 +12,7 @@
 CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
-obj-y := cpu.o setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
deleted file mode 100644
index f393f65..0000000
--- a/arch/mips/cavium-octeon/serial.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004-2007 Cavium Networks
- */
-#include <linux/console.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/serial.h>
-#include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
-#include <linux/tty.h>
-#include <linux/irq.h>
-
-#include <asm/time.h>
-
-#include <asm/octeon/octeon.h>
-
-#define DEBUG_UART 1
-
-unsigned int octeon_serial_in(struct uart_port *up, int offset)
-{
-	int rv = cvmx_read_csr((uint64_t)(up->membase + (offset << 3)));
-	if (offset == UART_IIR && (rv & 0xf) == 7) {
-		/* Busy interrupt, read the USR (39) and try again. */
-		cvmx_read_csr((uint64_t)(up->membase + (39 << 3)));
-		rv = cvmx_read_csr((uint64_t)(up->membase + (offset << 3)));
-	}
-	return rv;
-}
-
-void octeon_serial_out(struct uart_port *up, int offset, int value)
-{
-	/*
-	 * If bits 6 or 7 of the OCTEON UART's LCR are set, it quits
-	 * working.
-	 */
-	if (offset == UART_LCR)
-		value &= 0x9f;
-	cvmx_write_csr((uint64_t)(up->membase + (offset << 3)), (u8)value);
-}
-
-static int octeon_serial_probe(struct platform_device *pdev)
-{
-	int irq, res;
-	struct resource *res_mem;
-	struct uart_8250_port up;
-
-	/* All adaptors have an irq.  */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	memset(&up, 0, sizeof(up));
-
-	up.port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-	up.port.type = PORT_OCTEON;
-	up.port.iotype = UPIO_MEM;
-	up.port.regshift = 3;
-	up.port.dev = &pdev->dev;
-
-	if (octeon_is_simulation())
-		/* Make simulator output fast*/
-		up.port.uartclk = 115200 * 16;
-	else
-		up.port.uartclk = octeon_get_io_clock_rate();
-
-	up.port.serial_in = octeon_serial_in;
-	up.port.serial_out = octeon_serial_out;
-	up.port.irq = irq;
-
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res_mem == NULL) {
-		dev_err(&pdev->dev, "found no memory resource\n");
-		return -ENXIO;
-	}
-	up.port.mapbase = res_mem->start;
-	up.port.membase = ioremap(res_mem->start, resource_size(res_mem));
-
-	res = serial8250_register_8250_port(&up);
-
-	return res >= 0 ? 0 : res;
-}
-
-static struct of_device_id octeon_serial_match[] = {
-	{
-		.compatible = "cavium,octeon-3860-uart",
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, octeon_serial_match);
-
-static struct platform_driver octeon_serial_driver = {
-	.probe		= octeon_serial_probe,
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "octeon_serial",
-		.of_match_table = octeon_serial_match,
-	},
-};
-
-static int __init octeon_serial_init(void)
-{
-	return platform_driver_register(&octeon_serial_driver);
-}
-late_initcall(octeon_serial_init);
-- 
1.7.11.7
