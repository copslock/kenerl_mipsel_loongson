Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA16484; Thu, 26 Jun 1997 11:46:43 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA17963 for linux-list; Thu, 26 Jun 1997 11:46:26 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA17934 for <linux@engr.sgi.com>; Thu, 26 Jun 1997 11:46:22 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA11570 for linux@engr.sgi.com; Thu, 26 Jun 1997 11:46:22 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199706261846.LAA11570@oz.engr.sgi.com>
Subject: anon-ftp enabled on linus
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 26 Jun 1997 11:46:22 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

FYI:

I just enabled public ftp access to linus.linux.sgi.com
ftpd runs as user/group  ftp/ftp.

The chroot'ed location (~ftp) is /src (where the CVS tree resides)

I made sure that the source tree has no world write permissions
or ftp group write permissions anywhere.

Since IRIX comes only with a dynamically liked '/bin/ls'
I had to add /lib/rld libc.so and /dev/zero rooted at /src
for dir to work.  I made all the permissions secure but
another check would be appreciated.

If anyone feels like building the latest wu-ftpd (with all security
patches) and replace the SGI ftpd - welcome.

A web site is planned too.  I hope we got a volunteer to set it up.

Let's keep the public areas only on the /src partition. I suggest
/src/www (or some such) for the web doc root.

-- 
Peace, Ariel
