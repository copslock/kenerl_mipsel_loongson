Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 09:38:13 +0100 (BST)
Received: from verden.pvv.ntnu.no ([IPv6:::ffff:129.241.210.224]:16146 "HELO
	verden.pvv.ntnu.no") by linux-mips.org with SMTP
	id <S8225214AbTFBIiL>; Mon, 2 Jun 2003 09:38:11 +0100
Received: (qmail 72864 invoked by uid 23199); 2 Jun 2003 08:38:08 -0000
Date: Mon, 2 Jun 2003 10:38:08 +0200 (CEST)
From: Bjorn Hanch Sollie <bhs@pvv.org>
X-X-Sender: bhs@verden.pvv.ntnu.no
To: linux-mips@linux-mips.org
Subject: MIPSPro + GCC
Message-ID: <Pine.BSF.4.52.0306021029350.72800@verden.pvv.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <bhs@pvv.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhs@pvv.org
Precedence: bulk
X-list: linux-mips

Hi all,

Does anyone here have an idea about what it takes to link my MIPSPro
compiled program (MIPSPro 7.4) to a gcc built library (GCC 3.2.2)?  I
will be very thankful for suggestions on how to resolve the FATAL 52
below.  I suspect this might be a compiler/linker bug, since I at no
point specify the -fini option, and I'm not attempting to build a
driver or resident module (just a regular dso). (In case anyone is
wondering, the library I'm linking against is the ITK segmentation and
registration toolkit, http://www.itk.org/.)

Thanks in advance for any help!

-Beorn

bjorns@octane:~/Surge/Segmentation/demo:$ make
        ld -o seg InputOutput.o  Levelset.o  Lumen3DSegment.o  Thrombus2DSegment.o  Thrombus3DSegment.o  Segment.o  main.o -L/usr/lib32/mips3  -L/usr/lib32  -L/lib32  -L/lib  -L/oslo/people/bjorns/src/Surge/lib  -L/oslo/people/bjorns/Surge/lib/ITK -lITKAlgorithms  -lITKBasicFilters  -lITKCommon  -lITKFEM  -lITKIO  -lITKMetaIO  -lITKNumerics  -lITKStatistics  -lVXLNumerics  -litkpng  -litkzlib -cxx -n32 -nostdlib -abi
ld32: WARNING 84 : /oslo/people/bjorns/Surge/lib/ITK/libITKAlgorithms.so is not used for resolving any symbol.
ld32: WARNING 84 : /oslo/people/bjorns/Surge/lib/ITK/libITKBasicFilters.so is not used for resolving any symbol.
ld32: WARNING 84 : /oslo/people/bjorns/Surge/lib/ITK/libITKFEM.so is not used for resolving any symbol.
ld32: WARNING 84 : /oslo/people/bjorns/Surge/lib/ITK/libITKNumerics.so is not used for resolving any symbol.
ld32: WARNING 84 : /oslo/people/bjorns/Surge/lib/ITK/libITKStatistics.so is not used for resolving any symbol.
ld32: FATAL   52 : _fini specified for -fini is not defined in the current object.
*** Error code 4 (bu21)
bjorns@octane:~/Surge/Segmentation/demo:$ ld -V
ld32: INFO    153: Version 7.4.
ld32: INFO    46 : No objects linked.
bjorns@octane:~/Surge/Segmentation/demo:$ g++ --version
g++ (GCC) 3.2.2
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

bjorns@octane:~/Surge/Segmentation/demo:$ CC -version
MIPSpro Compilers: Version 7.4
bjorns@octane:~/Surge/Segmentation/demo:$

-Beorn
-- 
Truth is often just a widely held opinion.


-- 
Truth is often just a widely held opinion.
