Received:  by oss.sgi.com id <S305166AbQAOA40>;
	Fri, 14 Jan 2000 16:56:26 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:1393 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQAOA4M>;
	Fri, 14 Jan 2000 16:56:12 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA11997; Fri, 14 Jan 2000 16:53:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA63708
	for linux-list;
	Fri, 14 Jan 2000 16:47:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA20049
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 16:46:53 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09860
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 16:46:42 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA21540;
	Sat, 15 Jan 2000 01:46:20 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQANKoa>;
	Fri, 14 Jan 2000 11:44:30 +0100
Date:   Fri, 14 Jan 2000 11:44:30 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Soren S. Jorvang" <soren@wheel.dk>
Cc:     John Michael Clemens <clemej@rpi.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
Message-ID: <20000114114430.A4278@uni-koblenz.de>
References: <14462.24718.670816.841437@liveoak.engr.sgi.com> <Pine.A41.3.96.1000113224501.118018F-100000@vcmr-19.rcs.rpi.edu> <20000114055613.A26954@gnyf.wheel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000114055613.A26954@gnyf.wheel.dk>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Jan 14, 2000 at 05:56:13AM +0100, Soren S. Jorvang wrote:

> On Thu, Jan 13, 2000 at 10:56:25PM -0500, John Michael Clemens wrote:
> > Would there be enough in this firmware to do a basic text console?  even
> > that would be better than soldering together a serial cable to run over
> > Minicom.
> 
> You can always use the PROM callbacks for that.

In theory yes.  In practice all firmware that I've seen so far seems to
be rather fragile and for some systems also very performance limited as
it's running from uncached memory (veeeerry slooow) or at times even
from 8-bit wide PROMs which is so slow that it blows every meassure for
slowness.  Not to mention other problems.  So this should really be
considered a better than nothing solution.

That being said, Ulf Carlsson has implemented a PROM console which is
in the CVS archive.  Try it, I'm interested in reports.

  Ralf
