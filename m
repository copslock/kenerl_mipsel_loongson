Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6RHCLN16019
	for linux-mips-outgoing; Fri, 27 Jul 2001 10:12:21 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6RHCAV16014
	for <linux-mips@oss.sgi.com>; Fri, 27 Jul 2001 10:12:10 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6RGAsW29970;
	Fri, 27 Jul 2001 09:10:54 -0700
Message-ID: <3B619FBB.C9F53A65@mvista.com>
Date: Fri, 27 Jul 2001 10:07:07 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Appermont <tea@sonycom.com>
CC: linux-mips@oss.sgi.com
Subject: Re: measuring time intervals in kernel
References: <20010727154030.A10219@sonycom.com>
Content-Type: multipart/mixed;
 boundary="------------F9799E7F614F2D223D4D915C"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------F9799E7F614F2D223D4D915C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tom Appermont wrote:
> 
> Howdy,
> 
> Are there patches/applications/tools for mips that allow to
> measure time intervals in kernel paths? I'm thinking of
> something like timepeg (http://www.uow.edu.au/~andrewm/linux/)
> but prefer something that is running on mips already.
> 
> Tom

I wrote the original intlat patch for intel and ppc.  There is a half-way
ported MIPS patch you might be interested.  The patch is aginst mvista HHL2.0
kernel.  YOu can find the source in the journeyman edit/Malta cross lsp rpm
package from the ftp site.  You may also need to download the perfview user
program by following the www.mvista.com/realtime.

Jun
--------------F9799E7F614F2D223D4D915C
Content-Type: text/plain; charset=us-ascii;
 name="lat-measurement-mips-partial.0106xxx.010623.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lat-measurement-mips-partial.0106xxx.010623.patch"


This patch is obtained by mirroring ppc patch.  Two things need to be
done:

1. get CPU counter frequency
2. do_IRQ() does not apply readily to Malta board.  Either work harder to 
   get it right (under arch/mips/mips-boards/Malta/int.c, roughly), or
   pick another board.

Jun Sun
010623

diff -Nru linux/arch/mips/kernel/Makefile.orig linux/arch/mips/kernel/Makefile
--- linux/arch/mips/kernel/Makefile.orig	Wed May 30 11:53:23 2001
+++ linux/arch/mips/kernel/Makefile	Fri Jun 22 12:09:03 2001
@@ -20,7 +20,8 @@
 obj-y				+= branch.o process.o signal.o entry.o \
 				   traps.o ptrace.o vm86.o ioport.o reset.o \
 				   semaphore.o setup.o syscall.o sysmips.o \
-				   ipc.o scall_o32.o unaligned.o fast-sysmips.o
+				   ipc.o scall_o32.o unaligned.o fast-sysmips.o\
+				   intr_blocking.o ktprocentry.o intlatsamps.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o
 
 ifdef CONFIG_CPU_R3000
diff -Nru linux/arch/mips/kernel/intlatsamps.c.orig linux/arch/mips/kernel/intlatsamps.c
--- linux/arch/mips/kernel/intlatsamps.c.orig	Fri Jun 22 12:19:47 2001
+++ linux/arch/mips/kernel/intlatsamps.c	Fri Jun 22 13:20:59 2001
@@ -0,0 +1,159 @@
+/*++++++++++++++
+Change the INTLAT_CPU_KHZ to the processor clock in your setup.
+--------------*/
+#include <asm/system.h>
+#include <asm/current.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#define	BUCKETS		30 
+#define INTLAT_CPU_KHZ	NEED_TO_FIND_OUT
+
+unsigned long cpu_khz = INTLAT_CPU_KHZ;		/* number of rdtsc ticks per second/1000 */
+
+unsigned bucketlog [2][BUCKETS] = {
+	{ 2, 4, 6, 8, 10, 15, 20, 30, 40, 50, 75, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 700, 800, 900, 1000, 2000, 5000, 9000}, /* thresholds*/
+	{ 0, 0, 0, 0,  0,  0,  0,  0,  0,  0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  0,   0,   0,   0,   0,    0,    0,    0 }  /* number of samples in the bucket *ssociated to a threshold */
+};
+			    
+unsigned long total_samples; /* total number of samples collected so far in this boot session */
+
+asmlinkage void inthoff_logentry(unsigned diff)
+{
+	unsigned sampletime = diff / (cpu_khz / 1000);
+
+ 	if (sampletime < bucketlog [0][0] )
+		bucketlog[1][0]++;
+        else if (sampletime < bucketlog [0][1] )
+                bucketlog[1][1]++;
+        else if (sampletime < bucketlog [0][2] )
+                bucketlog[1][2]++;
+        else if (sampletime < bucketlog [0][3] )
+                bucketlog[1][3]++;
+        else if (sampletime < bucketlog [0][4] )
+                bucketlog[1][4]++;
+        else if (sampletime < bucketlog [0][5] )
+                bucketlog[1][5]++;
+        else if (sampletime < bucketlog [0][6] )
+                bucketlog[1][6]++;
+        else if (sampletime < bucketlog [0][7] )
+                bucketlog[1][7]++;
+        else if (sampletime < bucketlog [0][8] )
+                bucketlog[1][8]++;
+        else if (sampletime < bucketlog [0][9] )
+                bucketlog[1][9]++;
+        else if (sampletime < bucketlog [0][10] )
+                bucketlog[1][10]++;
+        else if (sampletime < bucketlog [0][11] )
+                bucketlog[1][11]++;
+        else if (sampletime < bucketlog [0][12] )
+                bucketlog[1][12]++;
+        else if (sampletime < bucketlog [0][13] )
+                bucketlog[1][13]++;
+        else if (sampletime < bucketlog [0][14] )
+                bucketlog[1][14]++;
+        else if (sampletime < bucketlog [0][15] )
+                bucketlog[1][15]++;
+        else if (sampletime < bucketlog [0][16] )
+                bucketlog[1][16]++;
+        else if (sampletime < bucketlog [0][17] )
+                bucketlog[1][17]++;
+        else if (sampletime < bucketlog [0][18] )
+                bucketlog[1][18]++;
+        else if (sampletime < bucketlog [0][19] )
+                bucketlog[1][19]++;
+        else if (sampletime < bucketlog [0][20] )
+                bucketlog[1][20]++;
+        else if (sampletime < bucketlog [0][21] )
+                bucketlog[1][21]++;
+        else if (sampletime < bucketlog [0][22] )
+                bucketlog[1][22]++;
+        else if (sampletime < bucketlog [0][23] )
+                bucketlog[1][23]++;
+        else if (sampletime < bucketlog [0][24] )
+                bucketlog[1][24]++;
+        else if (sampletime < bucketlog [0][25] )
+                bucketlog[1][25]++;
+        else if (sampletime < bucketlog [0][26] )
+                bucketlog[1][26]++;
+        else if (sampletime < bucketlog [0][27] )
+                bucketlog[1][27]++;
+        else if (sampletime < bucketlog [0][28] )
+                bucketlog[1][28]++;
+	else 
+		bucketlog[1][29]++;
+
+	total_samples++;
+
+	return;
+}
+
+static int g_read_completed = 0;
+
+static int ktimes_read_proc(
+       char *page_buffer,
+       char **my_first_byte,
+       off_t virtual_start,
+       int length,
+       int *eof,
+       void *data)
+{
+	int my_buffer_offset = 0;
+	char * const my_base = page_buffer;
+	int i;
+	if (virtual_start == 0){
+       		/* Just been opened so display the header information also stop logging */
+	        /* BUGBUG: stop logging while we are reading*/
+		/* initialize the index numbers in the log array */
+
+		g_read_completed = 0;
+
+                my_buffer_offset +=
+                        sprintf(my_base+my_buffer_offset,
+                		"Bucketing of samples for the total of %ld samples logged during this boot session\n"
+				"CPU clock measured %ld KHz.\n"
+	                      	" Threshold (usec)\t\t  Number of samples\n",
+                                total_samples,cpu_khz);
+
+        }else if (g_read_completed == BUCKETS){
+                *eof = 1;
+                /* BUGBUG: start logging again */
+                return 0;
+	}
+
+	/* dump the sample log on the screen */
+	for (i = 0; i < (BUCKETS-1); i++) {
+	       my_buffer_offset +=
+        	           sprintf(my_base + my_buffer_offset,
+					 " Less than %3u\t\t\t%10u\n",
+					bucketlog[0][i],
+					bucketlog[1][i]);
+	        g_read_completed++;
+	}
+        my_buffer_offset +=
+                 sprintf(my_base + my_buffer_offset,
+                                  " Above     %3u\t\t\t%10u\n",
+                                   bucketlog[0][i],
+                                   bucketlog[1][i]);
+        g_read_completed++;
+
+        *my_first_byte = page_buffer;
+        return  my_buffer_offset;
+}
+
+
+int __init
+inthoffsamps_init(void)
+{
+       printk("Interrupt holdoff times measurement enabled.\n");
+       create_proc_read_entry("inthoffsamps", 0, 0, ktimes_read_proc, 0);
+       return 0;
+}
+
+
+__initcall(inthoffsamps_init);
+
+
diff -Nru linux/arch/mips/kernel/intr_blocking.c.orig linux/arch/mips/kernel/intr_blocking.c
--- linux/arch/mips/kernel/intr_blocking.c.orig	Fri Jun 22 13:22:17 2001
+++ linux/arch/mips/kernel/intr_blocking.c	Fri Jun 22 13:25:11 2001
@@ -0,0 +1,258 @@
+#include <asm/system.h>
+
+extern void inthoff_logentry(unsigned);
+
+/**** platform ****/
+#include <asm/mipsregs.h>
+#define readclock(low) \
+     read_32bit_cp0_register(CP0_COUNT)
+
+/**** configure ****/
+#define        NUM_LOG_ENTRY           8
+#define        INTR_IENABLE            1
+
+struct IntrData {
+    /* count interrupt and iret */
+    int breakCount;
+
+    /* the test name */
+    const char * testName;
+
+    /* flag to control logging */
+    unsigned logFlag;   /* 0 - no logging; 1 - logging */
+
+    /* panic flag - set to 1 if something is realy wrong */
+    unsigned panicFlag;
+
+    /* for synchro between start and end */
+    unsigned syncFlag;
+
+    /* we only log interrupts within certain range */
+    unsigned rangeLow;
+    unsigned rangeHigh;
+
+    /* count the total number interrupts  and intrs in range*/
+    unsigned numIntrs;
+    unsigned numInRangeIntrs;
+
+
+    /* error accounting */
+    unsigned skipSti;
+    unsigned skipCli;
+    unsigned syncStiError;
+    unsigned syncCliError;
+    unsigned stiBreakError;
+    unsigned restoreSti;
+    unsigned restoreCli;
+
+    struct {
+        /* worst blocking time */
+        unsigned blockingTime;
+
+        const char * startFileName;
+        unsigned startFileLine;
+        unsigned startCount;
+        
+        const char *endFileName;
+        unsigned endFileLine;
+        unsigned endCount;
+    } count[NUM_LOG_ENTRY];
+};
+
+struct IntrData intrData = {
+    0,
+    "interrupt latency test for PPC (8 distinctive entries)",
+    0,
+    0,
+    0,
+
+    1,
+    0xffffffff,
+
+    0,
+    0,
+
+    0,
+    0,
+    0,
+    0,
+    0,
+    0,
+    0
+};
+
+static const char *intrStartFileName;
+static unsigned intrStartFileLine;
+static unsigned intrStartCount;
+
+/* strategy :
+ * if it is true "cli", i.e., clearing the IF, we remember
+ * everything, and clear breakCount.
+ */
+int intr_cli(const char *fname, unsigned lineno)
+{
+    unsigned flag;
+    int retValue = 0;
+
+    __save_flags(flag);
+
+    __intr_cli();
+
+    /* if we are not logging or we have an error, do nothing */
+    if ((intrData.logFlag == 0) || ( intrData.panicFlag != 0)) {
+        return retValue;
+    }
+
+    /* do nothing we had IF cleared before we call this function */
+    if ((flag & INTR_IENABLE) == 0) {
+        intrData.skipCli ++;
+        return retValue;
+    }
+
+    /* debug */
+    if (intrData.syncFlag == 1) {
+        intrData.syncCliError ++;
+    }
+    intrData.syncFlag = 1;
+
+    intrData.breakCount = 0;
+
+    /* Read the Time Stamp Counter */
+    intrStartFileName = fname;
+    intrStartFileLine = lineno;
+    readclock(intrStartCount);
+
+    return retValue;
+}
+
+/* strategy:
+ * we do a count only if
+ * 1. syncFlag is 1 (a valid cli() was called)
+ * 2. breakCount is 0 (no iret is called between cli() and this sti()
+ */
+void intr_sti(const char *fname, unsigned lineno)
+{
+    unsigned flag;
+    unsigned endCount;
+    unsigned diff;
+    int i;
+
+    __save_flags(flag);
+
+    /* if we are not logging or we have an error, do nothing */
+    if ((intrData.logFlag == 0) || ( intrData.panicFlag != 0)) {
+        __intr_sti();
+        return;
+    }
+
+
+    /* check if this is a real sti() */
+    if ((flag & INTR_IENABLE) != 0) {
+        intrData.skipSti ++;
+        __intr_sti();
+        return;
+    }
+
+
+    /* check 1*/
+    if (intrData.syncFlag != 1) {
+        intrData.syncStiError ++;
+        __intr_sti();
+        return;
+    }
+
+    /* check 2 */
+    if (intrData.breakCount != 0) {
+        intrData.stiBreakError ++;
+        __intr_sti();
+        return;
+    }
+
+    /* read count again */
+    readclock(endCount);
+
+    intrData.syncFlag = 0;
+
+    diff = endCount - intrStartCount;
+
+    if ((diff >= intrData.rangeLow) && (diff <= intrData.rangeHigh)) {
+        unsigned lowest=0xffffffff;
+        unsigned lowestIndex;
+        unsigned sameIndex = 0xffffffff;
+
+        intrData.numInRangeIntrs++;
+
+        /* check if we need to log this event */
+        for (i=0; i< NUM_LOG_ENTRY; i++) {
+
+            if (lowest > intrData.count[i].blockingTime) {
+               lowest = intrData.count[i].blockingTime;
+                lowestIndex = i;
+            }
+
+            if ( (lineno == intrData.count[i].endFileLine) &&
+                 (intrStartFileLine == intrData.count[i].startFileLine) &&
+                 (fname[0] == intrData.count[i].endFileName[0]) &&
+                 (intrStartFileName[0] == intrData.count[i].startFileName[0]) ) {
+                   /* if the line numbers are same, the first chars in
+                     * both file names are same, we consider it is the same
+                     * entry. */
+                   sameIndex = i;
+            }
+        }
+
+        if (sameIndex == 0xffffffff)  {
+            i = lowestIndex;
+        } else {
+            i = sameIndex;
+        }
+
+        if (diff > intrData.count[i].blockingTime) {
+            intrData.count[i].blockingTime = diff;
+            intrData.count[i].endFileName = fname;
+            intrData.count[i].endFileLine = lineno;
+            intrData.count[i].endCount = endCount;
+            intrData.count[i].startFileName = intrStartFileName;
+            intrData.count[i].startFileLine = intrStartFileLine;
+            intrData.count[i].startCount = intrStartCount;
+        }
+    }
+    inthoff_logentry(diff);
+    intrData.numIntrs++;
+    __intr_sti();
+}
+
+void intr_restore_flags(const char *fname, unsigned lineno, unsigned x)
+{
+    unsigned flag;
+
+    /* if we are not logging or we have an error, do nothing */
+    if ((intrData.logFlag == 0) || ( intrData.panicFlag != 0)) {
+        __intr_restore_flags(x);
+        return;
+    }
+
+    __save_flags(flag);
+
+    if (((flag & INTR_IENABLE) == 0)  &&
+        ((x & INTR_IENABLE) != 0) )  {
+        intrData.restoreSti ++;
+        intr_sti(fname, lineno);
+    }
+
+    if ( ((flag & INTR_IENABLE) != 0) &&
+         ((x & INTR_IENABLE) == 0) ) {
+        intrData.restoreCli ++;
+        intr_cli(fname, lineno);
+    }
+
+    __intr_restore_flags(x);
+}
+
+#include <asm/uaccess.h>
+
+asmlinkage int sys_get_intrData(void ** ptr)
+{
+     return put_user(&intrData, ptr);
+}
+
diff -Nru linux/arch/mips/kernel/ktprocentry.c.orig linux/arch/mips/kernel/ktprocentry.c
--- linux/arch/mips/kernel/ktprocentry.c.orig	Fri Jun 22 13:32:33 2001
+++ linux/arch/mips/kernel/ktprocentry.c	Fri Jun 22 13:52:22 2001
@@ -0,0 +1,156 @@
+/*++++++++++++++
+Change the KTIME_CPU_KHZ to the processor clock in your setup.
+--------------*/
+#include <asm/system.h>
+#include <asm/current.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/mipsregs.h>
+#define readclock(low) \
+     read_32bit_cp0_register(CP0_COUNT)
+
+#define		NUM_LOG_ENTRY           16
+#define		KTIME_CPU_KHZ		NEED_TO_FIGURE_OUT
+
+static unsigned kTimeStartCount;	/* count when interrupt processing started in the kernel */
+static unsigned startIrq;		/* irq number we are measuring the latency for, used to take care */
+					/* of nested interrupt. */
+struct log_entry {
+	unsigned irqNumber;	/* irq being handled */
+	unsigned kTime;		/* Time spent in kernel before calling the last handler in the list */
+	unsigned startCount;	/* count when do_IRQ was handed control to process the interrupt */
+	unsigned endCount;	/* count when last handler in the list was called */
+};
+
+struct kTimeData {
+        unsigned logFlag;			/* 0 - no logging; 1 - logging */
+        struct log_entry  entry[NUM_LOG_ENTRY]; /* Samples where processing time in the kernel was max*/
+};
+
+struct kTimeData ktimeData = {
+        logFlag:	1,
+};
+
+void ktime_logentry(unsigned kTimeEndCount, unsigned irqnum)
+{
+	unsigned diff;
+	
+	diff = kTimeEndCount - kTimeStartCount;
+
+	/* If this sample for this irq is greater than the previous one logged then replace it */
+	if(diff > ktimeData.entry[irqnum].kTime)
+	{
+                ktimeData.entry[irqnum].irqNumber	= irqnum;
+		ktimeData.entry[irqnum].kTime		= diff;
+                ktimeData.entry[irqnum].startCount	= kTimeStartCount;
+                ktimeData.entry[irqnum].endCount	= kTimeEndCount;
+	}
+	kTimeStartCount = 0;
+	return;
+}
+
+asmlinkage void ktime_end(unsigned irqnum)
+{
+	unsigned kTimeEndCount;
+	
+	/* if we are not logging or  kTimeStartCount is zero (which should never happen) do nothing */
+	if(ktimeData.logFlag == 0 || kTimeStartCount == 0 || startIrq != irqnum)
+	{
+		return;
+	}
+	
+	/* read timestamp counter again */
+	readclock(kTimeEndCount);
+	
+	/* log the entry if appropriate */
+	ktime_logentry(kTimeEndCount, irqnum);
+}
+
+asmlinkage void ktime_start(unsigned irqnum)
+{
+	/* If we are not logging, do nothing */
+	if(ktimeData.logFlag == 0 || kTimeStartCount != 0)
+	{
+		return;
+	}
+		
+	/* remember the irq we are monitoring */
+	startIrq = irqnum;
+
+	/* read timestamp counter */
+	readclock(kTimeStartCount);
+	
+	return;
+}
+
+static int g_read_completed = 0;
+
+static int ktimes_read_proc(
+       char *page_buffer,
+       char **my_first_byte,
+       off_t virtual_start,
+       int length,
+       int *eof,
+       void *data)
+{
+	int my_buffer_offset = 0;
+	char * const my_base = page_buffer;
+	int i;
+	unsigned long cpu_khz = KTIME_CPU_KHZ;
+ 
+	if (virtual_start == 0){
+       		/* Just been opened so display the header information also stop logging */
+		ktimeData.logFlag = 0; /* stop logging while we are reading*/
+		/* initialize the index numbers in the log array */
+		for (i=0;i<NUM_LOG_ENTRY;i++)
+			ktimeData.entry[i].irqNumber = i;
+
+		g_read_completed = 0;
+
+                my_buffer_offset +=
+                        sprintf(my_base+my_buffer_offset,
+                		"%d Samples showing maximum time spent in the kernel before the handler\n"
+				" was actually called.\n"
+				"CPU clock measured %ld KHz.\n"
+	                      	" irqnum\t\t  usec\t\tstartCount\t\t  endCount\n",
+                                NUM_LOG_ENTRY,cpu_khz);
+
+        }else if (g_read_completed == NUM_LOG_ENTRY){
+                *eof = 1;
+                ktimeData.logFlag = 1;  /* start logging again */
+                return 0;
+	}
+
+	/* dump the sample log on the screen */
+	for (i = 0; i < NUM_LOG_ENTRY; i++) {
+	       my_buffer_offset +=
+        	           sprintf(my_base + my_buffer_offset,
+					 " %6d\t\t%6d\t\t%10u\t\t%10u\n",
+				   	ktimeData.entry[i].irqNumber,
+					(ktimeData.entry[i].kTime / (cpu_khz / 1000)),
+	                                ktimeData.entry[i].startCount,
+        	                        ktimeData.entry[i].endCount);
+	        g_read_completed++;
+	}
+
+       *my_first_byte = page_buffer;
+        return  my_buffer_offset;
+}
+
+
+int __init
+intktimes_init(void)
+{
+       printk("kernel interrupt processing time monitoring enabled.\n");
+       create_proc_read_entry("kinttimes", 0, 0, ktimes_read_proc, 0);
+       return 0;
+}
+
+
+__initcall(intktimes_init);
+
+
diff -Nru linux/arch/mips/kernel/syscalls.h.orig linux/arch/mips/kernel/syscalls.h
--- linux/arch/mips/kernel/syscalls.h.orig	Mon Apr 23 08:14:43 2001
+++ linux/arch/mips/kernel/syscalls.h	Fri Jun 22 14:26:19 2001
@@ -235,3 +235,4 @@
 SYS(sys_madvise, 3)
 SYS(sys_getdents64, 3)
 SYS(sys_fcntl64, 3)				/* 4220 */
+SYS(sys_get_intrData, 1)		
diff -Nru linux/include/asm-mips/system.h.orig linux/include/asm-mips/system.h
--- linux/include/asm-mips/system.h.orig	Thu Jun 21 16:49:54 2001
+++ linux/include/asm-mips/system.h	Fri Jun 22 14:35:22 2001
@@ -46,7 +46,7 @@
  * no nops at all.
  */
 extern __inline__ void
-__cli(void)
+__intr_cli(void)
 {
 	__asm__ __volatile__(
 		".set\tpush\n\t"
@@ -66,7 +66,7 @@
 		: "$1", "memory");
 }
 
-#define __save_flags(x)							\
+#define __intr_save_flags(x)							\
 __asm__ __volatile__(							\
 	".set\tpush\n\t"						\
 	".set\treorder\n\t"						\
@@ -74,6 +74,7 @@
 	".set\tpop\n\t"							\
 	: "=r" (x))
 
+#if 0
 #define __save_and_cli(x)						\
 __asm__ __volatile__(							\
 	".set\tpush\n\t"						\
@@ -91,8 +92,9 @@
 	: "=r" (x)							\
 	: /* no inputs */						\
 	: "$1", "memory")
+#endif
 
-#define __restore_flags(flags)						\
+#define __intr_restore_flags(flags)						\
 do {									\
 	unsigned long __tmp1;						\
 									\
@@ -114,6 +116,18 @@
 		: "0" (flags)						\
 		: "$1", "memory");					\
 } while(0)
+
+extern int intr_cli(const char*, unsigned);
+extern void intr_sti(const char *, unsigned);
+extern void intr_restore_flags(const char *, unsigned, unsigned);
+
+#define __cli()                        intr_cli(__FILE__,__LINE__)
+#define __sti()                        intr_sti(__FILE__,__LINE__)
+#define __save_flags(flags)            __intr_save_flags(flags)
+gs)
+#define __restore_flags(flags)         intr_restore_flags(__FILE__,__LINE__, flags)
+
+#define __save_and_cli(flags) ({__save_flags(flags);__cli();})
 
 /*
  * Non-SMP versions ...

--------------F9799E7F614F2D223D4D915C--
