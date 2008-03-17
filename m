Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 10:08:22 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:11955 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28590715AbYCQKIU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 10:08:20 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JbCGS-0007Fo-00; Mon, 17 Mar 2008 11:08:20 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 6D357C235C; Mon, 17 Mar 2008 11:08:15 +0100 (CET)
Date:	Mon, 17 Mar 2008 11:08:15 +0100
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: unexpected irq 71 on ip32
Message-ID: <20080317100815.GA10179@alpha.franken.de>
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
X-archive-position: 18413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 17, 2008 at 10:41:44AM +0100, Giuseppe Sacco wrote:
> from what I understand, this is an irq related to serial line ttyS1. On

I had a closer look, and it's related to ttyS1. Looks like the DMA
interface for serial (probably RX DMA overrun). I'll have a look
later, why we don't ignore this interrupt.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
