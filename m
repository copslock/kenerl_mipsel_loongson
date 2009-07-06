Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 20:42:40 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17202 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492902AbZGFSmd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 20:42:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a5243f20000>; Mon, 06 Jul 2009 14:35:30 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Jul 2009 11:34:41 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Jul 2009 11:34:41 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n66IYbHH008569;
	Mon, 6 Jul 2009 11:34:37 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n66IYabW008567;
	Mon, 6 Jul 2009 11:34:36 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix support for Cavium Octeon debugger stub.
Date:	Mon,  6 Jul 2009 11:34:36 -0700
Message-Id: <1246905276-8543-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 06 Jul 2009 18:34:41.0598 (UTC) FILETIME=[6D06B5E0:01C9FE68]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The Cavium Octeon bootloader has a debugger stub that requires a
little help from the target application to break in.

If configured, when we get an interrupt on the debug uart we wake up
the debugger.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig.debug               |   10 ++++++
 arch/mips/cavium-octeon/serial.c      |   53 ++++++++++++++++++++++++++++++++-
 arch/mips/cavium-octeon/setup.c       |   10 ++++++
 arch/mips/include/asm/octeon/octeon.h |    1 -
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 364ca89..f6a0e68 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -42,6 +42,16 @@ config SB1XXX_CORELIS
 	  Select compile flags that produce code that can be processed by the
 	  Corelis mksym utility and UDB Emulator.
 
+config CAVIUM_GDB
+	bool "Remote GDB debugging using the Cavium Networks Multicore GDB"
+	depends on DEBUG_KERNEL
+	depends on CPU_CAVIUM_OCTEON
+	select DEBUG_INFO
+	help
+	  If you say Y here, it will be possible to remotely debug the MIPS
+	  kernel using the Cavium Networks GDB with extended SMP support.
+	  This is only useful for kernel hackers. If unsure, say N.
+
 config RUNTIME_DEBUG
 	bool "Enable run-time debugging"
 	depends on DEBUG_KERNEL
diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
index 8240728..2110e68 100644
--- a/arch/mips/cavium-octeon/serial.c
+++ b/arch/mips/cavium-octeon/serial.c
@@ -18,11 +18,60 @@
 
 #include <asm/octeon/octeon.h>
 
+#if defined(CONFIG_CAVIUM_GDB)
+
 #ifdef CONFIG_GDB_CONSOLE
 #define DEBUG_UART 0
 #else
 #define DEBUG_UART 1
 #endif
+static irqreturn_t interrupt_debug_char(int cpl, void *dev_id)
+{
+	unsigned long lsrval;
+	unsigned long tmp;
+
+	lsrval = cvmx_read_csr(CVMX_MIO_UARTX_LSR(DEBUG_UART));
+	if (lsrval & 1) {
+#ifdef CONFIG_KGDB
+		/*
+		 * The Cavium EJTAG bootmonitor stub is not compatible
+		 * with KGDB.  We should never get here.
+		 */
+#error Illegal to use both CONFIG_KGDB and CONFIG_CAVIUM_GDB
+#endif
+		/*
+		 * Pulse MCD0 signal on Ctrl-C to stop all the
+		 * cores. Also set the MCD0 to be not masked by this
+		 * core so we know the signal is received by
+		 * someone.
+		 */
+		octeon_write_lcd("brk");
+		asm volatile ("dmfc0 %0, $22\n\t"
+			      "ori   %0, %0, 0x10\n\t"
+			      "dmtc0 %0, $22" : "=r" (tmp));
+		octeon_write_lcd("");
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+/* Enable uart1 interrupts for debugger Control-C processing */
+
+static int octeon_setup_debug_uart(void)
+{
+	if (request_irq(OCTEON_IRQ_UART0 + DEBUG_UART, interrupt_debug_char,
+			IRQF_SHARED, "KGDB", interrupt_debug_char)) {
+		panic("request_irq(%d) failed.", OCTEON_IRQ_UART0 + DEBUG_UART);
+	}
+	cvmx_write_csr(CVMX_MIO_UARTX_IER(DEBUG_UART),
+		       cvmx_read_csr(CVMX_MIO_UARTX_IER(DEBUG_UART)) | 1);
+	return 0;
+}
+
+/* Install this as early as possible to be able to debug the boot
+   sequence.  */
+core_initcall(octeon_setup_debug_uart);
+#endif	/* CONFIG_CAVIUM_GDB */
 
 unsigned int octeon_serial_in(struct uart_port *up, int offset)
 {
@@ -97,7 +146,9 @@ static int __init octeon_serial_init(void)
 	enable_uart1 = 1;
 #endif
 #endif
-
+#ifdef CONFIG_CAVIUM_GDB
+	enable_uart1 = 0;
+#endif
 	/* Right now CN52XX is the only chip with a third uart */
 	enable_uart2 = OCTEON_IS_MODEL(OCTEON_CN52XX);
 
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index e195ea8..dc9f461 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -295,6 +295,16 @@ static void octeon_halt(void)
 	octeon_kill_core(NULL);
 }
 
+/**
+ * Return the debug flag passed by the bootloader
+ *
+ * Return debug flag (0 or 1)
+ */
+static int octeon_get_boot_debug_flag(void)
+{
+	return (octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_DEBUG) != 0;
+}
+
 #if 0
 /**
  * Platform time init specifics.
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index cac9b1a..f3c2b15 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -214,7 +214,6 @@ struct octeon_cf_data {
 
 extern void octeon_write_lcd(const char *s);
 extern void octeon_check_cpu_bist(void);
-extern int octeon_get_boot_debug_flag(void);
 extern int octeon_get_boot_uart(void);
 
 struct uart_port;
-- 
1.6.0.6
