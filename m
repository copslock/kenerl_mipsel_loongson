Received:  by oss.sgi.com id <S42273AbQGSRUd>;
	Wed, 19 Jul 2000 10:20:33 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:21771 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42257AbQGSRUH>;
	Wed, 19 Jul 2000 10:20:07 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA09913;
	Wed, 19 Jul 2000 10:13:50 -0700
Date:   Wed, 19 Jul 2000 10:13:50 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
        linuxce-devel@linuxce.org
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000719101346.B7480@chem.unr.edu>
References: <Pine.GSO.3.96.1000719160110.21239D-100000@delta.ds2.pg.gda.pl> <Pine.SGI.4.10.10007191041270.6330-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SGI.4.10.10007191041270.6330-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Wed, Jul 19, 2000 at 11:54:59AM -0300
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 19, 2000 at 11:54:59AM -0300, J. Scott Kasten wrote:

> However, the problem is that I am having only limited success compiling
> user space stuff myself on the Indy, be it our own code, or any of the
> common distribution libs/apps. I cannot compile shared objects of good
> size and expect apps built from them to work.  Xlibs, lesstif, etc and
> apps built against them just bus error. However if I go to one of the

This is interesting. I have seen plenty of problems (with several
toolchains) building pic objects and then using -static to link. But
linking against shared objects seems to work fine. I have successfully
built the X libs (4.0 + Guido's newport patch) with the toolchain
included in Simple 0.2b, and have run applications linked against
them. The entire system was built from the same toolchain.

> swapping that out for the 2.2.14 kernel from Simle Linux which runs very
> stable on that box, but there appears to be a kernel/glibc mismatch at
> that point because things don't work right after the boot.  Would like to

Could you explain in greater detail? For example, the userland in
Simple 0.2b will not work with kernel < 2.3.51, and will give an
error to that effect if you try to boot it with 2.2.14. This is
intentional; it seems for some reason that glibc 2.2 userland on a 2.2
kernel will have, actually, the kind of behaviour you are observing.

> errors.  Unfortunately, our c++ apps will not compile with g++-2.7.2 even
> if that did work.

And unfortunately we still don't have a working c++ compiler for
2.96. Hopefully we're close though.

I almost wonder if your hardware is broken somehow, as the system you
describe is identical in every way to the one I am using to develop
Simple.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
