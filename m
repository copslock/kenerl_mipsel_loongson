Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA57989 for <linux-archive@neteng.engr.sgi.com>; Tue, 15 Sep 1998 19:39:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA16821
	for linux-list;
	Tue, 15 Sep 1998 19:39:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA51100
	for <linux@engr.sgi.com>;
	Tue, 15 Sep 1998 19:39:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA04543
	for <linux@engr.sgi.com>; Tue, 15 Sep 1998 19:39:03 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-11.uni-koblenz.de [141.26.249.11])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id EAA25460
	for <linux@engr.sgi.com>; Wed, 16 Sep 1998 04:38:55 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA00926;
	Wed, 16 Sep 1998 03:50:21 +0200
Message-ID: <19980916035021.A451@uni-koblenz.de>
Date: Wed, 16 Sep 1998 03:50:21 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: MIPS HOWTO / FAQ
References: <19980916001625.F32589@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=OXfL5xGRrasGEqWY
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980916001625.F32589@uni-koblenz.de>; from ralf@uni-koblenz.de on Wed, Sep 16, 1998 at 12:16:25AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii

On Wed, Sep 16, 1998 at 12:16:25AM +0200, ralf@uni-koblenz.de wrote:

> since nobody else does (hint, hint ...) I started to rework the MIPS FAQ.
> Attached the first very incomplete version.  As of this version the
> FAQ is now written using the Linux SGML tools.  I append a text version
> generated with sgml2txt.  Comments, additional text etc. apreciated.
> I'm especially thinking of the DECstation people but not only.
> 
> Special feature: the topic ``How to brew a cross compiler'' now has it's
> own uptodate and about 5 printed pages long section describing how to
> roll a crosscompiler based on the newest stuff.  The topic has actually
> also been interesting for other people as many postings in the past
> have shown.  Maybe the crosscompiler part is actually worth it's own,
> separate HOWTO document?

Sorry, forgot to add the attachment ...

  Ralf

