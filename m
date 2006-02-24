Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 08:24:42 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41230 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133465AbWBXIYc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 08:24:32 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1FCYMb-0003kI-HK; Fri, 24 Feb 2006 08:31:46 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1FCYMX-0008RL-K3; Fri, 24 Feb 2006 08:31:41 +0000
Date:	Fri, 24 Feb 2006 08:31:41 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060224083141.GA32080@flint.arm.linux.org.uk>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060223224346.GA7536@flint.arm.linux.org.uk> <20060224003947.GJ9704@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224003947.GJ9704@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, Feb 24, 2006 at 12:39:47AM +0000, Martin Michlmayr wrote:
> * Russell King <rmk@arm.linux.org.uk> [2006-02-23 22:43]:
> > Looking at the ip22 driver, it seems that if shutdown() is called for
> > the console port, the driver does _nothing_.
> 
> sunzilog.c does the same, and it's based on a comment by you (quoted
> right before shutdown()).  Anyway, I don't quite understand the
> comment but maybe Ralf (or you) can write a patch.

Not quite - I didn't say "do absolutely nothing" - I did explicitly say
that something should happen on the software side, and gave the example
that the IRQ should be freed.  The intention of that comment was to
satisfy the requirement I mentioned in my previous mail in this thread.

At a guess, for the console port, you want to disable the receiver, leave
the transmitter enabled, and disable all interrupts originating from the
port.

How other drivers do it is that they do a normal shutdown in every case,
but the console code explicitly re-enables the transmitter.  I don't
understand why these two drivers can't do it the same way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
