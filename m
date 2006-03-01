Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 12:00:12 +0000 (GMT)
Received: from p549F6BF0.dip.t-dialin.net ([84.159.107.240]:62851 "EHLO
	p549F6BF0.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133138AbWCAL7o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 11:59:44 +0000
Received: from [IPv6:::ffff:202.230.225.126] ([IPv6:::ffff:202.230.225.126]:50519
	"EHLO topsns2.toshiba-tops.co.jp") by linux-mips.net with ESMTP
	id <S869099AbWCAMG4>; Wed, 1 Mar 2006 13:06:56 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for p549F6BF0.dip.t-dialin.net [84.159.107.240]) with ESMTP; Wed, 1 Mar 2006 21:06:46 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 067E020404;
	Wed,  1 Mar 2006 21:05:42 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E6C7820341;
	Wed,  1 Mar 2006 21:05:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k21C5f4D053710;
	Wed, 1 Mar 2006 21:05:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 01 Mar 2006 21:05:41 +0900 (JST)
Message-Id: <20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 10696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 01 Mar 2006 14:44:42 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> Hi.  I noticed that the 'jiffies' variable has 'wall_jiffies +
anemo> 1' value in most of time.  I'm using MIPS platform but I think
anemo> this is same for other platforms.

anemo> I suppose this is due to gcc does not know that jiffies_64 and
anemo> jiffies share same place.
...
anemo> Is this really expected code?  If no, how it can be fixed?
anemo> Insert "barrier()" right after "jiffies_64++" ?

I suppose passing updated jiffies to update_times() would be more
efficient than barrier().  Here is a patch.


Pass updated jiffies to update_times() to avoid jiffies/jiffies_64
aliasing.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/kernel/timer.c b/kernel/timer.c
index fe3a9a9..7734788 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -904,11 +904,11 @@ void run_local_timers(void)
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
-static inline void update_times(void)
+static inline void update_times(unsigned long jif)
 {
 	unsigned long ticks;
 
-	ticks = jiffies - wall_jiffies;
+	ticks = jif - wall_jiffies;
 	if (ticks) {
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
@@ -924,8 +924,7 @@ static inline void update_times(void)
 
 void do_timer(struct pt_regs *regs)
 {
-	jiffies_64++;
-	update_times();
+	update_times(++jiffies_64);
 	softlockup_tick(regs);
 }
 
---
Atsushi Nemoto
