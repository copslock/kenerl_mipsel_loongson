Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:56:29 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39850 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011967AbaJTUzIVG4qF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:08 +0200
Received: by mail-pd0-f179.google.com with SMTP id r10so5633445pdi.24
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LRV093ZJeE7UbCqCoKj+g5IZ+AFSO0zb0CEwEOCXQ3o=;
        b=AkSQPAhVTK07Q6DEzB/4EvP1ZSjX+PLJbyFlmQEp0IFdsxasr8Rs5tFDOKD1jrw6ue
         UdkydrldwiIY8+2FU8FNAlYHKwTSam9aC29q8xljaCASDd4D9rDm4+RT4Y1e1H8LQDSU
         DeXu1EFVHrd5oJ1LXzx0MGr7rOrxOvx5/hxgFpXeY65e2waLPZ+ZuX36pEK60i2fCnEo
         670Mq+df4McMdIQsVwMbk5Jdj3QgzYpT7uOMhm15vMyDj9/wG0MiqEnNh4yA5QjLTsHM
         +JAwrSonW3sW6rOj0U3NI2Pmt7/tok4jh9V0JEtVBPpgeUOy/3mnMp7vuTNt59u+hQOI
         4RSg==
X-Received: by 10.70.135.226 with SMTP id pv2mr22777054pdb.11.1413838502443;
        Mon, 20 Oct 2014 13:55:02 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.55.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:55:01 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 5/9] tty: serial: bcm63xx: Enable DT earlycon support
Date:   Mon, 20 Oct 2014 13:54:04 -0700
Message-Id: <1413838448-29464-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43384
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
index a70910e..2015284 100644
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
