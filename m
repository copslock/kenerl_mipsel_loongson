Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1F9V3Z11782
	for linux-mips-outgoing; Fri, 15 Feb 2002 01:31:03 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1F9Us911778;
	Fri, 15 Feb 2002 01:30:55 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id AAA03677;
	Fri, 15 Feb 2002 00:30:38 -0800
Date: Fri, 15 Feb 2002 00:30:37 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020215003037.A3670@mvista.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020214232030.A3601@mvista.com>; from jsun@mvista.com on Thu, Feb 14, 2002 at 11:20:30PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 14, 2002 at 11:20:30PM -0800, Jun Sun wrote:
> On Fri, Feb 15, 2002 at 03:11:18AM +0100, Ralf Baechle wrote:
> > On Thu, Feb 14, 2002 at 05:56:31PM -0800, Jun Sun wrote:
> > 
> > > I have been chasing a FPU register corruption problem on a SMP box.  The
> > > curruption seems to be caused by FPU emulator code.  Is that code SMP safe? 
> > > If not, what are the volunerable spots?
> > > 
> > > Just thought I'd check before I dive into it ....
> > 
> > In theory the fp emulation code should be MP safe as the full emulation
> > is only accessing it's context in the fp register set of struct
> > task_struct.  The 32-bit kernel's fp register switching is entirely broken
> > (read: close to non-existant).  Lots of brownie points for somebody to
> > backport that from the 64-bit kernel to the 32-bit kernel and forward
> > port all the FPU emu bits to the 64-bit kernel ...
> > 
> 
> Brownie sounds good. :-)  So what is the "fp register switching" you are 
> referring to?  There is set of code related to lazy fpu context switch,
> which seems to be working fine now.
>

Hmm, I see. The lazy fpu context switch code is not SMP safe.
I see fishy things like "last_task_used_math" etc...

Jun