--OXfL5xGRrasGEqWY
Content-Type: text/plain
Content-Disposition: attachment; filename="mips-howto.txt"

  Linux/MIPS HOWTO
  Ralf Baechle, ralf@gnu.org
  September 11, 1998

  XXX General blurb for the first page.
  ______________________________________________________________________

  Table of Contents


  1. What is Linux/MIPS?

  2. What hardware does Linux/MIPS support?

     2.1 Hardware platforms
        2.1.1 Silicon Graphics Indy
        2.1.2 Silicon Graphics Challenge S
        2.1.3 Silicon Graphics Indigo
        2.1.4 Motorola 68k based machines like the Iris 3000
        2.1.5 Other Silicon Graphics machines
        2.1.6 SNI RM200C
        2.1.7 SNI RM200
        2.1.8 Algorithmics P4032
        2.1.9 DECstation series
        2.1.10 Mips Magnum 4000 / Olivetti M700-10
        2.1.11 MIPS Magnum 4000SC
     2.2 Processor types
        2.2.1 R2000, R3000 family
        2.2.2 R6000
        2.2.3 R4000 and R5000 family
        2.2.4 R8000
        2.2.5 R10000
     2.3 Drivers

  3. Is there a Linux distribution?

     3.1 RedHat
     3.2 What about other distributions?

  4. Where can I get Linux/MIPS from?

  5. Installation of Linux/MIPS.

  6. How do I setup a crosscompiler?

     6.1 Diskspace requirements
     6.2 Byte order
     6.3 Configuration names
     6.4 Installation of GNU Binutils.
     6.5 Assert.h
     6.6 First installation of egcs
     6.7 float.h
     6.8 Installing the kernel sources
     6.9 Installing GNU libc
     6.10 Building egcs again
     6.11 Should I build the C++, Objective C or F77 compilers?


  ______________________________________________________________________

  1.  What is Linux/MIPS?

  XXX Add some general blurb, maybe move into abstract.



  2.  What hardware does Linux/MIPS support?

  2.1.  Hardware platforms


  Many machines are available with a number of different CPU options of
  which not all are currently are supported.  Please check section
  ``Processor Type'' to make shure your CPU type is supported.


  2.1.1.  Silicon Graphics Indy

  The Indy is currently the only (mostly) supported Silicon Graphics
  machine.


  2.1.2.  Silicon Graphics Challenge S

  This machine is very similar to the Indy; it would therefore be a
  worthwile target for a hacker.  What's missing is modifying the
  graphics card probing code such that it works in absence of a graphics
  card as this is the case on a headless machine like the Challenge S.


  2.1.3.  Silicon Graphics Indigo

  This machine is only being mentioned here because occasionally people
  have confused it with Indys.  The Indigo series is a different
  architecture however and therefore yet unsupported.


  2.1.4.  Motorola 68k based machines like the Iris 3000

  These are very old machines, probably more than ten years old by now.
  As these machines are not based on MIPS processors this document is
  the wrong place to search for information.  However, in order to make
  things easy, these machines are currently not supported.


  2.1.5.  Other Silicon Graphics machines

  At this time no other Silicon Graphics machine is supported.  This
  also applies to the very old Motorola 68k based systems.


  2.1.6.  SNI RM200C

  In contrast to the RM200 (see below) this machine has EISA and PCI
  slots.  The RM200 is supported with the exception of the availability
  of the onboard NCR53c810A SCSI controller.


  2.1.7.

  SNI RM200

  If your machine has both EISA and PCI slots, then this is a RM200C,
  please see above.  Due to the slight architectural differences of the
  RM200 and the RM200C this machine isn't currently supported in the
  official sources.  Michael Engel engel@numerik.math.uni-siegen.de has
  managed to get his RM200 working partially but the patches haven't yet
  be included into the official Linux/MIPS sources.




  2.1.8.  Algorithmics P4032

  (XXX Bash Ralf and Michael to finish this ... XXX)

  2.1.9.  DECstation series

  XXX Could some DECy write something for this? XXX

  2.1.10.

  Mips Magnum 4000 / Olivetti M700-10

  These two machines are both almost completely identical.  Back during
  the ACE initiative Olivetti licensed the Jazz design and marketed the
  machine with Windows NT as OS.  MIPS Computer Systems, Inc. itself
  bought the Jazz design and marketed it as the MIPS Magnum 4000 series
  of machines.  Magnum 4000 systems were marketed with Windows NT and
  RISC/os as operating systems.

  Depending from the operating system which was installed on the machine
  a different firmware was installed on the box.  Linux/MIPS supports
  only the little endian firmware on these two types of machines.  Since
  the M700-10 was only marketed as NT machine all M700-10 machines have
  this firmware installed.  The MIPS Magnum case is somewhat more
  complex.  If your machine has been configured big endian for RISC/os
  then you need to reload the little endian firmware.  This firmware was
  originally included with the delivery of every Magnum on a floppy.  If
  you don't have the floppy anymore you can download it via anonymous
  ftp from <ftp://ftp.fnet.fr>.

  Note that the little endian firmware does not support headless
  operation.  So if your machine does not include the standard G364
  graphics card, your machine cannot boot.

  2.1.11.  MIPS Magnum 4000SC

  The Mips Magnum 4000SC is just the same as an Magnum 4000 (see above)
  with the exception that it's using a R4000SC CPU which currently is
  not supported by Linux.

  2.2.


  Processor types

  2.2.1.  R2000, R3000 family

  The R2000 is the original MIPS processor.  It's a 32 bit processor
  which was clocked at 8MHz back in '85 when the first MIPS processors
  came to the market.  Later versions were clocked faster.  The R3000 is
  a redesign of the R2000 which is 100% compatible, it was just again
  clocked faster.  Because of the high compatibility this document
  usually only mentions the R3000 even though the same facts in most
  cases also apply for the R2000.

  Same also applies for the R3000 which basically a R3000 plus a R3010
  FPU and 64k cache running at upto 40Mhz and integrated into same chip.
  Support for the R3000 processor is currently in the works by various
  people.  Harald Koerfgen harald.koerfgen@netcologne.de and Gleb O.
  Raiko raiko@niisi.msk.ru have both indepentently worked on patches
  which however haven't yet been integrated into the official Linux/MIPS
  sources.




  2.2.2.  R6000

  Sometimes people confuse the R6000, a MIPS processor, with RS6000, a
  series of workstations made by IBM.  So if you're reading this in hope
  to find out more about Linux on IBM machines you're reading the wrong
  document.

  The R6000 is currently not supported.  It is a 32 bit MIPS ISA 2
  processor and a pretty interesting and wiered piece of silicon.  It
  was developed and produced by a company named BIT Technology.  Later
  NEC took over the semiconductor production.  It was built in ECL
  technology, the same technology that was and still is being used to
  build extremly fast chips like those used in some Cray computers.  The
  processor had it's TLB implemented as part of the last couple of lines
  of the external primary cache, a technology called TLB slice.  That
  means it's MMU is substancially different from those of the R3000 or
  R4000 series which also is one of the reasons why the processor isn't
  supported.

  2.2.3.  R4000 and R5000 family

  Linux supports many of the members of the R4000 family, currently
  these are R4000PC, R4400PC, R4300, R4600, R4700, R5000, R5230, R5260.
  Many others are probably working as well.

  Not supported are R4000SC, R4000MC, R4400SC and R4400MC CPUs as well
  as R5000 systems with a CPU controlled second level cache.  This means
  where the cache is controlled by the R5000 itself in contrast to some
  external external cache controller.  The difference is important
  because unlike to other systems, especially PCs, on MIPS the cache is
  archtecturally visible and needs to be controlled by software.  Ulf
  Carlsson grim@zigzegv.ml.org and Ralf Baechle ralf@gnu.org are
  currently working on support for R4000SC and R4400SC.

  2.2.4.  R8000

  The R8000 is currently unsupported partly because the machines used by
  the Linux/MIPS developers don't have such a machine, partly because
  this processor is relativly rare and has only been used in a few SGI
  machines.

  The R8000 is a pretty interesting piece of silicon.  Unlike the other
  members of the MIPS family it is a set of seven chips.  It's cache and
  TLB architecture is pretty different from the other members of the
  MIPS family.  It was born as a hack in order to get the floating point
  crown back to Silicon Graphics in time before the R10000 is finished.

  2.2.5.  R10000

  The R10000 is currently unsupported because the machines used by the
  Linux/MIPS developers don't have such a machine.

  2.3.  Drivers

  3.  Is there a Linux distribution?


  3.1.  RedHat

  XXX Add some gossip about HardHat aka Rough Cuts XXX.

  3.2.  What about other distributions?




  4.  Where can I get Linux/MIPS from?


  5.  Installation of Linux/MIPS.


  6.  How do I setup a crosscompiler?

  First of all go and download the following source packages: XXX
  Incomplete, maybe tell'em to get the files from the srpm packages? XXX

  o  binutils-2.8.1.tar.gz

  o  egcs-1.0.2.tar.gz

  o  glibc-2.0.6.tar.gz

  o  glibc-crypt-2.0.6.tar.gz

  o  glibc-localedata-2.0.6.tar.gz

  o  glibc-linuxthreads-2.0.6.tar.gz

     These are the currently recommended versions.  Older versions may
     or may not be working.  If you're trying to use older versions
     please don't send bug reports, we don't care.  When installing
     please install things in the order binutils, egcs, then glibc.
     Unless you already have older versions already installed changing
     the order will fail.



  6.1.  Diskspace requirements

  For the installation you'll have to choose a directory for
  installation.  I'll refer to that directory below with <prefix>.  To
  avoid a certain problem best just the same value for <prefix> as your
  native gcc.  For example if your gcc is installed in /usr/bin/gcc then
  choose /usr for <prefix>.  You must use the same <prefix> value for
  all the packages that you're going to install.

  During compilation you'll need about 31mb diskspace for binutils.  For
  installation you'll need 7mb diskspace for binutils on <prefix>'s
  partition.  Building egcs requires 71mb and installation 14mb.  GNU
  libc requires 149mb diskspace during installation and 33mb for
  installation.  Note these number are just a guideline and may differ
  significantly for different processor and operating system
  architectures.


  6.2.  Byte order

  On of the special features of the MIPS architecture is that all
  processors except the R8000 can be configured to run either in big or
  in little endian mode.  Byte order means the way the processor stores
  multibyte numbers in memory.  Big endian machines store the the byte
  with the highest value digits at the lowest address while little
  endian machines store it at the highest address.  Think of it like
  writing multi digit numbers from the left to the right or visa versa.

  In order to setup your crosscompiler correctly you have to know the
  byte order of the crosscompiler target.  If you don't know already
  know, check the section ``Hardware Platforms'' for your machine's
  byteorder.


  6.3.  Configuration names

  Many of the packages based on autoconf are supporting many different
  architectures and operating systems.  In order to differenciate
  between these many configurations names madeup like
  <cpu>-<company>-<os> or even <cpu>-<company>-<kernel>-<os>.  Expressed
  that way the configuration names of Linux/MIPS are mips-unknown-linux-
  gnu for big endian targets or mipsel-unknown-linux-gnu for little
  endian targets.  Those names are a bit long and so it's allowed to
  abreviate them to mips-linux or mipsel-linux.  You must use the same
  configuration name for all the packages that your crosscompilation
  environment consists of.  Also, while other names like mips-sni-linux
  or mipsel-sni-linux are both legal configuration names, don't use them
  but only mips-linux or mipsel-linux.  The reason is that other
  packages like the Linux kernel sources know about these configuration
  names and you'd have to change them for crosscompilation.  I'll refer
  to the target configuration name below with <target>.


  6.4.  Installation of GNU Binutils.

  This is the first and most simple part - at least as long as you're
  trying to install on any halfway sane UNIX flavour.  Just cd into a
  directory with enough free space and do the following:

      gzip -cd binutils-<version>.tar.gz | tar xf -
      cd binutils-<version>
      patch -p1 < ../binutils-<version>-mips.patch
      ./configure --prefix=<prefix> --target=<target>
      make CFLAGS=-O2
      make install



  This usually works very easily.  On certain machines using GCC 2.7.x
  as compiler is known to dump core.  This is a known bug in GCC and can
  be fixed by upgrading to GCC 2.8.1 or egcs.


  6.5.  Assert.h

  Some people have an old assert.h headerfile installed, probably a
  leftover from an old crosscompiler installation.  This file may cause
  autoconf scripts to fail silently.  It was never necessary and only
  got installed due to a bug in older GCC versions.  Check if
  <prefix>/<target>/include/assert.h exists in your installation.  If
  so, just delete it.


  6.6.  First installation of egcs

  Now the not so funny part begins.  There is a so called bootstrap
  problem.  In our case that means the installation process of egcs
  needs an already installed glibc.  But we cannot yet compile glibc
  because we don't have a working crosscompiler yet.  Luckily you'll
  only have to go through this once when you install a crosscompiler for
  the first time.  Later when you already have glibc installed things
  will be much smoother.  So now do:








      gzip -cd egcs-<version>.tar.gz | tar xf -
      cd egcs-<version>
      for i in egcs-1.0.2-libio.patch egcs-1.0.2-hjl.patch \
            egcs-1.0.2-rth1.patch egcs-1.0.2-rth2.patch egcs-1.0.2-rth3.patch \
            egcs-1.0.2-rth4.patch egcs-1.0.2-hjl2.patch egcs-1.0.2-jim.patch \
            egcs-1.0.2-haifa.patch egcs-1.0.1-objcbackend.patch \
            egcs-1.0.2-mips.patch; do patch -p1 -d < ../$i; done
      ./configure --prefix=<prefix> --with-newlib --target=<target>
      cd gcc
      make LANGUAGES="c"



  Note that we deliberately don't build gcov, protoize, unprotoize and
  the libraries.  Gcov doesn't make sense in a crosscompiler environe-
  ment and protoize and unprotoize might even overwrite your native pro-
  grams - this is a bug in the gcc makefiles.  Finally we cannot yet
  build the libraries because we don't have glibc installed yet.  If
  everything went successful install with:

      make LANGUAGES="c" install





  6.7.  float.h

  Another, bootstrap problem is that building GCC requires running
  programs on the machine that GCC will generate code for.  But since a
  crosscompiler is running on a different type of machine this cannot
  work.  When buiding GCC this happens for the header file float.h.
  Luckily there is a simple solution.  Download the header file from one
  of the Linux/MIPS ftp servers or rip it from one of the native
  Linux/MIPS binary packages.  Later when recompiling or upgrading egcs
  usually the already installed float.h file will do because float.h
  changes rarely.  Install it with:

      cp float.h <prefix>/<target/<version>/include/float.h



  where <version> is the internal version number of the egcs version
  you're using.  For egcs 1.0.2 for example you would put egcs-2.90.27
  for <version>.  If not shure - ls is your friend.



  6.8.  Installing the kernel sources

  XXX Write some simple shit for nobrainers.  If you only want the
  crosscompiler for building kernel you're done.


  6.9.  Installing GNU libc

  Do:









      gzip -cd glibc-2.0.6.tar.gz | tar xf -
      cd glibc-2.0.6
      gzip -cd glibc-crypt-2.0.6.tar.gz | tar xf -
      gzip -cd glibc-localedata-2.0.6.tar.gz | tar xf -
      gzip -cd glibc-linuxthreads-2.0.6.tar.gz | tar xf -
      patch -p1 < ../glibc-2.0.6-mips.patch
      mkdir build
      cd build
      CC=<target>-gcc BUILD_CC=gcc AR=<target>-ar RANLIB=<target>-ranlib \
            ../configure --prefix=/usr --host=<target> \
            --enable-add-ons=crypt,linuxthreads,localedata --enable-profile
      make



  You now have a compiled GNU libc which still needs to be installed.
  Do not just type make install.  That would overwrite your host sys-
  tem's files with Linux/MIPS specific files with desasterous effects.
  Instead install GNU libc into some arbitrary other directory <somedir>
  from which we'll move the part's we need for crosscompilation into the
  actual target directory:

      make install_root=<somedir> install



  Now cd into <somedir> and install finally install GNU libc manually:

      cd usr/include
      find . -print | cpio -pumd <prefix>/<target>/include
      cd ../../lib
      find . -print | cpio -pumd <prefix>/<target>/lib
      cd ../usr/lib
      find lib -print | cpio -pumd <prefix>/<target>/lib



  GNU libc also contains extensive online documentation.  Your systems
  might already have a version of this documentation installed.  So if
  you don't want to install the info pages which will save you a less
  than a megabyte or already have them installed skip the next step:
  step:

      cd ../info
      gzip -9 *.info*
      find . -name \*.info\* -print | cpio -pumd <prefix>/info



  If you're not bootstrapping you're installation is now finished.


  6.10.  Building egcs again

  The first attempt of building egcs was stopped by a not yet existent
  GNU libc.  Since we now have libc installed we can rebuild egcs but
  this time as complete as a crosscompiler installation can be:









      gzip -cd egcs-<version>.tar.gz | tar xf -
      cd egcs-<version>
      for i in egcs-1.0.2-libio.patch egcs-1.0.2-hjl.patch \
            egcs-1.0.2-rth1.patch egcs-1.0.2-rth2.patch egcs-1.0.2-rth3.patch \
            egcs-1.0.2-rth4.patch egcs-1.0.2-hjl2.patch egcs-1.0.2-jim.patch \
            egcs-1.0.2-haifa.patch egcs-1.0.1-objcbackend.patch \
            egcs-1.0.2-mips.patch; do patch -p1 < ../$i; done
      ./configure --prefix=<prefix> --target=<target>
      make LANGUAGES="c c++ objective-c f77"



  As you can see the procedure is the same as the first time with the
  exception that we dropped the --with-newlib option.  This option was
  necessary to avoid the libgcc build breaking due to the not yet
  installed libc.  Now install with:

      make LANGUAGES="c c++ objective-c f77" install



  You're almost finished.  All you'll now still have to do is to rein-
  stall float.h which has been overwritten by the last make install com-
  mand.  You'll have to do that every time you reinstall egcs as a
  crosscompiler.  If you think you don't need the Objective C or F77
  compilers you can omit them from above commands.  Each will save you
  about 3mb.  However don't build gcov, protoize and unprotoize.


  6.11.  Should I build the C++, Objective C or F77 compilers?

  The answer to this question largely depends on your use of your
  crosscompiler environment.  If you only intend to rebuild the Linux
  kernel then you have no need for the full blown setup and can safely
  omit the Objective C and F77 compilers.  You however must build the
  C++ compiler because building the libraries included with the egcs
  distribution are written in C++.






























--OXfL5xGRrasGEqWY--
