Received:  by oss.sgi.com id <S305165AbQAOFfK>;
	Fri, 14 Jan 2000 21:35:10 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:46450 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305155AbQAOFex>;
	Fri, 14 Jan 2000 21:34:53 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA01748; Fri, 14 Jan 2000 21:36:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA19875
	for linux-list;
	Fri, 14 Jan 2000 21:28:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA35300;
	Fri, 14 Jan 2000 21:28:14 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id VAA27135;
	Fri, 14 Jan 2000 21:28:02 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14464.1378.215834.722831@liveoak.engr.sgi.com>
Date:   Fri, 14 Jan 2000 21:28:02 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Soren S. Jorvang" <soren@wheel.dk>,
        John Michael Clemens <clemej@rpi.edu>,
        linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
In-Reply-To: <20000114114430.A4278@uni-koblenz.de>
References: <14462.24718.670816.841437@liveoak.engr.sgi.com>
	<Pine.A41.3.96.1000113224501.118018F-100000@vcmr-19.rcs.rpi.edu>
	<20000114055613.A26954@gnyf.wheel.dk>
	<20000114114430.A4278@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Fri, Jan 14, 2000 at 05:56:13AM +0100, Soren S. Jorvang wrote:
 > 
 > > On Thu, Jan 13, 2000 at 10:56:25PM -0500, John Michael Clemens wrote:
 > > > Would there be enough in this firmware to do a basic text console?  even
 > > > that would be better than soldering together a serial cable to run over
 > > > Minicom.
 > > 
 > > You can always use the PROM callbacks for that.
 > 
 > In theory yes.  In practice all firmware that I've seen so far seems to
 > be rather fragile and for some systems also very performance limited as
 > it's running from uncached memory (veeeerry slooow) or at times even
 > from 8-bit wide PROMs which is so slow that it blows every meassure for
 > slowness.  Not to mention other problems.  So this should really be
 > considered a better than nothing solution.
 > 
 > That being said, Ulf Carlsson has implemented a PROM console which is
 > in the CVS archive.  Try it, I'm interested in reports.

      On some platforms the PROM code is actually copied to main memory
and executed (cached) from there.  If I remember correctly, O2 works that
way.  Indy is probably in the slow (possibly very slow) category.
