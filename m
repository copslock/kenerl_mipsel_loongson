Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id CAA31437; Wed, 6 Aug 1997 02:43:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA13568 for linux-list; Wed, 6 Aug 1997 02:42:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA13554 for <linux@cthulhu.engr.sgi.com>; Wed, 6 Aug 1997 02:42:32 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA25341
	for <linux@cthulhu.engr.sgi.com>; Wed, 6 Aug 1997 02:42:21 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id LAA13489; Wed, 6 Aug 1997 11:42:06 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708060942.LAA13489@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id LAA07368; Wed, 6 Aug 1997 11:42:03 +0200
Subject: Re: Kernel instructions...
To: schaefer@dsai.com (Mark Schaefer)
Date: Wed, 6 Aug 1997 11:42:02 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9708050920.ZM6923@ratbert.daic.dsai.com> from "Mark Schaefer" at Aug 5, 97 09:20:19 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 	Are there any further instructions on how to install the Linux kernel
> after it's been compiled?  I know IRIX will automatically install unix.new on
> bootup, is there some method like that to use?  Is there a reason MILO is
> included on the ftp site?

The way the kernel needs to be installed depends from the particular
machine.  On the little endian machines we use a two stage boot process,
the kernel loads Milo, then Milo load the kernel possibly other files,
then runs it.  You might also need something like Milo because your old
M120's firmware expects (at least I believe that ...) ECOFF exectuables,
while the kernel is being built as an ELF executable.  Milo won't work
on the M120 firmware, though because it has a different firmware, but
this shouldn't be tooo hard to fix.

Maybe one of the SGI or ex-Mips people on this list knows more about that
firmware.  Is it similar or identical to pre-ARC SGI firmware as I suppose?

  Ralf
