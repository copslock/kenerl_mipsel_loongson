Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TMvknC003848
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 15:57:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TMvkX4003847
	for linux-mips-outgoing; Wed, 29 May 2002 15:57:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TMvbnC003844;
	Wed, 29 May 2002 15:57:37 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 29 May 2002 15:58:38 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4TMx51S005882; Wed, 29 May 2002 15:59:05 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4TMx5g09598; Wed, 29 May 2002 15:59:05 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Re: __flush_cache_all() miscellany
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020529222325.17584N-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1020529222325.17584N-100000@delta.ds2.pg.gda.pl>
X-Mailer: Ximian Evolution 1.0.5
Date: 29 May 2002 15:59:05 -0700
Message-ID: <1022713145.7644.363.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10EB829436381-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2002-05-29 at 14:00, Maciej W. Rozycki wrote:
> On 29 May 2002, Justin Carlson wrote:
> 
> > Are the general semantics of the thing just broken, then?  We already
> > ignore the arguments to sys_cacheflush; would redefining the syscall to
> > mean "flush the caches in such a way that I won't get stale instructions
> > from this address range" actually break any current programs? 
> > (Evidently not, if several ports are already doing it that way)...
> 
>  You mean removing the DCACHE operation?  The overlying _flush_cache() 
> library function is specified by the MIPS ABI supplement, so we shouldn't
> really redefine it.  Also a reasonable use for it may exist -- a userland
> program touching hardware directly (say X11) may want to use cached
> accesses for performance reasons (e.g. because cache can do prefetches on
> reads).

This is true;  I hadn't thought about the cases of userland touching
hardware directly.  Of course, I think these cases should be hunted down
and eliminated (go framebuffer device!), but alas, if that ever really
happens, it's not going to be soon.

> 
>  I guess the intent for the ICACHE operation is to assure ICACHE vs DCACHE
> coherency and the intent for the DCACHE operation is to assure DCACHE vs
> RAM coherency.  If the operations do not work in this way for a given
> backend, then there is a bug in it. 

We may theoretically need these capabilities, but, given that several of
the ports already get this wrong and no loud screaming has been heard, I
wonder about the real need.

Assuming we do need these capabilities in the syscall (and, really, it's
pretty easy to make them right), I'm actually more wondering about the
need for the __flush_cache_all() in the first place.  The gdb stubs can
use the defined interface without a problem (and, indeed, more
efficiently.  What they're doing now is overkill).  That leaves the
syscalls, which, if implemented properly, should also use the normal
interface.

I'm still looking for a reason for the existence of __flush_cache_all().


>  I converted a few flush_cache_all() invocations to __flush_cache_all() 
> where appropriate late last year, but the function is a bit older.  I
> think you might dig the linux-kernel list archives for a discussion on the
> semantics of flush_cache_all() (it's a nop for many MIPS CPUs) and
> friends.  The short description in Documentation/cachetlb.txt is a bit
> insufficient, I'm afraid. 

Woefully insufficient.  :)  I'm going to have a stab at editing that
file when I feel like I have a complete understanding.  Don't hold your
breath.  :)

-Justin
