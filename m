Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA27264 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 08:44:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA40354
	for linux-list;
	Fri, 17 Jul 1998 08:44:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA01842
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 08:44:07 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id IAA26244
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 08:44:06 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from pluto.npi.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id HAA31409; Fri, 17 Jul 1998 07:53:14 -0400
Date: Fri, 17 Jul 1998 12:03:10 -0400
Message-Id: <199807171603.MAA04280@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Dong Liu <dliu@npiww.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Message while mounting NFS
In-Reply-To: <Pine.LNX.3.95.980717012619.5792C-100000@lager.engsoc.carleton.ca>
References: <199807161738.NAA17076@pluto.npiww.com>
	<Pine.LNX.3.95.980717012619.5792C-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > On Thu, 16 Jul 1998, Dong Liu wrote:
 > > I think this is a bug of red hat system (BTW, where I can send them this bug
 > > report?), portmapper is started after nfsfs, it should be started before
 > > nfsfs.
 > 
 > Does starting portmapper before nfsfs actually work for you?  I still had
 > NFS client problems on my HH install (although the client works somewhat
 > better on my totally custom and hacked install).

Yes, it works for me, the only thing I changed is the "chkconfig" line of 
/etc/rc.d/init.d/{portmap,nfsfs} and run "chkconfig reset", no more
kernel error message and long delay of mounting nfs. 

Here is another thought, in order to mount /usr as nfs, should portmap
be under /sbin instead of /usr/sbin?

BTW, speaking of nfs, I have observed another problem, when I first
login to a user whose home directory is nfs mounted from an HP server,
sgi linux kernel prints

NFS: server xxxx, readdir reply truncated
NFS: nr=156, slots=2, len=10

All the i386 linux boxes don't exhibit this problem


Dong
