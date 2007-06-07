Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 16:53:07 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:48604 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027236AbXFGPxF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 16:53:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57Fm29P024944;
	Thu, 7 Jun 2007 16:48:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57Fm15T024943;
	Thu, 7 Jun 2007 16:48:01 +0100
Date:	Thu, 7 Jun 2007 16:48:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070607154801.GG26047@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com> <20070607113032.GA26047@linux-mips.org> <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com> <46680B75.5040809@ru.mvista.com> <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 04:44:11PM +0200, Franck Bui-Huu wrote:

> >   No, it doesn't. Even on dyntick kernels, interrupts do happen several
> >times a second. Dynticks have nothing to do with disabling timer
> >interrupts...
> >
> 
> That's true however if your system has 2 clock devices. One is the r4k-hpt
> and the other one soemthing else with a higher rating. If you don't stop
> r4k-hpt interrupts, how does it work ?

To some degree this question is hypothetic because generally the cp0
count/compare timer will be the highest rated counter.

But even if so, the basic solution is the same - just ignore the interrupt
whenever it happens to be triggered.  Or if it isn't shared with an
active performance counter interrupt, you could even disable_irq() it.

  Ralf
