Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JN5r628484
	for linux-mips-outgoing; Tue, 19 Feb 2002 15:05:53 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JN5l928481;
	Tue, 19 Feb 2002 15:05:47 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id OAA25810;
	Tue, 19 Feb 2002 14:05:14 -0800
Date: Tue, 19 Feb 2002 14:05:14 -0800
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219140514.C25739@mvista.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002b01c1b607$6afbd5c0$10eca8c0@grendel>; from kevink@mips.com on Fri, Feb 15, 2002 at 10:59:09AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 10:59:09AM +0100, Kevin D. Kissell wrote:
> > > > > I have been chasing a FPU register corruption problem on a SMP box.  The
> > > > > curruption seems to be caused by FPU emulator code.  Is that code SMP safe? 
> > > > > If not, what are the volunerable spots?
> > > > 
> > > > In theory the fp emulation code should be MP safe as the full emulation
> > > > is only accessing it's context in the fp register set of struct
> > > > task_struct.  The 32-bit kernel's fp register switching is entirely broken
> > > > (read: close to non-existant).  Lots of brownie points for somebody to
> > > > backport that from the 64-bit kernel to the 32-bit kernel and forward
> > > > port all the FPU emu bits to the 64-bit kernel ...
> > > > 
> > > 
> > > Brownie sounds good. :-)  So what is the "fp register switching" you are 
> > > referring to?  There is set of code related to lazy fpu context switch,
> > > which seems to be working fine now.
> > >
> > 
> > Hmm, I see. The lazy fpu context switch code is not SMP safe.
> > I see fishy things like "last_task_used_math" etc...
> 
> What, you mean "last_task_used_math" isn't allocated in a
> processor-specific page of kseg3???    ;-)
>

You must be talking about another OS, right? :-)  I don't think 
Linux has processor-specific page, although this sounds like
a good idea to explore.

Jun
