Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 22:52:38 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:5192 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28640956AbYCRWwM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 22:52:12 +0000
Received: by mo.po.2iij.net (mo30) id m2IMpm4m080801; Wed, 19 Mar 2008 07:51:48 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id m2IMphhQ013534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Mar 2008 07:51:43 +0900
Message-Id: <200803182251.m2IMphhQ013534@po-mbox302.po.2iij.net>
Date:	Wed, 19 Mar 2008 07:49:57 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] add vr41xx_siu_early_setup() for serial console
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add vr41xx_siu_early_setup() for serial console

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/serial/vr41xx_siu.c linux/drivers/serial/vr41xx_siu.c
--- linux-orig/drivers/serial/vr41xx_siu.c	2008-03-12 17:03:43.420462106 +0900
+++ linux/drivers/serial/vr41xx_siu.c	2008-03-12 17:03:38.730540709 +0900
@@ -1,7 +1,7 @@
 /*
  *  Driver for NEC VR4100 series Serial Interface Unit.
  *
- *  Copyright (C) 2004-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2004-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  Based on drivers/serial/8250.c, by Russell King.
  *
@@ -840,6 +840,19 @@ static int __devinit siu_console_init(vo
 
 console_initcall(siu_console_init);
 
+void __init vr41xx_siu_early_setup(struct uart_port *port)
+{
+	if (port->type == PORT_UNKNOWN)
+		return;
+
+	siu_uart_ports[port->line].line = port->line;
+	siu_uart_ports[port->line].type = port->type;
+	siu_uart_ports[port->line].uartclk = SIU_BAUD_BASE * 16;
+	siu_uart_ports[port->line].mapbase = port->mapbase;
+	siu_uart_ports[port->line].mapbase = port->mapbase;
+	siu_uart_ports[port->line].ops = &siu_uart_ops;
+}
+
 #define SERIAL_VR41XX_CONSOLE	&siu_console
 #else
 #define SERIAL_VR41XX_CONSOLE	NULL
