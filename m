Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA95122 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 16:51:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA73941
	for linux-list;
	Wed, 15 Jul 1998 16:50:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA69567
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 16:50:40 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA13529
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 16:50:39 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA14037;
	Wed, 15 Jul 1998 19:50:35 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 15 Jul 1998 19:50:34 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI... (fwd)
In-Reply-To: <199807151959.VAA21677@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980715194807.22020M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 15 Jul 1998, Honza Pazdziora wrote:
> > From shm@cthulhu.engr.sgi.com  Wed Jul 15 20:56:01 1998
> > it still hangs at
> > Looking up port of RPC 100003/2 on (server_ip)
> > page fault from irq handler: 0
> > in case you would like to know this in IP22 r4400 with 16K I and D caches
> > ..
> > what is wrong ?

I don't actually know if this is a CPU compatibility issue.  Ralf?

> > could it be because I am serving the files from a dir, which are in turn
> > NFS exported from an SGI box .. (though I would be very surprised to hear
> > a yes to this )

I have not yet tried to install it using an Irix box because I only have
one;  is it possible to try this using another Linux box?

(as expected, it works with Linux on Sparc)

- Alex
