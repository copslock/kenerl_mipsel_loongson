Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G4GDm11112
	for linux-mips-outgoing; Wed, 15 Aug 2001 21:16:13 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G4GAj11109
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 21:16:10 -0700
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 16 Aug 2001 04:16:10 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id F341954C11; Thu, 16 Aug 2001 13:16:08 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA69673; Thu, 16 Aug 2001 13:16:08 +0900 (JST)
To: dan@debian.org
Cc: carstenl@mips.com, linux-mips@oss.sgi.com
Subject: Re: FP emulator patch
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010815110634.A19305@nevyn.them.org>
References: <3B7A70B8.ED92FE4@mips.com>
	<20010815110634.A19305@nevyn.them.org>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Aug_16_13:19:40_2001_179)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010816132042T.nemoto@toshiba-tops.co.jp>
Date: Thu, 16 Aug 2001 13:20:42 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Thu_Aug_16_13:19:40_2001_179)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Wed, 15 Aug 2001 11:06:34 -0700, Daniel Jacobowitz <dan@debian.org> said:
>> Index: linux/arch/mips/kernel/signal.c
>
>> @@ -353,12 +355,11 @@
>>  	owned_fp = (current == last_task_used_math);
>>  	err |= __put_user(owned_fp, &sc->sc_ownedfp);
>>  
>> -	if (current->used_math) {	/* fp is active.  */
>> +	if (owned_fp) { /* fp is active.  */
>>  		set_cp0_status(ST0_CU1);
>>  		err |= save_fp_context(sc);
>>  		last_task_used_math = NULL;
>>  		regs->cp0_status &= ~ST0_CU1;
>> -		current->used_math = 0;
>>  	}
>>  
>>  	return err;

dan> This is absolutely not right.  It's righter than the status quo.
dan> If we don't own the FP, you don't save the FP.  Then we can use
dan> FP in the signal handler, corrupting the process's original
dan> floating point context.

I also am trying to fix this problem.  How about my patch?

restore_sigcontext() can be more optimized, but I think this is a
smallest patch to fix the problem.

---
Atsushi Nemoto

----Next_Part(Thu_Aug_16_13:19:40_2001_179)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signal.c.patch"

diff -ur linux.sgi/arch/mips/kernel/signal.c linux/arch/mips/kernel/signal.c
--- linux.sgi/arch/mips/kernel/signal.c	Mon Jun 25 22:56:56 2001
+++ linux/arch/mips/kernel/signal.c	Thu Aug 16 13:09:28 2001
@@ -350,11 +350,18 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = (current == last_task_used_math);
+	/* restore_sigcontext must restore the fp context even if this
+	   process was not last_task_used_math. */
+	owned_fp = current->used_math;
 	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 
 	if (current->used_math) {	/* fp is active.  */
+#if 0
+		/* Do not set CU1 here.  If this process does not
+		   owned fp, save_fp_context causes lazy_fpu_switch
+		   (and fp-owner's context will saved). */
 		set_cp0_status(ST0_CU1);
+#endif
 		err |= save_fp_context(sc);
 		last_task_used_math = NULL;
 		regs->cp0_status &= ~ST0_CU1;

----Next_Part(Thu_Aug_16_13:19:40_2001_179)----
