Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PImwr07067
	for linux-mips-outgoing; Fri, 25 May 2001 11:48:58 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PIZcF06589
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 11:41:39 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA29592;
	Fri, 25 May 2001 19:19:35 +0200 (MET DST)
Date: Fri, 25 May 2001 19:19:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0D8F51.6000100@redhat.com>
Message-ID: <Pine.GSO.3.96.1010525190438.21771D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 24 May 2001, Joe deBlaquiere wrote:

> and those pesky little inlined code snippets...
> 
> #define PT_EI extern inline
> 
> PT_EI long int
> testandset (int *spinlock)
> 
> which of course uses ll/sc if your world is built for _MIPS_ISA >= 
> _MIPS_ISA_MIPS2

 The glibc's non-inlined _test_and_set() also uses ll/sc, if built for
_MIPS_ISA >= _MIPS_ISA_MIPS2.  We might remove the inline version of
_test_and_set() for _MIPS_ISA == _MIPS_ISA_MIPS1 (I forgot about this one
previously, sorry) from <sys/tas.h>, but at a cost of an additional
function call.  I'm not sure if that's fine performance-wise at this
moment...

 However, when I finish my implementation of a _test_and_set() syscall, it
will be perfectly fine and even necessary to remove the inline wrapper for
_MIPS_ISA == _MIPS_ISA_MIPS1 -- the only reason the wrapper is needed now
is the incompatibility of the arguments of sysmips() and _test_and_set(). 
The good news is I already started the implementation -- hopefully it'll
be ready over this weekend and the never-ending discussion about
sysmips(MIPS_ATOMIC_SET) will be over.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
