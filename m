Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 10:44:04 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:7707
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225401AbVCDKnr>; Fri, 4 Mar 2005 10:43:47 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Mar 2005 10:43:46 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 09FFD1F31C;
	Fri,  4 Mar 2005 19:43:42 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id EA4E61F31A;
	Fri,  4 Mar 2005 19:43:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j24Ahf9c096235;
	Fri, 4 Mar 2005 19:43:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 04 Mar 2005 19:43:41 +0900 (JST)
Message-Id: <20050304.194341.01917677.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: 2.6.11 preemption fix
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
X-archive-position: 7365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

It seems 2.6.11 preemption kernel is broken.

The preempt_schedule_irq() expects preempt_count is 0.  Also trailing
branch instructino have been lost.  How about this fix?

--- linux-mips/arch/mips/kernel/entry.S	2005-02-10 11:27:50.000000000 +0900
+++ linux/arch/mips/kernel/entry.S	2005-03-04 17:09:53.000000000 +0900
@@ -58,9 +58,8 @@
 	LONG_L	t0, PT_STATUS(sp)		# Interrupts off?
 	andi	t0, 1
 	beqz	t0, restore_all
-	li	t0, PREEMPT_ACTIVE
-	sw	t0, TI_PRE_COUNT($28)
 	jal	preempt_schedule_irq
+	b	need_resched
 #endif
 
 FEXPORT(ret_from_fork)

---
Atsushi Nemoto
