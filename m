Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2003 23:03:18 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:40324 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225500AbTKRXDG>; Tue, 18 Nov 2003 23:03:06 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DC2474AD81; Wed, 19 Nov 2003 00:02:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP id B7B3347A4D
	for <linux-mips@linux-mips.org>; Wed, 19 Nov 2003 00:02:56 +0100 (CET)
Date: Wed, 19 Nov 2003 00:02:56 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
Subject: [announce] 64-bit toolchain available for the R4000/R4400
Message-ID: <Pine.LNX.4.55.0311182243470.25195@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 As you might already know the R4000 and revision 1.0 of the R4400
processor suffer from a few errata that make 64-bit operation problematic
with standard code.  Under certain conditions, doubleword addition and
extended shift instructions can produce incorrect results.

 There is no hardware workaround available for these problems, but by
carefully selecting instruction sequences and avoiding certain operations
reliable code can be generated that does not trigger these problems.  The
current version of Linux as present in our CVS executes specific tests for
these errata early during bootstrap and if found, then code is checked for
having been generated by tools that are aware of the respective problem.  
If the code fails such a check then the kernel refuses to boot.

 I'm pleased to announce a toolchain that supports software workarounds
for these errata is available at my site.  The stable versions are:  

1. binutils 2.14:

- mips64el-linux-binutils-2.14-3.src.rpm -- a source package,

- mips64el-linux-binutils-2.14-3.i386.rpm -- an i386 binary package,

2. gcc 2.95.4:

- mips64el-linux-boot-gcc-2.95.4-15.src.rpm -- a source package,

- mips64el-linux-boot-gcc-2.95.4-15.i386.rpm -- an i386 binary package.

3. glibc 2.2.5 (headers needed to rebuild gcc):

- mips64el-linux-boot-glibc-headers-2.2.5-6.src.rpm -- a source package,

- mips64el-linux-boot-glibc-headers-2.2.5-6.noarch.rpm -- an
architecture-independent binary package.

As implied by the names, all these are tools for a cross-compilation.  
Binary packages are provided for convenience only -- a cross-binutils
binary package may be generated for any architecture with a native gcc
compiler from the source package which is self-contained and with the aid
of the supplied glibc headers, the cross-gcc package can be regenerated as
well.

 Due to the lack of support for mips64 in glibc 2.2.x, the gcc package is 
provided in a minimal configuration (hence the -boot- infix) with the 
plain C compiler and libgcc only.  It is sufficient to build Linux 
kernels.

 The toolchain enables workarounds in code generators whenever a 64-bit
output is requested (e.g. "-mabi=64") and either an R4000 or an R4400 CPU
is selected (e.g. "-march=r4000"), as appropriate for the workaround.  

 For the extended shift errata a workaround is activated for the R4000
CPU.  There is no further control of the setting.  When active,
problematic sequences of a multiplication or division and an extended
shift are avoided in the generated code.

 For the doubleword addition errata a workaround is activated for both the
R4000 and the R4400 CPU.  Additionally, there is a new option "-mdaddi"  
and its negation -- "-mno-daddi", recognized by both gcc and gas, which
activate and deactivate the workaround respectively.  There is a pair of
assembly directives, ".set daddi" and ".set nodaddi", as well, which
operate just like respective command line options.  The workaround makes
gcc avoid emitting certain macro instructions that expand to sequences
containing problematic doubleword additions.  For gas it makes problematic
doubleword additions, that would normally be machine instructions, be
expanded as macros using safe replacements.  As a side effect certain
macros have a more strict requirement on their arguments as otherwise two
temporary registers would be needed.  This is the reason gcc needs to
avoid such macros and also why code emitted by `gcc -mdaddi' could not
necessarily be successfully assembled by `as -mno-daddi'.

 You are welcome to use the tools and I'll appreciate feedback.  As a few
assembly bits of the kernel cannot be compiled with "-mno-daddi", I have
prepared appropriate patches, which are available upon request (version
2.4 only).  If you have a processor which has its PRId in the range from
0x0400 to 0x044f inclusive and would like to use a 64-bit kernel, then the
tools are for you.  I've been using 64-bit kernels built with these tools
with my R4400-based DECstation for some time now and they appear no less
stable than their 32-bit counterparts.

 If there are problem reports with the tools I'm going to maintain them
for the time being, but in the long run I'm going to work on merging
appropriate bits into the mainline.  Therefore I do not expect to put much
more work into these particular versions of tools and I'm focusing on
upgrading the changes to apply against current versions of software.  In
particular I'm not going to write any more decent documentation than this
notice before I get the upgrade done (sorry).  My goal is to get gcc
patches upgraded to 3.4 and attempt to merge them into 3.5.  With respect
to binutils, I've already upgraded to 2.14.90 and I suppose to try a merge
attempt for 2.16.

 The address of my site is the same as always:  
'ftp://ftp.ds2.pg.gda.pl/pub/macro/' -- see the "SRPMS" and "RPMS"  
directories for source and binary packages, respectively.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
