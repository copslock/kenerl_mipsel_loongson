Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 17:59:54 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63223 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225285AbTHFQ7u>;
	Wed, 6 Aug 2003 17:59:50 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h76Gxk419084;
	Wed, 6 Aug 2003 09:59:46 -0700
Date: Wed, 6 Aug 2003 09:59:46 -0700
From: Jun Sun <jsun@mvista.com>
To: Dmitry Antipov <dmitry.antipov@mail.ru>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: IT8172G on-board timers
Message-ID: <20030806095946.C18963@mvista.com>
References: <3F2FB360.9040005@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F2FB360.9040005@mail.ru>; from dmitry.antipov@mail.ru on Tue, Aug 05, 2003 at 05:38:40PM +0400
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Aug 05, 2003 at 05:38:40PM +0400, Dmitry Antipov wrote:
> Hello all,
> 
>  I'm working with IT8172-based MIPS board and want to use one of (or may 
> be both) on-board timers.
> For my purposes, it's required to generate irq from timer rarely, for 
> example, each 1 sec, or each 5 sec
> or so. (The usage of Linux timer interface (init_timer() etc...) is 
> forbidden

Using linux timer seems perfect for the need.  Why not?  For an example
of using timer you can take a look of my real time test suite

http://linux.junsun.net/preemp-test/

> , and I don't want to touch
> system timer to avoid the potential damage for basic timekeeping, 
> scheduling, etc.). I have two problems:
> - timer backward counter is 16-bit wide and reaches zero too fast, even 
> starting from 0xffff;
> - timer input clock may be one of CPU clock, CPU clock /4, CPU clock/8 
> or CPU  clock /16, which looks
>    very fast too
> So, the minimum interrupt frequency from both timers is 96 ints/HZ (with 
> TCR0.PST0 is 0 and
> TCVR0 is 0xffff) and the maximum is around 150000 ints/HZ. Even the 
> minimum is too large for me...
>

You can write a driver that "accumlates" the interrupts until a desired
duration is reached before it actually does anything useful.

Jun
