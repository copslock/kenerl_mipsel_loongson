Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA23006 for <linux-archive@neteng.engr.sgi.com>; Mon, 31 Aug 1998 16:28:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA74113
	for linux-list;
	Mon, 31 Aug 1998 16:28:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA44238
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Aug 1998 16:28:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09759
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Aug 1998 16:28:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA28553
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Sep 1998 01:27:49 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA01072;
	Tue, 1 Sep 1998 01:26:27 +0200
Message-ID: <19980901012626.C843@uni-koblenz.de>
Date: Tue, 1 Sep 1998 01:26:26 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
References: <Pine.LNX.3.96.980831184941.15439A-100000@calypso.saturn> <19980901001911.30136@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980901001911.30136@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Sep 01, 1998 at 12:19:11AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 01, 1998 at 12:19:11AM +0200, Thomas Bogendoerfer wrote:

> On Mon, Aug 31, 1998 at 06:56:10PM +0200, Ulf Carlsson wrote:
> > Hi,
> > Has someone managed to mount a CD yet?
> 
> my Indy doesn't have a CDrom drive. But it works on my M700. So it's
> probably related to the scsi low level driver. Ralf mentioned some
> problems with DAT, but that could also be a generic problem.

DAT and a couple more of the wd33c93 driver options available via the
kernel command line.  I wouldn't wonder if a CDROM or second disk results
in the same sick effects.

Somebody recently offered to take a look on driver issues, any success
yet?

  Ralf
