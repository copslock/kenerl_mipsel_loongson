Received:  by oss.sgi.com id <S553750AbQKOUWA>;
	Wed, 15 Nov 2000 12:22:00 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:17403 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553736AbQKOUVu>;
	Wed, 15 Nov 2000 12:21:50 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eAFKJN319524;
	Wed, 15 Nov 2000 12:19:23 -0800
Message-ID: <3A12F062.5E05CA0B@mvista.com>
Date:   Wed, 15 Nov 2000 12:21:54 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
References: <Pine.GSO.3.96.1001115210032.5687K-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
> On Wed, 15 Nov 2000, Harald Koerfgen wrote:
> 
> > On 15-Nov-00 Jun Sun wrote:
> > [R3000 UP userland spinlocks]
> > > In fact, I don't think you can perform automic operation ONLY based on
> > > the knowledge whether a context switch has happened during a specified
> > > period.  (It should be interesting to see if we can actually "prove"
> > > it.)
> >
> > I doubt this as well, although I'd love to be proven wrong.
> 
>  Well, on UP the only events that can break atomicity are exceptions (here
> I treat interrupts as exceptions as well) and DMA accesses.  I don't think
> we do DMA to user space, so this should not be a problem.  So if we can
> detect an exception occured we may assume an operation failed and retry.
> It's not a problem for an exception handler to clobber k0 or k1 upon exit.
> 

I gave more thoughts on this.  While your argument sounds plausible, the
devil is in "retry" - without a lower-level atomic operation, you cannot
"restore" the initial condition and conduct a re-try.

Come up with a pseudo code to show I am wrong.

>  Unfortunately we cannot use this implementation in the userland or we
> risk problems when running on SMP systems -- an ISA-I user binary might
> very well be run on an ISA-II (or higher) SMP system.  But we can use it
> in the kernel, for sysmips() and everything else.  All we have to be
> careful about is not to allow DMA accesses to spinlocks.  I don't think
> this is a problem in reality.
>

Let us solve UP first. :-)

 
Jun
