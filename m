Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA10665 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 12:08:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA91085
	for linux-list;
	Wed, 14 Apr 1999 12:06:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA71944
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Apr 1999 12:06:53 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from aw.ivm.net (mail.ivm.net [195.78.161.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA03265
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 12:06:51 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port16.koeln.ivm.de [195.247.239.16])
	by aw.ivm.net (8.8.8/8.8.8) with ESMTP id VAA25418;
	Wed, 14 Apr 1999 21:06:23 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990414210905.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.3.96.990414015809.15825C-100000@lager.engsoc.carleton.ca>
Date: Wed, 14 Apr 1999 21:09:05 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Subject: RE: Errors building...
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

On 14-Apr-99 Alex deVries wrote:
> 
> So, I've finally found a few minutes to catch up on the amazing recent
> SGI
> Linux excitements... I destroyed my old kernel tree, and re imported.
> 
> Now my builds die with:
> 
> egcs -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2
> -pipe
> -c -o r2300.o r2300.c
> {standard input}: Assembler messages:
> {standard input}:2486: Internal error!
> Assertion failure in tc_gen_reloc at ./config/tc-mips.c line 10203.
> Please report this bug.
> 
> And so here I am, dutifully reporting this bug.

Strange, works fine on my end. Anyone else seeing this?
 
> I'm a bit unclear on why r2300.c is even being compiled, when clearly I
> have an R4600SC, but I did set R4000 support in my .config.

That's normal and always has been so. The goal is to be able to build
generic kernel, i.e. kernels which work on R3000 *and* higher CPUs.

---
Regards,
Harald
