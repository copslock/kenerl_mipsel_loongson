Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA251321; Thu, 10 Jul 1997 14:39:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA25600 for linux-list; Thu, 10 Jul 1997 14:38:52 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA25593 for <linux@cthulhu.engr.sgi.com>; Thu, 10 Jul 1997 14:38:50 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA23929 for linux@engr.sgi.com; Thu, 10 Jul 1997 14:38:50 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199707102138.OAA23929@oz.engr.sgi.com>
Subject: How to get the masses (IRIX<->Linux)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 10 Jul 1997 14:38:49 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

To get a critical mass of SGI users installing/running linux
I believe we should aim at a setup where any non-guru could:

	1) Install a full Linux distribution over the net
	   (e.g. from linus.linux) from a running IRIX system
	   On a virgin (separate) SCSI disk.

	2) Once it is there, hot-start Linux from IRIX

If we do it this way, users will be able to keep IRIX
and it'll cost just an additional disk (a few hundred dollars)
to get Linux running on the systems they are already used to
work with.  Since they have little to lose or to risk this
way we have a much higher chance to get many users on board.

Tangentially related:
For those who don't know this, you may do a scheduled auto
power-off / power-on on IRIX:

        % su
        # at 5am July 3
        /usr/sbin/wakeupat 6pm Thursday
        /etc/shutdown -y
        <Ctl-d> (control - d)  This will submit the job.
        # exit

If we could rewrite wakeupat or reboot to take some
extra boot options or alternatively run some Linux loader
(SILO/MILO) from IRIX then 2) should be easy.

-- 
Peace, Ariel
