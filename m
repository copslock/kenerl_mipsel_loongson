Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARKQZT30458
	for linux-mips-outgoing; Tue, 27 Nov 2001 12:26:35 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARKNXo30360;
	Tue, 27 Nov 2001 12:23:33 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fARJODB28054;
	Tue, 27 Nov 2001 11:24:13 -0800
Message-ID: <3C03E82F.462A8E7C@mvista.com>
Date: Tue, 27 Nov 2001 11:23:27 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: [PATCH] MIPS RTC driver again
Content-Type: multipart/mixed;
 boundary="------------AF391AE875D823750F12E752"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------AF391AE875D823750F12E752
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


In last round of RFC, I heard several voices:

. some similar ones are already there, drivers/macintosh/rtc.c.  But we can't
really use it unless we modified it to interface with MIPS kernel rtc routines
and fix a couple of other minor stuff.  Even then it seems a little
politically incorrect to use a Macintosh driver for MIPS boards. :-)

. Tom Rini wants to do a universal RTC driver.  Cool, we need to wait.

Meanwhile I also heard people who want the driver.  So it seems to me it makes
sense to check in this driver.  Right now there are nine boards using
NEW_TIME_C, which can benefit from this driver immediately.  I expect more
boards will use NEW_TIME_C soon.

So here is my updated patch.  Please consider for applying.

Jun
--------------AF391AE875D823750F12E752
Content-Type: text/plain; charset=us-ascii;
 name="mips-rtc.011127.011127.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-rtc.011127.011127.patch"

diff -Nru linux/Documentation/Configure.help.orig linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig	Tue Nov  6 11:25:32 2001
+++ linux/Documentation/Configure.help	Tue Nov 27 11:05:10 2001
@@ -15163,6 +15163,17 @@
 #EFI Real Time Clock Services
 #CONFIG_EFI_RTC
 
+Generic MIPS RTC Support
+CONFIG_MIPS_RTC
+
+  If your machine is a MIPS machine, this option provides a simple,
+  generic RTC driver for /dev/rtc device.  It only implements two IOCTL 
+  operations of the standard PC RTC driver: RTC_RD_TIME and RTC_SET_TIME.
+  It is sufficient to run hwclock program. 
+
+  You should say Y here if there is no machine-specific RTC driver for your
+  MIPS machine but you do want a simple RTC driver for your RTC device.
+
 Tadpole ANA H8 Support
 CONFIG_H8
   The Hitachi H8/337 is a microcontroller used to deal with the power
diff -Nru linux/drivers/char/Config.in.orig linux/drivers/char/Config.in
--- linux/drivers/char/Config.in.orig	Tue Nov 27 11:03:11 2001
+++ linux/drivers/char/Config.in	Tue Nov 27 11:05:10 2001
@@ -213,6 +213,9 @@
 if [ "$CONFIG_OBSOLETE" = "y" -a "$CONFIG_ALPHA_BOOK1" = "y" ]; then
    bool 'Tadpole ANA H8 Support'  CONFIG_H8
 fi
+if [ "$CONFIG_MIPS" = "y" -a "$CONFIG_NEW_TIME_C" = "y" ]; then
+   tristate 'Generic MIPS RTC Support' CONFIG_MIPS_RTC
+fi
 
 tristate 'Double Talk PC internal speech card support' CONFIG_DTLK
 tristate 'Siemens R3964 line discipline' CONFIG_R3964
diff -Nru linux/drivers/char/Makefile.orig linux/drivers/char/Makefile
--- linux/drivers/char/Makefile.orig	Tue Nov 27 11:03:12 2001
+++ linux/drivers/char/Makefile	Tue Nov 27 11:05:10 2001
@@ -196,6 +196,7 @@
 obj-$(CONFIG_PC110_PAD) += pc110pad.o
 obj-$(CONFIG_RTC) += rtc.o
 obj-$(CONFIG_EFI_RTC) += efirtc.o
+obj-$(CONFIG_MIPS_RTC) += mips_rtc.o
 ifeq ($(CONFIG_PPC),)
   obj-$(CONFIG_NVRAM) += nvram.o
 endif
