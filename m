Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:48:18 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50505 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013346AbaKLIrRYwY0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:17 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so11704754pdj.26
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uy6H06FxX1Eg+y3xyImkVbMPS8xxkJ27cutHB0z84v4=;
        b=DzBFZ8S+ejPZclo4iY7WsJJI0xl7fQPKN4r3o3Z674xll0nBnv+nVsuZeF3FCqVB4O
         iuPSiAcwgB0ffc93LYEabi1EgcOr5kCn5j0/wL5gbr30bJHsyUoWs/b8HM8LTUQiEg6S
         QkH3UhR59P5WacCB2pQUouOWKYhhpOYycwgV9V8GZZafesz30ycIbDoI9JBBYRcNE3g7
         4HIyjDTnx3I4XK8EqTyFztj2ISq45x7XrUBX+bUYALUe8vpQU8OZnlbvUmnEtuGuOdzu
         bjMonM41Hn5Dti/ixIYH3piCze8XeF3NX1EHEbmAMuaomo3VNKuLk4dC4mSLXS2cqInJ
         KYlg==
X-Received: by 10.70.5.227 with SMTP id v3mr615370pdv.165.1415782031623;
        Wed, 12 Nov 2014 00:47:11 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:11 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian properties
Date:   Wed, 12 Nov 2014 00:46:29 -0800
Message-Id: <1415781993-7755-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44032
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
 drivers/tty/serial/pxa.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 21b7d8b..78ed7ee 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -60,13 +60,19 @@ struct uart_pxa_port {
 static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
 {
 	offset <<= 2;
-	return readl(up->port.membase + offset);
+	if (!up->port.big_endian)
+		return readl(up->port.membase + offset);
+	else
+		return ioread32be(up->port.membase + offset);
 }
 
 static inline void serial_out(struct uart_pxa_port *up, int offset, int value)
 {
 	offset <<= 2;
-	writel(value, up->port.membase + offset);
+	if (!up->port.big_endian)
+		writel(value, up->port.membase + offset);
+	else
+		iowrite32be(value, up->port.membase + offset);
 }
 
 static void serial_pxa_enable_ms(struct uart_port *port)
@@ -833,6 +839,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
+	u32 val;
 
 	if (!np)
 		return 1;
@@ -843,6 +850,11 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 	sport->port.line = ret;
+
+	if (of_property_read_u32(np, "fifo-size", &val) == 0)
+		sport->port.fifosize = val;
+	sport->port.big_endian = of_device_is_big_endian(np);
+
 	return 0;
 }
 
-- 
2.1.1
