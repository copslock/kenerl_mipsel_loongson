Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BHNERw011509
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 10:23:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BHND8G011508
	for linux-mips-outgoing; Thu, 11 Jul 2002 10:23:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ace.ulyssis.org (IDENT:root@ace.ulyssis.student.kuleuven.ac.be [193.190.253.36])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BHLsRw011491;
	Thu, 11 Jul 2002 10:21:55 -0700
Received: (from p2@localhost)
	by ace.ulyssis.org (8.11.6/8.11.6) id g6BHQME04622;
	Thu, 11 Jul 2002 19:26:22 +0200
Date: Thu, 11 Jul 2002 19:26:22 +0200
From: Peter De Schrijver <p2@ace.ulyssis.org>
To: geert@linux-m68k.org, wim@sonycom.com, lionel@sonycom.com,
   thomasv@sonycom.com, Nico.DeRanter@sonycom.com, tea@sonycom.com,
   joel@sonycom.com, michiels@CoWare.com, gds@denayer.wenk.be, p2@mind.be,
   ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: ds1286    \\\\
Message-ID: <20020711192622.A4119@ace.ulyssis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch moves ralf's ds1286 driver to drivers/char and makes it selectable
for the ddb5074 board as well. I don't have an SGI here to check if it still
works for an indy though. It should though :) test results welcome :)

Cheers,

Peter.

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffje-ds1286

diff -r -N -u -w oss-2.4/linux/drivers/char/Config.in oss-2.4-ddb5074/linux/drivers/char/Config.in
--- oss-2.4/linux/drivers/char/Config.in	Mon Jul  1 22:45:39 2002
+++ oss-2.4-ddb5074/linux/drivers/char/Config.in	Thu Jul 11 19:16:33 2002
@@ -268,6 +268,9 @@
 if [ "$CONFIG_OBSOLETE" = "y" -a "$CONFIG_ALPHA_BOOK1" = "y" ]; then
    bool 'Tadpole ANA H8 Support'  CONFIG_H8
 fi
+if [ "$CONFIG_DDB5074" = "y" -o "$CONFIG_SGI" = "y" ]; then
+   bool 'DS1286 RTC support' CONFIG_RTC_DS1286
+fi
 
 tristate 'Double Talk PC internal speech card support' CONFIG_DTLK
 tristate 'Siemens R3964 line discipline' CONFIG_R3964
diff -r -N -u -w oss-2.4/linux/drivers/char/Makefile oss-2.4-ddb5074/linux/drivers/char/Makefile
--- oss-2.4/linux/drivers/char/Makefile	Thu Jun 27 00:35:32 2002
+++ oss-2.4-ddb5074/linux/drivers/char/Makefile	Tue Jul  9 15:19:26 2002
@@ -179,6 +179,7 @@
 obj-$(CONFIG_BVME6000_SCC) += generic_serial.o vme_scc.o
 obj-$(CONFIG_SERIAL_TX3912) += generic_serial.o serial_tx3912.o
 obj-$(CONFIG_TXX927_SERIAL) += serial_txx927.o
+obj-$(CONFIG_RTC_DS1286) += ds1286.o
 
 subdir-$(CONFIG_RIO) += rio
 subdir-$(CONFIG_INPUT) += joystick
