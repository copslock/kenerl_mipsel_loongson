Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NK6U121221
	for linux-mips-outgoing; Wed, 23 May 2001 13:06:30 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NK5pF21196;
	Wed, 23 May 2001 13:05:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA15441;
	Wed, 23 May 2001 20:47:34 +0200 (MET DST)
Date: Wed, 23 May 2001 20:47:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Florian Lohoff <flo@rfc822.org>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0BF5AA.DE13EA3F@mvista.com>
Message-ID: <Pine.GSO.3.96.1010523202819.5196G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Jun Sun wrote:

> Same old questions : Where is the definition of sysmips()?  What is considered
> standard implementation of sysmips() so that we can do reverse-engineering? 
> Irix?  

 I think Ralf can comment it.

> Even if Irix is considered standard implementation of sysmips(), I wonder if
> we need to mirror it.  Here is my reasoning.  
> 
> The sytem V ABI specifies _test_and_set() as the exntended system call. 

 I think we want to execute IRIX binaries.  The idea of providing
sysmips() was to provide compatibility to other systems, AFAIK.  I reused
sysmips() for pthreads support in glibc as it was non-existent for ISA I
CPUs and I needeed librt to run on my R3k.

 Much of discussion happened later and the conclusion was it's better to
make a new call than to try to fiddle with sysmips().  I was not aware of
the problems with sysmips() when I wrote the glibc code as sysmips() was
nowhere defined and the interface seemed to be reasonable as implemented
at that time.  Later I was told sysmips(MIPS_ATOMIC_SET) is expected to
return an error code which makes it incompatible to _test_and_set().

> Therefore, for MIPS I system, we simply choose to call sysmips(NEW_ATOMIC_SET,
> ....) with three arguments.  Any application that bypasses _test_and_set() and
> calls sysmips() directly is running at its own risk of not being portable.

 Well, I now see using sysmips() for this purpose is ugly, it complicates
immplementation a lot and hits performance of these slow systems where we
want to save as many CPU cycles as possible.  And still the problem of the
error code remains.

> Of course, we need to fix glibc, which seems to be the only client that
> matters at this moment.

 That is not a problem, as I already stated.  I'll see if I can cook the
new syscall I'm writing of, soon.  You'll see what I mean, then.

> In short, I think we DON"T have to maitain the semantic of sysmips().  My
> understanding is that it is justed used to implement extended MIPS ABS calls. 

 Adding a new subfunction of sysmips() is not a problem.  The cleanness on
the code and the performance is.  Note that other subfunctions of
sysmips() are not performance-critical. 

 The whole idea of sysmips() appears hackish to me.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
