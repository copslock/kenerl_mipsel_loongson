Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 10:26:45 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:14866
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224839AbUHKJ0k>; Wed, 11 Aug 2004 10:26:40 +0100
Received: from comm1.baslerweb.com (proxy.baslerweb.com [172.16.13.2])
          by proxy.baslerweb.com (Post.Office MTA v3.5.3 release 223
          ID# 0-0U10L2S100V35) with ESMTP id com
          for <linux-mips@linux-mips.org>; Wed, 11 Aug 2004 11:25:43 +0200
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id PLG5SNFT; Wed, 11 Aug 2004 11:26:37 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: [PATCH] serial support for yosemite
Date: Wed, 11 Aug 2004 11:28:44 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111128.44965.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

this is a revised version of my previous yosemite patch.
It adds fully interrrupt-driven operation for both
serial ports as well as working kgdb support. It also
updates yosemite_defconfig to reflect the code changes.

tk




diff -rpu linux-mips/arch/mips/pmc-sierra/yosemite/dbg_io.c linux-mips-work/arch/mips/pmc-sierra/yosemite/dbg_io.c
--- linux-mips/arch/mips/pmc-sierra/yosemite/dbg_io.c	2004-05-20 17:01:41.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/dbg_io.c	2004-08-10 11:14:44.000000000 +0200
@@ -23,18 +23,22 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/*
- * Support for KGDB for the Yosemite board. We make use of single serial
- * port to be used for KGDB as well as console. The second serial port
- * seems to be having a problem. Single IRQ is allocated for both the
- * ports. Hence, the interrupt routing code needs to figure out whether
- * the interrupt came from channel A or B.
- */
-
 #include <linux/config.h>
+#include <asm/io.h>
+
+#include "setup.h"
 
 #if defined(CONFIG_KGDB)
-#include <asm/serial.h>
+
+#if defined(CONFIG_SERIAL_8250) && CONFIG_SERIAL_8250_NR_UARTS > 1
+#error Debug port used by serial driver
+#endif
+
+#define TITAN_UART_CLK		3686400
+#define TITAN_SERIAL_BASE_BAUD	(TITAN_UART_CLK / 16)
+#define TITAN_SERIAL_BASE_0	0xfd000008UL
+#define TITAN_SERIAL_BASE_1	0xfd000000UL
+
 
 /*
  * Baud rate, Parity, Data and Stop bit settings for the
@@ -71,6 +75,7 @@
 #define	SERIAL_SEND_BUFFER	0x0
 #define	SERIAL_INTR_ENABLE	(1 * SERIAL_REG_OFS)
 #define	SERIAL_INTR_ID		(2 * SERIAL_REG_OFS)
+#define	SERIAL_FIFO_CONTROL	SERIAL_INTR_ID
 #define	SERIAL_DATA_FORMAT	(3 * SERIAL_REG_OFS)
 #define	SERIAL_LINE_CONTROL	(3 * SERIAL_REG_OFS)
 #define	SERIAL_MODEM_CONTROL	(4 * SERIAL_REG_OFS)
@@ -84,59 +89,26 @@
 #define	SERIAL_DIVISOR_MSB	(1 * SERIAL_REG_OFS)
 
 /*
- * Functions to READ and WRITE to serial port 0
+ * Functions to READ and WRITE to serial port
  */
-#define	SERIAL_READ(ofs)		(*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE + ofs)))
-
-#define	SERIAL_WRITE(ofs, val)		((*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE + ofs))) = val)
+#define	SERIAL_READ(ofs)		readb(serbase + ofs)
+#define	SERIAL_WRITE(ofs, val)		writeb((val), serbase + ofs)
 
-/*
- * Functions to READ and WRITE to serial port 1
- */
-#define	SERIAL_READ_1(ofs)		(*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE_1 + ofs)
-
-#define	SERIAL_WRITE_1(ofs, val)	((*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE_1 + ofs))) = val)
-
-/*
- * Second serial port initialization
- */
-void init_second_port(void)
-{
-	/* Disable Interrupts */
-	SERIAL_WRITE_1(SERIAL_LINE_CONTROL, 0x0);
-	SERIAL_WRITE_1(SERIAL_INTR_ENABLE, 0x0);
-
-	{
-		unsigned int divisor;
-
-		SERIAL_WRITE_1(SERIAL_LINE_CONTROL, 0x80);
-		divisor = TITAN_SERIAL_BASE_BAUD / YOSEMITE_BAUD_115200;
-		SERIAL_WRITE_1(SERIAL_DIVISOR_LSB, divisor & 0xff);
-
-		SERIAL_WRITE_1(SERIAL_DIVISOR_MSB,
-			       (divisor & 0xff00) >> 8);
-		SERIAL_WRITE_1(SERIAL_LINE_CONTROL, 0x0);
-	}
-
-	SERIAL_WRITE_1(SERIAL_DATA_FORMAT, YOSEMITE_DATA_8BIT |
-		       YOSEMITE_PARITY_NONE | YOSEMITE_STOP_1BIT);
-
-	/* Enable Interrupts */
-	SERIAL_WRITE_1(SERIAL_INTR_ENABLE, 0xf);
-}
+static int initialized = 0;
 
 /* Initialize the serial port for KGDB debugging */
 void debugInit(unsigned int baud, unsigned char data, unsigned char parity,
-	       unsigned char stop)
+	unsigned char stop)
 {
+	initialized = 1;
+	
 	/* Disable Interrupts */
 	SERIAL_WRITE(SERIAL_LINE_CONTROL, 0x0);
 	SERIAL_WRITE(SERIAL_INTR_ENABLE, 0x0);
 
+	/* Disable FIFOs */
+	SERIAL_WRITE(SERIAL_FIFO_CONTROL, 0x00);
+
 	{
 		unsigned int divisor;
 
@@ -152,15 +124,11 @@ void debugInit(unsigned int baud, unsign
 	SERIAL_WRITE(SERIAL_DATA_FORMAT, data | parity | stop);
 }
 
-static int remoteDebugInitialized = 0;
-
 unsigned char getDebugChar(void)
 {
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
+	if (!initialized) {
 		debugInit(YOSEMITE_BAUD_115200,
-			  YOSEMITE_DATA_8BIT,
-			  YOSEMITE_PARITY_NONE, YOSEMITE_STOP_1BIT);
+			  YOSEMITE_DATA_8BIT, YOSEMITE_PARITY_NONE, YOSEMITE_STOP_1BIT);
 	}
 
 	while ((SERIAL_READ(SERIAL_LINE_STATUS) & 0x1) == 0);
@@ -169,11 +137,9 @@ unsigned char getDebugChar(void)
 
 int putDebugChar(unsigned char byte)
 {
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
+	if (!initialized) {
 		debugInit(YOSEMITE_BAUD_115200,
-			  YOSEMITE_DATA_8BIT,
-			  YOSEMITE_PARITY_NONE, YOSEMITE_STOP_1BIT);
+			  YOSEMITE_DATA_8BIT, YOSEMITE_PARITY_NONE, YOSEMITE_STOP_1BIT);
 	}
 
 	while ((SERIAL_READ(SERIAL_LINE_STATUS) & 0x20) == 0);
diff -rpu linux-mips/arch/mips/pmc-sierra/yosemite/irq.c linux-mips-work/arch/mips/pmc-sierra/yosemite/irq.c
--- linux-mips/arch/mips/pmc-sierra/yosemite/irq.c	2004-07-14 16:21:29.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/irq.c	2004-08-10 11:33:57.000000000 +0200
@@ -110,7 +110,6 @@ asmlinkage void ll_ht_smp_irq_handler(in
 }
 
 #ifdef CONFIG_KGDB
-extern void init_second_port(void);
 extern void breakpoint(void);
 extern void set_debug_traps(void);
 #endif
@@ -126,18 +125,6 @@ void __init init_IRQ(void)
 	init_generic_irq();
 	mips_cpu_irq_init(0);
 	rm7k_cpu_irq_init(8);
-
-#ifdef CONFIG_KGDB
-	/* At this point, initialize the second serial port */
-	init_second_port();
-	printk("Start kgdb ... \n");
-	set_debug_traps();
-	breakpoint();
-#endif
-
-#ifdef CONFIG_GDB_CONSOLE
-	register_gdb_console();
-#endif
 }
 
 #ifdef CONFIG_KGDB
diff -rpu linux-mips/arch/mips/pmc-sierra/yosemite/setup.c linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.c
--- linux-mips/arch/mips/pmc-sierra/yosemite/setup.c	2004-07-20 11:43:44.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.c	2004-08-11 11:09:43.493286520 +0200
@@ -22,6 +22,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#include <linux/config.h>
 #include <linux/bcd.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -44,6 +45,7 @@
 #include <asm/reboot.h>
 #include <asm/pci_channel.h>
 #include <asm/serial.h>
+#include <asm/gdb-stub.h>
 #include <linux/termios.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -58,6 +60,7 @@ unsigned char titan_ge_mac_addr_base[6] 
 
 unsigned long cpu_clock;
 unsigned long yosemite_base;
+volatile unsigned char * serbase;
 
 void __init bus_error_init(void)
 {
@@ -156,11 +159,13 @@ EXPORT_SYMBOL(ocd_base);
 #define TITAN_UART_CLK		3686400
 #define TITAN_SERIAL_BASE_BAUD	(TITAN_UART_CLK / 16)
 #define TITAN_SERIAL_IRQ	4
-#define TITAN_SERIAL_BASE	0xfd000008UL
+#define TITAN_SERIAL_BASE	0xfd000000UL
+#define TITAN_SERIAL_REG_SIZE	8
 
 static void __init py_map_ocd(void)
 {
-        struct uart_port up;
+	static const char serr[] = KERN_ERR "Serial port #%u setup failed\n";
+	struct uart_port up;
 
 	/*
 	 * Not specifically interrupt stuff but in case of SMP core_send_ipi
@@ -170,21 +175,45 @@ static void __init py_map_ocd(void)
 	if (!ocd_base)
 		panic("Mapping OCD failed - game over.  Your score is 0.");
 
+	/* Map uart registers */
+	serbase = (unsigned char *) ioremap(TITAN_SERIAL_BASE, TITAN_SERIAL_REG_SIZE * 2);
+	if (!serbase)
+		panic("Failed to map UART registers");
+
+#if defined(CONFIG_SERIAL_8250)
 	/*
-	 * Register to interrupt zero because we share the interrupt with
-	 * the serial driver which we don't properly support yet.
+	 * Set up serial port #0. Do not use autodetection; the result is
+	 * not what we want.
 	 */
 	memset(&up, 0, sizeof(up));
-	up.membase      = (unsigned char *) ioremap(TITAN_SERIAL_BASE, 8);
+	up.membase      = serbase + TITAN_SERIAL_REG_SIZE;
 	up.irq          = TITAN_SERIAL_IRQ;
 	up.uartclk      = TITAN_UART_CLK;
 	up.regshift     = 0;
 	up.iotype       = UPIO_MEM;
-	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	up.type         = PORT_16550A;
+	up.flags        = UPF_SHARE_IRQ;
 	up.line         = 0;
+	if (early_serial_setup(&up))
+		printk(serr, up.line);
 
+#if CONFIG_SERIAL_8250_NR_UARTS > 1
+	/* And now for port #1. */
+	up.membase      = serbase;
+	up.line         = 1;
 	if (early_serial_setup(&up))
-		printk(KERN_ERR "Early serial init of port 0 failed\n");
+		printk(serr, up.line);
+#endif /* CONFIG_SERIAL_8250_NR_UARTS > 1 */
+#endif  /* defined(CONFIG_SERIAL_8250) */
+
+#ifdef CONFIG_KGDB
+	printk(KERN_INFO "Start kgdb ... \n");
+#ifdef CONFIG_GDB_CONSOLE
+	register_gdb_console();
+#endif
+	set_debug_traps();
+	breakpoint();
+#endif
 }
 
 static int __init pmc_yosemite_setup(void)
diff -rpu linux-mips/arch/mips/pmc-sierra/yosemite/setup.h linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.h
--- linux-mips/arch/mips/pmc-sierra/yosemite/setup.h	2004-05-24 12:32:42.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.h	2004-08-10 11:02:16.000000000 +0200
@@ -28,4 +28,7 @@
 #define	TITAN_ATMEL_24C32_SIZE		32768
 #define	TITAN_ATMEL_24C64_SIZE		65536
 
+/* UART base */
+extern volatile unsigned char * serbase;
+
 #endif /* __SETUP_H__ */
--- linux-mips/arch/mips/configs/yosemite_defconfig	2004-08-11 10:56:37.292807160 +0200
+++ linux-mips-work/arch/mips/configs/yosemite_defconfig	2004-08-11 11:22:35.905861960 +0200
@@ -352,8 +352,13 @@ CONFIG_SOUND_GAMEPORT=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_MULTIPORT is not set
+# CONFIG_SERIAL_8250_RSA is not set
 
 #
 # Non-8250 serial port support

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
