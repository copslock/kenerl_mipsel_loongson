Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 19:19:10 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:34804 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225770AbUCaSTJ>;
	Wed, 31 Mar 2004 19:19:09 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2VIJ7x6007068;
	Wed, 31 Mar 2004 10:19:07 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2VIJ5OE007066;
	Wed, 31 Mar 2004 10:19:05 -0800
Date: Wed, 31 Mar 2004 10:19:05 -0800
From: Jun Sun <jsun@mvista.com>
To: Lijun Chen <chenli@nortelnetworks.com>
Cc: linux-mips@linux-mips.org, Dominic Sweetman <dom@mips.com>,
	ralf@linux-mips.org, jsun@mvista.com
Subject: Re: exception priority for BCM1250
Message-ID: <20040331101905.D6712@mvista.com>
References: <4069F90D.9060903@americasm01.nt.com> <16490.33481.5505.705679@arsenal.mips.com> <406AE627.30104@americasm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <406AE627.30104@americasm01.nt.com>; from chenli@nortelnetworks.com on Wed, Mar 31, 2004 at 10:39:19AM -0500
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 31, 2004 at 10:39:19AM -0500, Lijun Chen wrote:
> Thanks a lot, Dominic and Ralf.
> So interrupts and a few exception conditions are maskable and preemptable.
> The machine-level exceptions are non-maskable.If ever multiple 
> exceptions occur
> at the same time, cpu picks the highest priority one.
> 
> But in the MIPS64 spec, it says the EXL bit is set when any exception 
> other than Reset,
> Soft reset, NMI or Cache Error exception are taken. Does this mean Cache 
> error can
> preempt whatever else is going on except for Reset and NMI?
> 

I think so.  Usually when cache error happens you are dead.  
For bcm1250 there is a cache error handler which works around a hw bug.
I believe the workaround code is in the linux-mips.org tree.
 
> My intention is to write some information to a kernel buffer when cache 
> and bus
> error exceptions occur. If they use the common buffer and a spin_lock() 
> is used before
> writing, will this cause dead lock if kernel is handling bus error while 
> a cache error
> occurs?
> 

It will be a deadlock only if another exception happens and you try
to acquire the lock while you are already in the middle of spin_lock()/spin_unlock(). 
You should use spin_lock() in a scope as small as possible.

BTW, you may my tiby tracing patch handy for something like this.

http://linux.junsun.net/patches/generic/experimental/040316.a-jstrace.patch

Jun
