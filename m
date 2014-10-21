Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:25:13 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61381 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011966AbaJUWXiyjau4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:38 +0200
Received: by mail-pd0-f173.google.com with SMTP id g10so2205911pdj.18
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKG3v+cjfhAW3SQ7UMX54RWwGVDSv1dxcWb9ef3ybls=;
        b=y/Ioi5Jf1SUUQSk5U4yLfE/JJjx4Yt6n0DPn+UDYpTLJnnFu3V/tThq7tPEULx/XNU
         jvKsfsmF9iMXaIs09Hp4MwyTnyzwS6QpsW79nGQFP/pJF7VUFbIBOS3yyeKy51MpHGP0
         LGj/2myR4oN/xyB0FaJF3O/wdycbAt85IJP05D3NGiosAdVUdnWGPfxzcZ9Yki6R78l+
         Ije28V4uwHYZbArrrzppeLzNAHeUBv+nDKTkGsMIxRfC00roiW/rmXOJpO9SiJnIou9h
         Qp0TLefvnUj++fJwS9NOVqYx5DfH7m6XsWZYSaTacHo2Pul3ZVhzjLbNop+UEcRe0mJ3
         ZoxQ==
X-Received: by 10.66.218.202 with SMTP id pi10mr21462402pac.28.1413930212765;
        Tue, 21 Oct 2014 15:23:32 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:32 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 06/10] tty: serial: bcm63xx: Enable DT earlycon support
Date:   Tue, 21 Oct 2014 15:23:02 -0700
Message-Id: <1413930186-23168-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43442
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

This enables early console output if there is a chosen/stdout-path
property referencing a UART node with the "brcm,bcm6345-uart" compatible
string.  The bootloader sets up the pinmux and baud/parity/etc.
Tested on bcm3384 (MIPS, DT).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig        |  1 +
 drivers/tty/serial/bcm63xx_uart.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 815b652..fdd851e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1297,6 +1297,7 @@ config SERIAL_BCM63XX_CONSOLE
 	bool "Console on BCM63xx serial port"
 	depends on SERIAL_BCM63XX=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  If you have enabled the serial port on the BCM63xx CPU
 	  you can make it the console by answering Y to this option.
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index b615af2..109dea7 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -782,6 +782,26 @@ static int __init bcm63xx_console_init(void)
 
 console_initcall(bcm63xx_console_init);
 
+static void bcm_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, bcm_console_putchar);
+	wait_for_xmitr(&dev->port);
+}
+
+static int __init bcm_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = bcm_early_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", bcm_early_console_setup);
+
 #define BCM63XX_CONSOLE	(&bcm63xx_console)
 #else
 #define BCM63XX_CONSOLE	NULL
-- 
2.1.1
