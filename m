Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA347336 for <linux-archive@neteng.engr.sgi.com>; Mon, 6 Apr 1998 14:21:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA8478520
	for linux-list;
	Mon, 6 Apr 1998 14:19:58 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA8549734
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Apr 1998 14:19:54 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA00258
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Apr 1998 14:19:51 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA10168;
	Mon, 6 Apr 1998 17:19:45 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 6 Apr 1998 17:19:45 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Dong Liu <dliu@npiww.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: what is the proper way to install linux -- part 2
In-Reply-To: <199804062129.RAA29966@pluto.npiww.com>
Message-ID: <Pine.LNX.3.95.980406171915.19893Z-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 6 Apr 1998, Dong Liu wrote:
> Does the fdisk on root-be-0.03.tar.gz work?, the kernel said my SCSI disk 
> has 4 partitions, but fdisk prints no partition informarion.

We don't currently have an fdisk that recognizes SGI partitions.

- Alex
