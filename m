Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f95ISFL12986
	for linux-mips-outgoing; Fri, 5 Oct 2001 11:28:15 -0700
Received: from e32.bld.us.ibm.com (e32.co.us.ibm.com [32.97.110.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f95ISAD12980
	for <linux-mips@oss.sgi.com>; Fri, 5 Oct 2001 11:28:10 -0700
Received: from westrelay03.boulder.ibm.com (westrelay03.boulder.ibm.com [9.99.140.24])
	by e32.bld.us.ibm.com (8.9.3/8.9.3) with ESMTP id OAA40034;
	Fri, 5 Oct 2001 14:25:46 -0400
Received: from localhost.localdomain (dyn9-47-18-112.des.beaverton.ibm.com [9.47.18.112])
	by westrelay03.boulder.ibm.com (8.11.1m3/NCO v4.98) with ESMTP id f95IQrG147206;
	Fri, 5 Oct 2001 12:26:53 -0600
Received: (from dave@localhost)
	by localhost.localdomain (8.11.2/8.11.2) id f95IQpb02486;
	Fri, 5 Oct 2001 11:26:51 -0700
Date: Fri, 5 Oct 2001 11:26:51 -0700
From: "David C. Hansen" <haveblue@us.ibm.com>
Message-Id: <200110051826.f95IQpb02486@localhost.localdomain>
To: linux-mips@oss.sgi.com, ralf@gnu.org
Subject: [PATCH] to fix locking in ip27-rtc.c open() and release()
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This patch fixes a potential race condition in ip27-rtc.c.  The rtc_status variable is not sufficient to ensure exclusive write access to the file in the open() function.  This patch adds locking around the necessary critical areas in open() and replaces the big kernel lock in release().


--- linux-2.4.10-clean/arch/mips64/sgi-ip27/ip27-rtc.c	Tue Nov 28 21:42:04 2000
+++ linux/arch/mips64/sgi-ip27/ip27-rtc.c	Tue Oct  2 13:23:09 2001
@@ -61,6 +61,7 @@
 #define RTC_TIMER_ON		0x02	/* missed irq timer active	*/
 
 static unsigned char rtc_status;	/* bitmapped status byte.	*/
+static spinlock_t rtc_status_lock = SPIN_LOCK_UNLOCKED;
 static unsigned long rtc_freq;	/* Current periodic IRQ rate	*/
 static struct m48t35_rtc *rtc;
 
@@ -166,10 +167,15 @@
 
 static int rtc_open(struct inode *inode, struct file *file)
 {
+	spin_lock( rtc_status_lock );
 	if(rtc_status & RTC_IS_OPEN)
+	{
+		spin_unlock( rtc_status_lock );
 		return -EBUSY;
+	}
 
 	rtc_status |= RTC_IS_OPEN;
+	spin_unlock( rtc_status_lock );
 	return 0;
 }
 
@@ -180,9 +186,9 @@
 	 * in use, and clear the data.
 	 */
 
-	lock_kernel();
+	spin_lock( rtc_status_lock );
 	rtc_status &= ~RTC_IS_OPEN;
-	unlock_kernel();
+	spin_unlock( rtc_status_lock );
 	return 0;
 }
 

--
David C. Hansen
haveblue@us.ibm.com
IBM LTC Base/OS Group
(503)578-4080
