Received:  by oss.sgi.com id <S553886AbQKCVpB>;
	Fri, 3 Nov 2000 13:45:01 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:14284 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553832AbQKCVob>;
	Fri, 3 Nov 2000 13:44:31 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA02775;
	Fri, 3 Nov 2000 22:41:40 +0100 (MET)
Date:   Fri, 3 Nov 2000 22:41:40 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     ian@ichilton.co.uk
cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@oss.sgi.com
Subject: Re: More GCC problems
In-Reply-To: <20001103200432.A2615@woody.ichilton.co.uk>
Message-ID: <Pine.GSO.3.96.1001103215223.1420A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 3 Nov 2000, Ian Chilton wrote:

> > I have no idea how to build a static compiler.
> 
> make -LDFLAGS=-static
> but just make didn't work either..

$ CFLAGS='-static' ./configure
$ make

That's the usual way.  You need to specify necessary options to configure
as well.  You may also put other options in CFLAGS.  You may also specify
other variables -- CC, CXX, CXXFLAGS and LDFLAGS are likely to work.  For
others you need to study configure scripts yourself.

 For example I use more or less the following commands to build an
i386-linux hosted cross-compiler for mipsel-linux on an i386-linux build
system: 

$ mkdir -p obj && cd obj
$ CC="i386-linux-gcc" CXX="i386-linux-g++" \
	CFLAGS="-pipe -O2 -fomit-frame-pointer" \
	CXXFLAGS="-pipe -O2 -fomit-frame-pointer" \
	../configure --prefix=/usr \
	--with-local-prefix=/usr/mipsel-linux/local \
	--enable-shared --enable-haifa --enable-threads \
	--cache-file=config.cache \
	--build=i386-linux --host=i386-linux --target=mipsel-linux
$ make all

and the following lines to build a mipsel-linux native compiler on an
i386-linux build system:

$ mkdir -p obj && cd obj
$ CC="i386-linux-gcc" CXX="i386-linux-g++" \
	CC_FOR_BUILD="i386-linux-gcc" \
	CXX_FOR_BUILD="i386-linux-g++" \
	CC_FOR_TARGET="mipsel-linux-gcc" \
	CXX_FOR_TARGET="mipsel-linux-g++" \
	CFLAGS="-pipe -O2 -fomit-frame-pointer" \
	CXXFLAGS="-pipe -O2 -fomit-frame-pointer" \
	../configure --prefix=/usr \
	--enable-shared --enable-haifa --enable-threads \
	--cache-file=config.cache \
	--build=i386-linux --host=mipsel-linux --target=mipsel-linux
$ make all
	
Note also you need to have glibc headers for the target system installed
on your build system before performing either builds.  I believe gcc
expects them to be found in ${prefix}/${target_alias}/sys-include (that
would be /usr/mipsel-linux/sys-include for the above examples).  It will
copy them to ${prefix}/${target_alias}/include upon build.

 If you do not fear of deep RPM magic, you may try to bootstrap a compiler
toolchain using packages I made available at
ftp://ftp.ds2.pg.gda.pl/pub/macro.  You'll need .rpm* files available
there -- as you are building for mips-linux and I use mipsel-linux, you'll
have to tweak all the files with `sed s/mipsel/mips/g'.  Then you may
start building binary packages from source ones.  You will have to modify
mipsel-linux-* packages slightly -- basically `sed s/mipsel/mips/g' again. 
You need to build packages in a specific order and install every built
package before proceeding to the following one.

 The order is:

1. mips-linux-binutils, mips-linux-boot-glibc-headers (in any order),

2. mips-linux-boot-gcc,

3. mips-linux-glibc,

4. mips-linux-gcc,

5. binutils, gcc (native, for mips-linux; basically any mips-linux
software).

Spec files include appropriate "BuildRequires" statements to remind you
(and rpm) which packages have be installed to build a given package.  The
packages reflect the way I bootstrapped a mipsel-linux system from scratch
on an i386-linux build system.  Gcc is 2.95.3 (or 2.95.2 plus a
few patches, actually), which is sufficient to build glibc 2.2.  You may
build a current gcc snapshot with it if you need to.

 Please note there is a compatibility breakage as of Oct 28th (see the
README file available at the site; it's also explained in change logs for
binutils and glibc).  You may want to fetch earlier binutils and glibc
packages (barring the binary compatibility they work equally well) if you
insist on a compatibility with a current binutils snapshot and binaries
available throughout the Internet.  I'll submit an appropriate change to
the binutils CVS soon; glibc 2.1.97 already has the fix applied.

 I hope this helps,

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
