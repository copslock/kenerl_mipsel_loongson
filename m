Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA141576 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Feb 1998 16:42:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA28194 for linux-list; Fri, 6 Feb 1998 16:39:07 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA28153 for <linux@cthulhu.engr.sgi.com>; Fri, 6 Feb 1998 16:39:02 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA25373
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Feb 1998 16:38:57 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA02654;
	Fri, 6 Feb 1998 19:40:00 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 6 Feb 1998 19:40:00 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Masashi Sasahara/=?ISO-2022-JP?B?GyRCOns4NkA1O0obKEI=?= <sasahm@taec.toshiba.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Trouble in making swap area
In-Reply-To: <199802062332.PAA27891@sol-x86-1.taec.com>
Message-ID: <Pine.LNX.3.95.980206193645.7374B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 6 Feb 1998, Masashi Sasahara/[ISO-2022-JP] 笹原正司 wrote:
> 
>   I'm trying to install linux onto indy using vmlinux-970916-efs
> and Linux-installer-0.1d which is on ftp.linux.sgi.com.
>   Actually I failed to start "installer" so I extracted
> root-be-0.03 by hand. So I managed to install everything in
> root-be-0.01.cpio. but I'm having a problem on creating swap
> area.

Uh, are you using root-be 0.01, or 0.03?  I believe 0.03 has mkswap in it,
but 0.01 does not.

What happened when you tried to run the installer?

You probably don't need mkswap at this point anyway, since there really
aren't that many applications in root-be that will chew up that much
space.  The goal should be to put root-be on your filesystem, and from
there install all the RPMS (which contain mkswap in util-linux).

- Alex
