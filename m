Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 22:35:16 +0000 (GMT)
Received: from mail-dub.bigfish.com ([213.199.154.10]:36705 "EHLO
	mail23-dub-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20039330AbYAOWfH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 22:35:07 +0000
Received: from mail23-dub (localhost.localdomain [127.0.0.1])
	by mail23-dub-R.bigfish.com (Postfix) with ESMTP id A372A6A8955;
	Tue, 15 Jan 2008 22:35:01 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.66.75;Service: EHS
Received: by mail23-dub (MessageSwitch) id 1200436499314188_30744; Tue, 15 Jan 2008 22:34:59 +0000 (UCT)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	by mail23-dub.bigfish.com (Postfix) with ESMTP id 2ADB4590089;
	Tue, 15 Jan 2008 22:34:57 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id m0FMYuVM028551;
	Tue, 15 Jan 2008 22:34:57 GMT
Received: from USBMAXIM01.am.sony.com (us-east-xims.am.sony.com [43.145.108.25])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0FMYuME007446;
	Tue, 15 Jan 2008 22:34:56 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM01.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 15 Jan 2008 17:34:52 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 17:34:52 -0500
Subject: [PATCH 3/4] serial_txx9 driver support
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <1200436139.4092.30.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
Content-Type: text/plain
Date:	Tue, 15 Jan 2008 14:33:52 -0800
Message-Id: <1200436432.4092.38.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 22:34:52.0238 (UTC) FILETIME=[D8325EE0:01C857C6]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

From: Frank Rowand <frank.rowand@am.sony.com>

Add polled debug driver support to serial_txx9.c for kgdb, and initialize
the driver for the Toshiba RBTX4927.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    6 	6 +	0 -	0 !
 drivers/serial/serial_txx9.c                               |   90 	90 +	0 -	0 !
 2 files changed, 96 insertions(+)

Index: linux-2.6.24-rc7/drivers/serial/serial_txx9.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/serial/serial_txx9.c
+++ linux-2.6.24-rc7/drivers/serial/serial_txx9.c
@@ -1237,6 +1237,96 @@ void prom_putchar(char ch)
 #endif
 
 
+/******************************************************************************/
+/* BEG: KDBG Routines                                                         */
+/******************************************************************************/
+
+#ifdef CONFIG_KGDB
+int kgdb_initialized;
+
+void txx9_sio_kgdb_hook(unsigned int port, unsigned int baud_rate)
+{
+	static struct resource kgdb_resource;
+	int ret;
+	struct uart_txx9_port *up = &serial_txx9_ports[port];
+
+	/* prevent initialization by driver */
+	kgdb_resource.name = "serial_txx9(debug)";
+	kgdb_resource.start = (resource_size_t)up->port.membase;
+	kgdb_resource.end = (resource_size_t)up->port.membase + 36 - 1;
+	kgdb_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	ret = request_resource(&iomem_resource, &kgdb_resource);
+	if (ret == -EBUSY)
+		printk(KERN_ERR
+			"txx9_sio_kgdb_hook(): request_resource failed\n");
+
+	return;
+}
+void
+txx9_sio_kdbg_init(unsigned int port_number)
+{
+	if (port_number == 1) {
+		txx9_sio_kgdb_hook(port_number, 38400);
+		kgdb_initialized = 1;
+	} else {
+		printk(KERN_ERR
+			"txx9_sio_kdbg_init(): Bad Port Number [%u] != [1]\n",
+			port_number);
+	}
+
+	return;
+}
+
+u8
+txx9_sio_kdbg_rd(void)
+{
+	unsigned int status, ch;
+	struct uart_txx9_port *up = &serial_txx9_ports[1];
+
+	if (!kgdb_initialized)
+		return 0;
+
+	while (1) {
+		status = sio_in(up, TXX9_SIDISR);
+		if (status & 0x1f) {
+			ch = sio_in(up, TXX9_SIRFIFO);
+			break;
+		}
+	}
+
+	return ch;
+}
+
+int
+txx9_sio_kdbg_wr(u8 ch)
+{
+	unsigned int status;
+	struct uart_txx9_port *up = &serial_txx9_ports[1];
+
+	if (!kgdb_initialized)
+		return 0;
+
+	while (1) {
+		status = sio_in(up, TXX9_SICISR);
+		if (status & TXX9_SICISR_TRDY) {
+			if (ch == '\n')
+				txx9_sio_kdbg_wr('\r');
+			sio_out(up, TXX9_SITFIFO, (u32)ch);
+
+			break;
+		}
+	}
+
+	return 1;
+}
+#endif /* CONFIG_KGDB */
+
+
+/******************************************************************************/
+/* END: KDBG Routines                                                         */
+/******************************************************************************/
+
 static int __init serial_txx9_init(void)
 {
 	int ret;
Index: linux-2.6.24-rc7/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux-2.6.24-rc7.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux-2.6.24-rc7/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -919,6 +919,12 @@ void __init toshiba_rbtx4927_setup(void)
 		early_printk_serial_txx9_console_setup();
 	}
 #endif
+#ifdef CONFIG_KGDB
+	{
+		extern void txx9_sio_kdbg_init(unsigned int port_number);
+		txx9_sio_kdbg_init(1);
+	}
+#endif
 #endif
 #endif
 
