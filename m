Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2008 19:46:10 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:34026 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025555AbYHYSqI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2008 19:46:08 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KXh4p-0006wY-00; Mon, 25 Aug 2008 20:46:07 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 37310C3164; Mon, 25 Aug 2008 20:46:01 +0200 (CEST)
Date:	Mon, 25 Aug 2008 20:46:01 +0200
To:	David Daney <ddaney@avtrex.com>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: What's up with cpu_is_noncoherent_r10000() ?
Message-ID: <20080825184600.GA8993@alpha.franken.de>
References: <48B2DF15.5030903@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48B2DF15.5030903@avtrex.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Aug 25, 2008 at 09:34:29AM -0700, David Daney wrote:
> What is the reasoning for only doing the cache operation on  R10K based 
> systems?

non coherent R10k need after DMA operations to get rid of remains
of load/store speculations. Other CPUs don't pollute the cache
after it got flushed.

But this optimization is wrong, we need to do the flush for
every non coherent device otherwise polling a descriptor via
a cached mapping can't work. And this exactly what E100 does.

Instead of if (cpu_is_noncoherent_r10000(deva)) something like

if (cpu_is_noncoherent_r10000(dev) || 
    (!plat_device_is_coherent(dev) && (direction != DMA_TO_DEVICE)))


should do the trick with minimum flushes for non R10k CPUs. But probably
a simple

if ((!plat_device_is_coherent(dev))

is the safest approach.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
