Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA39415 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 10:13:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA03717
	for linux-list;
	Fri, 17 Jul 1998 10:12:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA73511
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 10:12:41 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02914
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 10:12:40 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA30519;
	Fri, 17 Jul 1998 13:12:03 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 17 Jul 1998 13:12:03 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Installing noarch packages
In-Reply-To: <199807170716.JAA24626@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980717131126.28871C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I'll get a new rpm of rpm that fixes this; I think I submitted that fix
for rpm 2.5.2 anyway. 

- alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Fri, 17 Jul 1998, Honza Pazdziora wrote:

> Date: Fri, 17 Jul 1998 09:16:10 +0200 (MET DST)
> From: Honza Pazdziora <adelton@informatics.muni.cz>
> To: Alex deVries <adevries@engsoc.carleton.ca>
> Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
> Subject: Re: Installing noarch packages
> 
> > 
> > there's a problem with /usr/lib/rpmrc then.  It should have a line like:
> > arch_compat: mipseb: noarch
> 
> This was there already.
> 
> > If that doesn't work, try adding:
> > arch_compat: mips: noarch
> 
> This fixed the problem. Thanks,
> 
> ------------------------------------------------------------------------
>  Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
>                    I can take or leave it if I please
> ------------------------------------------------------------------------
> 
