Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA213723 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 13:59:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA20756 for linux-list; Thu, 12 Feb 1998 13:55:42 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA20546 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 13:55:11 -0800
Received: from mauve.csi.cam.ac.uk (mauve.csi.cam.ac.uk [131.111.8.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id NAA28242
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 13:55:08 -0800
	env-from (Dave@imladris.demon.co.uk)
Received: from dwmw2.robinson.cam.ac.uk (imladris.demon.co.uk) [131.111.217.153] (exim)
	by mauve.csi.cam.ac.uk with smtp (Exim 1.82 #1)
	id 0y36aE-0004Js-00; Thu, 12 Feb 1998 21:54:14 +0000
Received: from localhost (dwmw2.robinson.cam.ac.uk) [127.0.0.1] (dwmw2)
	by imladris.demon.co.uk with esmtp (Exim 1.82 #9)
	id 0y36YO-00042j-00; Thu, 12 Feb 1998 21:52:20 +0000
X-Mailer: exmh version 2.0zeta 7/24/97
To: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ralf@uni-koblenz.de,
        linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: TLB entries > 4kb 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Feb 1998 21:52:19 +0000
From: David Woodhouse <Dave@imladris.demon.co.uk>
Message-Id: <E0y36YO-00042j-00@imladris.demon.co.uk>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


mingo@chiara.csoma.elte.hu said:
> On Thu, 12 Feb 1998, Alan Cox wrote:
> > On the intel its a huge win to map PCI frame buffers using 4Mbyte pages, but
> > the kernel mmap really can't hack the idea right now. A pity cos if you
> > hack it in and make sure you never unmap it you get 2-3% better X 
> > performance
> 
> i tried to hack this half a year ago, but had to find out that 4MB pages
> are only valid for kernel mappings, which means we'd have to make X a ring
> 0 process too ...

---------------

alan@lxorguk.ukuu.org.uk said:
>  The way its done is ok normally. I guess you need to make X over
> Linux/RT call the rtlinux kernel to handle it. Note X _has_ to do
> those global cli/sti's to meet hardware needs

---------------


GGI (well, KGI) should be able to fix both of these, shouldn't it?




----                              ----                              ----
David Woodhouse, Robinson College, CB3 9AN, England.   (+44) 0976 658355
    Dave@imladris.demon.co.uk        http://dwmw2.robinson.cam.ac.uk
	    finger pgp@dwmw2.robinson.cam.ac.uk for PGP key.
