Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA1095097 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 10:24:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA11156 for linux-list; Thu, 11 Dec 1997 10:21:57 -0800
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA11073; Thu, 11 Dec 1997 10:21:50 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) id KAA13893; Thu, 11 Dec 1997 10:21:49 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199712111821.KAA13893@oz.engr.sgi.com>
Subject: Re: Announce: New uploads
To: jalonso@kaydara.com
Date: Thu, 11 Dec 1997 10:21:49 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <348FFDBF.EE8@kaydara.com> from "Joe Alonso" at Dec 11, 97 09:50:39 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:Pardon my ignorance, but...
:I have a couple of questions;  
:is there a how-to document that outlines how to load linux on an sgi?
:
We are waiting for someone to write this.

You may get all the info by reading:

	http://reality.sgi.com/ariel/linux.gz

(an archive of this mailing list).  The problem is that
it is way too long in this form.


:is the Indigo Elan (r4000) supported?
:

Unfortunately, no.


:I'm not sure how to initialize a loading of linux on the sgi.
:Here's what I've assumed:
:- bring over the src's to the sgi
:- compile a basic system (under irix)
:- copy over the original irix kernel with the new linux kernel
:- re-boot
:
:The begging questions:
:The FS are not compatible, therefore a new mkfs has to be done on the
:(root) partitions.
:This just doesn't "sound" right to me. 
:What am I overlooking?
:

You should be either:

1) boot via bootp (/vmlinux on a remote filesystem) and mount
   stuff via NFS.

2) Go through a complex and not well documented way of creating
   an ext2fs filesystem on your Indy (better get an additional disk)
   copy the kernel and root to that system and reboot.

--
Peace, Ariel
