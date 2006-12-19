Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 15:01:22 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:723 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576972AbWLSPBR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 15:01:17 +0000
Received: from localhost (p7053-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.53])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 42782B864; Wed, 20 Dec 2006 00:01:14 +0900 (JST)
Date:	Wed, 20 Dec 2006 00:01:13 +0900 (JST)
Message-Id: <20061220.000113.59033093.anemo@mba.ocn.ne.jp>
To:	danieljlaird@hotmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
References: <7925588.post@talk.nabble.com>
	<7943218.post@talk.nabble.com>
	<20061219.233410.25911550.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Dec 2006 00:17:24 -0800 (PST), Daniel Laird <danieljlaird@hotmail.com> wrote:
> On the PNX8550 it does not use the CP0 timer but use a different timer (the
> Custom MIPS core has 3 extra timers) 

Do you know what this ifndef line mean?

#ifndef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
	/* Ack this timer interrupt and set the next one.  */
	expirelo += cycles_per_jiffy;
#endif

If it means "On PNX8550, writing to COMPARE register resets COUNTER to
zero", new time.c might be broken for PNX8550.  Could you try this
patch?

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 11aab6d..4eb0741 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -119,7 +119,11 @@ static cycle_t c0_hpt_read(void)
 /* For use both as a high precision timer and an interrupt source.  */
 static void __init c0_hpt_timer_init(void)
 {
+#ifdef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
+	expirelo = cycles_per_jiffy;
+#else
 	expirelo = read_c0_count() + cycles_per_jiffy;
+#endif
 	write_c0_compare(expirelo);
 }
 
