Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2009 06:49:00 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:47514 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21365687AbZAUGs6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jan 2009 06:48:58 +0000
Received: (qmail 27110 invoked by uid 1000); 21 Jan 2009 07:48:56 +0100
Date:	Wed, 21 Jan 2009 07:48:56 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Alchemy: fix edge irq handling
Message-ID: <20090121064856.GA27020@roarinelk.homelinux.net>
References: <20090120100353.GA18971@roarinelk.homelinux.net> <1232498838.3678.17.camel@kh-d820>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1232498838.3678.17.camel@kh-d820>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Kevin,

> Have you actually seen this happen (outside of inducing it manually)?  I
> have some concern that by doing this we may either miss interrupts on
> devices that send a lot (by design) or miss a design bug in a system
> because we are masking out some interrupts.  I know that system
> stability is important, but I don't like hiding problems.

Yes, in a customer project.  A simple pushbutton which connects a pulled-up
gpio pin to ground.  Push it, instant hang (handler called over and over
again) when it is not debounced.  With a single edge and a much lower
edge-frequency it obviously works fine (see timer).

(And, handle_edge_irq() _does_ call mask_ack() after all).


Best regards,
	Manuel Lauss

 
> =Kevin
> 
> On Tue, 2009-01-20 at 11:03 +0100, Manuel Lauss wrote:
> > Introduce separate mack_ack callbacks which really do shut up the
> > edge-triggered irqs when called.  Without this change, high-frequency
> > edge interrupts can result in an endless irq storm, hanging the system.
> > 
> > This can be easily triggered for example by setting an irq to falling
> > edge type and manually connecting the associated pin to ground.
> > 
