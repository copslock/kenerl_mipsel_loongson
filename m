Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA12704 for <linux-archive@neteng.engr.sgi.com>; Mon, 20 Jul 1998 11:44:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA87237
	for linux-list;
	Mon, 20 Jul 1998 11:44:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA92662
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Jul 1998 11:44:20 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: from ms21.hinet.net (ms21.hinet.net [168.95.4.21]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02043
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Jul 1998 11:44:18 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: from sgi.sgi.com (SGI.COM [192.48.153.1])
	by ms21.hinet.net (8.8.8/8.8.8) with ESMTP id CAA08176
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Tue, 21 Jul 1998 02:44:03 +0800 (CST)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01832; Mon, 20 Jul 1998 11:43:50 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA99731;
	Mon, 20 Jul 1998 11:43:49 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA28524; Mon, 20 Jul 1998 11:43:15 -0700
Date: Mon, 20 Jul 1998 11:43:15 -0700
Message-Id: <199807201843.LAA28524@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
cc: Linux <linux%cthulhu.engr.sgi.com@ms21.hinet.net>
Subject: Re: [Q] How to reboot automatically?
In-Reply-To: <19980720203200.D440@uni-koblenz.de>
References: <19980718164741.A868@life.nthu.edu.tw>
	<19980719041810.G489@uni-koblenz.de>
	<19980720041815.A298@helix.life.nthu.edu.tw>
	<19980719232054.A956@uni-koblenz.de>
	<19980720202548.A526@helix.life.nthu.edu.tw>
	<199807201610.JAA28042@fir.engr.sgi.com>
	<19980720203200.D440@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Mon, Jul 20, 1998 at 09:10:34AM -0700, William J. Earl wrote:
 > 
 > > IRIX looks at the environment when booting.  That is, it finds
 > > argc, argv, and envp in $a0, $a1, and $a2.  It copies them to
 > > private storage before starting up, since they are in memory
 > > which will be overlaid by dynamic memory allocation.  All of the
 > > NVRAM and temporary environment variables are passed via envp.
 > > IRIX looks for root= on the command line (in argv) first, and then
 > > in the environment, before falling back on a default.  linux could
 > > do the same.
 > 
 > That looks like a good idea; it can be implemented easily and nicely
 > within Linux.  And for transparency we should.  What will stay different
 > is the naming convention of Linux partitions.

     That is good, but you might consider translating incoming IRIX-format
and ARCS-format names to Linux names, just as IRIX translates ARCS-format
names to IRIX-format names.  

 > The environment is allocated in ``Firmware Temporary'' memory, isn't it?
 > We don't free that yet but we should, for low memory configurations that
 > should be a significant amount of memory.

     Yes, the environment is in firmware temporary memory, along with
a copy of the firmware.  The non-volatile environment is in the Dallas
part, but the user, via PROM or sash, may have replaced one or more
of the variables after the environment was copied to memory.

     I would guess that, depending on how the system was booted,
firmware temporary memory could be 4 MB or more, although the
actual environment and argument values are of course much smaller.
Once you free the firmware area, you can no longer use the firmware
entries (except to leave linux and reboot or halt).
