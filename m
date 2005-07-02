Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 16:54:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:6910 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8226095AbVGBPyP>; Sat, 2 Jul 2005 16:54:15 +0100
Received: from localhost (p8134-ipad01funabasi.chiba.ocn.ne.jp [61.207.82.134])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BE32B108E; Sun,  3 Jul 2005 00:54:11 +0900 (JST)
Date:	Sun, 03 Jul 2005 00:59:21 +0900 (JST)
Message-Id: <20050703.005921.25910131.anemo@mba.ocn.ne.jp>
To:	djohnson+linuxmips@sw.starentnetworks.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <17093.19241.353160.946039@cortez.sw.starentnetworks.com>
References: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
	<20050701.114358.21591461.nemoto@toshiba-tops.co.jp>
	<17093.19241.353160.946039@cortez.sw.starentnetworks.com>
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
X-archive-position: 8332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 1 Jul 2005 09:54:49 -0400, Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com> said:

dave> That'll do it.  My patch wasn't enough.  I added some sanity
dave> checks to get_wchan and it hit one while running overnight.

dave> The task being examined transitioned from !TASK_RUNNING to
dave> TASK_RUNNING while it was being examined. Doh!

dave> Definately not SMP/preempt safe as written today.

Perhaps you can make it SMP/preempt safe by doing stack_page test in
the unwinding loop as done on i386, etc.

But anyway I think just calling thread_saved_pc is enough.

Ralf, how do you think about this?

---
Atsushi Nemoto
