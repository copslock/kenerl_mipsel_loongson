Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OJ0XQ09522
	for linux-mips-outgoing; Thu, 24 Jan 2002 11:00:33 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OJ0SP09497
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 11:00:28 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0OHwgB31678;
	Thu, 24 Jan 2002 09:58:42 -0800
Subject: Re: Does anyone know how HHL boots?
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20020124083723.A47711@idiom.com>
References: <20020124015042.B29933@momenco.com> 
	<20020124083723.A47711@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 10:02:30 -0800
Message-Id: <1011895350.26391.11.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-01-24 at 08:37, Geoffrey Espin wrote:
> Matt,
> 
> > MontaVista has HHL support for several MIPS boards... including one that my
> >... 
> > I mean, our boards have an elementary boot loader that can load a kernel
> > from the network, and disk-booting is something we're trying to figure out.
> > But how does HHL accomplish this?  And is it a general solution for
> > multiple platforms?
> 
> I went thru the same pain and confusion myself 9 months ago.  My
> understanding is MontaVista uses whatever the manufacturer supplies
> with the hardware.  And/or they have an internal version of PMON.
> There are probably a dozen differernt MIPS loaders... some of
> which you might be able to find source for, but probably won't
> be even close to working on your board without weeks+ of effort.

There is pmon2000 which was ported to mips and runs on the ev96100
(rm7k). Porting it to the Ocelot should be straight forward. The CPU is
the same. The system controller is different, but the gt96100 is a
superset of the gt64120, so that part should be easy too. I believe the
low level code that initializes the memory controller will be the same.
I did find a bug in the mem init code that reports the wrong memory size
and sets up the sub decoder incorrectly, but ... it still worked and I
didn't have time to fix it.

Pmon2000 is rather large because it's openbsd based. What's nice though
is that porting drivers to it is much easier since you can just grab it
from openbsd and get rid of some of the memory/bus code.

Another option I like a lot is yamon from MIPS T.  I don't know how long
it would take to port it to the rm7k and the gt64120, but it can't be
that bad.  

Pete
