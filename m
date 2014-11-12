Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:56:20 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44129 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013574AbaKLUyspe01P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:48 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so12990447pdj.33
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeXN0av0SJQvR2KPqkHZh9ijGc0iU0NsH2HOsiVwSx4=;
        b=nbOieWznr6vGFRxjUWJNUbU1Evi4gBvtmWJehvcp9ofSWxp7am7/l2btMPayoVTLS0
         lodD06dfiimQtDAyX3NDiNEisA2NMpkxUeV2y9DhmKF64oMoAuNAjxF7DTxgpHgUlP7I
         FtBunOAkRBvng1oblMwsJZ4G40aUeYsh8a93aKC+P9jrqXDoJGMfjW/HuWe7WzbWwag/
         JrBhoHZeyg+12p+z+sSeuL5yDN0sf22zH0Xt8Ab6XIMIrIckZK0vOVA/UPsavyu5QPVv
         0vyzPaCurlqI8LoTCOTmpeoDWTEB55LrLzDZL2NUBwdoyaX/UMIISITEsIrx3qUrJM/x
         hglg==
X-Received: by 10.68.197.170 with SMTP id iv10mr22421207pbc.135.1415825683118;
        Wed, 12 Nov 2014 12:54:43 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:42 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 06/10] serial: pxa: Add fifo-size and {big,native}-endian properties
Date:   Wed, 12 Nov 2014 12:54:03 -0800
Message-Id: <1415825647-6024-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44081
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

With a few tweaks, the PXA serial driver can handle other 16550A clones.
Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
and {native,big}-endian properties similar to regmap to support SoCs that
have BE or "automagic endian" registers.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/pxa.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 21b7d8b..21406dc 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -60,13 +60,19 @@ struct uart_pxa_port {
 static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
 {
 	offset <<= 2;
-	return readl(up->port.membase + offset);
+	if (up->port.iotype == UPIO_MEM32BE)
+		return ioread32be(up->port.membase + offset);
+	else
+		return readl(up->port.membase + offset);
 }
 
 static inline void serial_out(struct uart_pxa_port *up, int offset, int value)
 {
 	offset <<= 2;
-	writel(value, up->port.membase + offset);
+	if (up->port.iotype == UPIO_MEM32BE)
+		iowrite32be(value, up->port.membase + offset);
+	else
+		writel(value, up->port.membase + offset);
 }
 
 static void serial_pxa_enable_ms(struct uart_port *port)
@@ -833,6 +839,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
+	u32 val;
 
 	if (!np)
 		return 1;
@@ -843,6 +850,13 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 	sport->port.line = ret;
+
+	if (of_property_read_u32(np, "fifo-size", &val) == 0)
+		sport->port.fifosize = val;
+
+	sport->port.iotype =
+		of_device_is_big_endian(np) ? UPIO_MEM32BE : UPIO_MEM32;
+
 	return 0;
 }
 
-- 
2.1.1
