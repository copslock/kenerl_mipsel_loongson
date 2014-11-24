Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:38:31 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37726 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013720AbaKXXgodUVwa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:44 +0100
Received: by mail-pa0-f42.google.com with SMTP id et14so10490467pad.15
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3DZ8FkQRiY6bEy9Jh+NBoxPwBKOAmH0zEdJKdtJCJq4=;
        b=vrPNyPfyx5eaEStofnKCxqAtUz9FItag/1BFSPk1G9GTUT6qWf0EsYvkcKq20jNifU
         zf6wtBMh1k6LC8By3MbTCoB7Ioi0Oy86xsG5au3x6tkHDP8TYKM6cFiDyCjyiqW1E3Vt
         2XXbkwRtOtvY4B0ns0zBsLu6yC5EFkYeg86tR/nAXccHY437FDFgZK04abCct/PV2H6K
         OUiIqLnZhZc2KHH3C83H4h0zEUMf2Sx3e97f0eLOe09j5u06C9MxN0dyCbZHwyG8FE7/
         laWm1kXrOLCOJe24EsYNk9UEmalIdfZDAha//Ql+gUpRFXT4HXWQNfgulcCBLMRi7MWS
         KDrg==
X-Received: by 10.66.136.137 with SMTP id qa9mr36749748pab.129.1416872198908;
        Mon, 24 Nov 2014 15:36:38 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:38 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 7/7] serial: 8250: Add support for big-endian MMIO accesses
Date:   Mon, 24 Nov 2014 15:36:22 -0800
Message-Id: <1416872182-6440-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44419
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

Add cases for UPIO_MEM32BE wherever there are currently cases handling
UPIO_MEM32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c  | 20 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_early.c |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ca5cfdc..53982f0 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -428,6 +428,18 @@ static unsigned int mem32_serial_in(struct uart_port *p, int offset)
 	return readl(p->membase + offset);
 }
 
+static void mem32be_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = offset << p->regshift;
+	iowrite32be(value, p->membase + offset);
+}
+
+static unsigned int mem32be_serial_in(struct uart_port *p, int offset)
+{
+	offset = offset << p->regshift;
+	return ioread32be(p->membase + offset);
+}
+
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -466,6 +478,11 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = mem32_serial_out;
 		break;
 
+	case UPIO_MEM32BE:
+		p->serial_in = mem32be_serial_in;
+		p->serial_out = mem32be_serial_out;
+		break;
+
 #if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
@@ -491,6 +508,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 	switch (p->iotype) {
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
@@ -2655,6 +2673,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_MEM:
 		if (!port->mapbase)
 			break;
@@ -2691,6 +2710,7 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_MEM:
 		if (!port->mapbase)
 			break;
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 4858b8a..33a0fb6 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -45,6 +45,8 @@ unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offse
 		return readb(port->membase + offset);
 	case UPIO_MEM32:
 		return readl(port->membase + (offset << 2));
+	case UPIO_MEM32BE:
+		return ioread32be(port->membase + (offset << 2));
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
 	default:
@@ -61,6 +63,9 @@ void __weak __init serial8250_early_out(struct uart_port *port, int offset, int
 	case UPIO_MEM32:
 		writel(value, port->membase + (offset << 2));
 		break;
+	case UPIO_MEM32BE:
+		iowrite32be(value, port->membase + (offset << 2));
+		break;
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
-- 
2.1.0
