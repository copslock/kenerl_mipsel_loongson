Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 15:47:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:3827 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024792AbXJVOrX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2007 15:47:23 +0100
Received: from localhost (p4177-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DE458A920; Mon, 22 Oct 2007 23:46:02 +0900 (JST)
Date:	Mon, 22 Oct 2007 23:47:55 +0900 (JST)
Message-Id: <20071022.234755.45745247.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 17155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007 19:43:15 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> +static int gt641xx_timer0_set_next_event(unsigned long delta,
> +					 struct clock_event_device *evt)
> +{
> +	unsigned long flags;
> +	u32 ctrl;
> +
> +	spin_lock_irqsave(&gt641xx_timer_lock, flags);
> +
> +	ctrl = GT_READ(GT_TC_CONTROL_OFS);
> +	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
> +	ctrl |= GT_TC_CONTROL_ENTC0_MSK;
> +
> +	GT_WRITE(GT_TC0_OFS, delta);
> +	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
> +
> +	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
> +
> +	return 0;
> +}
> +
> +static void gt641xx_timer0_set_mode(enum clock_event_mode mode,
> +				    struct clock_event_device *evt)
> +{
> +	unsigned long flags;
> +	u32 ctrl;
> +
> +	spin_lock_irqsave(&gt641xx_timer_lock, flags);
> +
> +	ctrl = GT_READ(GT_TC_CONTROL_OFS);
> +	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		ctrl |= GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK;
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		ctrl |= GT_TC_CONTROL_ENTC0_MSK;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
> +
> +	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
> +}

These clockevent routines are always called with interrupt disabled,
so I suppose those spin_lock_irqsave/spin_unlock_irqrestore pairs can
be omitted. (or this timer can be used on SMP?)

> +	cd = &gt641xx_timer0_clockevent;
> +	cd->rating = 200 + gt641xx_base_clock / 10000000;
> +	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
> +	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
> +	clockevent_set_clock(cd, gt641xx_base_clock);

clockevent_delta2ns() use shift and mult value.  So you should call
clockevent_set_clock() first.

---
Atsushi Nemoto
