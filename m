Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA12311; Mon, 7 Jul 1997 09:21:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA23017 for linux-list; Mon, 7 Jul 1997 09:21:41 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA23012 for <linux@cthulhu.engr.sgi.com>; Mon, 7 Jul 1997 09:21:39 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA00729
	for <linux@cthulhu.engr.sgi.com>; Mon, 7 Jul 1997 09:21:37 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id MAA29746;
	Mon, 7 Jul 1997 12:21:35 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id MAA20927; Mon, 7 Jul 1997 12:19:28 -0400
Date: Mon, 7 Jul 1997 12:19:28 -0400
Message-Id: <199707071619.MAA20927@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199707071610.SAA28936@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Mon, 7 Jul 1997 18:10:24 +0200 (MET DST))
Subject: Re: MIPS Distribution status (Was: Status ...)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
   Date: Mon, 7 Jul 1997 18:10:24 +0200 (MET DST)

    - Package doesn't build for unknown reasons:
       Emacs getty_ps e2fsprogs bdflush 

Emacs should build strictly out of the box in an of itself, I know
because I specifically sent RMS patches for linux-mips support the
moment I got it working last summer with GLIBC.  (I even then logged
in to the gnu project machines and made sure those changes made it
into his tree ;-)

If it isn't compiling at all, tell me how it is failing.
