Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id AAA82637 for <linux-archive@neteng.engr.sgi.com>; Sat, 11 Oct 1997 00:27:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA16402 for linux-list; Sat, 11 Oct 1997 00:26:44 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA16397; Sat, 11 Oct 1997 00:26:40 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) id AAA34328; Sat, 11 Oct 1997 00:26:36 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199710110726.AAA34328@oz.engr.sgi.com>
Subject: Re: booted, what's next...
To: maciek@cadsys.com.pl
Date: Sat, 11 Oct 1997 00:26:35 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <343E2AD9.2984F854@cadsys.com.pl> from "Maciek Dyczkowski" at Oct 10, 97 03:17:14 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:I was able to get my new OS running over the net. Kernel loads, NFS
:mounts root filesystem and .... this is all I can
:do. The next step should be :
:
:1. Mount your local disks.... how can I do that? How can I mount disks
:on SGI/Linux? Do I need to format my
:drive? What tools should I use?
:
:2. Download all RPMS .... done
:
:3. use command ' rpm --root=/mnt -Uvh *rpm ' ..... even I couldn't mount
:my drive I checked, whether I could use rpm
:command - it just doesn't exist in my root filesystem. Anybody has any
:experiences with installing SGI/Linux?
:
:Thank you for ANY help!
:
:--
:Maciek Dyczkowski
:
I believe that with your current setting that's what you can do.
You may mount additional remote disks via NFS but not local ones
as is.  The local disks are probably in formats that the current
snapshot of the port doesn't recognize (EFS or XFS).  Mike Shaver
was working in his spare time (he also needs to make a living :-)
on read-only EFS support.

To mount a local disk you need to go through a pretty complex
sequence that was discussed on this list before.

For a full archive of the list check-out:

	http://reality.sgi.com/ariel/linux.gz (~0.5 Mb)

We are working on a better installation and setup.

-- 
Peace, Ariel
