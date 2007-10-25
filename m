Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 18:59:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:30378 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023909AbXJYR7R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 18:59:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9PHxF9E029295;
	Thu, 25 Oct 2007 18:59:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9PHxEVe029294;
	Thu, 25 Oct 2007 18:59:14 +0100
Date:	Thu, 25 Oct 2007 18:59:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1: au1xxx and clocksource
Message-ID: <20071025175914.GB27616@linux-mips.org>
References: <20071024183135.GA23096@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071024183135.GA23096@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 24, 2007 at 08:31:35PM +0200, Manuel Lauss wrote:

> Hi everyone,
> 
> > So time to check how your favorite platform is doing and fix what broke!
> 
> I let it loose on my Au1200, but unfortunately the new time code is b0rked
> ina way I don't understand.
> 
> Following call chain:
> 
> start_kernel()
>  time_init()
>   init_mips_clocksource()
>   mips_clockevent_init()
>    clockevents_register_device()
>     clockevents_do_notify()
>      notifier_call_chain():
> 
>       It dies here, line 69, in kernel/notifier.c:
>       ret = nb->notifier_call(nb, val, v);

What sort of death?  Please describe all sympthoms of the patient.

> Maybe my debug method is faulty (homebrew putstring() with au1200 uart
>  banging) but the last debug output is before this line.

It is consistent with another bug report on IP27.

The function tick_notify has been installed as notifier, so that is what
I think nb->notifier_call() should be pointing at.  So it should be
called like this:

  tick_notify(&tick_notifier, CLOCK_EVT_NOTIFY_ADD, dev)

So things are likely going wrong somewhere in there.

  Ralf
