Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA363024 for <linux-archive@neteng.engr.sgi.com>; Mon, 6 Apr 1998 14:31:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA8549930
	for linux-list;
	Mon, 6 Apr 1998 14:29:51 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA8503015
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Apr 1998 14:29:45 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id OAA04200
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Apr 1998 14:29:44 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id RAA28601; Mon, 6 Apr 1998 17:38:36 -0400
Date: Mon, 6 Apr 1998 17:44:40 -0400
Message-Id: <199804062144.RAA00492@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: what is the proper way to install linux -- part 2
In-Reply-To: <Pine.LNX.3.95.980406171915.19893Z-100000@lager.engsoc.carleton.ca>
References: <199804062129.RAA29966@pluto.npiww.com>
	<Pine.LNX.3.95.980406171915.19893Z-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > On Mon, 6 Apr 1998, Dong Liu wrote:
 > > Does the fdisk on root-be-0.03.tar.gz work?, the kernel said my SCSI disk 
 > > has 4 partitions, but fdisk prints no partition informarion.
 > 
 > We don't currently have an fdisk that recognizes SGI partitions.
 > 
 > - Alex
 > 

I have two scsi disks on my machine, I plan to install linux on
/dev/sdb, so what is the best way to partition it? using linux fdisk,
or the IRIX's tool (dvhtool?)

Thanks!

Dong
