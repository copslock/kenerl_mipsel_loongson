Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4OGVg221348
	for linux-mips-outgoing; Thu, 24 May 2001 09:31:42 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4OGOaF21098
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 09:25:49 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA20690;
	Thu, 24 May 2001 18:21:14 +0200 (MET DST)
Date: Thu, 24 May 2001 18:21:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Joe deBlaquiere <jadb@redhat.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <001101c0e464$72c130e0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010524173937.19424A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 24 May 2001, Kevin D. Kissell wrote:

> >  First, we are talking about glibc and not the entire userland.
> 
> But since essentially the entire userland is linked with glibc,
> I'm not sure how much that distinction matters, in practical
> terms.

 Do you link statically?  If not, then almost no code from glibc is
incorporated into your binaries, with an unimportant exception of a few
functions from libc_nonshared.

> I'm simply saying that if one just does "./configure"
> and "make" for glibc with a mips target, it should default
> to use ll/sc, and that if one simply builds RPMs for binary
> distribution of MIPS/Linux binaries, they should be linked
> with a glibc that uses ll/sc.  And that therefore the MIPS/Linux
> kernel for R3000's (and R4100's) should have ll/sc emulation 
> support built in by default.

 Then you need to change your gcc configuration so that it assumes
"-mips2" (or whatever level you want to) by default.  That's typically
done in the gcc's specs file.  Nothing about glibc here. 

 For RPM you might put "-mips2" into optflags in its rc file.

> >  Second, do you expect everyone compiling the entire userland from
> > sources?  I don't.  The normal approach is to take a distribution and
> > build only these pieces which are not satisfying for one reason or
> > another.  Just take an ISA I, ISA II or whatever version you need.
> 
> >From where?  I'd love to find a decently complete (with compilers,
> networking tools, X, etc.) mipsel distribution of any MIPS ISA level 
> less that MIPS V to replace the antique crud that runs on my mipsel 
> platform.

 That's a real problem, but there is Debian available for MIPS -- is it
missing anything?  The main problem was to get glibc 2.2 right.  Since it
was done, building other programs should be easy.

 Then building other variants is just a matter of disk space and CPU time.

> >  Fourth, maintaining differently optimized distributions is not that
> > troublesome.
> 
> Please don't get me wrong here, because I tremendously
> respect the work that you've been doing for MIPS/Linux,
> but how many differently optimised distributions do you
> presonally build, distribute, support, and maintain?

 I understand maintaining a distribution is serious task, but with
appropriate tools maintaining two or more distributions with a common
source set is not much harder than a single one.

 For example, using the source set as available at my FTP site, building
differently optimized binaries is as easy as running a script looking
more or less as follows:

for rc in .rpmrc-mipsel .rpmrc-mipsel-II .rpmrc-mipsel-III
.rpmrc-mipsel-IV; do
	for name in *.src.rpm; do
		rpm --rcfile=$rc --rebuild $name
	done
done

with different optflags set in .rpmrc-mipsel* files.  It's boring and
disk-consuming but easy and automatic.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
