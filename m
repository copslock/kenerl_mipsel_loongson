Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA89144; Fri, 15 Aug 1997 13:17:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA01083 for linux-list; Fri, 15 Aug 1997 13:17:09 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA01068 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 13:17:07 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA04153 for linux@engr.sgi.com; Fri, 15 Aug 1997 13:17:06 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199708152017.NAA04153@oz.engr.sgi.com>
Subject: boot linux - wish
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Fri, 15 Aug 1997 13:17:06 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel wrote:

: Ok, it is not that simple.  
:
: The problem is that the Linux kernel does not have a module for
: accessing EFS, so you have to do this in two steps:
:

Hi,

Could someone rise to the challenge of writing a utility
that will install Linux on an IRIX machine?

It can ask questions like:
	Do you want to boot Linux from a [L]ocal disk or from
	a [R]emote machine [l/r] ? ...

And:
	To install Linux locally, you'll need a free partition.
	On what partition do you want to install Linux on [/dev/sdb7]?

And give hints like:
	Sorry you don't have the e2fs tools installed on IRIX yet
	should I download them from ftp.linux.sgi.com [y/n]?

And give big warnings like:
	Are you sure you want to destroy your IRIX /dev/sdb7 partition
	by running mke2fs on it [y/n]? 

But it should make it much easier for non-hackers to install
Linux side-by-side with IRIX.

This utility should give ask the user where from to take a kernel
etc. but it should have good defaults like getting it from
ftp://ftp.linux.sgi.com/ etc.

Lastly: it can have two steps (before reboot and after)
but it should do enough sanity checks and user confirms to make
sure it does the right thing.

A working utility like this is effectively a HOWTO and can be much
more useful for most people.

-- 
Peace, Ariel
