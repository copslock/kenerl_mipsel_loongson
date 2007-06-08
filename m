Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 10:49:02 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:17327 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021756AbXFHJtA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Jun 2007 10:49:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l589fsOV016453;
	Fri, 8 Jun 2007 10:41:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l589frD2016452;
	Fri, 8 Jun 2007 10:41:53 +0100
Date:	Fri, 8 Jun 2007 10:41:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070608094153.GA13686@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com> <20070607113032.GA26047@linux-mips.org> <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com> <46680B75.5040809@ru.mvista.com> <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com> <20070607154801.GG26047@linux-mips.org> <cda58cb80706080129h77450e6cx52824a4dbb654717@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706080129h77450e6cx52824a4dbb654717@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 08, 2007 at 10:29:42AM +0200, Franck Bui-Huu wrote:

> Well it increments every other clock. So it's not impossible to have a
> an other higher rated counter.

In practice that's very rare.  Otoh there are reasons why the cp0 counter
might be unusable - clockscaling, no interrupt, CPU powered off.

> >But even if so, the basic solution is the same - just ignore the interrupt
> >whenever it happens to be triggered.  Or if it isn't shared with an
> >active performance counter interrupt, you could even disable_irq() it.
> 
> OK, but the current code doesn't seem to support very well multiple
> clock event devices. For example the global_cd array is not updated if
> a new clock event device is registered. Even ll_timer_interrupt()
> handler should be renamed something like ll_hpt_interrupt() for
> example.

global_cd is meant to only hold the pointers to all processors' count/compare
clockevent devices, nothing else.  So if another clockevent device should
have a higher rating on a particular CPU the content of global_cd[] just
doesn't matter.

  Ralf
