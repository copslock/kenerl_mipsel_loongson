Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 04:36:07 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:44655
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225386AbVFVDfu>; Wed, 22 Jun 2005 04:35:50 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j5M3YdS5027071;
	Wed, 22 Jun 2005 12:34:39 +0900
Date:	Wed, 22 Jun 2005 12:36:25 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [patch 2.6.12 1/1] tx4938: Added kgdb support for Toshiba
 RBHMA4500(TX4938)
Message-Id: <20050622123625.62caaa36.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against 2.6.12 and it works fine. 
Please review it.

	Hiroshi DOYU
----
Added kgdb support for Toshiba RBHMA4500(TX4938)

Signed-off-by: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
----

 arch/mips/tx4938/common/Makefile |    1 
 arch/mips/tx4938/common/dbgio.c  |   50 +++++++++++++++++++++
 drivers/serial/serial_txx9.c     |   90 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

Index: linux/arch/mips/tx4938/common/Makefile
===================================================================
--- linux.orig/arch/mips/tx4938/common/Makefile	2005-06-22 11:59:51.110947320 +0900
+++ linux/arch/mips/tx4938/common/Makefile	2005-06-22 11:59:55.294311352 +0900
@@ -7,4 +7,5 @@
 #
 
 obj-y	+= prom.o setup.o irq.o irq_handler.o rtc_rx5c348.o
+obj-$(CONFIG_KGDB) += dbgio.o
 
Index: linux/arch/mips/tx4938/common/dbgio.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/dbgio.c	2005-06-22 12:03:12.064397752 +0900
@@ -0,0 +1,50 @@
+/*
+ * linux/arch/mips/tx4938/common/dbgio.c
+ *
+ * kgdb interface for gdb
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Support for TX4938 in 2.6 - Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
+ */
+
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <asm/tx4938/tx4938_mips.h>
+
+extern u8 txx9_sio_kdbg_rd(void);
+extern int txx9_sio_kdbg_wr( u8 ch );
+
+u8 getDebugChar(void)
+{
+	return (txx9_sio_kdbg_rd());
+}
+
+int putDebugChar(u8 byte)
+{
+	return (txx9_sio_kdbg_wr(byte));
+}
+
Index: linux/drivers/serial/serial_txx9.c
===================================================================
--- linux.orig/drivers/serial/serial_txx9.c	2005-06-22 11:55:50.169575976 +0900
+++ linux/drivers/serial/serial_txx9.c	2005-06-22 11:59:55.295311200 +0900
@@ -1129,6 +1129,96 @@
 MODULE_DEVICE_TABLE(pci, serial_txx9_pci_tbl);
 #endif /* ENABLE_SERIAL_TXX9_PCI */
 
+/******************************************************************************/
+/* BEG: KDBG Routines                                                         */
+/******************************************************************************/
+
+#ifdef CONFIG_KGDB
+int kgdb_init_count = 0;
+
+void txx9_sio_kgdb_hook(unsigned int port, unsigned int baud_rate)
+{
+	static struct resource kgdb_resource;
+	int ret;
+	struct uart_txx9_port *up = &serial_txx9_ports[port];
+
+	/* prevent initialization by driver */
+	kgdb_resource.name = "serial_txx9(debug)";
+	kgdb_resource.start = up->port.membase;
+	kgdb_resource.end = up->port.membase + 36 - 1;
+	kgdb_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	ret = request_resource(&iomem_resource, &kgdb_resource);
+	if(ret == -EBUSY)
+		printk(" serial_txx9(debug): request_resource failed\n");
+
+	return;
+}
+void
+txx9_sio_kdbg_init( unsigned int port_number )
+{
+	if (port_number == 1) {
+		txx9_sio_kgdb_hook(port_number, 38400);
+	} else {
+		printk("Bad Port Number [%u] != [1]\n",port_number);
+	}
+	return;
+}
+
+u8
+txx9_sio_kdbg_rd( void )
+{
+	unsigned int status,ch;
+	struct uart_txx9_port *up = &serial_txx9_ports[1];
+
+	if (kgdb_init_count == 0) {
+		txx9_sio_kdbg_init(1);
+		kgdb_init_count = 1;
+	}
+
+	while (1) {
+		status = sio_in(up, TXX9_SIDISR);
+		if ( status & 0x1f ) {
+			ch = sio_in(up, TXX9_SIRFIFO );
+			break;
+		}
+	}
+
+	return (ch);
+}
+
+int
+txx9_sio_kdbg_wr( u8 ch )
+{
+	unsigned int status;
+	struct uart_txx9_port *up = &serial_txx9_ports[1];
+
+	if (kgdb_init_count == 0) {
+		txx9_sio_kdbg_init(1);
+		kgdb_init_count = 1;
+	}
+
+	while (1) {
+		status = sio_in(up, TXX9_SICISR);
+		if (status & TXX9_SICISR_TRDY) {
+			if ( ch == '\n' ) {
+				txx9_sio_kdbg_wr( '\r' );
+			}
+			sio_out(up, TXX9_SITFIFO, (u32)ch );
+
+			break;
+		}
+	}
+
+	return (1);
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
