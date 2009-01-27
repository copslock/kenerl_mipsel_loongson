Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 06:20:40 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:6348 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21102777AbZA0GUi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 06:20:38 +0000
Received: (qmail 14761 invoked by uid 1000); 27 Jan 2009 07:20:36 +0100
Date:	Tue, 27 Jan 2009 07:20:36 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Alchemy: fix edge irq handling
Message-ID: <20090127062036.GA14558@roarinelk.homelinux.net>
References: <20090120100353.GA18971@roarinelk.homelinux.net> <1232498838.3678.17.camel@kh-d820> <20090121064856.GA27020@roarinelk.homelinux.net> <1233022725.14733.10.camel@kh-d820>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1233022725.14733.10.camel@kh-d820>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Kevin,

On Mon, Jan 26, 2009 at 08:18:45PM -0600, Kevin Hickey wrote:
> Your example below is similar - debouncing the switch in hardware seems
> a better solution (albeit likely an expensive one) than patching the
> mainline kernel.  And I reiterate: some devices send a lot of interrupts
> by design; we should honor their requests, not mask them out.

I agree in principle, but what's the point of honoring the requests if they
come in faster than the cpu can handle them?  I think that's why the
handle_edge_irq() flowhandler masks the interrupt when another edge comes in
while the handler for the previous one is still running.  This is also the
problem I'm running into:  the second (and following) edges don't get acked
when the flowhandler tries to mask them, resulting in the irq storm.  If I
explicitly ack it in the irq handler itself, all is well.

The current in-tree irq code bahaves differently than in <=2.6.28;  this
patch restores this behaviour, and I believe it is the way the mask_ack()
callback is supposed to work.  It affects only edge interrupts which come in
faster than the cpu can handle them;  for all others there's no change (other
than 2 more stores in the mask fastpath).

(Or maybe it's a logic bug in handle_edge_irq(); I don't know.)

Thanks,
	Manuel Lauss
