Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA308423 for <linux-archive@neteng.engr.sgi.com>; Tue, 27 Jan 1998 22:13:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA07804 for linux-list; Tue, 27 Jan 1998 22:09:35 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA07786 for <linux@engr.sgi.com>; Tue, 27 Jan 1998 22:09:29 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA25220
	for <linux@engr.sgi.com>; Tue, 27 Jan 1998 22:09:27 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id HAA09324
	for <linux@engr.sgi.com>; Wed, 28 Jan 1998 07:09:25 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA08171;
	Wed, 28 Jan 1998 02:27:37 +0100
Message-ID: <19980128022737.36152@uni-koblenz.de>
Date: Wed, 28 Jan 1998 02:27:37 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Mips Magnum and Linux
References: <199801272051.PAA03145@hp817.speedware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801272051.PAA03145@hp817.speedware.com>; from Chris. Rupnik on Tue, Jan 27, 1998 at 03:51:58PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 27, 1998 at 03:51:58PM -0500, Chris. Rupnik wrote:

>  I noticed that the latest news page was updated yesterday, so i was wondering
>  if one of you had a little more time to perhaps guide me along in starting
>  a big endian port of linux for the mips magnum?

Actually the big endian port should be pretty much straight forward because
Linux is already running on big endian machines.  What would need to be
done is:

 - You'll have to implement a new boot strategy for the machine.  The way
   it is being done for the other machines won't work because the big
   endian Magnum uses a different firmware.

   Q: is there any documentation available about the firmware used for the
   big endian Magnum 4000?  Is it the same firmware as the old pre-ARC
   firmware for SGIs?  What type of disk partitions do the old firmware
   rsp. the RISC/os use?  (Sun style disklabels or ???)

   Cc to linux@engr where the real Magnum gurus are.

 - possibly fixing endianess related bugs in the code.  The kernel runs
   on big endian machines however the Magnum specific code and drivers
   have only be tested on little endian machines

 - No work will have to be done on userland.

 - Caveat: the DMA engine in the Magnum does not know about the byteorder.
   The Magnum is actually designed as a little endian machine.  If you're
   running the Magnum in big endian mode the DMA engine will read from
   memory in 64 bit chunks but not swap the byteorder as it would have to.

   This means data will correctly be read/written from/to the disk but
   media will not be exchangeable with other systems.  A possible workaround
   would be to swap the buffers in software, but that's a performance problem
   for fast devices like hard disks.

   So initially you can just ignore the problem as long as you don't want to
   exchange data with other systems via exchangable media.

  Ralf
