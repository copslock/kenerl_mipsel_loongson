Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 14:08:38 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:8466
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224931AbUIWNIc>; Thu, 23 Sep 2004 14:08:32 +0100
Received: from comm1.baslerweb.com (proxy.baslerweb.com [172.16.13.2])
          by proxy.baslerweb.com (Post.Office MTA v3.5.3 release 223
          ID# 0-0U10L2S100V35) with ESMTP id com;
          Thu, 23 Sep 2004 15:07:41 +0200
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id TPGPBX2L; Thu, 23 Sep 2004 15:08:30 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] pmc-sierra yosemite serial i/o support
Date: Thu, 23 Sep 2004 15:11:06 +0200
User-Agent: KMail/1.6.2
References: <200409221651.12521.thomas.koeller@baslerweb.com> <4151AB96.4090704@mvista.com>
In-Reply-To: <4151AB96.4090704@mvista.com>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409231511.06274.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Wednesday 22 September 2004 18:43, Manish Lachwani wrote:
>
> Hello Thomas
>
> Sure, please send the patches over to me so that I can take a look at it.
>
> thanks
> Manish

Hi Manish,

here's the patch again, as a diff against current cvs head. It addresses the
following issues:

- avoids autodetection of the uart chip type. The chip was always detected as
  a fifo-less 16540. Autodetection really isn't required here, since we know
  exactly what we're dealing with.

- enables interrupt sharing for both ports. Since the two uart interrupt lines
  are physically ORed together, this makes the second port fully usable.

- use 'arch_initcall' instead of the 'late_time_init' hook, as is appropriate.

thomas



Signed-off-by: Thomas Koeller  <thomas.koeller@baslerweb.com>

diff -ru linux-mips-cvs/arch/mips/pmc-sierra/yosemite/dbg_io.c linux-mips-work/arch/mips/pmc-sierra/yosemite/dbg_io.c
--- linux-mips-cvs/arch/mips/pmc-sierra/yosemite/dbg_io.c	2004-08-20 12:30:47.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/dbg_io.c	2004-09-23 14:04:12.002692920 +0200
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
+  
 #ifdef CONFIG_KGDB
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
@@ -84,59 +89,28 @@
 #define	SERIAL_DIVISOR_MSB	(1 * SERIAL_REG_OFS)
 
 /*
- * Functions to READ and WRITE to serial port 0
+ * Functions to READ and WRITE to serial port
  */
 #define	SERIAL_READ(ofs)		(*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE + ofs)))
-
+					(serbase + ofs)))
 #define	SERIAL_WRITE(ofs, val)		((*((volatile unsigned char*)	\
-					(TITAN_SERIAL_BASE + ofs))) = val)
-
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
+					(serbase + ofs))) = val)
 
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
 
@@ -152,15 +126,11 @@
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
@@ -169,11 +139,9 @@
 
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
diff -ru linux-mips-cvs/arch/mips/pmc-sierra/yosemite/irq.c linux-mips-work/arch/mips/pmc-sierra/yosemite/irq.c
--- linux-mips-cvs/arch/mips/pmc-sierra/yosemite/irq.c	2004-08-20 12:30:47.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/irq.c	2004-09-21 13:22:13.000000000 +0200
@@ -109,10 +109,6 @@
 	do_IRQ(irq, regs);
 }
 
-#ifdef CONFIG_KGDB
-extern void init_second_port(void);
-#endif
-
 /*
  * Initialize the next level interrupt handler
  */
@@ -123,15 +119,6 @@
 	set_except_vector(0, titan_handle_int);
 	mips_cpu_irq_init(0);
 	rm7k_cpu_irq_init(8);
-
-#ifdef CONFIG_KGDB
-	/* At this point, initialize the second serial port */
-	init_second_port();
-#endif
-
-#ifdef CONFIG_GDB_CONSOLE
-	register_gdb_console();
-#endif
 }
 
 #ifdef CONFIG_KGDB
