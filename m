Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id LAA689892 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 11:42:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA03128 for linux-list; Wed, 21 Jan 1998 11:38:42 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA03109 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 11:38:41 -0800
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA10655
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 11:38:40 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id LAA01946
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 11:38:36 -0800 (PST)
Received: from netscape.com ([208.12.32.37]) by dredd.mcom.com
          (Netscape Messaging Server 3.0)  with ESMTP id AAA5658;
          Wed, 21 Jan 1998 11:38:35 -0800
Message-ID: <34C64EB7.1FA95A9C@netscape.com>
Date: Wed, 21 Jan 1998 19:38:31 +0000
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.03 [en] (X11; U; Linux 2.0.31 i686)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <Pine.LNX.3.95.980121135323.22712E-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> I can already see some things that should go into 0.04..

It would be nice if there was a really minimal root-be with just enough
to get a network configured and then start pulling stuff down via RPM. 
That was my goal with the Linux-installer, although we could have two
versions, too.
 
> Some things to work on:
> - get a more modern version of vmlinux with efs for both scache'd and
>   non-scache'd machines

I _must_ start working on EFS again.  I assume I've missed the 2.2
freeze, but I could still help a lot of people by getting off my a** and
finishing it.  My apologies to those who are waiting on it.

> - make Linux-installer-0.1c with root-be-0.03.tar.gz (with Mike's
>   permission)

Sold!
Note that you'll have to make a cpio of it, because that's all the
installer understands.  Also, if you talk to Alan about how to fix the
installer to do devices correctly, things will get a little simpler.

> - document all this (damn, I wish I had another SCSI disk to practice
>   installs)

I have one, and the work Indy survived the layoffs (woohoo!), so I'll be
back to work on that stuff shortly (cross your fingers =) ).

Mike

-- 
509756.92 504401.08
