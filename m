Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA87729 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Dec 1998 16:36:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA17956
	for linux-list;
	Fri, 25 Dec 1998 16:35:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA31204
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Dec 1998 16:35:38 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04608
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Dec 1998 16:35:37 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA10818
	for <linux@cthulhu.engr.sgi.com>; Sat, 26 Dec 1998 01:35:34 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id SAA05352;
	Fri, 25 Dec 1998 18:14:41 +0100
Message-ID: <19981225181440.C4641@uni-koblenz.de>
Date: Fri, 25 Dec 1998 18:14:40 +0100
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel build problem.
References: <19981223054440.E6183@uni-koblenz.de> <Pine.LNX.3.96.981224102244.27207B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.981224102244.27207B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Thu, Dec 24, 1998 at 10:31:16AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 24, 1998 at 10:31:16AM -0500, Alex deVries wrote:

> On Wed, 23 Dec 1998 ralf@uni-koblenz.de wrote:
> > Add -mno-split-addresses to CFLAGS.  Your egcs still enables that optimization
> > by default.
> 
> Alright.  That made it build.
> 
> Now when I build it and boot that kernel I get in the Command Monitor:
> 
> Exception: <vector=UTLB Miss>
> Status register: 0x300004803<CU1,CU0,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
> Exception PC: 0x881385cc, Exception RA: 0x88002614
> exception, bad address: 0x47c4
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
>   Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>   arg: 7 8bfff938 8bfffc4d 880025dc
>   tmp: 8818c14c 8818c14c 10 881510c4 14 8bfad9e0 0 48
>   sve: 8bfdf3e8 8bfffc40 8bfb2720 8bfff938 a8747420 9fc56394 0 9fc56394
>   t8 48 t9 8bfffee66 at 1 v0 0 v1 8bfff890 k1 bad11bad
>   gp 881dfd90 fp 9fc4be88 sp 8bfff8b8 ra 88002614
> 
> PANIC: Unexpected exception

>clickety faq<

[...]
  5.2.  Self compiled kernels crash when booting.

  When I build my own kernel and it crashes.  On an Indy the crash
  message looks like the following but the same problem hits other
  machines as well and there what happens may look completly different.


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




  This problem is caused by a still unfixed bug in Binutils newer than
  version 2.7.  As a workaround, remove the -N flags from LDFLAGS in
  arch/mips/Makefile and relink the kernel.
[...]

  Ralf
