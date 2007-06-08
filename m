Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 11:04:38 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:42644 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021775AbXFHKEg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Jun 2007 11:04:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l589vYtG016723;
	Fri, 8 Jun 2007 10:57:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l589vYns016722;
	Fri, 8 Jun 2007 10:57:34 +0100
Date:	Fri, 8 Jun 2007 10:57:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070608095734.GB13686@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com> <20070607113032.GA26047@linux-mips.org> <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com> <20070607151447.GF26047@linux-mips.org> <cda58cb80706080207ia8a6633na921c5faa69344cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706080207ia8a6633na921c5faa69344cd@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 08, 2007 at 11:07:23AM +0200, Franck Bui-Huu wrote:

> devices. Actually an external interrupt controller, which is a simple
> MUX, allows several devices to share the same irq line. To know which
> device generates an irq you need to probe this irq controller.
> 
> So it seems to me that if the hardware designers decide to not reserve
> the highest irq line for the timer irq, you're in trouble...

Yuck.  That's a new configuration ...

Thinking about a really bad one.  If your processor is a MIPS R2 processor,
fine.  If it's older you can't reliably test for a timer interrupt
pending other than by masking all performance counter interrupts, then
testing if IE7 is still pending in the cause register.  If of course that
probe isn't reliable because there is another device you will have to do
more guessing by trying to acknowledge the cp0 compare interrupt.  If IE7
transitioned to 0, there was a timer interrupt pending if not there was
an external interrupt pending and there there may or may not have been
a compare interrupt have been pending.  And if the external goes 1->0 at
just that time you may believe you got a timer interrupt anyway.
Things get slightly better if the external interrupt controller has a
register where interrupt pending can be queried but it's still ...
interesting.

I guess the easy solution in such a case is to not use the compare
interrupt in such a configuration and just ack it.  Or go for an R2
processor.

  Ralf
