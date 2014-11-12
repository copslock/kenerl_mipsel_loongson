Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:57:26 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59109 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013563AbaKLUy4AHlIm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:56 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so13741190pab.33
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LnyfKTd3jbsxIG026k2YuGW6demfTZ1jNR9cJmkyr0s=;
        b=uvDNZiQ6yB4sbxVyiXykhjNW1bIjqQd5y6RpSOh1ZyBIG3nNLn+2fjFJ/g+W3qRFOM
         ZZmoSuV06nHDO20KkSR+B/hn3+ALyOf/oYpoX6jCF72FdwltSlMlCY30i8LhQYPLaDw8
         PzneNEoay6BAwXxMRtu62oiQ9JLQs0mIlfFj0LjFtz23UYRJAH/VQ4OZCgHp36ImrP/Z
         3nCIE7qkeGNIO6O+2jVpQppun/yJyaG2ssXsL8XT1SP139wP74x71DYycvckfeiBXPyt
         qYKj/asKOwguDgVzCD8wAd7JPobh1VW2jWMbGt2CKOniD671cVeOjooFRWlQDSMmrM2Q
         LPVA==
X-Received: by 10.68.68.137 with SMTP id w9mr50631228pbt.71.1415825690370;
        Wed, 12 Nov 2014 12:54:50 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:49 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 10/10] serial: pxa: Add OF_EARLYCON support
Date:   Wed, 12 Nov 2014 12:54:07 -0800
Message-Id: <1415825647-6024-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44085
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

Implement a bare bones earlycon; this assumes that the bootloader sets
up the tty parameters.  Matches all three compatible strings.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/pxa.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 086b371..0140108 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -761,6 +761,51 @@ static struct console serial_pxa_console = {
 	.data		= &serial_pxa_reg,
 };
 
+static struct uart_pxa_port serial_pxa_early_port __initdata;
+
+static void __init early_wait_for_xmitr(struct uart_pxa_port *up)
+{
+	/* it's unsafe to call udelay() in the "early" variant */
+	while ((serial_in(up, UART_LSR) & BOTH_EMPTY) != BOTH_EMPTY)
+		;
+}
+
+static void __init serial_pxa_early_putchar(struct uart_port *port, int ch)
+{
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+
+	early_wait_for_xmitr(up);
+	serial_out(up, UART_TX, ch);
+}
+
+static void __init serial_pxa_early_write(struct console *con, const char *s,
+					  unsigned n)
+{
+	uart_console_write(&serial_pxa_early_port.port, s, n,
+			   serial_pxa_early_putchar);
+	early_wait_for_xmitr(&serial_pxa_early_port);
+}
+
+static int __init serial_pxa_early_console_setup(struct earlycon_device *device,
+						 const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	serial_pxa_early_port.port.membase = device->port.membase;
+	serial_pxa_early_port.port.iotype = device->port.iotype;
+
+	device->con->write = serial_pxa_early_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(pxa_uart, "mrvl,pxa-uart",
+		    serial_pxa_early_console_setup);
+OF_EARLYCON_DECLARE(mmp_uart, "mrvl,mmp-uart",
+		    serial_pxa_early_console_setup);
+OF_EARLYCON_DECLARE(bcm7401_upg_uart, "brcm,bcm7401-upg-uart",
+		    serial_pxa_early_console_setup);
+
 #define PXA_CONSOLE	&serial_pxa_console
 #else
 #define PXA_CONSOLE	NULL
-- 
2.1.1
