Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 16:26:20 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:62172 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133728AbWC2P0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 16:26:11 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FOcgp-0003j5-Tl
	for linux-mips@linux-mips.org; Wed, 29 Mar 2006 17:34:32 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FOck0-0008Rt-4k
	for linux-mips@linux-mips.org; Wed, 29 Mar 2006 17:37:48 +0200
Date:	Wed, 29 Mar 2006 17:37:48 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Message-ID: <20060329153748.GU10460@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Timing with TOY on Au1100
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

I've checked the TOY programming on a board Au1100 based and I notice
that the frequency is not correct. Infact the TOY frequency is just
HZ/2... I suggest this patch that should fix this topic. 

The patch also try to fix (in a poor manner) a problem related with
the jiffie_drift and the fact that HZ may be in the range [100:1000].

The last block (@@ -189,15 +196,11 @@) remove a bug during system wake
up when HZ is 1000. The while() may loose too much time computing the
last_match20 parameter and if TOY must run at 1K the system hangs
since the TOY is programmed with an alredy passed time stamp.

Ciao,

Rodolfo

Index: common/time.c
===================================================================
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/common/time.c,v
retrieving revision 1.3
diff -u -r1.3 time.c
--- a/common/time.c	26 Jul 2005 21:33:32 -0000	1.3
+++ b/common/time.c	29 Mar 2006 15:26:03 -0000
@@ -142,7 +143,7 @@
 		time_elapsed = pc0 - last_match20;
 	}
 
-	while (time_elapsed > 0) {
+	do {
 		do_timer(regs);
 #ifndef CONFIG_SMP
 		update_process_times(user_mode(regs));
@@ -150,14 +151,19 @@
 		time_elapsed -= MATCH20_INC;
 		last_match20 += MATCH20_INC;
 		jiffie_drift++;
-	}
+	} while (time_elapsed > MATCH20_INC);
 
 	last_pc0 = pc0;
 	au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
 	au_sync();
 
-	/* our counter ticks at 10.009765625 ms/tick, we we're running
-	 * almost 10uS too slow per tick.
+#if HZ < 400
+	/* our counter ticks at 
+	 *   HZ =  100 -> 10.009765625    ms/tick
+	 *   HZ =  400 ->  2.50244140625  ms/tick
+	 *   HZ =  500 ->  1.983642578125 ms/tick
+	 *   HZ = 1000 ->  0.9765625      ms/tick
+	 * so HZ = 400 may be a good discriminating point...
 	 */
 
 	if (jiffie_drift >= 999) {
@@ -167,6 +173,7 @@
 		update_process_times(user_mode(regs));
 #endif
 	}
+#endif
 
 	return IRQ_HANDLED;
 }
@@ -189,15 +196,11 @@
 		time_elapsed = pc0 - last_match20;
 	}
 
-	while (time_elapsed > 0) {
-		time_elapsed -= MATCH20_INC;
-		last_match20 += MATCH20_INC;
-	}
+	last_match20 += time_elapsed - time_elapsed%MATCH20_INC;
 
 	last_pc0 = pc0;
 	au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
 	au_sync();
-
 }
 
 /* This is just for debugging to set the timer for a sleep delay.

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
