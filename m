Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA2666528 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 10:47:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id KAA4860160
	for linux-list;
	Thu, 2 Apr 1998 10:40:37 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA6993073
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 10:40:31 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id KAA04820
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 10:40:29 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id NAA25564; Thu, 2 Apr 1998 13:49:01 -0500
Date: Thu, 2 Apr 1998 13:55:41 -0500
Message-Id: <199804021855.NAA08562@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: kernel panic
In-Reply-To: <199804021731.TAA00404@calypso.saturn>
References: <199804021731.TAA00404@calypso.saturn>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson writes:
 > Hello again... we're updating the internet connection to my mail server so
 > I can't read what you've written today. But I've downloaded patch-3 of the
 > sgi-kernel. I get further, but it still doesn't work.. well, I think it's
 > almost fixed now. Here's the output:
 > 
 > IP-Config: Got BOOTP answer from 192.168.0.1, my address is 192.168.0.3
 > Partition check:
 >  sda: sda1 sda2 sda3 sda4
 >  sdb: sdb1 sdb2 sdb3
 > VFS: Mounted root (ext2 filesystem) readonly.
 > Warning: unable to open an initial console.
 > Got vced at 8801a2a4.
 > Kernel panic: Caught VCE exception - should not happen
 > 

Same here, only difference is I'm using nfsroot.

Good work! Now only I can find a serial cable for this damn Indy:=).

Dong
