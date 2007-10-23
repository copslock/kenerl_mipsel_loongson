Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 03:49:01 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:9931 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20026100AbXJWCsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 03:48:52 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 23 Oct 2007 11:48:51 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E839042B87;
	Tue, 23 Oct 2007 11:48:25 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id DBA2C42B85;
	Tue, 23 Oct 2007 11:48:25 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l9N2mOAF081451;
	Tue, 23 Oct 2007 11:48:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 23 Oct 2007 11:48:24 +0900 (JST)
Message-Id: <20071023.114824.122622188.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org, tglx@linutronix.de
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200710230214.l9N2EYBa016911@po-mbox301.hop.2iij.net>
References: <200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net>
	<20071023.100645.74754145.nemoto@toshiba-tops.co.jp>
	<200710230214.l9N2EYBa016911@po-mbox301.hop.2iij.net>
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
X-archive-position: 17168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Added Thomas Gleixner for CC list.

On Tue, 23 Oct 2007 11:15:58 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > > These clockevent routines are always called with interrupt disabled,
> > > > so I suppose those spin_lock_irqsave/spin_unlock_irqrestore pairs can
> > > > be omitted. (or this timer can be used on SMP?)
> > > 
> > > Yes, it can be used on Malta(SMP).
> > 
> > Then spin_lock()/spin_unlock() is enough, isn't it?
> 
> The timer control register(GT_TC_CONTROL_OFS) is shared with 4 timers.
> The 4 timers are connected with separate IRQ. 
> 
> clockevents_program_event() and clockevents_set_mode() can be called from
> anywhere(in the kernel).
> 
> I think that it's necessary for it.

Hmm... clockevents_set_mode() must be called with interrupt disabled
as stated in its comment.  There are no such a comment for
clockevents_program_event(), but it is always called with interrupt
disabled if the interrupt for the event was registered with
IRQF_DISABLED flag.

I agree that saving/restoring irq_flag would be safer, but I think it
can be omitted at least for now.

If clockevents_program_event() could be called with interrupt enabled,
mips_next_event() in cevt-r4k.c should be fixed.


Thomas, clockevents_program_event() (or ->set_next_event() method for
clock_event_device) is supposed to be called with interrupt enabled?

---
Atsushi Nemoto
