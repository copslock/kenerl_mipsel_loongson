Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2008 01:25:59 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:23805 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20035511AbYEQAZ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 May 2008 01:25:57 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4H0PWau006137;
	Sat, 17 May 2008 02:25:32 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4H0PJqN006133;
	Sat, 17 May 2008 01:25:27 +0100
Date:	Sat, 17 May 2008 01:25:18 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <a.zummo@towertech.it>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Andrew Morton <akpm@linux-foundation.org>
cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RTC: M41T80: Century Bit support
Message-ID: <Pine.LNX.4.55.0805170057370.4049@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Make use of the Century Bit to support years in the range from 1970 to 
2169.  Enable toggling of the bit at the end of a century on a clock 
update.
---
 The clock is used with the Broadcom SWARM and the D-Link DNS-323 
platform.

 I have verified correct operation with the SWARM -- the firmware assumes
19YY when CB is clear and 20YY otherwise.  Which means years 1900-1969
will be shown as 2100-2169 in Linux.  I think this is a feature rather
than a problem.  The firmware does not set the CEB bit itself and does not 
care of what its state is.

 I will be happy to hear from a DNS-323 user to confirm or deny whether
such an interpretation is compatible.

 Otherwise, please apply.

  Maciej

patch-2.6.26-rc1-20080505-m41t80-century-4
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/rtc/rtc-m41t80.c linux-2.6.26-rc1-20080505/drivers/rtc/rtc-m41t80.c
--- linux-2.6.26-rc1-20080505.macro/drivers/rtc/rtc-m41t80.c	2008-05-05 02:55:40.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/rtc/rtc-m41t80.c	2008-05-16 21:16:48.000000000 +0000
@@ -52,6 +52,8 @@
 	(M41T80_REG_ALARM_SEC + 1 - M41T80_REG_ALARM_MON)
 
 #define M41T80_SEC_ST		(1 << 7)	/* ST: Stop Bit */
+#define M41T80_HOUR_CEB		(1 << 7)	/* CEB: Century Enable Bit */
+#define M41T80_HOUR_CB		(1 << 6)	/* CB: Century Bit */
 #define M41T80_ALMON_AFE	(1 << 7)	/* AFE: AF Enable Bit */
 #define M41T80_ALMON_SQWE	(1 << 6)	/* SQWE: SQW Enable Bit */
 #define M41T80_ALHOUR_HT	(1 << 6)	/* HT: Halt Update Bit */
@@ -164,8 +166,12 @@ static int m41t80_get_datetime(struct i2
 	tm->tm_wday = buf[M41T80_REG_WDAY] & 0x07;
 	tm->tm_mon = BCD2BIN(buf[M41T80_REG_MON] & 0x1f) - 1;
 
-	/* assume 20YY not 19YY, and ignore the Century Bit */
-	tm->tm_year = BCD2BIN(buf[M41T80_REG_YEAR]) + 100;
+	/* Assume 1970-2169, taking the Century Bit into account. */
+	tm->tm_year = BCD2BIN(buf[M41T80_REG_YEAR]);
+	if ((buf[M41T80_REG_HOUR] & M41T80_HOUR_CB) != 0)
+		tm->tm_year += 100;
+	if (tm->tm_year < 70)
+		tm->tm_year += 200;
 	return 0;
 }
 
@@ -196,8 +202,14 @@ static int m41t80_set_datetime(struct i2
 		BIN2BCD(tm->tm_mday) | (buf[M41T80_REG_DAY] & ~0x3f);
 	buf[M41T80_REG_MON] =
 		BIN2BCD(tm->tm_mon + 1) | (buf[M41T80_REG_MON] & ~0x1f);
-	/* assume 20YY not 19YY */
+	/* Assume 1970-2169 and set the Century Bit for 19YY/21YY. */
 	buf[M41T80_REG_YEAR] = BIN2BCD(tm->tm_year % 100);
+	if ((tm->tm_year / 100) % 2 != 0)
+		buf[M41T80_REG_HOUR] |= M41T80_HOUR_CB;
+	else
+		buf[M41T80_REG_HOUR] &= ~M41T80_HOUR_CB;
+	/* Enable toggling of the Century Bit at the end of a century. ;-) */
+	buf[M41T80_REG_HOUR] |= M41T80_HOUR_CEB;
 
 	if (m41t80_write_block_data(client, M41T80_REG_SSEC,
 				    M41T80_DATETIME_REG_SIZE, buf) < 0) {
