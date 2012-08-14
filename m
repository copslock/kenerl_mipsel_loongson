Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 18:43:20 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:48483 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903568Ab2HNQnN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 18:43:13 +0200
Received: by yhjj52 with SMTP id j52so694466yhj.36
        for <multiple recipients>; Tue, 14 Aug 2012 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0kvHdHGADzUNERLVPByzjnvzKCeEzFSPJYGa1KQfw2g=;
        b=fjxVyL5PxC2iuf36TcSvVcgxCpTEJqzz51OqomtJJbY0pDeQWe277RCs18OTWDIV8b
         FJF3KlaU4aeWtX9BaaSLAULTpHZTfGU9hk4ls2GHG5vZZwizJ41u7AUYd2Q8lg434yGv
         jpBaM5DjcspGrBM9r2Ihciol66/G+K5/yNSfvnJe5siM6pS0zhyiPCDKis6NUmY5ctvx
         Qc4z4bjvCUQbCpebhDPNywZk5wMNjaQT72y1nzNOkI5q3EVczmZcCJ1EUr9bJHtgTKNq
         Jd9lDM3OPc9m4HwDWgC6Z6LPuUbRunNjoaZ9d1UTEK3fBh/EtnJdYmKwq2yldsDGc8kt
         +pew==
Received: by 10.42.157.5 with SMTP id b5mr12201074icx.37.1344962586839;
        Tue, 14 Aug 2012 09:43:06 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id xm2sm12273407igb.3.2012.08.14.09.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 09:43:06 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q7EGgg25006859;
        Tue, 14 Aug 2012 09:42:42 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q7EGgfMe006858;
        Tue, 14 Aug 2012 09:42:41 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-serial@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        Alan Cox <alan@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MIPS: OCTEON: Fix breakage due to 8250 changes.
Date:   Tue, 14 Aug 2012 09:42:39 -0700
Message-Id: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 34163
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The changes in linux-next removing serial8250_register_port() cause
OCTEON to fail to compile.

Lets make OCTEON use the new serial8250_register_8250_port() instead.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Perhaps we can get an Acked-by from Ralf, and then merge this along
with the 8250 patches that caused the breakage?  What do you think?

 arch/mips/cavium-octeon/serial.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 138b221..569f41b 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -47,40 +47,40 @@ static int __devinit octeon_serial_probe(struct platform_device *pdev)
 {
 	int irq, res;
 	struct resource *res_mem;
-	struct uart_port port;
+	struct uart_8250_port up;
 
 	/* All adaptors have an irq.  */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	memset(&port, 0, sizeof(port));
+	memset(&up, 0, sizeof(up));
 
-	port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-	port.type = PORT_OCTEON;
-	port.iotype = UPIO_MEM;
-	port.regshift = 3;
-	port.dev = &pdev->dev;
+	up.port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	up.port.type = PORT_OCTEON;
+	up.port.iotype = UPIO_MEM;
+	up.port.regshift = 3;
+	up.port.dev = &pdev->dev;
 
 	if (octeon_is_simulation())
 		/* Make simulator output fast*/
-		port.uartclk = 115200 * 16;
+		up.port.uartclk = 115200 * 16;
 	else
-		port.uartclk = octeon_get_io_clock_rate();
+		up.port.uartclk = octeon_get_io_clock_rate();
 
-	port.serial_in = octeon_serial_in;
-	port.serial_out = octeon_serial_out;
-	port.irq = irq;
+	up.port.serial_in = octeon_serial_in;
+	up.port.serial_out = octeon_serial_out;
+	up.port.irq = irq;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res_mem == NULL) {
 		dev_err(&pdev->dev, "found no memory resource\n");
 		return -ENXIO;
 	}
-	port.mapbase = res_mem->start;
-	port.membase = ioremap(res_mem->start, resource_size(res_mem));
+	up.port.mapbase = res_mem->start;
+	up.port.membase = ioremap(res_mem->start, resource_size(res_mem));
 
-	res = serial8250_register_port(&port);
+	res = serial8250_register_8250_port(&up);
 
 	return res >= 0 ? 0 : res;
 }
-- 
1.7.2.3
