Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA12056 for <linux-archive@neteng.engr.sgi.com>; Mon, 20 Jul 1998 11:33:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA92631
	for linux-list;
	Mon, 20 Jul 1998 11:32:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA81586
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Jul 1998 11:32:37 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from ms21.hinet.net (ms21.hinet.net [168.95.4.21]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA26853
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Jul 1998 11:32:35 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1])
	by ms21.hinet.net (8.8.8/8.8.8) with ESMTP id CAA27996
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Tue, 21 Jul 1998 02:32:30 +0800 (CST)
Received: from uni-koblenz.de (ralf@pmport-18.uni-koblenz.de [141.26.249.18])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id UAA06416
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Mon, 20 Jul 1998 20:32:26 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA00744;
	Mon, 20 Jul 1998 20:32:00 +0200
Message-ID: <19980720203200.D440@uni-koblenz.de>
Date: Mon, 20 Jul 1998 20:32:00 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>,
        "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
Cc: Linux <linux%cthulhu.engr.sgi.com@ms21.hinet.net>
Subject: Re: [Q] How to reboot automatically?
References: <19980718164741.A868@life.nthu.edu.tw> <19980719041810.G489@uni-koblenz.de> <19980720041815.A298@helix.life.nthu.edu.tw> <19980719232054.A956@uni-koblenz.de> <19980720202548.A526@helix.life.nthu.edu.tw> <199807201610.JAA28042@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199807201610.JAA28042@fir.engr.sgi.com>; from William J. Earl on Mon, Jul 20, 1998 at 09:10:34AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 20, 1998 at 09:10:34AM -0700, William J. Earl wrote:

> IRIX looks at the environment when booting.  That is, it finds
> argc, argv, and envp in $a0, $a1, and $a2.  It copies them to
> private storage before starting up, since they are in memory
> which will be overlaid by dynamic memory allocation.  All of the
> NVRAM and temporary environment variables are passed via envp.
> IRIX looks for root= on the command line (in argv) first, and then
> in the environment, before falling back on a default.  linux could
> do the same.

That looks like a good idea; it can be implemented easily and nicely
within Linux.  And for transparency we should.  What will stay different
is the naming convention of Linux partitions.

The environment is allocated in ``Firmware Temporary'' memory, isn't it?
We don't free that yet but we should, for low memory configurations that
should be a significant amount of memory.

  Ralf
