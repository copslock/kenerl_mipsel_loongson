Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA790901 for <linux-archive@neteng.engr.sgi.com>; Wed, 8 Apr 1998 17:15:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA9448370
	for linux-list;
	Wed, 8 Apr 1998 17:14:57 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA9498628
	for <linux@engr.sgi.com>;
	Wed, 8 Apr 1998 17:14:55 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA25441
	for <linux@engr.sgi.com>; Wed, 8 Apr 1998 17:14:53 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA26568
	for <linux@engr.sgi.com>; Thu, 9 Apr 1998 02:14:44 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA13730;
	Tue, 7 Apr 1998 17:13:17 +0200
Message-ID: <19980407171317.55021@uni-koblenz.de>
Date: Tue, 7 Apr 1998 17:13:17 +0200
To: adevries@engsoc.carleton.ca
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: problem building linux
References: <199804061845.LAA813915@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804061845.LAA813915@oz.engr.sgi.com>; from Ariel Faigon on Mon, Apr 06, 1998 at 11:45:47AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Apr 06, 1998 at 11:45:47AM -0700, Ariel Faigon wrote:

> Ralf,
> 
> This bounced recently from the list...
> anyway, you may be the main interested party so....

> ----- Forwarded message from owner-linux@cthulhu -----
> 
> Date: Mon, 6 Apr 1998 09:46:26 -0700 (PDT)
> Message-Id: <199804061646.JAA8401229@cthulhu.engr.sgi.com>
> To: owner-linux@cthulhu
> Subject: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from [Alex deVries <adevries@engsoc.carleton.ca>]   Message too long (>40000 chars)  
> 

> Message-ID: <Pine.LNX.3.95.980406123416.19893D-100000@lager.engsoc.carleton.ca>

Alex, are you subscribed as adevries@lager.engsoc.carleton.ca?  That'll
bounce.

> When I boot, I get the following error (copied by hand):
> Command Monitor.   Type "exit" or click on "done" to return to the menu.
> >> boot vmlinux91a
> 115360+19584+334528+42744d+4248+6368 entry: 0x8bfa8850
> 
> Exception: <vector=UTLB Miss>
> Status register: 0x30004803<CUI,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
> Exception PC: 0x8813eb40, Exception RA: 0x88000253c
> exception, bad address: 0x7c
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
>   Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>   arg: 7 8bfff938 8bfffc40 8800250c
>   tmp: 881928c 88192c8c 10 88147c8c 14 8bfad9e0 0 48
>   sve: 8bfdf3e8 8bfffc40 8bfb2720 ...
> 
> <snip>
> PANIC: Unexpection exception

If you are using binutils 2.8.1, then please try removing the ``-N'' flag
from the definition for LINKFLAGS in arch/mips/Makefile.  The ELF section
to segment layout is broken when using -N.

  Ralf
