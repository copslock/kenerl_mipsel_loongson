Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TKJQnC028162
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 13:19:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TKJQYu028161
	for linux-mips-outgoing; Wed, 29 May 2002 13:19:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TKJJnC028158;
	Wed, 29 May 2002 13:19:19 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 29 May 2002 13:20:19 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4TKKl1S002805; Wed, 29 May 2002 13:20:47 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4TKKlM08677; Wed, 29 May 2002 13:20:47 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Re: __flush_cache_all() miscellany
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020529213719.17584J-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1020529213719.17584J-100000@delta.ds2.pg.gda.pl>
X-Mailer: Ximian Evolution 1.0.5
Date: 29 May 2002 13:20:46 -0700
Message-ID: <1022703646.7643.175.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10EBE7896168-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2002-05-29 at 12:50, Maciej W. Rozycki wrote:
> On 29 May 2002, Justin Carlson wrote:
> 
> > Here's a patch against cvs that does the rename.  Unless anyone has
> > objections, Ralf, could  you apply this?
> 
>  That looks fine to me.  I'd keep the leading double underscore, though --
> it acts as a warning sign the function is internal and low-level and thus
> it should not be used without an appropriate justification.
> 

Yes, you're right, it's not a standard function to have.  But I'm
already wondering if this is not the right thing to do.  See below.

>  Well, at least r3k uses WT for dcache, so it really doesn't matter unless
> what you want to achieve is to hit performance.  I suspect this is also
> the case for the others that ignore dcache flushes.  The L1 vs L2 issue
> should be investigated where applicable. 

Are the general semantics of the thing just broken, then?  We already
ignore the arguments to sys_cacheflush; would redefining the syscall to
mean "flush the caches in such a way that I won't get stale instructions
from this address range" actually break any current programs? 
(Evidently not, if several ports are already doing it that way)...

More to the point, does __flush_cache_all() serve any useful purpose at
all, or can it just be replaced with appropriate invocations of
flush_icache_range()?   Other than internal use for the individual port
cache routines, it's *only* used in the syscalls and the gdb stub. 

I'd like to hear the rationale for __flush_cache_all() from the original
author; it appears to have shown up in CVS a little more than a year
ago, but I don't know who sent the patch to Ralf.  Ralf, do you
remember?

Thanks,
  Justin
