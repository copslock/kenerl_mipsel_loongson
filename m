Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 07:48:01 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:63763
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225541AbTKTHr2>; Thu, 20 Nov 2003 07:47:28 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 20 Nov 2003 07:47:53 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hAK7ljnd000782;
	Thu, 20 Nov 2003 16:47:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 20 Nov 2003 16:50:28 +0900 (JST)
Message-Id: <20031120.165028.59648656.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: frame_info_init in 2.6 kernel
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
X-archive-position: 3646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I suppose everybody running 2.6 mips kernel see this error message:

> Can't analyze prologue code at XXXXXXXX

XXXXXXXX is an address of schedule_timeout function.

This is because schedule_timeout was moved to timer.c from sched.c and
therefore compiled without -fno-omit-frame-pointer.

If the error is detected, get_wchan does not work so the "ps lw"
command can not print WCHAN field correctly.

How about this patch?

--- arch/mips/kernel/process.c.org	Thu Nov 20 16:34:45 2003
+++ arch/mips/kernel/process.c	Thu Nov 20 16:38:39 2003
@@ -251,12 +251,20 @@
 
 static int __init frame_info_init(void)
 {
-	mips_frame_info_initialized =
-		!get_frame_info(&schedule_frame, schedule) &&
-		!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
-		!get_frame_info(&sleep_on_frame, sleep_on) &&
-		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
-		!get_frame_info(&wait_for_completion_frame, wait_for_completion);
+	/* in 2.6 kernel, schedule_timout is out of [first_sched,last_sched] */
+	if ((unsigned long)schedule_timeout < first_sched ||
+	    (unsigned long)schedule_timeout >= last_sched)
+		mips_frame_info_initialized =
+			!get_frame_info(&schedule_frame, schedule) &&
+			!get_frame_info(&sleep_on_frame, sleep_on) &&
+			!get_frame_info(&wait_for_completion_frame, wait_for_completion);
+	else
+		mips_frame_info_initialized =
+			!get_frame_info(&schedule_frame, schedule) &&
+			!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
+			!get_frame_info(&sleep_on_frame, sleep_on) &&
+			!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
+			!get_frame_info(&wait_for_completion_frame, wait_for_completion);
 
 	return 0;
 }
@@ -323,6 +331,9 @@
 	goto out;
 
 schedule_timeout_caller:
+	if ((unsigned long)schedule_timeout < first_sched ||
+	    (unsigned long)schedule_timeout >= last_sched)
+		return pc;	/* failsafe */
 	/*
 	 * The schedule_timeout frame
 	 */
---
Atsushi Nemoto
