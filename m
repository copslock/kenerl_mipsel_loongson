Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 06:08:53 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:170 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133385AbWCAGIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 06:08:42 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 1 Mar 2006 15:16:30 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9A5E620535;
	Wed,  1 Mar 2006 15:16:28 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 85F7220268;
	Wed,  1 Mar 2006 15:16:28 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k216GQ4D052138;
	Wed, 1 Mar 2006 15:16:27 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 01 Mar 2006 15:16:26 +0900 (JST)
Message-Id: <20060301.151626.48531391.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, geert@linux-m68k.org, takata@linux-m32r.org,
	davem@davemloft.net
Subject: [PATCH] [MIPS] use USECS_PER_SEC / HZ instead of tick_usec in
 do_gettimeofday
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The 'tick_usec' is USER_HZ period in usec.  do_gettimeofday() should
use kernel HZ value.

Here is a patch for MIPS.  It seems m32r, m68k and sparc have same
problem though their HZ and USER_HZ are same for now.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 7050b4f..42c94c7 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -163,7 +163,7 @@ void do_gettimeofday(struct timeval *tv)
 	unsigned long seq;
 	unsigned long lost;
 	unsigned long usec, sec;
-	unsigned long max_ntp_tick = tick_usec - tickadj;
+	unsigned long max_ntp_tick;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
@@ -178,12 +178,13 @@ void do_gettimeofday(struct timeval *tv)
 		 * Better to lose some accuracy than have time go backwards..
 		 */
 		if (unlikely(time_adjust < 0)) {
+			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
 			usec = min(usec, max_ntp_tick);
 
 			if (lost)
 				usec += lost * max_ntp_tick;
 		} else if (unlikely(lost))
-			usec += lost * tick_usec;
+			usec += lost * (USEC_PER_SEC / HZ);
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
