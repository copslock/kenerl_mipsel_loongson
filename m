Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15Lfvq15520
	for linux-mips-outgoing; Tue, 5 Feb 2002 13:41:57 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15LfsA15517
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 13:41:54 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g15LdjB21511;
	Tue, 5 Feb 2002 13:39:45 -0800
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
From: Pete Popov <ppopov@pacbell.net>
To: sjhill@cotw.com
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3C604D73.88F1CDCE@cotw.com>
References: <200202051747.SAA21696@copsun18.mips.com>
	<3C6044A7.13FEB2E2@cotw.com> <1012943709.10659.106.camel@zeus> 
	<3C604D73.88F1CDCE@cotw.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 05 Feb 2002 13:44:03 -0800
Message-Id: <1012945444.10720.113.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-02-05 at 13:24, Steven J. Hill wrote:
> Pete Popov wrote:
> > 
> > I'm not sure if it's a "little" though.  Ralf has already done the work
> > for 64bit memory support on 32bit kernels, but that only works currently
> > on 64bit CPUs.  I started hacking on the 64bit memory patch to get it to
> > work on 32bit processors, but had to put that aside for a few weeks. I
> > hope to get back to it soon.
> > 
> Sure, the "little" is a relative term. As far as your patch is concerned,
> you are essentially trying to use a true 32-bit processor (my definition
> being that it is not a 64-bit processor running in 32-bit mode), to address
> address more than 4GB of physical memory. I don't see how that is possible
> with just the MMU and TLB unless you are using chip selects and customm
> logic.

I failed to mention that the additional patch, once working, would be
for MIPS32 (as in the MIPS Tech's MIPS32 spec, not just any 32 bit CPU)
CPUs that implemented the full 36 bit physical address space.  So the
support really won't be 64bit, it will be 36bit.

Pete
