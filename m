Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA784319 for <linux-archive@neteng.engr.sgi.com>; Wed, 8 Apr 1998 17:15:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA9502470
	for linux-list;
	Wed, 8 Apr 1998 17:14:30 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA9446176
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Apr 1998 17:14:27 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA25298
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Apr 1998 17:14:25 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA26529
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Apr 1998 02:14:23 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA13801;
	Tue, 7 Apr 1998 18:32:22 +0200
Message-ID: <19980407183222.13099@uni-koblenz.de>
Date: Tue, 7 Apr 1998 18:32:22 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Dong Liu <dliu@npiww.com>, linux@cthulhu.engr.sgi.com
Subject: Re: what is the proper way to install linux -- part 2
References: <199804062129.RAA29966@pluto.npiww.com> <Pine.LNX.3.95.980406171915.19893Z-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980406171915.19893Z-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Apr 06, 1998 at 05:19:45PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Apr 06, 1998 at 05:19:45PM -0400, Alex deVries wrote:

> On Mon, 6 Apr 1998, Dong Liu wrote:
> > Does the fdisk on root-be-0.03.tar.gz work?, the kernel said my SCSI disk 
> > has 4 partitions, but fdisk prints no partition informarion.
> 
> We don't currently have an fdisk that recognizes SGI partitions.

While this is correct, it's no real problem.  You can use PC-style partition
tables on all disks except the disks where sash resides and where it loads
the kernel from.

PC-style partition table can actually be quite handy.  When bringing up
Linux on the Indy for the first time from a disk I prepared the disk hooked
on to a Linux PC.  After that I just hooked the disk on to the Indy and
had the first Indy booting from disk.  Except DaveM, that is.

  Ralf
