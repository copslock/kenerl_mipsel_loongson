Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA06571 for <linux-archive@neteng.engr.sgi.com>; Mon, 14 Sep 1998 16:44:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA63390
	for linux-list;
	Mon, 14 Sep 1998 16:42:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA43021
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Sep 1998 16:42:58 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06026
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Sep 1998 16:42:52 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA24018
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Sep 1998 01:42:49 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA02747;
	Tue, 15 Sep 1998 01:42:36 +0200
Message-ID: <19980915014236.A2707@uni-koblenz.de>
Date: Tue, 15 Sep 1998 01:42:36 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: SCSI problem solved
References: <19980913003802.06252@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980913003802.06252@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Sep 13, 1998 at 12:38:02AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Sep 13, 1998 at 12:38:02AM +0200, Thomas Bogendoerfer wrote:

> Right now I'm doing some stress test with my Indy (dd from DAT and untaring
> a tar file from one disk to another at the same time). And it hasn't crashed.
> Below is the patch I'm using. If it works for others too, I'll check it in.

Side effect: lmbench says disk write bandwidth has roughly trippled.

  Ralf
