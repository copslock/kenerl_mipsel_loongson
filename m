Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA12726 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 10:10:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA72354
	for linux-list;
	Thu, 16 Jul 1998 10:09:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA72671
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 10:09:49 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA10687
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 10:09:45 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id TAA10615
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 19:09:43 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id TAA16687
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 19:09:39 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id TAA15707
	for linux@cthulhu.engr.sgi.com; Thu, 16 Jul 1998 19:09:42 +0200 (MET DST)
Message-Id: <199807161709.TAA15707@aisa.fi.muni.cz>
Subject: Message while mounting NFS
In-Reply-To: <199807161617.SAA14485@aisa.fi.muni.cz> from Honza Pazdziora at "Jul 16, 98 06:17:57 pm"
To: linux@cthulhu.engr.sgi.com
Date: Thu, 16 Jul 1998 19:09:42 +0200 (MET DST)
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello,

These messages run accross console and go to syslog when I mount
NFS disk from remote host:

Jul 16 17:04:33 nemesis kernel: lockd_up: no pid, 2 users??
Jul 16 17:04:38 nemesis kernel: portmap: RPC call returned error 146
Jul 16 17:04:38 nemesis kernel: RPC: task of released request still queued!
Jul 16 17:04:38 nemesis kernel: RPC: (task is on xprt_pending)
Jul 16 17:04:43 nemesis kernel: portmap: RPC call returned error 146
Jul 16 17:04:43 nemesis kernel: RPC: task of released request still queued!
Jul 16 17:04:43 nemesis kernel: RPC: (task is on xprt_pending)
Jul 16 17:04:43 nemesis kernel: lockd_up: makesock failed, error=-146
Jul 16 17:04:48 nemesis kernel: portmap: RPC call returned error 146
Jul 16 17:04:48 nemesis kernel: RPC: task of released request still queued!
Jul 16 17:04:48 nemesis kernel: RPC: (task is on xprt_pending)

The filesystem is however mounted and further works OK. The remote
system is Solaris 2.5.1.

Yours,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
