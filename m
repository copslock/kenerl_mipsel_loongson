Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2006 19:10:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40604 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038922AbWINSKB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Sep 2006 19:10:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8EIAcQe002889;
	Thu, 14 Sep 2006 19:10:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8EIAbnB002888;
	Thu, 14 Sep 2006 19:10:37 +0100
Date:	Thu, 14 Sep 2006 19:10:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: [PATCH] au1x00 serial real interrupt
Message-ID: <20060914181037.GC2197@linux-mips.org>
References: <20060522165244.GA16223@enneenne.com> <44FD9587.3030708@ru.mvista.com> <4502ED14.6080506@ru.mvista.com> <20060909163907.GA24012@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909163907.GA24012@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 09, 2006 at 05:39:07PM +0100, Russell King wrote:

> Well, if you need IRQ0 to be real then redefining is_real_interrupt()
> is the correct way forward.
> 
> However, Linus' policy is that IRQ0 shall be invalid at least on PCI
> systems, and architectures _should_ remap their real IRQ0 to some other
> number.  Personally I don't like this.  Hence why I prefer to give people
> the option.

I have no strong opinion either.  In some cases not having interrupt 0
available sucks because Linux will have to use a different interrupt
numbering than system documentation ...

  Ralf
