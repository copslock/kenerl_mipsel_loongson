Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFuYRw007098
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:56:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFuYNn007097
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:56:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f21.dialo.tiscali.de [62.246.18.21])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFuKRw007059
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:56:23 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6BCDWk12070;
	Thu, 11 Jul 2002 14:13:32 +0200
Date: Thu, 11 Jul 2002 14:13:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@oss.sgi.com,
   carstenl@mips.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Message-ID: <20020711141332.C11700@dea.linux-mips.net>
References: <80256BF3.00366849.00@notesmta.eur.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <80256BF3.00366849.00@notesmta.eur.3com.com>; from Jon_Burgess@eur.3com.com on Thu, Jul 11, 2002 at 10:49:55AM +0100
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 11, 2002 at 10:49:55AM +0100, Jon Burgess wrote:

> I'm fairly sure i've seen comments that say that cache manipulation code
> should be run uncached. My current thought is that it is probably safe to
> manipulate the d-cache with cached code, but I-cache manipulation which
> could invalidate the cacheline containing the currently executing code
> really should be run uncached. I think the CPU probably then skips
> instructions until it gets to the next cacheline, what effect this has
> depends on how the instructions are aligned relative to the cacheline.
> Given how hit-and-miss this is I am suspicous that this problem could
> simply be lurking undiscovered.
> 
> The patch below makes the I-Cache routines run via kseg1, it is a bit
> ugly but seems to work. I have not measured the performance impact of
> this patch.

Have you tried to insert a large number of nops instead?  Or preferably,
how about replacing the __restore_flags() in your example with the
following piece of inline assembler:

  __asm__ __volatile__("mtc0\t%0, $12" ::"r" (flags) : "memory");

  Ralf
