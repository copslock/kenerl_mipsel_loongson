Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 10:01:34 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:22706 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28599841AbYCQKBc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 10:01:32 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JbC9r-0005FQ-00; Mon, 17 Mar 2008 11:01:31 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id ACE4BC235B; Mon, 17 Mar 2008 11:01:09 +0100 (CET)
Date:	Mon, 17 Mar 2008 11:01:09 +0100
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: unexpected irq 71 on ip32
Message-ID: <20080317100109.GA10140@alpha.franken.de>
References: <1205746904.3515.37.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1205746904.3515.37.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 17, 2008 at 10:41:44AM +0100, Giuseppe Sacco wrote:
> from what I understand, this is an irq related to serial line ttyS1. On

not on my O2:

serial8250.0: ttyS0 at MMIO 0x1f390000 (irq = 60) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x1f398000 (irq = 66) is a 16550A

Is there something listed for irq 71 in /proc/interrupts ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
