Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA60328 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Dec 1998 23:57:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA77550
	for linux-list;
	Wed, 23 Dec 1998 23:56:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA79099
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Dec 1998 23:56:21 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA05950
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Dec 1998 23:56:20 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id IAA27579
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Dec 1998 08:56:15 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id FAA07012;
	Wed, 23 Dec 1998 05:44:41 +0100
Message-ID: <19981223054440.E6183@uni-koblenz.de>
Date: Wed, 23 Dec 1998 05:44:40 +0100
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel build problem.
References: <Pine.LNX.3.96.981222182405.22999A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.981222182405.22999A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Dec 22, 1998 at 06:26:08PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Dec 22, 1998 at 06:26:08PM -0500, Alex deVries wrote:

> So, I'm building 2.1.121 that's in cvs using egcs-2.90.27 980315 and
> binutils  2.8.1.  Both are from Rough Cuts.
> 
> Here's the error:
> 
> make[2]: Entering directory `/usr/src/linux/arch/mips/mm'
> egcs -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe
> -c -o r6000.o r6000.c
> {standard input}: Assembler messages:
> {standard input}:384: Warning: Unmatched %hi reloc
> {standard input}:487: Internal error!
> Assertion failure in tc_gen_reloc at ./config/tc-mips.c line 10203.
> Please report this bug.
> make[2]: *** [r6000.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/arch/mips/mm'

Add -mno-split-addresses to CFLAGS.  Your egcs still enables that optimization
by default.

> Any ideas on what I should do here?  Also, Ralf, are you going to upload
> 2.1.131 soon?

Somewhen, when it's working and when I'm done with more urgent non-software
things of live ...

  Ralf
