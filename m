Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 05:11:51 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:36876
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225211AbUE1ELh>; Fri, 28 May 2004 05:11:37 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 May 2004 04:11:36 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 17EAA239E3D; Fri, 28 May 2004 13:13:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i4S4BQwB039335;
	Fri, 28 May 2004 13:11:26 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 28 May 2004 13:12:36 +0900 (JST)
Message-Id: <20040528.131236.112629910.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: 2.4 preempt kernel patch
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  I'm investigating preempt patch for 2.4 kernel.  (MIPS part of
preempt-kernel-rml-2.4.26-pre5-1.patch seems a bit old.  I'm looking
Jun Sun's 030304-b.preempt-mips.patch).

The patch contains following block (end of
arch/mips/kernel/irq.c:do_IRQ()):

 
 	if (softirq_pending(cpu))
 		do_softirq();
+
+#if defined(CONFIG_PREEMPT)
+	for(;;) {
+		preempt_enable_no_resched();
+		if (preempt_is_disabled() || !need_resched())
+			break;
+
+		db_assert(intr_off());
+		db_assert(!in_interrupt());
+
+		preempt_disable();
+		__sti();
+		preempt_schedule();
+		__cli();
+	}
+#endif
+
 	return 1;
 }
 

Q1.  What is purpose of this block?  (To decrease latency?  But other
archs (and 2.6 MIPS kernel) do not have block like this...)

Q2.  If an interrupt happened between __sti() and __cli(), and the
interrupt handler raise softirq, the softirq handler will not be
called soon (because do_softirq() immediately return if preempt
disabled).  So we must check softirq_pending again after this block?

Thank you.
---
Atsushi Nemoto
