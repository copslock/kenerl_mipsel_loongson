Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA46593 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 01:10:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA20865024
	for linux-list;
	Fri, 8 May 1998 01:08:20 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA20142418
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 01:08:11 -0700 (PDT)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id BAA28675
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 01:08:03 -0700 (PDT)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id IAA00678; Fri, 8 May 1998 08:22:21 +0200
Date: Fri, 8 May 1998 08:22:21 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: rs_cons_hook() ?
In-Reply-To: <Pine.LNX.3.95.980507134501.20653L-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.980508082131.254C-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> ... and the final link complains that it can't find rs_cons_hook defined
> anywhere.  That's because I'm not compiling in
> drivers/sgi/char/sgiserial.c (which has other linking errors, and is
> another problem, but you should be able to compile in console support
> without having to have compiled in SGI serial support).
>

you need SGI serial support (sgi/char/sgiserial.c) for the serial console 
support ..

o. 
