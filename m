Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NHfpF15712
	for linux-mips-outgoing; Wed, 23 May 2001 10:41:51 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NHfmF15708;
	Wed, 23 May 2001 10:41:48 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4NHdC000808;
	Wed, 23 May 2001 10:39:12 -0700
Message-ID: <3B0BF5AA.DE13EA3F@mvista.com>
Date: Wed, 23 May 2001 10:38:50 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Florian Lohoff <flo@rfc822.org>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523145044.3890B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Tue, 22 May 2001, Jun Sun wrote:
> 
> > I took a look of MIPS ABI in system V and found that the spec only specifies
> > this extended call in C prototype:
> >
> > int _test_and_set(int *p, int v);
> >
> > It seems perfectly legal for us to add one more argument to store the return
> > value while still have the function returns error.  Of course, doing that will
> > break binary compatibility.
> 
>  We have _test_and_set() in the library.  Implementing a clean underlying
> _test_and_set() syscall is very high on my to-do list -- lack of time
> prevents me from finishing it, unfortunately.
> 
>  There is no point to mess with sysmips() any further, I think.  The
> library's _test_and_set() only calls sysmips() if the library was compiled
> for ISA I systems.  As I guess from reports on the list, ISA I systems are
> a minority, mostly DECstations and possibly a few embedded systems.  Most
> people have ISA II+ and they do not need to call any syscall from
> _test_and_set() at all.  For ISA II+ systems the library implements
> _test_and_set() in the userland, using ll/sc appropriately.
> 
>  Anyone having ISA II+ systems only, please do yourself a favour and set
> "-mips2" (or maybe even "-mips3") somewhere in your CFLAGS for all
> compilations -- not only you'll get better optimized binaries, but you'll
> get rid of this sysmips() problem as well.
> 
> > Otherwise, I think Flo's patch is the best fix to satisfy the spec and binary
> > compatibility although it is a little clunky.
> 
>  I'll have yet to look at the patch, but what I think is, we should get
> sysmips() work as defined by the original spec (or as reverse-engineered,
> as the real spec seems to be out of reach).  Everything else belong to a
> separate implementation.
> 
>  Binary compatibility is not a necessity here.  The only sysmips() client
> is glibc at the moment, and it can be updated to use a new syscall at any
> time.
> 
>  In short: let's leave sysmips() semantics alone.
> 

Same old questions : Where is the definition of sysmips()?  What is considered
standard implementation of sysmips() so that we can do reverse-engineering? 
Irix?  

Even if Irix is considered standard implementation of sysmips(), I wonder if
we need to mirror it.  Here is my reasoning.  

The sytem V ABI specifies _test_and_set() as the exntended system call. 
Exactly how we achieve that is up to each implementation of the OS. 
Therefore, for MIPS I system, we simply choose to call sysmips(NEW_ATOMIC_SET,
....) with three arguments.  Any application that bypasses _test_and_set() and
calls sysmips() directly is running at its own risk of not being portable.

Of course, we need to fix glibc, which seems to be the only client that
matters at this moment.

In short, I think we DON"T have to maitain the semantic of sysmips().  My
understanding is that it is justed used to implement extended MIPS ABS calls. 
As long as we get those calls implemented correctly, the exact sysmips()
semantic does not matter.

Did I misundertand something?

Along this line, I think I even favor "just change the current ATOMIC_SET"
approach.

Jun