diff -ru linux-mips-cvs/arch/mips/pmc-sierra/yosemite/setup.c linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.c
--- linux-mips-cvs/arch/mips/pmc-sierra/yosemite/setup.c	2004-09-21 13:08:14.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.c	2004-09-23 11:37:18.106608792 +0200
@@ -24,6 +24,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#include <linux/config.h>
 #include <linux/bcd.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -45,6 +46,7 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/serial.h>
+#include <asm/gdb-stub.h>
 #include <linux/termios.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -143,12 +145,10 @@
 
 unsigned long uart_base = 0xfd000000L;
 
-/* No other usable initialization hook than this ...  */
-extern void (*late_time_init)(void);
-
 unsigned long ocd_base;
-
 EXPORT_SYMBOL(ocd_base);
+unsigned long serbase;
+EXPORT_SYMBOL(serbase);
 
 /*
  * Common setup before any secondaries are started
@@ -157,11 +157,13 @@
 #define TITAN_UART_CLK		3686400
 #define TITAN_SERIAL_BASE_BAUD	(TITAN_UART_CLK / 16)
 #define TITAN_SERIAL_IRQ	4
-#define TITAN_SERIAL_BASE	0xfd000008UL
+#define TITAN_SERIAL_BASE	0xfd000000UL
+#define TITAN_SERIAL_REG_SIZE	8
 
-static void __init py_map_ocd(void)
+static int __init py_map_ocd(void)
 {
-        struct uart_port up;
+	static const char serr[] = KERN_ERR "Serial port #%u setup failed\n";
+	struct uart_port up;
 
 	/*
 	 * Not specifically interrupt stuff but in case of SMP core_send_ipi
@@ -171,21 +173,46 @@
 	if (!ocd_base)
 		panic("Mapping OCD failed - game over.  Your score is 0.");
 
+	/* Map uart registers */
+	serbase = (unsigned long) ioremap(TITAN_SERIAL_BASE, TITAN_SERIAL_REG_SIZE * 2);
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
+	up.membase      = (char *) (serbase + TITAN_SERIAL_REG_SIZE);
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
+	up.membase      = (char *) serbase;
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
+	return 0;
 }
 
 static int __init pmc_yosemite_setup(void)
@@ -193,21 +220,12 @@
 	extern void pmon_smp_bootstrap(void);
 
 	board_time_init = yosemite_time_init;
-	late_time_init = py_map_ocd;
 
 	/* Add memory regions */
 	add_memory_region(0x00000000, 0x10000000, BOOT_MEM_RAM);
 
-#if 0 /* XXX Crash ...  */
-	OCD_WRITE(RM9000x2_OCD_HTSC,
-	          OCD_READ(RM9000x2_OCD_HTSC) | HYPERTRANSPORT_ENABLE);
-
-	/* Set the BAR. Shifted mode */
-	OCD_WRITE(RM9000x2_OCD_HTBAR0, HYPERTRANSPORT_BAR0_ADDR);
-	OCD_WRITE(RM9000x2_OCD_HTMASK0, HYPERTRANSPORT_SIZE0);
-#endif
-
 	return 0;
 }
 
 early_initcall(pmc_yosemite_setup);
+arch_initcall(py_map_ocd);
diff -ru linux-mips-cvs/arch/mips/pmc-sierra/yosemite/setup.h linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.h
--- linux-mips-cvs/arch/mips/pmc-sierra/yosemite/setup.h	2004-05-24 12:32:42.000000000 +0200
+++ linux-mips-work/arch/mips/pmc-sierra/yosemite/setup.h	2004-09-21 13:22:13.000000000 +0200
@@ -28,4 +28,7 @@
 #define	TITAN_ATMEL_24C32_SIZE		32768
 #define	TITAN_ATMEL_24C64_SIZE		65536
 
+/* UART base */
+extern unsigned long serbase;
+
 #endif /* __SETUP_H__ */


-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
