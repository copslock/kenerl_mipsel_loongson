Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2448420 for <linux-archive@neteng.engr.sgi.com>; Tue, 31 Mar 1998 06:40:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA5987303
	for linux-list;
	Tue, 31 Mar 1998 06:39:09 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA5931045
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 31 Mar 1998 06:39:07 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA05120
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 06:39:02 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id QAA16327
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 16:38:58 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id QAA05219;
	Tue, 31 Mar 1998 16:38:50 +0200
Message-ID: <19980331163848.49537@uni-koblenz.de>
Date: Tue, 31 Mar 1998 16:38:48 +0200
To: Oliver Frommel <oliver@aec.at>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
References: <19980331091452.41730@uni-koblenz.de> <Pine.LNX.3.96.980331093700.8445C-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980331093700.8445C-100000@web.aec.at>; from Oliver Frommel on Tue, Mar 31, 1998 at 09:39:47AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 31, 1998 at 09:39:47AM +0200, Oliver Frommel wrote:

> Hi,
> 
> i forgot to add the output of xgcc compiling with -v ... 
> 
> $ ../xgcc -v -B../ -c test.c
> 
>  ../cpp -lang-c -v -isystem ../include -undef -D__GNUC__=2 -D__GNUC_MINOR__=7 -D__ELF__ -D_MIPS_SIM=_MIPS_SIM_ABI32 -D__PIC__ -D__pic__ -Dunix -Dmips -DR3000 -DMIPSEB -Dlinux -D__ELF__ -D_MIPS_SIM=_MIPS_SIM_ABI32 -D__PIC__ -D__pic__ -D__unix__ -D__mips__ 
> -D__R3000__ -D__MIPSEB__ -D__linux__ -D__unix -D__mips -D__R3000 -D__MIPSEB -D__linux -Asystem(linux) -Asystem(posix) -Acpu(mips) -Amachine(mips) -D__LANGUAGE_C__ -DLANGUAGE_C -D_MIPS_FPSET=32 -D_MIPS_ISA=_MIPS_ISA_MIPS1 -D_MIPS_SZINT=32 -D__SIZE_TYPE__=u
> nsigned int -D__SSIZE_TYPE__=int -D__PTRDIFF_TYPE__=int -D_MIPS_SZLONG=32 -D_MIPS_SZPTR=32 test.c /tmp/cca22420.i
> GNU CPP version 2.7.2 [AL 1.1, MM 40] (MIPS Linux/ELF)
> #include "..." search starts here:
> #include <...> search starts here:
>  ../include
>  /usr/lib/gcc-lib/mips-linux/2.7.2/include
>  /usr/lib/gcc-lib/mips-linux/2.7.2/sys-include
>  /usr/mips-linux/include
> End of search list.
>  ../cc1 /tmp/cca22420.i -quiet -dumpbase test.c -version -o /tmp/cca22420.s
> GNU C version 2.7.2 [AL 1.1, MM 40] (MIPS Linux/ELF) compiled by GNU C version 2.7.2.3.
>  as -v -KPIC -o test.o /tmp/cca22420.s
> GNU assembler version 2.8.1 (i686-pc-linux-gnu), using BFD version linux-2.8.1.0.1
> as: unrecognized option `-PIC'

Your crosscompiler is caling the native assembler.  Did you install binutils?
Did you configure the sources them using the same --prefix option?

  Ralf
