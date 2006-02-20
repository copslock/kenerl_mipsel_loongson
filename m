Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 00:08:24 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:58381 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133727AbWBTAIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 00:08:12 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id DCAF764D3D; Mon, 20 Feb 2006 00:15:00 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9B6028D5D; Mon, 20 Feb 2006 00:14:53 +0000 (GMT)
Date:	Mon, 20 Feb 2006 00:14:53 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: drivers/char/rtc.c: Handle memory-mapped chips properly
Message-ID: <20060220001453.GA18060@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Maciej,

The following change you made to drivers/char/rtc.c ("Handle
memory-mapped chips properly") never made it into mainline.  Can you
please review the change again and submit it to the appropriate
sub-system maintainer.


--- linux-2.6.16-rc4/drivers/char/rtc.c	2006-02-19 20:08:44.000000000 +0000
+++ mips-2.6.16-rc4/drivers/char/rtc.c	2006-02-19 20:15:07.000000000 +0000
@@ -35,23 +35,22 @@
  *	1.09a	Pete Zaitcev: Sun SPARC
  *	1.09b	Jeff Garzik: Modularize, init cleanup
  *	1.09c	Jeff Garzik: SMP cleanup
- *	1.10    Paul Barton-Davis: add support for async I/O
+ *	1.10	Paul Barton-Davis: add support for async I/O
  *	1.10a	Andrea Arcangeli: Alpha updates
  *	1.10b	Andrew Morton: SMP lock fix
  *	1.10c	Cesar Barros: SMP locking fixes and cleanup
  *	1.10d	Paul Gortmaker: delete paranoia check in rtc_exit
  *	1.10e	Maciej W. Rozycki: Handle DECstation's year weirdness.
- *      1.11    Takashi Iwai: Kernel access functions
+ *	1.11	Takashi Iwai: Kernel access functions
  *			      rtc_register/rtc_unregister/rtc_control
  *      1.11a   Daniele Bellucci: Audit create_proc_read_entry in rtc_init
- *	1.12	Venkatesh Pallipadi: Hooks for emulating rtc on HPET base-timer
+ *	1.12    Venkatesh Pallipadi: Hooks for emulating rtc on HPET base-timer
  *		CONFIG_HPET_EMULATE_RTC
+ *	1.12a	Maciej W. Rozycki: Handle memory-mapped chips properly.
  *	1.12ac	Alan Cox: Allow read access to the day of week register
  */
 
-#define RTC_VERSION		"1.12ac"
-
-#define RTC_IO_EXTENT	0x8
+#define RTC_VERSION		"1.12a"
 
 /*
  *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with
@@ -338,7 +337,15 @@
 	if (rtc_has_irq == 0)
 		return -EIO;
 
-	if (count < sizeof(unsigned))
+	/*
+	 * Historically this function used to assume that sizeof(unsigned long)
+	 * is the same in userspace and kernelspace.  This lead to problems
+	 * for configurations with multiple ABIs such a the MIPS o32 and 64
+	 * ABIs supported on the same kernel.  So now we support read of both
+	 * 4 and 8 bytes and assume that's the sizeof(unsigned long) in the
+	 * userspace ABI.
+	 */
+	if (count != sizeof(unsigned int) && count !=  sizeof(unsigned long))
 		return -EINVAL;
 
 	add_wait_queue(&rtc_wait, &wait);
@@ -369,10 +376,12 @@
 		schedule();
 	} while (1);
 
-	if (count < sizeof(unsigned long))
-		retval = put_user(data, (unsigned int __user *)buf) ?: sizeof(int); 
+	if (count == sizeof(unsigned int))
+		retval = put_user(data, (unsigned int __user *)buf) ?: sizeof(int);
 	else
 		retval = put_user(data, (unsigned long __user *)buf) ?: sizeof(long);
+	if (!retval)
+		retval = count;
  out:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&rtc_wait, &wait);
@@ -924,6 +933,9 @@
 	struct sparc_isa_device *isa_dev;
 #endif
 #endif
+#ifndef __sparc__
+	void *r;
+#endif
 
 #ifdef __sparc__
 	for_each_ebus(ebus) {
@@ -969,8 +981,13 @@
 	}
 no_irq:
 #else
-	if (!request_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc")) {
-		printk(KERN_ERR "rtc: I/O port %d is not free.\n", RTC_PORT (0));
+	if (RTC_IOMAPPED)
+		r = request_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc");
+	else
+		r = request_mem_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc");
+	if (!r) {
+		printk(KERN_ERR "rtc: I/O resource %lx is not free.\n",
+		       (long)(RTC_PORT(0)));
 		return -EIO;
 	}
 
@@ -984,7 +1001,10 @@
 	if(request_irq(RTC_IRQ, rtc_int_handler_ptr, SA_INTERRUPT, "rtc", NULL)) {
 		/* Yeah right, seeing as irq 8 doesn't even hit the bus. */
 		printk(KERN_ERR "rtc: IRQ %d is not free.\n", RTC_IRQ);
-		release_region(RTC_PORT(0), RTC_IO_EXTENT);
+		if (RTC_IOMAPPED)
+			release_region(RTC_PORT(0), RTC_IO_EXTENT);
+		else
+			release_mem_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -EIO;
 	}
 	hpet_rtc_timer_init();
@@ -1084,7 +1104,10 @@
 	if (rtc_has_irq)
 		free_irq (rtc_irq, &rtc_port);
 #else
-	release_region (RTC_PORT (0), RTC_IO_EXTENT);
+	if (RTC_IOMAPPED)
+		release_region(RTC_PORT(0), RTC_IO_EXTENT);
+	else
+		release_mem_region(RTC_PORT(0), RTC_IO_EXTENT);
 #ifdef RTC_IRQ
 	if (rtc_has_irq)
 		free_irq (RTC_IRQ, NULL);


-- 
Martin Michlmayr
http://www.cyrius.com/
