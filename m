Received:  by oss.sgi.com id <S553902AbQLTNav>;
	Wed, 20 Dec 2000 05:30:51 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:34213 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553729AbQLTNad>;
	Wed, 20 Dec 2000 05:30:33 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA02079;
	Wed, 20 Dec 2000 14:24:38 +0100 (MET)
Date:   Wed, 20 Dec 2000 14:24:37 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET in sys_sysmips()
In-Reply-To: <3A3FAB2B.35F0148E@mvista.com>
Message-ID: <Pine.GSO.3.96.1001220141230.846B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 19 Dec 2000, Jun Sun wrote:

> >  There is no problem with using ll/sc in sysmips() itself for machines
> > that support them.
> 
> Sure - but with ll/sc available the user programs don't need to issue
> sysmip(MIPS_ATOMIC_SET,...) at the first place ...

 You may be running a MIPS I binary on a MIPS II+ SMP system and the
binary has to run absolutely correctly.  Programs affected include ones
that use threads or that use locks in shared memory.

> >  I asked Ralf for a clarification of the sysmips(MIPS_ATOMIC_SET, ...)
> > call before I write better code.  No response so far.  I'm now really
> > cosidering implementing the Ultrix atomic_op() syscall -- at least it has
> > a well-known defined behaviour.
> 
> Where can I find the definitino of atomic_op()?  Or can you tell us a little
> more about it? 

 You may search the Net for atomic_op -- you should find a couple of
Ultrix man pages.  A copy is included below for your convenience.

> >  The previous code was definitely broken -- depending on the path taken it
> > would return either the value fetched from memory or an error code.  No
> > way to distinguish between them.
> 
> I notice that.  I notice glibc is the only "customer" of the MIPS_SET_ATOMIC
> call, the bug does not appear to be a big deal because error should not
> happen.  Of course, it will be nice to fix it.

 It is at the moment, but I can see other users once we establish the API. 
PostgreSQL is one of them.  It would call _test_and_set() but it implies
the latter should work as expected.  The _test_and_set() function is
documented in the MIPS ABI supplement and the underlying syscall
(whichever it is) must provide means for the fuction to behave as
expected.  Besides, if we want this to be a compatibility call, then we
should at least make it behave in a compatible way.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

                                                                 atomic_op(2)

   Name
     atomic_op - perform test and set operation.

   Syntax
     #include <sys/lock.h>

     int atomic_op(op, addr)
     int op;
     int *addr;

   Arguments

     op             This argument is the operation type.  If the operation
                    type is ATOMIC_SET, this call specifies the test and set
                    operation on location addr.  If the operation type is
                    ATOMIC_CLEAR, this call specifies the clear operation on
                    location addr.

     addr           This is the target address of the operation.

   Description
     The atomic_op call provides test and set operation at a user address.

     For RISC systems, atomic_op is executed as a system call.  For VAX sys-
     tems, a system call is not executed for this library function.

   Return Values
     If the atomic_op operation succeeds, then 0 is returned.  Otherwise a -1
     is returned, and a more specific error code is stored in errno.

   Diagnostics

     [EBUSY]        The location specified by addr is already set.

     [EINVAL]       The op is not a valid operation type.

     [EACCES]       The address specified in addr is not write accessible.

     [EALIGN]       The addr is not on an integer boundary.
