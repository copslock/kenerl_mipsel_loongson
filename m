Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA94709 for <linux-archive@neteng.engr.sgi.com>; Wed, 9 Sep 1998 16:42:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA77686
	for linux-list;
	Wed, 9 Sep 1998 16:41:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA97183
	for <linux@engr.sgi.com>;
	Wed, 9 Sep 1998 16:41:18 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03130
	for <linux@engr.sgi.com>; Wed, 9 Sep 1998 16:41:14 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA08872
	for <linux@engr.sgi.com>; Thu, 10 Sep 1998 01:41:11 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id QAA00820;
	Wed, 9 Sep 1998 16:03:00 +0200
Message-ID: <19980909160300.C423@uni-koblenz.de>
Date: Wed, 9 Sep 1998 16:03:00 +0200
From: ralf@uni-koblenz.de
To: Rob Lembree <lembree@sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Success at last...
References: <Pine.LNX.3.96.980904130745.26347A-100000@lager.engsoc.carleton.ca> <35F59FCD.F7A6E459@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <35F59FCD.F7A6E459@sgi.com>; from Rob Lembree on Tue, Sep 08, 1998 at 05:21:17PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 08, 1998 at 05:21:17PM -0400, Rob Lembree wrote:

> > This is really weird.  Can you explain in greater detail what you changed
> > to make sure that it worked?
> 
> I found that IRIX's tar wasn't very careful with modification dates,
> which I don't think is a problem, but the major and minor IDs of the
> dev files were all zero -- clearly broken.  I haven't experimented,
> but I believe this to be the failure.

This seems to indicate to me that we should replace the dev directory
with a script that creates the inodes.  Luckily we already have one which
is called ``MAKEDEV''.  As we already know the representation of the
minor / major device number isn't transparent through NFS, so the MAKEDEV
will have to detect the NFS server's OS and to corrospondingly munge the
device number used as argument for mkdev in a way that after exporting
from the NFS server the client sees what he expects to see.  If that is
at all possible in all cases.  Yuck.  But it's a longstanding problem
which before has already been reported by people using other operating
systems like HP/UX.

  Ralf
