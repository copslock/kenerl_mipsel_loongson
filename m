Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA35271 for <linux-archive@neteng.engr.sgi.com>; Mon, 7 Sep 1998 14:45:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA16924
	for linux-list;
	Mon, 7 Sep 1998 14:44:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA79762
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 7 Sep 1998 14:44:47 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08426
	for <linux@cthulhu.engr.sgi.com>; Mon, 7 Sep 1998 14:44:44 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA01250
	for <linux@cthulhu.engr.sgi.com>; Mon, 7 Sep 1998 23:44:42 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA00945;
	Mon, 7 Sep 1998 01:23:31 +0200
Message-ID: <19980907012331.C390@uni-koblenz.de>
Date: Mon, 7 Sep 1998 01:23:31 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Carlsson <grim@ballyhoo.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: SCSI problems
References: <19980905223307.15653@alpha.franken.de> <Pine.LNX.3.96.980906104849.14540A-100000@ballyhoo.ml.org> <19980906113715.16157@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980906113715.16157@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Sep 06, 1998 at 11:37:15AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Sep 06, 1998 at 11:37:15AM +0200, Thomas Bogendoerfer wrote:

> On Sun, Sep 06, 1998 at 10:54:52AM +0200, Ulf Carlsson wrote:
> > On Sat, 5 Sep 1998, Thomas Bogendoerfer wrote:
> > Which processor do you have, e.g. which dma_cache_wback_inv procedure are
> > you making use of? 
> 
> it's a R4600 with second level cache. So it should use 
> r4k_dma_cache_wback_inv_sc(), too.

The R4600 _CPU_ doesn't support an l2 cache therefore the *_pc variants are
being used.  The l2 cache on the indy CPU module is handled by the logic on
the CPU _module_; the code to deal with that is being called by the *_pc
functions and is in arch/mips/sgi/kernel/indy_sc.c.

  Ralf
