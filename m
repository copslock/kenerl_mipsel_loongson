Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA14256 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 10:14:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA34522
	for linux-list;
	Thu, 16 Jul 1998 10:13:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA84324
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 10:13:52 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA12115
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 10:13:28 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA14289;
	Thu, 16 Jul 1998 13:13:23 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 16 Jul 1998 13:13:23 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Message while mounting NFS
In-Reply-To: <199807161709.TAA15707@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980716131249.6127D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Yup... this, I'm told, is because the NFS client in 2.1.100 is a bit sick.
that won't get fixed until we do a bit of kernel work.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Thu, 16 Jul 1998, Honza Pazdziora wrote:

> Date: Thu, 16 Jul 1998 19:09:42 +0200 (MET DST)
> From: Honza Pazdziora <adelton@informatics.muni.cz>
> To: linux@cthulhu.engr.sgi.com
> Subject: Message while mounting NFS
> 
> 
> Hello,
> 
> These messages run accross console and go to syslog when I mount
> NFS disk from remote host:
> 
> Jul 16 17:04:33 nemesis kernel: lockd_up: no pid, 2 users??
> Jul 16 17:04:38 nemesis kernel: portmap: RPC call returned error 146
> Jul 16 17:04:38 nemesis kernel: RPC: task of released request still queued!
> Jul 16 17:04:38 nemesis kernel: RPC: (task is on xprt_pending)
> Jul 16 17:04:43 nemesis kernel: portmap: RPC call returned error 146
> Jul 16 17:04:43 nemesis kernel: RPC: task of released request still queued!
> Jul 16 17:04:43 nemesis kernel: RPC: (task is on xprt_pending)
> Jul 16 17:04:43 nemesis kernel: lockd_up: makesock failed, error=-146
> Jul 16 17:04:48 nemesis kernel: portmap: RPC call returned error 146
> Jul 16 17:04:48 nemesis kernel: RPC: task of released request still queued!
> Jul 16 17:04:48 nemesis kernel: RPC: (task is on xprt_pending)
> 
> The filesystem is however mounted and further works OK. The remote
> system is Solaris 2.5.1.
> 
> Yours,
> 
> ------------------------------------------------------------------------
>  Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
>                    I can take or leave it if I please
> ------------------------------------------------------------------------
> 
