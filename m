Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA88663 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 17:40:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA96156
	for linux-list;
	Wed, 17 Jun 1998 17:39:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA12926;
	Wed, 17 Jun 1998 17:39:36 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id RAA10445; Wed, 17 Jun 1998 17:39:34 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA23249;
	Wed, 17 Jun 1998 20:39:26 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 17 Jun 1998 20:39:26 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: ralf@uni-koblenz.de, ariel@cthulhu.engr.sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: (fwd) linux SEGV details (another one)
In-Reply-To: <199806172156.XAA07993@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980617203842.8736P-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 17 Jun 1998, Honza Pazdziora wrote:
> > > I have noticed another problem. Linux happily mounts the same
> > > swap-file twice and if the system needs to swap, kswapd starts to run
> > > at 60% CPU (or more) and the system slows down to death.
> > On what kernel did this happen?  Some Linux kernels in the 2.1.x series
> 2.1.99 from the RH 5.1 Alpha 1 distribution (the original /vmlinux).

I am guilty of not having released a kernel that contains System.map and
.config with it;  I'll correct this.

- Alex
