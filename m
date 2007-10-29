Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 15:06:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7359 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574244AbXJ2PGm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 15:06:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TF6aSM004253;
	Mon, 29 Oct 2007 15:06:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TF6Pqf004252;
	Mon, 29 Oct 2007 15:06:25 GMT
Date:	Mon, 29 Oct 2007 15:06:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1 does not boot on SGI [was: Re: 2.4.24-rc1 does not
	boot on SGI]
Message-ID: <20071029150625.GB4165@linux-mips.org>
References: <1193468825.7474.6.camel@scarafaggio> <20071029.000713.59464443.anemo@mba.ocn.ne.jp> <1193599031.14874.1.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1193599031.14874.1.camel@scarafaggio>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 28, 2007 at 08:17:11PM +0100, Giuseppe Sacco wrote:

> Nothing changed using this patch: the system does not boot. Currently I
> suspect the reason is the change the IRQ handling because it is the main
> change in arch/mips/sg-ip32.

All the patch was meant to is to renumber interrupts so interrupts 0 ... 7
become available for use with cpu_irq.c.  Irq 7 is the cp0 compare interrupt
which on IP32 is used as the clockevent device that is the source of
timer interrupts.

  Ralf
