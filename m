Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA14394 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 00:54:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA92694
	for linux-list;
	Fri, 17 Jul 1998 00:54:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA45913
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 00:54:21 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA05589
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 00:54:19 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id JAA00528;
	Fri, 17 Jul 1998 09:54:12 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id JAA05021;
	Fri, 17 Jul 1998 09:54:04 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id JAA25634;
	Fri, 17 Jul 1998 09:54:05 +0200 (MET DST)
Message-Id: <199807170754.JAA25634@aisa.fi.muni.cz>
Subject: Re: Message while mounting NFS
In-Reply-To: <35AE3661.2E1A7F2F@detroit.sgi.com> from Eric Kimminau at "Jul 16, 98 01:20:33 pm"
To: eak@detroit.sgi.com
Date: Fri, 17 Jul 1998 09:54:05 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Honza Pazdziora wrote:
> > 
> > Hello,
> > 
> > These messages run accross console and go to syslog when I mount
> > NFS disk from remote host:
> > 
> > Jul 16 17:04:33 nemesis kernel: lockd_up: no pid, 2 users??
> > Jul 16 17:04:38 nemesis kernel: portmap: RPC call returned error 146
> > Jul 16 17:04:38 nemesis kernel: RPC: task of released request still queued!
> > Jul 16 17:04:38 nemesis kernel: RPC: (task is on xprt_pending)

[...]

> Try forcing an rsize and wsize of 8k (8192), make sure you are up to
> date on nfs, mountd and lockd patches, try forcing mounts to NFSv2 and
> if all else fails (my favorite) remove rpcbind from the picture.

Well, just starting portmap before NFS mounting the disks helped. I'm however
not able to say how "system" this solutions is ;-)

> ---------1---------2---------3---------4---------5---------6---------7
> Eric Kimminau                           FTA/RSA
> eak@detroit.sgi.com                     Silicon Graphics, Inc

[CC sent to SGI/Linux list]

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
