Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA82748 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 May 1999 23:38:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA46530
	for linux-list;
	Wed, 19 May 1999 23:35:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from roald.stavanger.sgi.com (roald.stavanger.sgi.com [144.253.219.14])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA27690
	for <linux@engr.sgi.com>;
	Wed, 19 May 1999 23:35:11 -0700 (PDT)
	mail_from (roald@stavanger.sgi.com)
Received: (from roald@localhost) by roald.stavanger.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id IAA02926 for linux@engr.sgi.com; Thu, 20 May 1999 08:35:09 +0200 (CEST)
From: "Roald Lygre" <roald@stavanger.sgi.com>
Message-Id: <9905200835.ZM102213@roald.stavanger.sgi.com>
Date: Thu, 20 May 1999 08:35:03 +0000
Reply_To: roald@stavanger.sgi.com
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Bott vmlinux trouble (
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I'm havind the problem described i January by Chad Carlin :

 sdb: sdb1 sdb2 sdb3 sdb4
Looking up port of RPC 100003/2 on 169.238.83.43
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server 169.238.83.43 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 169.238.83.43
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server 169.238.83.43 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
mount: server 169.238.83.43 not responding, timed out
Root-NFS: Server returned error -5 while mounting /tftpboot/
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00


My system is a R4600 100Mhz.

It is not clear from the mailing list archive how/where to get a kernel that
works in this case?

-Roald

-- 
    
---------------------------------------------------------------
| Company: SGI Norge A/S                                      |
| Email:   roald@sgi.com          Tlf:          +47 5184 3633 |
| Addr:    St Olavsgt 9           Mobil:        +47 909 33 903|
|          N-4004 Stavanger       VMail (SGI):  870-4679      |
|          NORWAY                 VMail(ext):   67114679      |
|                                                             |
| SGI Norway's WWW Home Page: http://www.sgi.no               |
---------------------------------------------------------------
