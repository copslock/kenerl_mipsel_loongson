Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA39469 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 10:13:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA42911
	for linux-list;
	Fri, 17 Jul 1998 10:13:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA24930
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 10:13:20 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA03345
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 10:13:17 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA30548;
	Fri, 17 Jul 1998 13:13:03 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 17 Jul 1998 13:13:03 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: dliu@npiww.com, linux@cthulhu.engr.sgi.com
Subject: Re: Message while mounting NFS
In-Reply-To: <199807170750.JAA25556@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980717131220.28871D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'll create appropriate updates to fix this.  That should be a piece of
cake.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Fri, 17 Jul 1998, Honza Pazdziora wrote:

> Date: Fri, 17 Jul 1998 09:50:24 +0200 (MET DST)
> From: Honza Pazdziora <adelton@informatics.muni.cz>
> To: Alex deVries <adevries@engsoc.carleton.ca>
> Cc: dliu@npiww.com, adelton@informatics.muni.cz,
>     linux@cthulhu.engr.sgi.com
> Subject: Re: Message while mounting NFS
> 
> > 
> > On Thu, 16 Jul 1998, Dong Liu wrote:
> > > I think this is a bug of red hat system (BTW, where I can send them this bug
> > > report?), portmapper is started after nfsfs, it should be started before
> > > nfsfs.
> > 
> > Does starting portmapper before nfsfs actually work for you?  I still had
> 
> Thanks to all. Yes, installing portmap-4.0-11.mipseb.rpm and moving
> S40portmap do S14portmap fixes the problem.
> 
> ------------------------------------------------------------------------
>  Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
>                    I can take or leave it if I please
> ------------------------------------------------------------------------
> 
