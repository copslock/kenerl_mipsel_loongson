Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA49641 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Apr 1999 23:08:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA80305
	for linux-list;
	Tue, 13 Apr 1999 23:03:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA02708
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Apr 1999 23:03:13 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA08278
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 23:03:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id CAA00637
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 02:03:19 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 14 Apr 1999 02:03:19 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Errors building...
Message-ID: <Pine.LNX.3.96.990414015809.15825C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


So, I've finally found a few minutes to catch up on the amazing recent SGI
Linux excitements... I destroyed my old kernel tree, and re imported.

Now my builds die with:

egcs -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe
-c -o r2300.o r2300.c
{standard input}: Assembler messages:
{standard input}:2486: Internal error!
Assertion failure in tc_gen_reloc at ./config/tc-mips.c line 10203.
Please report this bug.

And so here I am, dutifully reporting this bug.

I'm a bit unclear on why r2300.c is even being compiled, when clearly I
have an R4600SC, but I did set R4000 support in my .config.

- A
