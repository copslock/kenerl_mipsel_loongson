Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA43104 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Jan 1998 09:51:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA26180 for linux-list; Thu, 15 Jan 1998 09:47:06 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26139 for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 09:47:01 -0800
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA08584
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 09:46:59 -0800
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost)
	by neon.ingenia.ca (8.8.5/8.8.7) id MAA24761;
	Thu, 15 Jan 1998 12:47:39 -0500
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199801151747.MAA24761@neon.ingenia.ca>
Subject: Re: Follow-up:  Hard Drive Problems
In-Reply-To: <199801151340.IAA03707@mdhill.interlog.com> from Michael Hill at "Jan 15, 98 08:40:32 am"
To: mdhill@interlog.com
Date: Thu, 15 Jan 1998 12:47:39 -0500 (EST)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Michael Hill:
> Modifications to /var/sysgen/master.d/wd93 (courtesy of dealer tech
> support) have permitted my hard drive to be recognized by IRIX.  I
> successfully ran mke2fs on it and I'm trying to figure out what to do
> next.  Is there any further news on Mike Shaver's installer script?

As of yesterday, there _is_ news: I've escaped the Great Ice Storm and
beat INS and AIESEC at their own game, so I'm back in California and
almost ready to put a working version of the installer package up,
with new libc from Ralf and a working rpm binary from Alan.

This should happen tonight sometime.
In the meantime, you can get Alan's installer package from
ftp://ftp.uk.linux.org/pub/linux/SGI/sgi-installer-snapshot-0.0.tar.gz
and copy the file named a.out into the directory where the
instructions would have you looking for "installer".  That's all that
program is anyway.

Mike
