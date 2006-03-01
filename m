Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 16:05:32 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:19183 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133572AbWCAQFX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2006 16:05:23 +0000
Received: from localhost (p7129-ipad01funabasi.chiba.ocn.ne.jp [61.207.81.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 07D31B4D9; Thu,  2 Mar 2006 01:13:08 +0900 (JST)
Date:	Thu, 02 Mar 2006 01:13:04 +0900 (JST)
Message-Id: <20060302.011304.75185944.anemo@mba.ocn.ne.jp>
To:	nickpiggin@yahoo.com.au
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4405B700.1080607@yahoo.com.au>
References: <44059915.3010800@yahoo.com.au>
	<20060301.235750.25910018.anemo@mba.ocn.ne.jp>
	<4405B700.1080607@yahoo.com.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 02 Mar 2006 02:00:16 +1100, Nick Piggin <nickpiggin@yahoo.com.au> said:

>> Well, do you mean it should be like this ?
>> 
>> jiffies_64++;
>> update_times(jiffies_64);

nick> Yeah. It makes your patch a line smaller too!

Another solution might be simplifying update_times() like this.  It
looks there is no point to calculate ticks in update_times().

diff --git a/kernel/timer.c b/kernel/timer.c
index fe3a9a9..6188c99 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -906,14 +906,9 @@ void run_local_timers(void)
  */
 static inline void update_times(void)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
-	if (ticks) {
-		wall_jiffies += ticks;
-		update_wall_time(ticks);
-	}
-	calc_load(ticks);
+	wall_jiffies++;
+	update_wall_time(1);
+	calc_load(1);
 }
   
 /*


As for long term solution, using an union for jiffies and jiffies_64
would be robust.  But it affects so many codes ...

---
Atsushi Nemoto
