Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2RIOGx05559
	for linux-mips-outgoing; Tue, 27 Mar 2001 10:24:16 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2RIOBM05551
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 10:24:14 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA22261;
	Tue, 27 Mar 2001 20:24:13 +0200 (MET DST)
Date: Tue, 27 Mar 2001 20:24:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: David Jez <dave.jez@seznam.cz>, Karel van Houten <K.H.C.vanHouten@kpn.com>,
   linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
In-Reply-To: <20010317093919.A19754@foobazco.org>
Message-ID: <Pine.GSO.3.96.1010327201744.17103A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 17 Mar 2001, Keith M Wesolowski wrote:

> That's not the problem.  The problem is that static binaries which use
> libdl used to be (and perhaps still are) broken.  The reason it's
> using libdl is that the nss libraries are never truly static, unless
> you compile glibc with a special non-recommended option.  I have
> indications that this may be fixed in glibc 2.2.2 using my current
> toolchain, but my information is not complete.

 Glibc is fine; it's the kernel that needs a fix (I've sent it here
already once or twice).  We might possibly consider putting a workaround
into glibc as well.

 The problem is mmap() fails if a non-zero preferred address is given but
the space is already occupied and no space *above* is available (space
below is not taken into account).  A glibc workaround might be to call
mmap() again with no preferred address specified this time. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
