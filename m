Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA88292 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Dec 1998 15:25:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA60044
	for linux-list;
	Tue, 22 Dec 1998 15:24:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA72471
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 22 Dec 1998 15:24:56 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09835
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Dec 1998 15:24:55 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA24296
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Dec 1998 18:26:08 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 22 Dec 1998 18:26:08 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: kernel build problem.
Message-ID: <Pine.LNX.3.96.981222182405.22999A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


So, I'm building 2.1.121 that's in cvs using egcs-2.90.27 980315 and
binutils  2.8.1.  Both are from Rough Cuts.

Here's the error:

make[2]: Entering directory `/usr/src/linux/arch/mips/mm'
egcs -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe
-c -o r6000.o r6000.c
{standard input}: Assembler messages:
{standard input}:384: Warning: Unmatched %hi reloc
{standard input}:487: Internal error!
Assertion failure in tc_gen_reloc at ./config/tc-mips.c line 10203.
Please report this bug.
make[2]: *** [r6000.o] Error 1
make[2]: Leaving directory `/usr/src/linux/arch/mips/mm'

Any ideas on what I should do here?  Also, Ralf, are you going to upload
2.1.131 soon?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
