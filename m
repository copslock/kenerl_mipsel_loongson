Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA99985 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 10:21:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA84272
	for linux-list;
	Thu, 16 Jul 1998 10:19:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA34502
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 10:19:50 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id KAA14635
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 10:19:12 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from pluto.npi.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id JAA27448; Thu, 16 Jul 1998 09:28:06 -0400
Date: Thu, 16 Jul 1998 13:38:11 -0400
Message-Id: <199807161738.NAA17076@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: Honza Pazdziora <adelton@informatics.muni.cz>
Cc: linux@cthulhu.engr.sgi.com
Subject: Message while mounting NFS
In-Reply-To: <199807161709.TAA15707@aisa.fi.muni.cz>
References: <199807161617.SAA14485@aisa.fi.muni.cz>
	<199807161709.TAA15707@aisa.fi.muni.cz>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Honza Pazdziora writes:
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

I think this is a bug of red hat system (BTW, where I can send them this bug
report?), portmapper is started after nfsfs, it should be started before
nfsfs.

Dong
