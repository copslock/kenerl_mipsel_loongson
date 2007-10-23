Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 07:01:55 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:21535 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026080AbXJWGBq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 07:01:46 +0100
Received: by mo.po.2iij.net (mo32) id l9N60Ggc074870; Tue, 23 Oct 2007 15:00:16 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l9N60ERl001302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Oct 2007 15:00:15 +0900
Message-Id: <200710230600.l9N60ERl001302@po-mbox302.po.2iij.net>
Date:	Tue, 23 Oct 2007 15:01:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Thomas Gleixner <tglx@linutronix.de>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
In-Reply-To: <alpine.LFD.0.9999.0710230719090.3167@localhost.localdomain>
References: <200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net>
	<20071023.100645.74754145.nemoto@toshiba-tops.co.jp>
	<200710230214.l9N2EYBa016911@po-mbox301.hop.2iij.net>
	<20071023.114824.122622188.nemoto@toshiba-tops.co.jp>
	<alpine.LFD.0.9999.0710230719090.3167@localhost.localdomain>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 Oct 2007 07:21:28 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 23 Oct 2007, Atsushi Nemoto wrote:
> > Added Thomas Gleixner for CC list.
> > 
> > On Tue, 23 Oct 2007 11:15:58 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > > > > These clockevent routines are always called with interrupt disabled,
> > > > > > so I suppose those spin_lock_irqsave/spin_unlock_irqrestore pairs can
> > > > > > be omitted. (or this timer can be used on SMP?)
> > > > > 
> > > > > Yes, it can be used on Malta(SMP).
> > > > 
> > > > Then spin_lock()/spin_unlock() is enough, isn't it?
> > > 
> > > The timer control register(GT_TC_CONTROL_OFS) is shared with 4 timers.
> > > The 4 timers are connected with separate IRQ. 
> > > 
> > > clockevents_program_event() and clockevents_set_mode() can be called from
> > > anywhere(in the kernel).
> > > 
> > > I think that it's necessary for it.
> > 
> > Hmm... clockevents_set_mode() must be called with interrupt disabled
> > as stated in its comment.  There are no such a comment for
> > clockevents_program_event(), but it is always called with interrupt
> > disabled if the interrupt for the event was registered with
> > IRQF_DISABLED flag.
> > 
> > I agree that saving/restoring irq_flag would be safer, but I think it
> > can be omitted at least for now.
> > 
> > If clockevents_program_event() could be called with interrupt enabled,
> > mips_next_event() in cevt-r4k.c should be fixed.
> > 
> > 
> > Thomas, clockevents_program_event() (or ->set_next_event() method for
> > clock_event_device) is supposed to be called with interrupt enabled?
> 
> Actually all call sites have interrupts disabled right now and I can
> not think of a reason why we would ever call with interrupts
> enabled. Time to add some comment.

OK, I'll update GT641xx clockevent.

Thanks Nemoto-san and Thomas,

Yoichi
