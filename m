Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA2437414 for <linux-archive@neteng.engr.sgi.com>; Mon, 30 Mar 1998 23:40:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id XAA5755299
	for linux-list;
	Mon, 30 Mar 1998 23:39:55 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA5842547
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 30 Mar 1998 23:39:53 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id XAA09038
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Mar 1998 23:39:51 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id JAA09403 for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 09:39:47 +0200
Date: Tue, 31 Mar 1998 09:39:47 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
In-Reply-To: <19980331091452.41730@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980331093700.8445C-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

i forgot to add the output of xgcc compiling with -v ... 

$ ../xgcc -v -B../ -c test.c

 ../cpp -lang-c -v -isystem ../include -undef -D__GNUC__=2 -D__GNUC_MINOR__=7 -D__ELF__ -D_MIPS_SIM=_MIPS_SIM_ABI32 -D__PIC__ -D__pic__ -Dunix -Dmips -DR3000 -DMIPSEB -Dlinux -D__ELF__ -D_MIPS_SIM=_MIPS_SIM_ABI32 -D__PIC__ -D__pic__ -D__unix__ -D__mips__ 
-D__R3000__ -D__MIPSEB__ -D__linux__ -D__unix -D__mips -D__R3000 -D__MIPSEB -D__linux -Asystem(linux) -Asystem(posix) -Acpu(mips) -Amachine(mips) -D__LANGUAGE_C__ -DLANGUAGE_C -D_MIPS_FPSET=32 -D_MIPS_ISA=_MIPS_ISA_MIPS1 -D_MIPS_SZINT=32 -D__SIZE_TYPE__=u
nsigned int -D__SSIZE_TYPE__=int -D__PTRDIFF_TYPE__=int -D_MIPS_SZLONG=32 -D_MIPS_SZPTR=32 test.c /tmp/cca22420.i
GNU CPP version 2.7.2 [AL 1.1, MM 40] (MIPS Linux/ELF)
#include "..." search starts here:
#include <...> search starts here:
 ../include
 /usr/lib/gcc-lib/mips-linux/2.7.2/include
 /usr/lib/gcc-lib/mips-linux/2.7.2/sys-include
 /usr/mips-linux/include
End of search list.
 ../cc1 /tmp/cca22420.i -quiet -dumpbase test.c -version -o /tmp/cca22420.s
GNU C version 2.7.2 [AL 1.1, MM 40] (MIPS Linux/ELF) compiled by GNU C version 2.7.2.3.
 as -v -KPIC -o test.o /tmp/cca22420.s
GNU assembler version 2.8.1 (i686-pc-linux-gnu), using BFD version linux-2.8.1.0.1
as: unrecognized option `-PIC'


-oliver
