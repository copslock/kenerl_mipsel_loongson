Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 16:50:37 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:21977 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023920AbXJPPu1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2007 16:50:27 +0100
Received: from localhost (p2111-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 742689B67
	for <linux-mips@linux-mips.org>; Wed, 17 Oct 2007 00:50:23 +0900 (JST)
Date:	Wed, 17 Oct 2007 00:52:11 +0900 (JST)
Message-Id: <20071017.005211.108739735.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: plat_timer_setup, mips_timer_ack, etc.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

With recent clockevent conversion, for typical r4k counter timer,
setup_irq() for the timer interrupt is called three times.

1. from time_init()  (#ifdef CONFIG_IRQ_CPU block)
2. from plat_timer_setup()  (arch/tx4927/common/tx4927_setup.c, for example)
3. from mips_clockevent_init()

Which one should remain?

Also I found mips_timer_ack and cycles_per_jiffy are not used now.
Can we remove them entirely?

Furthermore, I wonder how to disable mips_clockevent_device even if
the CPU has r4k counter.  For example, pnx8550 has the r4k counter but
needs special mips_timer_ack and clocksource_mips.read routine.  I
suppose current time code is broken for such platforms.

Any suggestions?
---
Atsushi Nemoto
