Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NJpvB20485
	for linux-mips-outgoing; Wed, 23 May 2001 12:51:57 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NJpfF20479;
	Wed, 23 May 2001 12:51:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA16997;
	Wed, 23 May 2001 21:29:06 +0200 (MET DST)
Date: Wed, 23 May 2001 21:29:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: Jun Sun <jsun@mvista.com>, Florian Lohoff <flo@rfc822.org>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0BF7F8.3050306@redhat.com>
Message-ID: <Pine.GSO.3.96.1010523204831.5196H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Joe deBlaquiere wrote:

> 	Didn't mean to bring up a sore point, but it seems that we haven't yet 
> come to a consensus on what policy to have here. I think you both make 
> valid points that I don't necesarily disagree with, but I would like to 
> follow the counterpoint a little further.

 The consensus was come to in January, IIRC.  I should have coded an
implementation long time ago, actually, but various events keep
distracting me. 

> There's overhead to sysmips also, so neither one is going to give 
> stunning performance. All out performance isn't likely an issue on one 
> of these systems anyways.

 There is a big advantage of invoking a single syscall vs faulting twice
or more times on invalid opcodes.  An the performance is an issue here --
wasting a few cycles may remain unnoticed on a decent system while it is
extremely painful on slow systems.

> 	The problem here is that now I have mips, mipsel, and mipselnollsc 
> configurations of the cross-tools, the c library and the binary 
> applications. It's one extra configuration to maintain.

 How often do you build glibc?

 For other programs it really doesn't matter which version of glibc you
link against (given the same endianness).  The linker does not fetch any
code from shared objects when linking.  Install binaries of glibc as
appropriate but just choose any single copy of glibc for development.

> 	There's no way to solve the endianness issues, but using emulation to
> handle missing instructions (be they floating point or ll/sc, or
> what-have-you) solves the minor differences in the instruction set from
> the library/application standpoint. If all MIPS processors used the same

 Well, do you really have an ISA I CPU which implements ll/sc?  No?  What
about other missing instructions?  Emulating instructions (as well as e.g. 
unaligned memory accesses) might be good for debugging, but for good
performance you need to target your binaries to a specific system anyway.

> the library/application standpoint. If all MIPS processors used the same 
> instruction set then we wouldn't have the problem at all. Of course 
> there are very good reasons (and probably some silly ones too...) why 
> ISAs are tailored.

 The same is true for other processors.  E.g. there is a noticeable
performance advantage for certain code when compiled for the EV56
variation of Alpha (due to the BWX extension, i.e. instructions for byte-
and halfword-wide memory accesses).  Yet the resulting code does not run
on an EV5 or EV4.  You have to choose: either performance or
compatibility.

> 	The kernel is already going to have to adjust some anyway, so keeping the 
> differences in the kernel doesn't increase the testing burden. Throwing 

 The kernel gets adjusted at the build time.  It's unrelated to the topic,
though -- the syscall interface remains the same.

> the problem over to glibc (and the toolchain) does increase the number 
> of active configurations.

 The same can be said of other platforms.  For example, glibc built for
i386 does not make use of i686's cmov instructions and is thus highly
inefficient on such systems.  So if you care of performance you choose an
appropriate glibc build-time configuration which suits your system. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
