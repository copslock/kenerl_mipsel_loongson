Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2006 17:39:24 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:11533 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20038481AbWIIQjV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 9 Sep 2006 17:39:21 +0100
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1GM5rK-0004Bi-3f; Sat, 09 Sep 2006 17:39:10 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1GM5rI-0006l5-2f; Sat, 09 Sep 2006 17:39:08 +0100
Date:	Sat, 9 Sep 2006 17:39:07 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: [PATCH] au1x00 serial real interrupt
Message-ID: <20060909163907.GA24012@flint.arm.linux.org.uk>
References: <20060522165244.GA16223@enneenne.com> <44FD9587.3030708@ru.mvista.com> <4502ED14.6080506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4502ED14.6080506@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Sat, Sep 09, 2006 at 08:34:28PM +0400, Sergei Shtylyov wrote:
>    Well, after looking at drivers/serial/8250.c a bit more, I think this 
>    may be even more simlified since that driver seems to treat the negative 
> values as completely invalid anyway. IOW, we can just:
> 
> #define is_real_interrupt(irq)	1
> 
>    Russel, what do you think?

That's Russell 8)

Well, if you need IRQ0 to be real then redefining is_real_interrupt()
is the correct way forward.

However, Linus' policy is that IRQ0 shall be invalid at least on PCI
systems, and architectures _should_ remap their real IRQ0 to some other
number.  Personally I don't like this.  Hence why I prefer to give people
the option.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
