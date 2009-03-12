Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2009 11:20:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12429 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366527AbZCLLUH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Mar 2009 11:20:07 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2CBK4jW009053;
	Thu, 12 Mar 2009 12:20:05 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2CBK4Ox009051;
	Thu, 12 Mar 2009 12:20:04 +0100
Date:	Thu, 12 Mar 2009 12:20:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: __do_IRQ() going away
Message-ID: <20090312112004.GA6121@linux-mips.org>
References: <20090311112806.GA24541@linux-mips.org> <20090312072618.GA31978@roarinelk.homelinux.net> <20090312092810.GA13674@linux-mips.org> <f861ec6f0903120246m386a09c7o5825a92a00cef2d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0903120246m386a09c7o5825a92a00cef2d6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 12, 2009 at 10:46:28AM +0100, Manuel Lauss wrote:

> > Iow, now with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ always set half the
> > platforms will blow up because the function pointer irq_desc->handle_irq
> > is unset.
> 
> ...and it works fine so far on the DB1200 and another 2 boards I have.
> (I.e. your patch didn't break anything).  Unless I'm missing something
> very big.

Ah, there is a remaining call to set_irq_chip in the Alchemy code - but
that seems to be in "does not happen" code so should be benign.

  Ralf
