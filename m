Received:  by oss.sgi.com id <S305165AbQAOMDJ>;
	Sat, 15 Jan 2000 04:03:09 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:5162 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305155AbQAOMCr>;
	Sat, 15 Jan 2000 04:02:47 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA07284; Sat, 15 Jan 2000 04:04:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA38386
	for linux-list;
	Sat, 15 Jan 2000 03:54:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA08415;
	Sat, 15 Jan 2000 03:53:54 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01596; Sat, 15 Jan 2000 03:53:48 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-29.uni-koblenz.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id MAA12375;
	Sat, 15 Jan 2000 12:53:29 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAOLr0>;
	Sat, 15 Jan 2000 12:47:26 +0100
Date:   Sat, 15 Jan 2000 12:47:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     "Soren S. Jorvang" <soren@wheel.dk>,
        John Michael Clemens <clemej@rpi.edu>,
        linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
Message-ID: <20000115124726.B11241@uni-koblenz.de>
References: <14462.24718.670816.841437@liveoak.engr.sgi.com> <Pine.A41.3.96.1000113224501.118018F-100000@vcmr-19.rcs.rpi.edu> <20000114055613.A26954@gnyf.wheel.dk> <20000114114430.A4278@uni-koblenz.de> <14464.1378.215834.722831@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <14464.1378.215834.722831@liveoak.engr.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Jan 14, 2000 at 09:28:02PM -0800, William J. Earl wrote:

>  > In theory yes.  In practice all firmware that I've seen so far seems to
>  > be rather fragile and for some systems also very performance limited as
>  > it's running from uncached memory (veeeerry slooow) or at times even
>  > from 8-bit wide PROMs which is so slow that it blows every meassure for
>  > slowness.  Not to mention other problems.  So this should really be
>  > considered a better than nothing solution.
>  > 
>  > That being said, Ulf Carlsson has implemented a PROM console which is
>  > in the CVS archive.  Try it, I'm interested in reports.
> 
>       On some platforms the PROM code is actually copied to main memory
> and executed (cached) from there.  If I remember correctly, O2 works that
> way.  Indy is probably in the slow (possibly very slow) category.

Running from a PROM would explain why the Indy firmware crashes with
enabled L2 caches - the circuitry just wasn't designed to deal with the
type of access cycles (bursts?) as used by the l2 cache controller.
No major problem in practice.

  Ralf
