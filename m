Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f37FTxH24515
	for linux-mips-outgoing; Sat, 7 Apr 2001 08:29:59 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f37FTwM24512
	for <linux-mips@oss.sgi.com>; Sat, 7 Apr 2001 08:29:59 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7AB2B7F3; Sat,  7 Apr 2001 17:29:56 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id F40C9EE94; Sat,  7 Apr 2001 17:29:00 +0200 (CEST)
Date: Sat, 7 Apr 2001 17:29:00 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, debian-mips@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
Message-ID: <20010407172900.A3935@paradigm.rfc822.org>
References: <004f01c0bf41$fe823720$0deca8c0@Ulysses> <Pine.GSO.3.96.1010407124620.8778A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.3.96.1010407124620.8778A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sat, Apr 07, 2001 at 12:55:24PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Apr 07, 2001 at 12:55:24PM +0200, Maciej W. Rozycki wrote:
> 
>  You are right, of course.  That's why glibc contains two versions of
> _test_and_set() code.  If compiled for MIPS I, glibc uses a syscall
> (currently sysmips()), while for MIPS II and higher it uses inline
> assembly code which makes use of LL/SC.
> 
>  That's exactly the way glibc does CPU-model-specific code for other
> archs.

The problem is that it is compile time - I would like to have
a runtime version - Just export the existance of ll/sc to
userspace somewhow.

> > I've seen the hybrid proposal of having libc determine the LL/SC
> > capability of the processor and either executing the instructions
> > or doing the syscall as appropriate. While that would allow
> > near-optimal performance on all systems, I find it troublesome,
> > both on the principle that the OS should conceal hardware
> > implementation details from the user, and on the practical basis
> > that glibc is the last place I would want to put more CPU-specific
> > cruft.  But reasonable people can disagree.
> 
>  I don't like run-time detection either.  The compile-time choice is
> sufficient enough.  The _test_and_set() library function already hides
> implementation details from the user.

It isnt sufficent as we need a glibc beeing able to run on old
decstations AND on newer machines like the Lasat machine
which has an R5000.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
