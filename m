Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA13975 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 10:50:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA72767
	for linux-list;
	Thu, 16 Jul 1998 10:49:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA40633
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 10:49:50 -0700 (PDT)
	mail_from (weejock@ferret.lmh.ox.ac.uk)
Received: from ferret.lmh.ox.ac.uk (ferret.lmh.ox.ac.uk [163.1.138.204]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id KAA29222
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 10:49:48 -0700 (PDT)
	mail_from (weejock@ferret.lmh.ox.ac.uk)
Received: (qmail 21972 invoked by uid 504); 16 Jul 1998 17:49:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jul 1998 17:49:47 -0000
Date: Thu, 16 Jul 1998 18:49:47 +0100 (GMT)
From: Matthew Kirkwood <weejock@ferret.lmh.ox.ac.uk>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Message while mounting NFS
In-Reply-To: <199807161709.TAA15707@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.96.980716184835.21872A-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 16 Jul 1998, Honza Pazdziora wrote:

> These messages run accross console and go to syslog when I mount
> NFS disk from remote host:
> 
> Jul 16 17:04:33 nemesis kernel: lockd_up: no pid, 2 users??
> Jul 16 17:04:38 nemesis kernel: portmap: RPC call returned error 146
> Jul 16 17:04:38 nemesis kernel: RPC: task of released request still queued!
> Jul 16 17:04:38 nemesis kernel: RPC: (task is on xprt_pending)

[snip]

I think this is because the 2.1 NFS client does not like running
without a local portmap.

Matthew.
