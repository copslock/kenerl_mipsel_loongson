Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA05431 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 22:28:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA10836
	for linux-list;
	Thu, 16 Jul 1998 22:28:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA02771
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 22:28:26 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA04737
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 22:28:25 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA12871;
	Fri, 17 Jul 1998 01:28:20 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 17 Jul 1998 01:28:19 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Dong Liu <dliu@npiww.com>
cc: Honza Pazdziora <adelton@informatics.muni.cz>, linux@cthulhu.engr.sgi.com
Subject: Re: Message while mounting NFS
In-Reply-To: <199807161738.NAA17076@pluto.npiww.com>
Message-ID: <Pine.LNX.3.95.980717012619.5792C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 16 Jul 1998, Dong Liu wrote:
> I think this is a bug of red hat system (BTW, where I can send them this bug
> report?), portmapper is started after nfsfs, it should be started before
> nfsfs.

Does starting portmapper before nfsfs actually work for you?  I still had
NFS client problems on my HH install (although the client works somewhat
better on my totally custom and hacked install).

You don't mail them to redhat, you mail them to me or the list... redhat
doesn't really have anything to do with it apart from selling this and us
using their source.

- Alex
