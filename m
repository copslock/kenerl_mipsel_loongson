Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA04768; Thu, 5 Jun 1997 20:58:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA04744 for linux-list; Thu, 5 Jun 1997 20:58:37 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA04740 for <linux@cthulhu.engr.sgi.com>; Thu, 5 Jun 1997 20:58:36 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA15913 for <linux@yon.engr.sgi.com>; Thu, 5 Jun 1997 20:58:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA04712 for <linux@yon.engr.sgi.com>; Thu, 5 Jun 1997 20:58:14 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA04872
	for <linux@yon.engr.sgi.com>; Thu, 5 Jun 1997 20:58:13 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id XAA22624; Thu, 5 Jun 1997 23:44:49 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199706060344.XAA22624@neon.ingenia.ca>
Subject: Re: bogomips is cool
In-Reply-To: <199706060339.UAA15843@yon.engr.sgi.com> from Ariel Faigon at "Jun 5, 97 08:39:08 pm"
To: ariel@sgi.com
Date: Thu, 5 Jun 1997 23:44:49 -0400 (EDT)
Cc: linux@yon.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ariel Faigon:
> 	http://bogomips.ingenia.com/
> 
> It is pretty fast considering it is in Ottawa and it is not
> yet using its local disk (is this right Mike?)...

Yeah, it's all running NFS'd off of neon.
That may change over the next few days.  I suspect my disk problems
might have had something to do with the fact that I was using the
IRIX-hosted ext2fs tools.

I'll try to build some natively-hosted ext2 widgets tomorrow (perhaps
even ext2extend =) ) and see if it gets better.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
