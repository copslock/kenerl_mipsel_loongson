Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA13320 for <linux-archive@neteng.engr.sgi.com>; Mon, 20 Jul 1998 12:13:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA81884
	for linux-list;
	Mon, 20 Jul 1998 12:13:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA23440;
	Mon, 20 Jul 1998 12:11:59 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA13810; Mon, 20 Jul 1998 12:11:49 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-18.uni-koblenz.de [141.26.249.18])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA10154;
	Mon, 20 Jul 1998 21:11:34 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA00852;
	Mon, 20 Jul 1998 21:11:29 +0200
Message-ID: <19980720211128.F440@uni-koblenz.de>
Date: Mon, 20 Jul 1998 21:11:28 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: [Q] How to reboot automatically?
References: <19980718164741.A868@life.nthu.edu.tw> <19980719041810.G489@uni-koblenz.de> <19980720041815.A298@helix.life.nthu.edu.tw> <19980719232054.A956@uni-koblenz.de> <19980720202548.A526@helix.life.nthu.edu.tw> <199807201610.JAA28042@fir.engr.sgi.com> <19980720203200.D440@uni-koblenz.de> <199807201843.LAA28524@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199807201843.LAA28524@fir.engr.sgi.com>; from William J. Earl on Mon, Jul 20, 1998 at 11:43:15AM -0700
X-Mutt-References: <199807201843.LAA28524@fir.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 20, 1998 at 11:43:15AM -0700, William J. Earl wrote:

>  > That looks like a good idea; it can be implemented easily and nicely
>  > within Linux.  And for transparency we should.  What will stay different
>  > is the naming convention of Linux partitions.
> 
>      That is good, but you might consider translating incoming IRIX-format
> and ARCS-format names to Linux names, just as IRIX translates ARCS-format
> names to IRIX-format names.  
> 
>  > The environment is allocated in ``Firmware Temporary'' memory, isn't it?
>  > We don't free that yet but we should, for low memory configurations that
>  > should be a significant amount of memory.
> 
>      Yes, the environment is in firmware temporary memory, along with
> a copy of the firmware.  The non-volatile environment is in the Dallas
> part, but the user, via PROM or sash, may have replaced one or more
> of the variables after the environment was copied to memory.
> 
>      I would guess that, depending on how the system was booted,
> firmware temporary memory could be 4 MB or more, although the
> actual environment and argument values are of course much smaller.
> Once you free the firmware area, you can no longer use the firmware
> entries (except to leave linux and reboot or halt).

Once I enable the L2 caches of the R4600SC and R5000SC modules I can't use
the firmware any longer anyway, the machine just crashes.  So not much
of a loss anyway.

  Ralf
