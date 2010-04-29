Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 11:56:59 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:41326 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492385Ab0D2J4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 11:56:53 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id DAC72274006; Thu, 29 Apr 2010 11:56:51 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id B79D3274012;
        Thu, 29 Apr 2010 11:56:50 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id E7A5484250;
        Thu, 29 Apr 2010 12:14:31 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id D61A0FF855;
        Thu, 29 Apr 2010 11:58:44 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Cc:     david-b@pacbell.net, a.zummo@towertech.it, ralf@linux-mips.org,
        akpm@linux-foundation.org
Subject: [PATCH] rtc-cmos: Fix binary mode support
Organization: Mandriva
Date:   Thu, 29 Apr 2010 11:58:44 +0200
Message-ID: <m3zl0mwpez.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=

[ I'm sending again this patch, hoping it'll get reviewed ]


As a follow-up to the thread about rtc support for some loongson 2e/2f
boards, this patch tries to address the "REVISIT"/"FIXME" comments about
rtc binary mode handling and allow rtc to work with rtc in binary mode.
I've also raised the message about 24-h mode not supported to warning
otherwise, one may end up with no rtc without any message in the kernel
log.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=rtc_cmos_binary_mode_fix.patch

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index e9aa814..9d99408 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -238,31 +238,32 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	rtc_control = CMOS_READ(RTC_CONTROL);
 	spin_unlock_irq(&rtc_lock);
 
-	/* REVISIT this assumes PC style usage:  always BCD */
-
-	if (((unsigned)t->time.tm_sec) < 0x60)
-		t->time.tm_sec = bcd2bin(t->time.tm_sec);
-	else
-		t->time.tm_sec = -1;
-	if (((unsigned)t->time.tm_min) < 0x60)
-		t->time.tm_min = bcd2bin(t->time.tm_min);
-	else
-		t->time.tm_min = -1;
-	if (((unsigned)t->time.tm_hour) < 0x24)
-		t->time.tm_hour = bcd2bin(t->time.tm_hour);
-	else
-		t->time.tm_hour = -1;
-
-	if (cmos->day_alrm) {
-		if (((unsigned)t->time.tm_mday) <= 0x31)
-			t->time.tm_mday = bcd2bin(t->time.tm_mday);
+	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		if (((unsigned)t->time.tm_sec) < 0x60)
+			t->time.tm_sec = bcd2bin(t->time.tm_sec);
 		else
-			t->time.tm_mday = -1;
-		if (cmos->mon_alrm) {
-			if (((unsigned)t->time.tm_mon) <= 0x12)
-				t->time.tm_mon = bcd2bin(t->time.tm_mon) - 1;
+			t->time.tm_sec = -1;
+		if (((unsigned)t->time.tm_min) < 0x60)
+			t->time.tm_min = bcd2bin(t->time.tm_min);
+		else
+			t->time.tm_min = -1;
+		if (((unsigned)t->time.tm_hour) < 0x24)
+			t->time.tm_hour = bcd2bin(t->time.tm_hour);
+		else
+			t->time.tm_hour = -1;
+
+		if (cmos->day_alrm) {
+			if (((unsigned)t->time.tm_mday) <= 0x31)
+				t->time.tm_mday = bcd2bin(t->time.tm_mday);
 			else
-				t->time.tm_mon = -1;
+				t->time.tm_mday = -1;
+
+			if (cmos->mon_alrm) {
+				if (((unsigned)t->time.tm_mon) <= 0x12)
+					t->time.tm_mon = bcd2bin(t->time.tm_mon)-1;
+				else
+					t->time.tm_mon = -1;
+			}
 		}
 	}
 	t->time.tm_year = -1;
@@ -322,29 +323,26 @@ static void cmos_irq_disable(struct cmos_rtc *cmos, unsigned char mask)
 static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
-	unsigned char	mon, mday, hrs, min, sec;
+       unsigned char   mon, mday, hrs, min, sec, rtc_control;
 
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
-	/* REVISIT this assumes PC style usage:  always BCD */
-
-	/* Writing 0xff means "don't care" or "match all".  */
-
 	mon = t->time.tm_mon + 1;
-	mon = (mon <= 12) ? bin2bcd(mon) : 0xff;
-
 	mday = t->time.tm_mday;
-	mday = (mday >= 1 && mday <= 31) ? bin2bcd(mday) : 0xff;
-
 	hrs = t->time.tm_hour;
-	hrs = (hrs < 24) ? bin2bcd(hrs) : 0xff;
-
 	min = t->time.tm_min;
-	min = (min < 60) ? bin2bcd(min) : 0xff;
-
 	sec = t->time.tm_sec;
-	sec = (sec < 60) ? bin2bcd(sec) : 0xff;
+
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		/* Writing 0xff means "don't care" or "match all".  */
+		mon = (mon <= 12) ? bin2bcd(mon) : 0xff;
+		mday = (mday >= 1 && mday <= 31) ? bin2bcd(mday) : 0xff;
+		hrs = (hrs < 24) ? bin2bcd(hrs) : 0xff;
+		min = (min < 60) ? bin2bcd(min) : 0xff;
+		sec = (sec < 60) ? bin2bcd(sec) : 0xff;
+	}
 
 	spin_lock_irq(&rtc_lock);
 
@@ -478,7 +476,7 @@ static int cmos_procfs(struct device *dev, struct seq_file *seq)
 			"update_IRQ\t: %s\n"
 			"HPET_emulated\t: %s\n"
 			// "square_wave\t: %s\n"
-			// "BCD\t\t: %s\n"
+			"BCD\t\t: %s\n"
 			"DST_enable\t: %s\n"
 			"periodic_freq\t: %d\n"
 			"batt_status\t: %s\n",
@@ -486,7 +484,7 @@ static int cmos_procfs(struct device *dev, struct seq_file *seq)
 			(rtc_control & RTC_UIE) ? "yes" : "no",
 			is_hpet_enabled() ? "yes" : "no",
 			// (rtc_control & RTC_SQWE) ? "yes" : "no",
-			// (rtc_control & RTC_DM_BINARY) ? "no" : "yes",
+			(rtc_control & RTC_DM_BINARY) ? "no" : "yes",
 			(rtc_control & RTC_DST_EN) ? "yes" : "no",
 			cmos->rtc->irq_freq,
 			(valid & RTC_VRT) ? "okay" : "dead");
@@ -749,12 +747,11 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	spin_unlock_irq(&rtc_lock);
 
-	/* FIXME teach the alarm code how to handle binary mode;
+	/* FIXME:
 	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
 	 */
-	if (is_valid_irq(rtc_irq) &&
-	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
-		dev_dbg(dev, "only 24-hr BCD mode supported\n");
+       if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
+		dev_warn(dev, "only 24-hr supported\n")
 		retval = -ENXIO;
 		goto cleanup1;
 	}

--=-=-=--
