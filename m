Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 19:27:33 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:31486 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011799AbaJSR1bpC5Vo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 19:27:31 +0200
X-IronPort-AV: E=Sophos;i="5.04,749,1406617200"; 
   d="scan'208";a="48822033"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 19 Oct 2014 11:48:46 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Sun, 19 Oct 2014 10:27:37 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Sun, 19 Oct 2014 10:27:31 -0700
Received: from kcl.broadcom.com (ld-irv-0001 [10.12.156.101])   by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id BFA3840FE5;  Sun, 19 Oct
 2014 10:27:10 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.cz>
CC:     <f.fainelli@gmail.com>, <mbizon@freebox.fr>, <jogo@openwrt.org>,
        <linux-mips@linux-mips.org>, <linux-serial@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 4/3] tty: serial: bcm63xx: Enable DT earlycon support
Date:   Sun, 19 Oct 2014 10:26:15 -0700
Message-ID: <1413739575-10222-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43335
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
index 2315190..48bd509 100644
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
