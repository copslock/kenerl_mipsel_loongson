Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 01:13:46 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:28705
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225374AbTKTBNO>; Thu, 20 Nov 2003 01:13:14 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 20 Nov 2003 01:13:41 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hAK1DS9X099294;
	Thu, 20 Nov 2003 10:13:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 20 Nov 2003 10:16:11 +0900 (JST)
Message-Id: <20031120.101611.112629972.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, sjhill@realitydiluted.com
Subject: rtc_ds1742_wait
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The rtc_ds1742_wait() waits beginning of a next ODD second, though
users of this function expect that it will wait beginning of a next
second.  Here is a patch.

diff -u drivers/char/ds1742.c.org drivers/char/ds1742.c
--- drivers/char/ds1742.c.org	Tue Nov  4 16:57:38 2003
+++ drivers/char/ds1742.c	Thu Nov 20 10:06:05 2003
@@ -251,8 +251,8 @@
 
 void rtc_ds1742_wait(void)
 {
-	while (CMOS_READ(RTC_SECONDS) & 1);
-	while (!(CMOS_READ(RTC_SECONDS) & 1));
+	unsigned char sec = CMOS_READ(RTC_SECONDS);
+	while (!((sec ^ CMOS_READ(RTC_SECONDS)) & 1));
 }
 
 static int ds1742_ioctl(struct inode *inode, struct file *file,
---
Atsushi Nemoto
