Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 22:42:25 +0000 (GMT)
Received: from p3EE066C8.dip.t-dialin.net ([IPv6:::ffff:62.224.102.200]:63872
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224917AbVCTWmK>; Sun, 20 Mar 2005 22:42:10 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2KMeVbC008285;
	Sun, 20 Mar 2005 22:40:31 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2KMeTha008284;
	Sun, 20 Mar 2005 22:40:29 GMT
Date:	Sun, 20 Mar 2005 22:40:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
Cc:	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Pete Popov <ppopov@embeddedalley.com>,
	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Message-ID: <20050320224028.GB6727@linux-mips.org>
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319141351.74f6b2a5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 19, 2005 at 02:13:51PM -0800, Andrew Morton wrote:

> > au1x00_uart
> > -----------
> > 
> > Maintainer: unknown (akpm - any ideas?)
> 
> Ralf.

Actually Pete Popov (ppopov@embeddedalley.com) who I put on the cc.

> > This is a complete clone of 8250.c, which includes all the 8250-specific
> > structure names.
> > 
> > Specifically, I'd like to see the following addressed:
> > 
> > - Please clean this up to use au1x00-specific names.
> > - this driver is lagging behind with fixes that the other drivers are
> >   getting.  Is au1x00_uart actually maintained?

Sort of; much of the Alchemy development effort is still going into 2.4.

> > - the usage of UPIO_HUB6
> >   (this driver doesn't support hub6 cards)
> > - __register_serial, register_serial, unregister_serial
> >   (this driver doesn't support PCMCIA cards, all of which are based on
> >    8250-compatible devices.)
> > - early_serial_setup
> >   (should we really have the function name duplicated across different
> >    hardware drivers?)

No argument here.  Pete says the AMD Alchemy UART is just different enough
to be hard to handle in the 8250 and so the driver is just an ugly
chainsawed version of the 8250.c

> > The main reason is I wish to kill off uart_register_port and
> > uart_unregister_port, but these drivers are using it.

  Ralf
