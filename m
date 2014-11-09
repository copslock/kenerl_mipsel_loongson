Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Nov 2014 09:56:50 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40403 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013065AbaKII4e6gCXT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Nov 2014 09:56:34 +0100
Received: by mail-pa0-f52.google.com with SMTP id fa1so6277873pad.11
        for <linux-mips@linux-mips.org>; Sun, 09 Nov 2014 00:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FH4QvOT6CujPmxQ3+mb52TWsqQEV+n/0s9ULaEglGyI=;
        b=otdQT3DnGInxvlykJjiDU1kTTlZ0BASkcKNI4kJr5M+8qkeXXb32q4BapuKlqnRnrd
         Z24ma3ZPf2zIGfjSm6wA1ROYyByh7H1bOpNul8SXEbVrsyFeiytWGEiO+7Uw3Ri+JyYY
         vhx2qTD0dn6eVyLTbY6W7lS/6kcj24MgLnH7yG58lYor6BqWoU+Yaig5997DpxiFBnu0
         CNYlt4pHmsLjVLV6qITX2VfySAm/mSfisVWA39yYH/eRkOItvec/wY65rLkak4WOoR0W
         7F6zkl885hy4tAFu7iyLCGcqfsCV15v8dopRv8QBM7oS2RVj7i+DotQUq9Ra560+IUQZ
         kAKw==
X-Received: by 10.68.216.70 with SMTP id oo6mr24594839pbc.124.1415523388772;
        Sun, 09 Nov 2014 00:56:28 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id i11sm13248958pbq.84.2014.11.09.00.56.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Nov 2014 00:56:28 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be renamed to /dev/ttyBCM*
Date:   Sun,  9 Nov 2014 00:55:48 -0800
Message-Id: <1415523348-4631-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43935
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

By default, bcm63xx_uart.c uses the standard 8250 device naming and
major/minor numbers.  There are at least two situations where this could
be a problem:

1) Multiplatform kernels that need to support some chips that have 8250
UARTs and other chips that have bcm63xx UARTs.

2) Some older chips like BCM7125 have a mix of both UART types.

Add a new Kconfig option to tell the driver whether to register itself
as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
behavior to avoid surprises.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig        | 11 +++++++++++
 drivers/tty/serial/bcm63xx_uart.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fdd851e..c82cfd2 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1302,6 +1302,17 @@ config SERIAL_BCM63XX_CONSOLE
 	  If you have enabled the serial port on the BCM63xx CPU
 	  you can make it the console by answering Y to this option.
 
+config SERIAL_BCM63XX_TTYS
+	bool "Use ttyS[01] device nodes for bcm63xx_uart"
+	depends on SERIAL_BCM63XX
+	default y
+	help
+	  Say Y to name the serial ports /dev/ttyS0, ttyS1, ...
+	  This conflicts with the 8250 driver but may avoid breaking
+	  compatibility with existing init scripts.
+
+	  Say N to name the serial ports /dev/ttyBCM0, ttyBCM1, ...
+
 config SERIAL_GRLIB_GAISLER_APBUART
 	tristate "GRLIB APBUART serial support"
 	depends on OF && SPARC
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index e04e580..9f3dcc8 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -751,7 +751,11 @@ static int bcm_console_setup(struct console *co, char *options)
 static struct uart_driver bcm_uart_driver;
 
 static struct console bcm63xx_console = {
+#ifdef CONFIG_SERIAL_BCM63XX_TTYS
 	.name		= "ttyS",
+#else
+	.name		= "ttyBCM",
+#endif
 	.write		= bcm_console_write,
 	.device		= uart_console_device,
 	.setup		= bcm_console_setup,
@@ -796,9 +800,13 @@ OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", bcm_early_console_setup);
 static struct uart_driver bcm_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "bcm63xx_uart",
+#ifdef CONFIG_SERIAL_BCM63XX_TTYS
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
+#else
+	.dev_name	= "ttyBCM",
+#endif
 	.nr		= BCM63XX_NR_UARTS,
 	.cons		= BCM63XX_CONSOLE,
 };
-- 
2.1.1
