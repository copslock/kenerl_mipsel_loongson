Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 17:36:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31441 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021522AbXJPQgL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 17:36:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9GGaA7b026174;
	Tue, 16 Oct 2007 17:36:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9GGaAQ0026173;
	Tue, 16 Oct 2007 17:36:10 +0100
Date:	Tue, 16 Oct 2007 17:36:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: plat_timer_setup, mips_timer_ack, etc.
Message-ID: <20071016163610.GA25794@linux-mips.org>
References: <20071017.005211.108739735.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071017.005211.108739735.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 12:52:11AM +0900, Atsushi Nemoto wrote:

> With recent clockevent conversion, for typical r4k counter timer,
> setup_irq() for the timer interrupt is called three times.
> 
> 1. from time_init()  (#ifdef CONFIG_IRQ_CPU block)
> 2. from plat_timer_setup()  (arch/tx4927/common/tx4927_setup.c, for example)
> 3. from mips_clockevent_init()
> 
> Which one should remain?

I would suggest the one near where the clockevent device is registered.

> Also I found mips_timer_ack and cycles_per_jiffy are not used now.
> Can we remove them entirely?

I think so.  Each clockevent device should rather try to be independent
of others.  What made the old timer code such a mess is that it was
desparately trying to share resources giving everybody plenty of rope ...


> Furthermore, I wonder how to disable mips_clockevent_device even if
> the CPU has r4k counter.  For example, pnx8550 has the r4k counter but
> needs special mips_timer_ack and clocksource_mips.read routine.  I
> suppose current time code is broken for such platforms.

PNX and the old revisions of the R4000 which have a bug where the
compare interrupt can be lost if the counter is read just when it has
the same value as the compare register.

  Ralf
