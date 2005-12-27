Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 18:40:37 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29710 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133548AbVL0SkM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Dec 2005 18:40:12 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1ErJli-0002YI-QM; Tue, 27 Dec 2005 18:41:55 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1ErJlg-00057B-QU; Tue, 27 Dec 2005 18:41:52 +0000
Date:	Tue, 27 Dec 2005 18:41:52 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART used as a console
Message-ID: <20051227184152.GA4474@flint.arm.linux.org.uk>
References: <43B06DB4.409@ru.mvista.com> <20051227.144551.79070832.nemoto@toshiba-tops.co.jp> <43B143EE.6070700@ru.mvista.com> <20051228.003457.74752441.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228.003457.74752441.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, Dec 28, 2005 at 12:34:57AM +0900, Atsushi Nemoto wrote:
> Thanks for your comment.
> 
> >>>>> On Tue, 27 Dec 2005 16:38:54 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
> 
> >> The problem is not just only spin_lock_init.  The parameters of
> >> "console=" option (baudrate, etc.) are not passed for PCI UART.
> 
> sshtylyov>     They are -- uart_add_one_port() calls console setup
> sshtylyov> once more when registering PCI UART with serial code.
> 
> Yes, you are right.  I missed the register_console call in
> uart_add_one_port().  So your patch will fix the problem.  But I
> suppose the spinlock should be initialized in serial_core.  How about
> this?

I think you're layering work-around on top of work-around on top of
work-around here.

I think the first thing you need to resolve is the way you're
registering your ports.  Firstly, if you're solely PCI-based, there's
no need to pre-register all the uart ports at driver initialisation
time.  Consequently, there's no need to remove them all when you
remove the module.

Secondly, the upshot of this is that you only call uart_add_one_port()
when you initialise a PCI card.

This should result in a cleaner implementation, and the console will
not be started until you detect the PCI card.  Which is the behaviour
you desire in any case.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
