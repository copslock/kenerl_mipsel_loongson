Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA175122 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 20:51:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA24724 for linux-list; Mon, 26 Jan 1998 20:49:19 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA24719 for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 20:49:14 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA13408
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 20:49:09 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA17297;
	Mon, 26 Jan 1998 23:49:56 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 26 Jan 1998 23:49:56 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Michael Hill <mdhill@interlog.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Linux-installer 0.1d
In-Reply-To: <199801240324.WAA01949@mdhill.interlog.com>
Message-ID: <Pine.LNX.3.95.980126234436.9839T-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alright.  0.1d is created with --format=newc, which appears to actually be
the correct format. You can get it in
ftp://ftp.linux.sgi.com/pub/mips-linux/GettingStarted/ .

Sorry for the delay...

I know very little about cpio, but I suspect that if you used GNU cpio on
Irix it would have worked.

- Alex

-- 
Alex deVries          Run Linux on everything,
                      run everything on Linux.


On Fri, 23 Jan 1998, Michael Hill wrote:

> Date: Fri, 23 Jan 1998 22:24:20 -0500
> From: Michael Hill <mdhill@interlog.com>
> To: Alex deVries <adevries@engsoc.carleton.ca>
> Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
> Subject: Re: Linux-installer 0.1c
> 
> Hi Alex,
> 
> Running the installer with root-be-0.03 gives me the following:
> 
> cjwsh>cpio root-be-0.03.cpio
> error -2 reading header: Error 0
> 
> and kicks me back to the root prompt.  When I did it with
> root-be-0.01.cpio, it seemed to execute without a hitch.
> 
> Alex deVries writes:
>  > 
>  > I've merged the root-be-0.03 with Linux-installer 0.1 to make 0.1c.
>  > 
>  > I know the filesystem works, I don't know about the installer and I can't
>  > do that until I have another disk to install on. 
>  > 
> 
> Thanks,
> 
> Mike
> -- 
> Michael Hill
> Toronto, Canada
> mdhill@interlog.com
> 
