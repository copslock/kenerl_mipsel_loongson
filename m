Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 18:25:02 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:47869 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTD1RZA>;
	Mon, 28 Apr 2003 18:25:00 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3SHOLV30060;
	Mon, 28 Apr 2003 10:24:21 -0700
Date: Mon, 28 Apr 2003 10:24:21 -0700
From: Jun Sun <jsun@mvista.com>
To: Steven Seeger <sseeger@stellartec.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: wait on vr4181 part 2
Message-ID: <20030428102421.A29907@mvista.com>
References: <200304281825.09697.wom@tateyama.hu> <089f01c30da9$e237d5d0$3501a8c0@wssseeger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <089f01c30da9$e237d5d0$3501a8c0@wssseeger>; from sseeger@stellartec.com on Mon, Apr 28, 2003 at 10:16:18AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 28, 2003 at 10:16:18AM -0700, Steven Seeger wrote:
> If there is no wait, then what's that in arch/mips/vr4181/osprey/reset.c ?

Simple - it is a bug. :)

I got a confirmation from NEC that Vr4181 does _not_ have wait instruction.
It should generate an exception though.

In the halt case, kernel is probably in such a zombie state that we
don't even see the exception.

Jun

> void nec_osprey_halt(void)
> {
> 	printk("KERN_NOTICE "\n** You can safely turn off the power.\n");
> 	while(1)
> 		__asm__(".set\tmips3\n\t"
> 			"wait\n\t"
> 			".set\tmips0");
> }
> 
> Steve
> 
