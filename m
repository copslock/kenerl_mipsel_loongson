Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 01:56:00 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:57157 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20025810AbXJWAzw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 01:55:52 +0100
Received: by mo.po.2iij.net (mo32) id l9N0sXd1096388; Tue, 23 Oct 2007 09:54:33 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l9N0sVv7031267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Oct 2007 09:54:32 +0900
Message-Id: <200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net>
Date:	Tue, 23 Oct 2007 09:55:55 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
In-Reply-To: <20071022.234755.45745247.anemo@mba.ocn.ne.jp>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
	<20071022.234755.45745247.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007 23:47:55 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Mon, 22 Oct 2007 19:43:15 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > +static int gt641xx_timer0_set_next_event(unsigned long delta,
> > +					 struct clock_event_device *evt)
> > +{
> > +	unsigned long flags;
> > +	u32 ctrl;
> > +
> > +	spin_lock_irqsave(&gt641xx_timer_lock, flags);
> > +
> > +	ctrl = GT_READ(GT_TC_CONTROL_OFS);
> > +	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
> > +	ctrl |= GT_TC_CONTROL_ENTC0_MSK;
> > +
> > +	GT_WRITE(GT_TC0_OFS, delta);
> > +	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
> > +
> > +	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static void gt641xx_timer0_set_mode(enum clock_event_mode mode,
> > +				    struct clock_event_device *evt)
> > +{
> > +	unsigned long flags;
> > +	u32 ctrl;
> > +
> > +	spin_lock_irqsave(&gt641xx_timer_lock, flags);
> > +
> > +	ctrl = GT_READ(GT_TC_CONTROL_OFS);
> > +	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
> > +
> > +	switch (mode) {
> > +	case CLOCK_EVT_MODE_PERIODIC:
> > +		ctrl |= GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK;
> > +		break;
> > +	case CLOCK_EVT_MODE_ONESHOT:
> > +		ctrl |= GT_TC_CONTROL_ENTC0_MSK;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
> > +
> > +	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
> > +}
> 
> These clockevent routines are always called with interrupt disabled,
> so I suppose those spin_lock_irqsave/spin_unlock_irqrestore pairs can
> be omitted. (or this timer can be used on SMP?)

Yes, it can be used on Malta(SMP).

> > +	cd = &gt641xx_timer0_clockevent;
> > +	cd->rating = 200 + gt641xx_base_clock / 10000000;
> > +	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
> > +	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
> > +	clockevent_set_clock(cd, gt641xx_base_clock);
> 
> clockevent_delta2ns() use shift and mult value.  So you should call
> clockevent_set_clock() first.

Thank you for your comment.
I'll fix it up.

Yoichi
