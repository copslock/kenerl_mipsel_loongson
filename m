Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2659750 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 06:44:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA6887962
	for linux-list;
	Thu, 2 Apr 1998 06:43:53 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA6874921
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 06:43:51 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA02315
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 06:43:48 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id QAA19246 for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 16:42:59 +0200
Date: Thu, 2 Apr 1998 16:42:59 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
In-Reply-To: <19980401223954.56814@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980402164145.18788A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> On Wed, Apr 01, 1998 at 08:54:55PM +0200, Ulf Carlsson wrote:
> 
> > eth0: SGI Seeq8003 08:00:69:07:a8:c7
> > Unable to handle kernel paging request at virtual address 00000008, epc ==
> > 880ce1f4, ra == 880ce1d4
> 
> That one seems to be a pretty nasty one.  What is happening is something
> that looks like the caches are writing the values back with a certain
> delay or not at all.  Not good ...
>

kernel 2.1.90 with Ralf's new patch #3 is here:
ftp://zero.aec.at/pub/sgi-linux/linux-980326-3.tar.gz

-oliver 
