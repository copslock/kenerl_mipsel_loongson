Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA2315412 for <linux-archive@neteng.engr.sgi.com>; Mon, 30 Mar 1998 05:43:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id FAA5403835
	for linux-list;
	Mon, 30 Mar 1998 05:43:01 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA5503244
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 30 Mar 1998 05:42:54 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id FAA07096
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Mar 1998 05:42:50 -0800 (PST)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id PAA26303;
	Mon, 30 Mar 1998 15:42:48 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id PAA29886; Mon, 30 Mar 1998 15:42:45 +0200
Message-ID: <19980330154244.19782@uni-koblenz.de>
Date: Mon, 30 Mar 1998 15:42:44 +0200
From: ralf@uni-koblenz.de
To: Oliver Frommel <oliver@aec.at>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
References: <Pine.LNX.3.96.980330093827.20663A-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.980330093827.20663A-100000@web.aec.at>; from Oliver Frommel on Mon, Mar 30, 1998 at 09:42:56AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Mar 30, 1998 at 09:42:56AM +0200, Oliver Frommel wrote:

> i got the kernel (linux-980326) from linux.sgi.com and had the following
> problems crosscompiling it from intel-linux (which appeared on list once, but
> without any answer/solution as far as i remember):
> 
> mips-linux-gcc -D__KERNEL__ -I/mnt/dsk1/devel/mips/linux-980326/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
> entry.S: Assembler messages:
> entry.S:147: Error: .previous without corresponding .section; ignored
> entry.S:147: Error: .previous without corresponding .section; ignored
> entry.S:148: Error: .previous without corresponding .section; ignored
> entry.S:148: Error: .previous without corresponding .section; ignored
> entry.S:154: Error: .previous without corresponding .section; ignored
> entry.S:154: Error: .previous without corresponding .section; ignored
> entry.S:156: Error: .previous without corresponding .section; ignored
> entry.S:156: Error: .previous without corresponding .section; ignored
> entry.S:157: Error: .previous without corresponding .section; ignored
> entry.S:157: Error: .previous without corresponding .section; ignored
> entry.S:158: Error: .previous without corresponding .section; ignored
> entry.S:158: Error: .previous without corresponding .section; ignored
> make[1]: *** [entry.o] Error 1
> make[1]: Leaving directory `/mnt/dsk1/devel/mips/linux-980326/arch/mips/kernel'
> make: *** [linuxsubdirs] Error 2
> 
> 
> i'd appreciate an explanation what's happening here very much ..

In the vanilla FSF sources the .previous pseudo is broken resulting in
these messages.  The fix is in 2.7-4 and newer.

  Ralf