diff -Nru linux/drivers/char/mips_rtc.c.orig linux/drivers/char/mips_rtc.c
--- linux/drivers/char/mips_rtc.c.orig	Tue Nov 27 11:05:10 2001
+++ linux/drivers/char/mips_rtc.c	Tue Nov 27 11:05:10 2001
@@ -0,0 +1,221 @@
+/*
+ *	A simple generic Real Time Clock interface for Linux/MIPS
+ *
+ *	Copyright (C) 1996 Paul Gortmaker
+ *
+ *	Copyright (C) 2001 Monta Vista Software
+ *	Author Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ *	This is a simple generic RTC driver for MIPS boards configured 
+ *	with CONFIG_NEW_TIME_C.  For now, it makes use of the two
+ *	abstract kernel RTC functions introduced in include/asm-mips/time.h:
+ *
+ *		extern unsigned long (*rtc_get_time)(void);
+ *		extern int (*rtc_set_time)(unsigned long);
+ *
+ *	It uses the same protocol as the original drivers/char/rtc.c driver,
+ *	but only implements two ioctls: RTC_RD_TIME and RTC_SET_TIME.
+ *
+ * 	TODO :
+ *
+ * 	1. we can extend the null rtc ops defined in arch/mips/time.c to
+ * 	   at least record the elapsed time (by recording/checking jiffies)
+ * 	   This way RTC_RD_TIME and RTC_SET_TIME will make more sense.
+ * 	   (Maybe not.  A machine without a real RTC is broken anymore.
+ * 	   Just a thought.)
+ *
+ * 	2. If we make use of timer bh, we can emulate many RTC functions
+ * 	   such as RTC alarm interrupt, periodic interrupts, etc.
+ *
+ * 	3. It is possible to extend the kernel RTC abstractions to more
+ * 	   than two functions, so that perhaps we can implement more
+ * 	   full-featured RTC driver and also have a better abstraction
+ * 	   to support more RTC hardware than the original RTC driver.
+ * 	   It needs to be done very carefully.
+ *
+ * Change Log :
+ * 	v1.0	- [jsun] initial version
+ */
+
+#define RTC_VERSION		"1.0"
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/fcntl.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+/*
+ * Check machine
+ */
+#if !defined(CONFIG_MIPS) || !defined(CONFIG_NEW_TIME_C)
+#error "This driver is for MIPS machines with CONFIG_NEW_TIME_C defined"
+#endif
+
+#include <asm/time.h>
+
+static unsigned long rtc_status = 0;	/* bitmapped status byte.       */
+
+static int rtc_read_proc(char *page, char **start, off_t off,
+			 int count, int *eof, void *data);
+
+
+#define RTC_IS_OPEN             0x01	/* means /dev/rtc is in use     */
+
+static spinlock_t rtc_lock;
+
+static int
+rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	struct rtc_time rtc_tm;
+	ulong curr_time;
+
+	switch (cmd) {
+	case RTC_RD_TIME:	/* Read the time/date from RTC  */
+		curr_time = rtc_get_time();
+		to_tm(curr_time, &rtc_tm);
+		rtc_tm.tm_year -= 1900;
+		return copy_to_user((void *) arg, &rtc_tm, sizeof(rtc_tm)) ? 
+			-EFAULT : 0;
+	case RTC_SET_TIME:	/* Set the RTC */
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if (copy_from_user(&rtc_tm, 
+				   (struct rtc_time *) arg,
+		                   sizeof(struct rtc_time))) 
+			return -EFAULT;
+
+		curr_time = mktime(rtc_tm.tm_year + 1900,
+				   rtc_tm.tm_mon + 1, /* tm_mon starts from 0 */
+				   rtc_tm.tm_mday,
+				   rtc_tm.tm_hour,
+				   rtc_tm.tm_min, 
+				   rtc_tm.tm_sec);
+		return rtc_set_time(curr_time);
+	default:
+		return -EINVAL;
+	}
+}
+
+/* We use rtc_lock to protect against concurrent opens. So the BKL is not
+ * needed here. Or anywhere else in this driver. */
+static int rtc_open(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&rtc_lock);
+
+	if (rtc_status & RTC_IS_OPEN) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+
+	rtc_status |= RTC_IS_OPEN;
+
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+static int rtc_release(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&rtc_lock);
+	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+/*
+ *	The various file operations we support.
+ */
+
+static struct file_operations rtc_fops = {
+	owner:THIS_MODULE,
+	llseek:no_llseek,
+	ioctl:rtc_ioctl,
+	open:rtc_open,
+	release:rtc_release,
+};
+
+static struct miscdevice rtc_dev = {
+	RTC_MINOR,
+	"rtc",
+	&rtc_fops
+};
+
+static int __init rtc_init(void)
+{
+
+	misc_register(&rtc_dev);
+	create_proc_read_entry("driver/rtc", 0, 0, rtc_read_proc, NULL);
+
+	printk(KERN_INFO "Generic MIPS RTC Driver v" RTC_VERSION "\n");
+
+	return 0;
+}
+
+static void __exit rtc_exit(void)
+{
+	remove_proc_entry("driver/rtc", NULL);
+	misc_deregister(&rtc_dev);
+
+}
+
+module_init(rtc_init);
+module_exit(rtc_exit);
+EXPORT_NO_SYMBOLS;
+
+/*
+ *	Info exported via "/proc/driver/rtc".
+ */
+
+static int rtc_proc_output(char *buf)
+{
+	char *p;
+	struct rtc_time tm;
+	unsigned long curr_time;
+
+	curr_time = rtc_get_time();
+	to_tm(curr_time, &tm);
+
+	p = buf;
+
+	/*
+	 * There is no way to tell if the luser has the RTC set for local
+	 * time or for Universal Standard Time (GMT). Probably local though.
+	 */
+	p += sprintf(p,
+		     "rtc_time\t: %02d:%02d:%02d\n"
+		     "rtc_date\t: %04d-%02d-%02d\n"
+		     "rtc_epoch\t: %04lu\n",
+		     tm.tm_hour, tm.tm_min, tm.tm_sec,
+		     tm.tm_year, tm.tm_mon + 1, tm.tm_mday, 0L);
+
+	return p - buf;
+}
+
+static int rtc_read_proc(char *page, char **start, off_t off,
+			 int count, int *eof, void *data)
+{
+	int len = rtc_proc_output(page);
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	return len;
+}
+
+MODULE_AUTHOR("Jun Sun");
+MODULE_LICENSE("GPL");

--------------AF391AE875D823750F12E752--
