Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f37AtgY19825
	for linux-mips-outgoing; Sat, 7 Apr 2001 03:55:42 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f37AtdM19822
	for <linux-mips@oss.sgi.com>; Sat, 7 Apr 2001 03:55:40 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA09080;
	Sat, 7 Apr 2001 12:55:24 +0200 (MET DST)
Date: Sat, 7 Apr 2001 12:55:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Florian Lohoff <flo@rfc822.org>, debian-mips@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
In-Reply-To: <004f01c0bf41$fe823720$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010407124620.8778A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 7 Apr 2001, Kevin D. Kissell wrote:

> >  It was discussed a few times already.  It's ugly and is an overkill for
> > UP machines -- you take at least two faults for ll/sc emulation and only a
> > single syscall for TAS.
> 
> Depends on your point of view.  Syscalls will be faster than
> emulation on processors without LL/SC support, certainly,
> but much slower than just executing the instructions on processors
> that do support LL/SC.  Intuitively, emulation would be roughly
> 2x worse for an R3K, but a syscall will be 10-100 times worse
> for an R4K.  If we gave an equal weight to both families, that
> would argue in favor of LL/SC emulation - and working for
> MIPS Technologies (where all our designs for the past
> 10 years have supported LL/SC) I would consider equal
> weighting to be very generous!  ;-)

 You are right, of course.  That's why glibc contains two versions of
_test_and_set() code.  If compiled for MIPS I, glibc uses a syscall
(currently sysmips()), while for MIPS II and higher it uses inline
assembly code which makes use of LL/SC.

 That's exactly the way glibc does CPU-model-specific code for other
archs.

> I've seen the hybrid proposal of having libc determine the LL/SC
> capability of the processor and either executing the instructions
> or doing the syscall as appropriate. While that would allow
> near-optimal performance on all systems, I find it troublesome,
> both on the principle that the OS should conceal hardware
> implementation details from the user, and on the practical basis
> that glibc is the last place I would want to put more CPU-specific
> cruft.  But reasonable people can disagree.

 I don't like run-time detection either.  The compile-time choice is
sufficient enough.  The _test_and_set() library function already hides
implementation details from the user.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
