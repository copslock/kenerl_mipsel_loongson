Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:56:44 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41538 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011965AbaJTUzKSxt0b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:10 +0200
Received: by mail-pa0-f52.google.com with SMTP id fb1so5951452pad.39
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=st0H1v7FzmU499SBJjF1xM1X+q6acr27fABk2+IeaTs=;
        b=k9RV3Pg+89KVFIUdngoSjGcLn7+5m9lTUD2JgZzFpXGHnY0jBa7/jpziRwZcQm4xIe
         85vU/UXBUrMoweAWvnWXRWM+0oYJdhrq/6QW3vnBRErIPgE9jwWZgpM3x4cXSr200kvo
         raFlwdiblsRY5rmeyV7LKgtjTUYaKvTLlU4s70+/8xw/MjRnZQJTc+dCSWeJu+xCO0rI
         MpR6jyoBD5VgrHYyZxjGGp9yRNpQkk1bRgsJ2jIjT4PZXkG/ojSAhfCIFUxDlFqaMuuv
         +kLKzsBYnwPkzeOJ91MFDv2JwLR55UQATosCpU6xkmwof2Tv1BwiI5UTyBbmgpr58J4r
         zMrQ==
X-Received: by 10.66.140.76 with SMTP id re12mr4681167pab.147.1413838504233;
        Mon, 20 Oct 2014 13:55:04 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.55.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:55:03 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 6/9] tty: serial: bcm63xx: Eliminate unnecessary request/release functions
Date:   Mon, 20 Oct 2014 13:54:05 -0700
Message-Id: <1413838448-29464-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

We don't really need to perform the ioremap "on demand" so it's simpler
just to do it from the probe function.  This also lets us eliminate the
UART_REG_SIZE constant and rely on the resource information passed in
from the DT or platform code.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 30 ++++++++++--------------------
 include/linux/serial_bcm63xx.h    |  2 --
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2015284..999bb6fa 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -588,20 +588,7 @@ static void bcm_uart_set_termios(struct uart_port *port,
  */
 static int bcm_uart_request_port(struct uart_port *port)
 {
-	unsigned int size;
-
-	size = UART_REG_SIZE;
-	if (!request_mem_region(port->mapbase, size, "bcm63xx")) {
-		dev_err(port->dev, "Memory region busy\n");
-		return -EBUSY;
-	}
-
-	port->membase = ioremap(port->mapbase, size);
-	if (!port->membase) {
-		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, size);
-		return -EBUSY;
-	}
+	/* UARTs always present */
 	return 0;
 }
 
@@ -610,8 +597,7 @@ static int bcm_uart_request_port(struct uart_port *port)
  */
 static void bcm_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_REG_SIZE);
-	iounmap(port->membase);
+	/* Nothing to release ... */
 }
 
 /*
@@ -833,13 +819,20 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
 		return -EINVAL;
 
-	if (ports[pdev->id].membase)
+	port = &ports[pdev->id];
+	if (port->membase)
 		return -EBUSY;
+	memset(port, 0, sizeof(*port));
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_mem)
 		return -ENODEV;
 
+	port->mapbase = res_mem->start;
+	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
 	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res_irq)
 		return -ENODEV;
@@ -848,10 +841,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-	port = &ports[pdev->id];
-	memset(port, 0, sizeof(*port));
 	port->iotype = UPIO_MEM;
-	port->mapbase = res_mem->start;
 	port->irq = res_irq->start;
 	port->ops = &bcm_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
diff --git a/include/linux/serial_bcm63xx.h b/include/linux/serial_bcm63xx.h
index a80aa1a..570e964 100644
--- a/include/linux/serial_bcm63xx.h
+++ b/include/linux/serial_bcm63xx.h
@@ -116,6 +116,4 @@
 					UART_FIFO_PARERR_MASK |		\
 					UART_FIFO_BRKDET_MASK)
 
-#define UART_REG_SIZE			24
-
 #endif /* _LINUX_SERIAL_BCM63XX_H */
-- 
2.1.1
