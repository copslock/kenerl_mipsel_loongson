Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39AAdk01068
	for linux-mips-outgoing; Mon, 9 Apr 2001 03:10:39 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39AAFM01055
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 03:10:29 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA10009;
	Mon, 9 Apr 2001 11:48:40 +0200 (MET DST)
Date: Mon, 9 Apr 2001 11:48:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Kevin D. Kissell" <kevink@mips.com>, debian-mips@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
In-Reply-To: <20010407172900.A3935@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010409113508.9470A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 7 Apr 2001, Florian Lohoff wrote:

> >  You are right, of course.  That's why glibc contains two versions of
> > _test_and_set() code.  If compiled for MIPS I, glibc uses a syscall
> > (currently sysmips()), while for MIPS II and higher it uses inline
> > assembly code which makes use of LL/SC.
> > 
> >  That's exactly the way glibc does CPU-model-specific code for other
> > archs.
> 
> The problem is that it is compile time - I would like to have
> a runtime version - Just export the existance of ll/sc to
> userspace somewhow.

 I can't see any problem.  If you want to go for speed -- compile glibc
for MIPS II (assuming you have a MIPS II or better CPU).  If you want to
go for compatibility -- compile glibc for MIPS I (it will still run on
MIPS II or better CPUs, although suboptimally; actually, it won't be the
worst suboptimality then).

 Similarly -- an Alpha EV56-compiled glibc will not run on an EV4 CPU,
while an EV4-compiled glibc will run on an EV56 CPU, although
suboptimally. 

> >  I don't like run-time detection either.  The compile-time choice is
> > sufficient enough.  The _test_and_set() library function already hides
> > implementation details from the user.
> 
> It isnt sufficent as we need a glibc beeing able to run on old
> decstations AND on newer machines like the Lasat machine
> which has an R5000.

 A MIPS-I-compiled glibc will run on any MIPS CPU, using a kernel
_test_and_set() emulation (how kernel emulates _test_and_set() is not the
point here -- it has to be done in an MP-safe way, if necessary; LL/SC is
the most likely candidate for MIPS II or better kernels).  A
MIPS-II-compiled glibc will run on any MIPS II or better CPU using LL/SC
directly.  Similar for MIPS-III-compiled glibc, etc.

 A MIPS-II-compiled kernel will still provide a _test_and_set() emulation
to keep the ABI consistent (e.g. for statically linked MIPS I binaries).

 Still any problems?  I will happily clarify any remaining issues. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
