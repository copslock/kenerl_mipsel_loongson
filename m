Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA73864 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Mar 1999 11:17:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA95103
	for linux-list;
	Tue, 16 Mar 1999 11:15:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA19672;
	Tue, 16 Mar 1999 11:15:13 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id LAA73750; Tue, 16 Mar 1999 11:15:12 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199903161915.LAA73750@oz.engr.sgi.com>
Subject: Anon CVS (was Re: FAQ)
To: R.vandenBerg@inter.nl.net
Date: Tue, 16 Mar 1999 11:15:12 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <199903161719.JAA96403@cthulhu.engr.sgi.com> from "owner-linux@cthulhu" at Mar 16, 99 09:19:37 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just a reminder since this is a FAQ...

(in a bounced message :-) Richard van den Berg wrote:
:
:P.S. is cvs read-only possible at linus.linux.sgi.com? I've tried without
:succes getting a permission denied. Instead I've ftp'ed the cvs tree.
:
:Regards,
:Richard
:

Anonymous read-only CVS to linus.linux.sgi.com:

        Using CVS you can checkout the Linux/MIPS source tree with
        the following commands:

        cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs login
        (Only needed the first time you use anonymous CVS,
         the password is "cvs")

        cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs co <repository>

        where you insert linux, libc, or gdb for <repository>.


-- 
Peace, Ariel
