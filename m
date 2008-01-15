Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 22:32:47 +0000 (GMT)
Received: from mail-dub.bigfish.com ([213.199.154.10]:8171 "EHLO
	mail6-dub-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20039290AbYAOWch (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 22:32:37 +0000
Received: from mail6-dub (localhost.localdomain [127.0.0.1])
	by mail6-dub-R.bigfish.com (Postfix) with ESMTP id 00B14A089B4;
	Tue, 15 Jan 2008 22:32:31 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.98.75;Service: EHS
Received: by mail6-dub (MessageSwitch) id 1200436349735706_12608; Tue, 15 Jan 2008 22:32:29 +0000 (UCT)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	by mail6-dub.bigfish.com (Postfix) with ESMTP id 985DF12E806E;
	Tue, 15 Jan 2008 22:32:28 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id m0FMWR9Y017136;
	Tue, 15 Jan 2008 22:32:27 GMT
Received: from USBMAXIM02.am.sony.com ([43.145.108.26])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0FMWRIl005106;
	Tue, 15 Jan 2008 22:32:27 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 15 Jan 2008 17:32:27 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 17:32:27 -0500
Subject: [PATCH 1/4] early_printk
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <1200436139.4092.30.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
Content-Type: text/plain
Date:	Tue, 15 Jan 2008 14:31:27 -0800
Message-Id: <1200436287.4092.33.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 22:32:27.0223 (UTC) FILETIME=[81C2D670:01C857C6]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

From: Frank Rowand <frank.rowand@am.sony.com>

Implement early printk in the serial_txx9 driver, and enable for the
Toshiba RBTX4927 board.  This is needed for the connect to GDB console
message.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/mips/Kconfig                                          |    1 	1 +	0 -	0 !
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    6 	6 +	0 -	0 !
 drivers/serial/serial_txx9.c                               |   39 	39 +	0 -	0 !
 3 files changed, 46 insertions(+)

Index: linux-2.6.24-rc7/arch/mips/Kconfig
===================================================================
--- linux-2.6.24-rc7.orig/arch/mips/Kconfig
+++ linux-2.6.24-rc7/arch/mips/Kconfig
@@ -631,6 +631,7 @@ config TOSHIBA_RBTX4927
 	select I8259 if TOSHIBA_FPCIB0
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
+	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
Index: linux-2.6.24-rc7/drivers/serial/serial_txx9.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/serial/serial_txx9.c
+++ linux-2.6.24-rc7/drivers/serial/serial_txx9.c
@@ -1198,6 +1198,45 @@ MODULE_DEVICE_TABLE(pci, serial_txx9_pci
 
 static struct platform_device *serial_txx9_plat_devs;
 
+#ifdef CONFIG_EARLY_PRINTK
+
+/*
+ * Do NOT request the console resources, allows normal driver to initialize
+ * console later.
+ */
+
+static int prom_putchar_port = -1;
+
+void early_printk_serial_txx9_console_setup(void)
+{
+	prom_putchar_port = 0;
+}
+
+void prom_putchar(char ch)
+{
+	unsigned int status;
+	struct uart_txx9_port *up;
+
+	if (prom_putchar_port == -1)
+		return;
+
+	up = &serial_txx9_ports[prom_putchar_port];
+
+	if (ch == '\n')
+		prom_putchar('\r');
+
+	while (1) {
+		status = sio_in(up, TXX9_SICISR);
+		if (status & TXX9_SICISR_TRDY) {
+			sio_out(up, TXX9_SITFIFO, (u32)ch);
+			break;
+		}
+	}
+}
+
+#endif
+
+
 static int __init serial_txx9_init(void)
 {
 	int ret;
Index: linux-2.6.24-rc7/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux-2.6.24-rc7.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux-2.6.24-rc7/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -913,6 +913,12 @@ void __init toshiba_rbtx4927_setup(void)
         if (strstr(argptr, "console=") == NULL) {
                 strcat(argptr, " console=ttyS0,38400");
         }
+#ifdef CONFIG_EARLY_PRINTK
+	{
+		extern void early_printk_serial_txx9_console_setup(void);
+		early_printk_serial_txx9_console_setup();
+	}
+#endif
 #endif
 #endif
 
