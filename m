Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:49:22 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35124 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013493AbaKLIrYbE0H9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:24 +0100
Received: by mail-pd0-f169.google.com with SMTP id y10so11776700pdj.14
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9MNFlUmmMzJRBnbM2sZ/L32D662Kpr16MAIsjtMmXjg=;
        b=eS0P4qdyQyBESFpVHX8KxQDBXIkF0zWpui078cBy9jsDT+dfK04IgNGa5WFNTngy97
         rtOB3qg5Eneovqass+xWr9fxZrUn2j39wrf7vEOJjiFXOZ/lcYX+bnt3S6HUG4xpVDq2
         /2apbjOvC9q8t94VDbdjVslMG0vyji5R409xbf4ybveeSAaYGNjYFXi0x3ViewoSVGco
         niVkFEYlfq4yMARUYda9UnHz4LYFjj4XNlFuIwY6u+cS9xqYAU4ACtgG4QW2I/yfsjpL
         D454duZHAAkCzzqvymT75Tey37Ztuv+orhaxT4S/viA1MwsETxA+CWH+jLGB/5C+dl7p
         NL2Q==
X-Received: by 10.66.142.137 with SMTP id rw9mr17648337pab.124.1415782038894;
        Wed, 12 Nov 2014 00:47:18 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:17 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 8/8] serial: pxa: Add OF_EARLYCON support
Date:   Wed, 12 Nov 2014 00:46:33 -0800
Message-Id: <1415781993-7755-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44036
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
index f6cc773..0764cf5 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -761,6 +761,51 @@ static struct console serial_pxa_console = {
 	.data		= &serial_pxa_reg,
 };
 
+static struct uart_pxa_port serial_pxa_early_port;
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
+	serial_pxa_early_port.port.big_endian = device->port.big_endian;
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
