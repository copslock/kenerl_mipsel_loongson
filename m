Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASNQ5M10939
	for linux-mips-outgoing; Wed, 28 Nov 2001 15:26:05 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASNPro10926
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 15:25:53 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fASMQVB02173;
	Wed, 28 Nov 2001 14:26:31 -0800
Message-ID: <3C05646B.51BF79FB@mvista.com>
Date: Wed, 28 Nov 2001 14:25:47 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: calibrating MIPS counter frequency
Content-Type: multipart/mixed;
 boundary="------------FC85174E863B59DDE137B503"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------FC85174E863B59DDE137B503
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I wrote a little routine to calibrate CPU counter if the frequency is not
given by the board setup routine.  See the patch below.

Not too much use of it right now - unless you are writing some generic MIPS
performance test program.  Then you should be grateful.  It removes the board
dependency.

In the future, I think mips counter frequency really should go to mips_cpu
structure.  If we always know the counter frequency, either by board setup
routine or runtime calibration, we can get rid of the gettimeoffset
calibration routines.

Feedbacks are welcome.

Jun
--------------FC85174E863B59DDE137B503
Content-Type: text/plain; charset=us-ascii;
 name="calibrate_mips_counter.011128.011128.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="calibrate_mips_counter.011128.011128.patch"

Calibrate CPU counter frequency if it is not specified by board setup
routine.  No usage for now.  In the future, it should be part of
mips_cpu structure and we can get rid of the run-time gettimeoffset
calibration routines.  Should also speed timer interrupt a little bit.

Jun Sun

diff -Nru linux-2.4.14/init/main.c.orig linux-2.4.14/init/main.c
--- linux-2.4.14/init/main.c.orig	Fri Oct 12 10:17:15 2001
+++ linux-2.4.14/init/main.c	Wed Nov 28 11:18:58 2001
@@ -539,6 +539,9 @@
  *	Activate the first processor.
  */
 
+#if defined(CONFIG_MIPS) && defined(CONFIG_NEW_TIME_C)
+extern void calibrate_mips_counter(void);
+#endif
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
@@ -581,6 +584,9 @@
 	kmem_cache_init();
 	sti();
 	calibrate_delay();
+#if defined(CONFIG_MIPS) && defined(CONFIG_NEW_TIME_C)
+	calibrate_mips_counter();
+#endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 			initrd_start < min_low_pfn << PAGE_SHIFT) {
diff -Nru linux-2.4.14/arch/mips/kernel/time.c.orig linux-2.4.14/arch/mips/kernel/time.c
--- linux-2.4.14/arch/mips/kernel/time.c.orig	Mon Nov 26 18:22:58 2001
+++ linux-2.4.14/arch/mips/kernel/time.c	Wed Nov 28 13:57:23 2001
@@ -27,6 +27,7 @@
 #include <asm/time.h>
 #include <asm/hardirq.h>
 #include <asm/div64.h>
+#include <asm/debug.h>
 
 /* This is for machines which generate the exact clock. */
 #define USECS_PER_JIFFY (1000000/HZ)
@@ -505,4 +506,47 @@
 	 * Determine the day of week
 	 */
 	tm->tm_wday = (gday + 4) % 7; /* 1970/1/1 was Thursday */
+}
+
+/*
+ * calibrate the mips_counter_frequency
+ */
+#define		CALIBRATION_CYCLES		20
+void calibrate_mips_counter(void)
+{
+	volatile unsigned long ticks;
+	volatile unsigned long countStart, countEnd;
+
+	if (mips_counter_frequency) {
+		/* it is already specified by the board */
+		return;
+	}
+
+	if ((mips_cpu.options & MIPS_CPU_COUNTER) == 0) {
+		/* we don't have cpu counter */
+		return;
+	}
+
+	printk("calibrating MIPS CPU counter frequency ...");
+
+	/* wait for the change of jiffies */
+	ticks = jiffies;
+	while (ticks == jiffies);
+
+	/* read cpu counter */
+	countStart = read_32bit_cp0_register(CP0_COUNT);
+
+	/* loop for another n jiffies */
+	ticks += CALIBRATION_CYCLES + 1;
+	while (ticks != jiffies);
+
+	/* read counter again */
+	countEnd = read_32bit_cp0_register(CP0_COUNT);
+
+	/* assuming HZ is 10's multiple */
+	db_assert((HZ % CALIBRATION_CYCLES) == 0);
+
+	mips_counter_frequency = 
+		(countEnd - countStart) * (HZ / CALIBRATION_CYCLES);
+	printk(" %d Hz\n", mips_counter_frequency);
 }

--------------FC85174E863B59DDE137B503--
