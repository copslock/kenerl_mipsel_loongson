Received:  by oss.sgi.com id <S305182AbQCVXki>;
	Wed, 22 Mar 2000 15:40:38 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:28970 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305174AbQCVXka>;
	Wed, 22 Mar 2000 15:40:30 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA10862; Wed, 22 Mar 2000 15:35:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA50578
	for linux-list;
	Wed, 22 Mar 2000 15:16:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA81145
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Mar 2000 15:16:10 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05029
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Mar 2000 15:16:08 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-5.uni-koblenz.de (cacc-5.uni-koblenz.de [141.26.131.5])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA28539;
	Thu, 23 Mar 2000 00:16:05 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407911AbQCVTUb>;
	Wed, 22 Mar 2000 20:20:31 +0100
Date:   Wed, 22 Mar 2000 20:20:31 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Richard <richardh@penguin.nl>
Cc:     "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: homemade kernel
Message-ID: <20000322202031.A9050@uni-koblenz.de>
References: <38D8C418.FAA1CC71@penguin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38D8C418.FAA1CC71@penguin.nl>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 22, 2000 at 02:01:13PM +0100, Richard wrote:

> Why is it, that with the latest repository sources,  i still get this:
> 
>   Exception: <vector=UTLB Miss>
>    Status register: 0x300004803<CU1,CU0,IM4,IPL=???,MODE=KERNEL,EXL,IE>
>    Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
>    Exception PC: 0x881385cc, Exception RA: 0x88002614
>    exception, bad address: 0x47c4
>    Local I/O interrupt register 1: 0x80 <VR/GIO2>
>    Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>      arg: 7 8bfff938 8bfffc4d 880025dc
>      tmp: 8818c14c 8818c14c 10 881510c4 14 8bfad9e0 0 48
>      sve: 8bfdf3e8 8bfffc40 8bfb2720 8bfff938 a8747420 9fc56394 0
> 9fc56394
>      t8 48 t9 8bfffee66 at 1 v0 0 v1 8bfff890 k1 bad11bad
>      gp 881dfd90 fp 9fc4be88 sp 8bfff8b8 ra 88002614
> 
>    PANIC: Unexpected exception
> 
> 
> I checked the arch/mips/Makefile for the linkflags, but there's no -N
> there. Has it gone to some other place ?

There have been various changes by other people working on non-Indy
targets that haven't been tested on silicon.  Similar I didn't test the
last kernel merges on silicon but only made sure they compile.  Will
try it and fix asap ...

  Ralf
