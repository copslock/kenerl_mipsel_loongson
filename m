Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA612496 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Sep 1997 22:44:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA09942 for linux-list; Tue, 2 Sep 1997 22:44:19 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA09934 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 22:44:16 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA07377
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 22:44:14 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id BAA16207; Wed, 3 Sep 1997 01:44:34 -0400
Date: Wed, 3 Sep 1997 01:44:34 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Booting off of sdb1...
In-Reply-To: <199709022358.SAA19505@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970903010816.4040B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 2 Sep 1997, Miguel de Icaza wrote:
> You need to get the binutils tar file as it was made available on
> ftp.linux.sgi.com, not the cross-compiler kit, nor the 2.8.1 release
> from the FSF.  

Okay, I'm getting closer.

I believe the correct version is binutils-2.7.tar.gz, patched with
ftp://ftp.linux.sgi.com/pub/src/binutils/binutils-2.7-4.diff.gz.  I'd have
used the patch for binutils-2.7.0.6, but I can't find the original
anywhere.

I did a ./configure --target=mips-big-linux (since mips-unknown-linux
produces a functional little endian binutils, which is useless for my
Indy).

I end up with this error when I compile binutils:

gcc -O2    -g  -DTARGET_BYTES_BIG_ENDIAN  -o as.new targ-cpu.o
obj-format.o atof-targ.o app.o as.o atof-generic.o bignum-copy.o cond.o
expr.o flonum-konst.o flonum-copy.o flonum-mult.o frags.o hash.o
input-file.o input-scrub.o literal.o messages.o output-file.o read.o
subsegs.o symbols.o write.o listing.o ecoff.o stabs.o sb.o macro.o
e-mipself.o  -L.../opcodes -lopcodes -L../bfd -lbfd
../libiberty/libiberty.a 
targ-cpu.o: In function `md_begin':
/home/binutils-2.7/gas/targ-cpu.c:826: undefined reference to
`bfd_mips_elf_swap_options_out'
targ-cpu.o: In function `mips_elf_final_processing':
/home/binutils-2.7/gas/targ-cpu.c:7863: undefined reference to
`bfd_mips_elf32_swap_reginfo_out'
/home/binutils-2.7/gas/targ-cpu.c:7879: undefined reference to
`bfd_mips_elf64_swap_reginfo_out'
make[1]: *** [as.new] Error 1
make[1]: Leaving directory `/home/binutils-2.7/gas'
make: *** [all-gas] Error 2

NB:  There's no problem with compiling with --target=mips-unknown-linux.

Ideas?  How have other people gotten around this?

Thanks for getting me started again, Miguel.

- Alex