diff -r -N -u -w oss-2.4/linux/drivers/char/ds1286.c oss-2.4-ddb5074/linux/drivers/char/ds1286.c
--- oss-2.4/linux/drivers/char/ds1286.c	Thu Jan  1 01:00:00 1970
+++ oss-2.4-ddb5074/linux/drivers/char/ds1286.c	Tue Jul  9 15:30:02 2002
@@ -0,0 +1,533 @@
+/*
+ * DS1286 Real Time Clock interface for Linux	
+ *
+ * Copyright (C) 1998, 1999, 2000 Ralf Baechle
+ *	
+ * Based on code written by Paul Gortmaker.
+ *
+ * This driver allows use of the real time clock (built into nearly all
+ * computers) from user space. It exports the /dev/rtc interface supporting
+ * various ioctl() and also the /proc/rtc pseudo-file for status
+ * information.
+ *
+ * The ioctls can be used to set the interrupt behaviour and generation rate
+ * from the RTC via IRQ 8. Then the /dev/rtc interface can be used to make
+ * use of these timer interrupts, be they interval or alarm based.
+ *
+ * The /dev/rtc interface will block on reads until an interrupt has been
+ * received. If a RTC interrupt has already happened, it will output an
+ * unsigned long and then block. The output value contains the interrupt
+ * status in the low byte and the number of interrupts since the last read
+ * in the remaining high bytes. The /dev/rtc interface can also be used with
+ * the select(2) call.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/rtc.h>
+#include <linux/spinlock.h>
+
+#include <asm/ds1286.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define DS1286_VERSION		"1.0"
+
+/*
+ *	We sponge a minor off of the misc major. No need slurping
+ *	up another valuable major dev number for this. If you add
+ *	an ioctl, make sure you don't conflict with SPARC's RTC
+ *	ioctls.
+ */
+
+static DECLARE_WAIT_QUEUE_HEAD(ds1286_wait);
+
+static ssize_t ds1286_read(struct file *file, char *buf,
+			size_t count, loff_t *ppos);
+
+static int ds1286_ioctl(struct inode *inode, struct file *file,
+                        unsigned int cmd, unsigned long arg);
+
+static unsigned int ds1286_poll(struct file *file, poll_table *wait);
+
+void ds1286_get_alm_time (struct rtc_time *alm_tm);
+void ds1286_get_time(struct rtc_time *rtc_tm);
+int ds1286_set_time(struct rtc_time *rtc_tm);
+
+void set_rtc_irq_bit(unsigned char bit);
+void clear_rtc_irq_bit(unsigned char bit);
+
+static inline unsigned char ds1286_is_updating(void);
+
+static spinlock_t ds1286_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ *	Bits in rtc_status. (7 bits of room for future expansion)
+ */
+
+#define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
+#define RTC_TIMER_ON		0x02	/* missed irq timer active	*/
+
+unsigned char ds1286_status;		/* bitmapped status byte.	*/
+unsigned long ds1286_freq;		/* Current periodic IRQ rate	*/
+
+unsigned char days_in_mo[] = 
+{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
+
+/*
+ *	Now all the various file operations that we export.
+ */
+
+static ssize_t ds1286_read(struct file *file, char *buf,
+                           size_t count, loff_t *ppos)
+{
+	return -EIO;
+}
+
+static int ds1286_ioctl(struct inode *inode, struct file *file,
+                        unsigned int cmd, unsigned long arg)
+{
+
+	struct rtc_time wtime; 
+
+	switch (cmd) {
+	case RTC_AIE_OFF:	/* Mask alarm int. enab. bit	*/
+	{
+		unsigned int flags;
+		unsigned char val;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		spin_lock_irqsave(&ds1286_lock, flags);
+		val = CMOS_READ(RTC_CMD);
+		val |=  RTC_TDM;
+		CMOS_WRITE(val, RTC_CMD);
+		spin_unlock_irqrestore(&ds1286_lock, flags);
+
+		return 0;
+	}
+	case RTC_AIE_ON:	/* Allow alarm interrupts.	*/
+	{
+		unsigned int flags;
+		unsigned char val;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		spin_lock_irqsave(&ds1286_lock, flags);
+		val = CMOS_READ(RTC_CMD);
+		val &=  ~RTC_TDM;
+		CMOS_WRITE(val, RTC_CMD);
+		spin_unlock_irqrestore(&ds1286_lock, flags);
+
+		return 0;
+	}
+	case RTC_WIE_OFF:	/* Mask watchdog int. enab. bit	*/
+	{
+		unsigned int flags;
+		unsigned char val;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		spin_lock_irqsave(&ds1286_lock, flags);
+		val = CMOS_READ(RTC_CMD);
+		val |= RTC_WAM;
+		CMOS_WRITE(val, RTC_CMD);
+		spin_unlock_irqrestore(&ds1286_lock, flags);
+
+		return 0;
+	}
+	case RTC_WIE_ON:	/* Allow watchdog interrupts.	*/
+	{
+		unsigned int flags;
+		unsigned char val;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		spin_lock_irqsave(&ds1286_lock, flags);
+		val = CMOS_READ(RTC_CMD);
+		val &= ~RTC_WAM;
+		CMOS_WRITE(val, RTC_CMD);
+		spin_unlock_irqrestore(&ds1286_lock, flags);
+
+		return 0;
+	}
+	case RTC_ALM_READ:	/* Read the present alarm time */
+	{
+		/*
+		 * This returns a struct rtc_time. Reading >= 0xc0
+		 * means "don't care" or "match all". Only the tm_hour,
+		 * tm_min, and tm_sec values are filled in.
+		 */
+
+		ds1286_get_alm_time(&wtime);
+		break; 
+	}
+	case RTC_ALM_SET:	/* Store a time into the alarm */
+	{
+		/*
+		 * This expects a struct rtc_time. Writing 0xff means
+		 * "don't care" or "match all". Only the tm_hour,
+		 * tm_min and tm_sec are used.
+		 */
+		unsigned char hrs, min, sec;
+		struct rtc_time alm_tm;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if (copy_from_user(&alm_tm, (struct rtc_time*)arg,
+				   sizeof(struct rtc_time)))
+			return -EFAULT;
+
+		hrs = alm_tm.tm_hour;
+		min = alm_tm.tm_min;
+
+		if (hrs >= 24)
+			hrs = 0xff;
+
+		if (min >= 60)
+			min = 0xff;
+
+		BIN_TO_BCD(sec);
+		BIN_TO_BCD(min);
+		BIN_TO_BCD(hrs);
+
+		spin_lock(&ds1286_lock);
+		CMOS_WRITE(hrs, RTC_HOURS_ALARM);
+		CMOS_WRITE(min, RTC_MINUTES_ALARM);
+		spin_unlock(&ds1286_lock);
+
+		return 0;
+	}
+	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
+	{
+		ds1286_get_time(&wtime);
+		break;
+	}
+	case RTC_SET_TIME:	/* Set the RTC */
+	{
+		struct rtc_time rtc_tm;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if (copy_from_user(&rtc_tm, (struct rtc_time*)arg,
+				   sizeof(struct rtc_time)))
+			return -EFAULT;
+		
+		return ds1286_set_time(&rtc_tm);
+	}
+	default:
+		return -EINVAL;
+	}
+	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
+}
+
+/*
+ *	We enforce only one user at a time here with the open/close.
+ *	Also clear the previous interrupt data on an open, and clean
+ *	up things on a close.
+ */
+
+static int ds1286_open(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&ds1286_lock);
+
+	if (ds1286_status & RTC_IS_OPEN)
+		goto out_busy;
+
+	ds1286_status |= RTC_IS_OPEN;
+
+	spin_lock_irq(&ds1286_lock);
+	return 0;
+
+out_busy:
+	spin_lock_irq(&ds1286_lock);
+	return -EBUSY;
+}
+
+static int ds1286_release(struct inode *inode, struct file *file)
+{
+	ds1286_status &= ~RTC_IS_OPEN;
+
+	return 0;
+}
+
+static unsigned int ds1286_poll(struct file *file, poll_table *wait)
+{
+	poll_wait(file, &ds1286_wait, wait);
+
+	return 0;
+}
+
+/*
+ *	The various file operations we support.
+ */
+
+static struct file_operations ds1286_fops = {
+	llseek:		no_llseek,
+	read:		ds1286_read,
+	poll:		ds1286_poll,
+	ioctl:		ds1286_ioctl,
+	open:		ds1286_open,
+	release:	ds1286_release,
+};
+
+static struct miscdevice ds1286_dev=
+{
+	RTC_MINOR,
+	"rtc",
+	&ds1286_fops
+};
+
+int __init ds1286_init(void)
+{
+	printk(KERN_INFO "DS1286 Real Time Clock Driver v%s\n", DS1286_VERSION);
+	misc_register(&ds1286_dev);
+
+	return 0;
+}
+
+static char *days[] = {
+	"***", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
+};
+
+/*
+ *	Info exported via "/proc/rtc".
+ */
+int get_ds1286_status(char *buf)
+{
+	char *p, *s;
+	struct rtc_time tm;
+	unsigned char hundredth, month, cmd, amode;
+
+	p = buf;
+
+	ds1286_get_time(&tm);
+	hundredth = CMOS_READ(RTC_HUNDREDTH_SECOND);
+	BCD_TO_BIN(hundredth);
+
+	p += sprintf(p,
+	             "rtc_time\t: %02d:%02d:%02d.%02d\n"
+	             "rtc_date\t: %04d-%02d-%02d\n",
+		     tm.tm_hour, tm.tm_min, tm.tm_sec, hundredth,
+		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+
+	/*
+	 * We implicitly assume 24hr mode here. Alarm values >= 0xc0 will
+	 * match any value for that particular field. Values that are
+	 * greater than a valid time, but less than 0xc0 shouldn't appear.
+	 */
+	ds1286_get_alm_time(&tm);
+	p += sprintf(p, "alarm\t\t: %s ", days[tm.tm_wday]);
+	if (tm.tm_hour <= 24)
+		p += sprintf(p, "%02d:", tm.tm_hour);
+	else
+		p += sprintf(p, "**:");
+
+	if (tm.tm_min <= 59)
+		p += sprintf(p, "%02d\n", tm.tm_min);
+	else
+		p += sprintf(p, "**\n");
+
+	month = CMOS_READ(RTC_MONTH);
+	p += sprintf(p,
+	             "oscillator\t: %s\n"
+	             "square_wave\t: %s\n",
+	             (month & RTC_EOSC) ? "disabled" : "enabled",
+	             (month & RTC_ESQW) ? "disabled" : "enabled");
+
+	amode = ((CMOS_READ(RTC_MINUTES_ALARM) & 0x80) >> 5) |
+	        ((CMOS_READ(RTC_HOURS_ALARM) & 0x80) >> 6) |
+	        ((CMOS_READ(RTC_DAY_ALARM) & 0x80) >> 7);
+	if (amode == 7)      s = "each minute";
+	else if (amode == 3) s = "minutes match";
+	else if (amode == 1) s = "hours and minutes match";
+	else if (amode == 0) s = "days, hours and minutes match";
+	else                 s = "invalid";
+	p += sprintf(p, "alarm_mode\t: %s\n", s);
+
+	cmd = CMOS_READ(RTC_CMD);
+	p += sprintf(p,
+	             "alarm_enable\t: %s\n"
+	             "wdog_alarm\t: %s\n"
+	             "alarm_mask\t: %s\n"
+	             "wdog_alarm_mask\t: %s\n"
+	             "interrupt_mode\t: %s\n"
+	             "INTB_mode\t: %s_active\n"
+	             "interrupt_pins\t: %s\n",
+		     (cmd & RTC_TDF) ? "yes" : "no",
+		     (cmd & RTC_WAF) ? "yes" : "no",
+		     (cmd & RTC_TDM) ? "disabled" : "enabled",
+		     (cmd & RTC_WAM) ? "disabled" : "enabled",
+		     (cmd & RTC_PU_LVL) ? "pulse" : "level",
+		     (cmd & RTC_IBH_LO) ? "low" : "high",
+	             (cmd & RTC_IPSW) ? "unswapped" : "swapped");
+
+	return  p - buf;
+}
+
+/*
+ * Returns true if a clock update is in progress
+ */
+static inline unsigned char ds1286_is_updating(void)
+{
+	return CMOS_READ(RTC_CMD) & RTC_TE;
+}
+
+
+void ds1286_get_time(struct rtc_time *rtc_tm)
+{
+	unsigned char save_control;
+	unsigned int flags;
+	unsigned long uip_watchdog = jiffies;
+	
+	/*
+	 * read RTC once any update in progress is done. The update
+	 * can take just over 2ms. We wait 10 to 20ms. There is no need to
+	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
+	 * If you need to know *exactly* when a second has started, enable
+	 * periodic update complete interrupts, (via ioctl) and then 
+	 * immediately read /dev/rtc which will block until you get the IRQ.
+	 * Once the read clears, read the RTC time (again via ioctl). Easy.
+	 */
+
+	if (ds1286_is_updating() != 0)
+		while (jiffies - uip_watchdog < 2*HZ/100)
+			barrier();
+
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+	spin_lock_irqsave(&ds1286_lock, flags);
+	save_control = CMOS_READ(RTC_CMD);
+	CMOS_WRITE((save_control|RTC_TE), RTC_CMD);
+
+	rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
+	rtc_tm->tm_min = CMOS_READ(RTC_MINUTES);
+	rtc_tm->tm_hour = CMOS_READ(RTC_HOURS) & 0x1f;
+	rtc_tm->tm_mday = CMOS_READ(RTC_DATE);
+	rtc_tm->tm_mon = CMOS_READ(RTC_MONTH) & 0x1f;
+	rtc_tm->tm_year = CMOS_READ(RTC_YEAR);
+
+	CMOS_WRITE(save_control, RTC_CMD);
+	spin_unlock_irqrestore(&ds1286_lock, flags);
+
+	BCD_TO_BIN(rtc_tm->tm_sec);
+	BCD_TO_BIN(rtc_tm->tm_min);
+	BCD_TO_BIN(rtc_tm->tm_hour);
+	BCD_TO_BIN(rtc_tm->tm_mday);
+	BCD_TO_BIN(rtc_tm->tm_mon);
+	BCD_TO_BIN(rtc_tm->tm_year);
+
+	/*
+	 * Account for differences between how the RTC uses the values
+	 * and how they are defined in a struct rtc_time;
+	 */
+	if (rtc_tm->tm_year < 45)
+		rtc_tm->tm_year += 30;
+	if ((rtc_tm->tm_year += 40) < 70)
+		rtc_tm->tm_year += 100;
+
+	rtc_tm->tm_mon--;
+}
+
+int ds1286_set_time(struct rtc_time *rtc_tm)
+{
+	unsigned char mon, day, hrs, min, sec, leap_yr;
+	unsigned char save_control;
+	unsigned int yrs, flags;
+
+
+	yrs = rtc_tm->tm_year + 1900;
+	mon = rtc_tm->tm_mon + 1;   /* tm_mon starts at zero */
+	day = rtc_tm->tm_mday;
+	hrs = rtc_tm->tm_hour;
+	min = rtc_tm->tm_min;
+	sec = rtc_tm->tm_sec;
+
+	if (yrs < 1970)
+		return -EINVAL;
+
+	leap_yr = ((!(yrs % 4) && (yrs % 100)) || !(yrs % 400));
+
+	if ((mon > 12) || (day == 0))
+		return -EINVAL;
+
+	if (day > (days_in_mo[mon] + ((mon == 2) && leap_yr)))
+		return -EINVAL;
+
+	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
+		return -EINVAL;
+
+	if ((yrs -= 1940) > 255)    /* They are unsigned */
+		return -EINVAL;
+
+	if (yrs >= 100)
+		yrs -= 100;
+
+	BIN_TO_BCD(sec);
+	BIN_TO_BCD(min);
+	BIN_TO_BCD(hrs);
+	BIN_TO_BCD(day);
+	BIN_TO_BCD(mon);
+	BIN_TO_BCD(yrs);
+
+	spin_lock_irqsave(&ds1286_lock, flags);
+	save_control = CMOS_READ(RTC_CMD);
+	CMOS_WRITE((save_control|RTC_TE), RTC_CMD);
+
+	CMOS_WRITE(yrs, RTC_YEAR);
+	CMOS_WRITE(mon, RTC_MONTH);
+	CMOS_WRITE(day, RTC_DATE);
+	CMOS_WRITE(hrs, RTC_HOURS);
+	CMOS_WRITE(min, RTC_MINUTES);
+	CMOS_WRITE(sec, RTC_SECONDS);
+	CMOS_WRITE(0, RTC_HUNDREDTH_SECOND);
+
+	CMOS_WRITE(save_control, RTC_CMD);
+	spin_unlock_irqrestore(&ds1286_lock, flags);
+
+	return 0;
+}
+
+void ds1286_get_alm_time(struct rtc_time *alm_tm)
+{
+	unsigned char cmd;
+	unsigned int flags;
+
+	/*
+	 * Only the values that we read from the RTC are set. That
+	 * means only tm_wday, tm_hour, tm_min.
+	 */
+	spin_lock_irqsave(&ds1286_lock, flags);
+	alm_tm->tm_min = CMOS_READ(RTC_MINUTES_ALARM) & 0x7f;
+	alm_tm->tm_hour = CMOS_READ(RTC_HOURS_ALARM)  & 0x1f;
+	alm_tm->tm_wday = CMOS_READ(RTC_DAY_ALARM)    & 0x07;
+	cmd = CMOS_READ(RTC_CMD);
+	spin_unlock_irqrestore(&ds1286_lock, flags);
+
+	BCD_TO_BIN(alm_tm->tm_min);
+	BCD_TO_BIN(alm_tm->tm_hour);
+	alm_tm->tm_sec = 0;
+}
+
+module_init(ds1286_init)
diff -r -N -u -w oss-2.4/linux/drivers/char/misc.c oss-2.4-ddb5074/linux/drivers/char/misc.c
--- oss-2.4/linux/drivers/char/misc.c	Thu Jun 27 00:35:33 2002
+++ oss-2.4-ddb5074/linux/drivers/char/misc.c	Thu Jul 11 19:19:24 2002
@@ -261,9 +261,6 @@
 #ifdef CONFIG_BVME6000
 	rtc_DP8570A_init();
 #endif
-#ifdef CONFIG_SGI_DS1286
-	ds1286_init();
-#endif
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_device_init();
 #endif

--liOOAslEiF7prFVr--
