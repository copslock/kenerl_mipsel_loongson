Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PMKU315410
	for linux-mips-outgoing; Fri, 25 May 2001 15:20:30 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PMKSF15404
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 15:20:28 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4PM3F023115;
	Fri, 25 May 2001 15:03:15 -0700
Message-ID: <3B0ED686.C1D85CE1@mvista.com>
Date: Fri, 25 May 2001 15:02:46 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe deBlaquiere <jadb@redhat.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010524173937.19424A-100000@delta.ds2.pg.gda.pl> <3B0D8F51.6000100@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Alright, I rolled my sleeve and digged into IRIX 6.5, and guess what? 
sysmips() does NOT have MIPS_ATOMIC_SET (2001) on IRIX!  See the header below.

So apparently MIPS_ATOMIC_SET was invented for Linux only, probably just to
implement _test_and_set().  (It would be interesting to see how IRIX implement
_test_and_set() on MIPS I machines.  However, the machine I have access uses
ll/sc instructions).

Given the above understanding, I think we are free to add a new sysmips
subcall or even just change the current one if we want to.

Through the discussions, I hope we have achived the following concensus:

1. We need a correct syscall support to implement _test_and_set() on MIPS I
machine.  ll/sc emulation is not considered good enough to eliminate this need
due to performance concerns.
  
People who take this route understand that they may have to create extra user
land configurations.

2. Nobody seems to object the idea of ll/sc emulation per se, althought it is
not currently fully implemented based on my understanding.

People who prefer this route will enjoy the same ll/sc-enabled userland but
presumably take a performance hit on machines without ll/sc.

Anybody still have objections to the above conclusions?

-------------

Now back to the fix for syscall: the cvs tree is buggy as it is, as pointed
out by Florian.

I see several possibilities, which more or less the same as I brought up at
the beginning:

1) Florian's fix - introduce a new assembly routine to intercept
MIPS_ATOMIC_SET call so that correct return value is returned when there is no
error and error value is returned when there is an error.

1.a) A slight modification to 1) - we send a seg fault when there is access
error.  This solves two problems in 1).  

With 1), _test_and_set() will not be able to distinguish whether an error has
happened or a negative value is returned.  So in effect, error is mistakenly
ignored.  

The second benenfit is that with seg fault MIPS I implementation will have the
same behavior as MIPS II implementation which uses ll/sc.

2) Add a new subcall to sysmips, MIPS_NEW_ATOMIC_SET.  It takes three
arguments with the third one being the address to hold return value.  Again, I
think we should send seg fault on access errors.

The advantage of 2) is that we can still use the same sysmips() call without
introducing any new files.  The disadvantage is that people who use
MIPS_ATOMIC_SET directly is still subject to error, either in one form or
another.

To me, either 1.a) or 2) is fine with me, although I have a slight faovr over
2) (perhaps because I don't like assembly code and the extra "vertical"
calling layer introduced in 1.a)

--------------

So, please do us all a favor, can everybody who cares let us know :

1) can we agree on the concensus?

2) which fix do you like (naturally assuming you agree with the concensus)?

Let us work together and put a closure on this recurring matter!

Jun
