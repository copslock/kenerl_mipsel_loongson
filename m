Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA83681 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Dec 1998 07:30:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA83318
	for linux-list;
	Thu, 24 Dec 1998 07:30:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA97683
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Dec 1998 07:30:03 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04864
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Dec 1998 07:30:02 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id KAA29289;
	Thu, 24 Dec 1998 10:31:16 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 24 Dec 1998 10:31:16 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel build problem.
In-Reply-To: <19981223054440.E6183@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.981224102244.27207B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 23 Dec 1998 ralf@uni-koblenz.de wrote:
> Add -mno-split-addresses to CFLAGS.  Your egcs still enables that optimization
> by default.

Alright.  That made it build.

Now when I build it and boot that kernel I get in the Command Monitor:

Exception: <vector=UTLB Miss>
Status register: 0x300004803<CU1,CU0,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
Exception PC: 0x881385cc, Exception RA: 0x88002614
exception, bad address: 0x47c4
Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: 7 8bfff938 8bfffc4d 880025dc
  tmp: 8818c14c 8818c14c 10 881510c4 14 8bfad9e0 0 48
  sve: 8bfdf3e8 8bfffc40 8bfb2720 8bfff938 a8747420 9fc56394 0 9fc56394
  t8 48 t9 8bfffee66 at 1 v0 0 v1 8bfff890 k1 bad11bad
  gp 881dfd90 fp 9fc4be88 sp 8bfff8b8 ra 88002614

PANIC: Unexpected exception

I can mail my .config if that helps.

- Alex
