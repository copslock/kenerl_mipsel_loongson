Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA65372 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 04:16:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA21611880
	for linux-list;
	Fri, 8 May 1998 04:15:40 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA20560349
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 04:15:38 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA03513
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 04:15:37 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id HAA21387
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 07:15:36 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 07:15:36 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: My .99 oops...
In-Reply-To: <Pine.LNX.3.95.980508065104.20848B-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.95.980508071419.20848D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 8 May 1998, Alex deVries wrote:
> Checking for 'wait' instruction...  available
> POSIX conformance testing by UNIFIX
> Starting kswapd v 1.5
> Floppy drive(s): fd0 is 1.44M
> Unable to handle kernel paging request at virtual address 00000000, epc ==
> My guess is it's that I enabled the floppy drive (as it came as the
> default).  I'll remove that, recompile and reboot.

Alright, I removed floppy support and recompiled, and everything is okay
now.

Now, I'll compile loads of contrib RPMs and we'll see how well this
floats.

- Alex
