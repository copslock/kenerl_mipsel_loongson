Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 20:05:15 +0100 (CET)
Received: from rtsoft3.corbina.net ([85.21.88.6]:38922 "EHLO
	buildserver.ru.mvista.com") by lappi.linux-mips.net with ESMTP
	id S526844AbYC0TFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Mar 2008 20:05:09 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 1A2E78810; Fri, 28 Mar 2008 00:04:54 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: kill useless time variables
Date:	Thu, 27 Mar 2008 22:05:57 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803272205.57531.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Since the commit 91a2fcc88634663e9e13dcdfad0e4a860e64aeee ([MIPS] Consolidate
all variants of MIPS cp0 timer interrupt handlers) removed the Alchemy specific
timer handler, 'r4k_offset' and 'r4k_cur' variables became practically useless,
so get rid of them at last, renaming cal_r4off() function into calc_clock() and
making it return CPU frequency. Also, make 'no_au1xxx_32khz' variable static...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/common/dbg_io.c |    4 ++--
 arch/mips/au1000/common/time.c   |   19 ++++---------------
 2 files changed, 6 insertions(+), 17 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/dbg_io.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dbg_io.c
+++ linux-2.6/arch/mips/au1000/common/dbg_io.c
@@ -56,7 +56,7 @@ typedef         unsigned int  uint32;
 #define UART16550_WRITE(y, z) (au_writel(z&0xff, DEBUG_BASE + y))
 
 extern unsigned long get_au1x00_uart_baud_base(void);
-extern unsigned long cal_r4koff(void);
+extern unsigned long calc_clock(void);
 
 void debugInit(uint32 baud, uint8 data, uint8 parity, uint8 stop)
 {
@@ -64,7 +64,7 @@ void debugInit(uint32 baud, uint8 data, 
 	if (UART16550_READ(UART_MOD_CNTRL) != 0x3) {
 		UART16550_WRITE(UART_MOD_CNTRL, 3);
 	}
-	cal_r4koff();
+	calc_clock();
 
 	/* disable interrupts */
 	UART16550_WRITE(UART_IER, 0);
Index: linux-2.6/arch/mips/au1000/common/time.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/time.c
+++ linux-2.6/arch/mips/au1000/common/time.c
@@ -48,9 +48,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
 
-static unsigned long r4k_offset; /* Amount to increment compare reg each time */
-static unsigned long r4k_cur;    /* What counter should be at next timer irq */
-int	no_au1xxx_32khz;
+static int no_au1xxx_32khz;
 extern int allow_au1k_wait; /* default off for CP0 Counter */
 
 #ifdef CONFIG_PM
@@ -184,7 +182,7 @@ wakeup_counter0_set(int ticks)
  * "wait" is enabled, and we need to detect if the 32KHz isn't present
  * but requested......got it? :-)		-- Dan
  */
-unsigned long cal_r4koff(void)
+unsigned long calc_clock(void)
 {
 	unsigned long cpu_speed;
 	unsigned long flags;
@@ -229,19 +227,13 @@ unsigned long cal_r4koff(void)
 	// Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16)
 	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)&0x03) + 2) * 16));
 	spin_unlock_irqrestore(&time_lock, flags);
-	return (cpu_speed / HZ);
+	return cpu_speed;
 }
 
 void __init plat_time_init(void)
 {
-	unsigned int est_freq;
+	unsigned int est_freq = calc_clock();
 
-	printk("calculating r4koff... ");
-	r4k_offset = cal_r4koff();
-	printk("%08lx(%d)\n", r4k_offset, (int) r4k_offset);
-
-	//est_freq = 2*r4k_offset*HZ;
-	est_freq = r4k_offset*HZ;
 	est_freq += 5000;    /* round */
 	est_freq -= est_freq%10000;
 	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
@@ -249,9 +241,6 @@ void __init plat_time_init(void)
  	set_au1x00_speed(est_freq);
  	set_au1x00_lcd_clock(); // program the LCD clock
 
-	r4k_cur = (read_c0_count() + r4k_offset);
-	write_c0_compare(r4k_cur);
-
 #ifdef CONFIG_PM
 	/*
 	 * setup counter 0, since it keeps ticking after a
