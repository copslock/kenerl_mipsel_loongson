Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA609990 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Sep 1997 14:07:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA02240 for linux-list; Tue, 16 Sep 1997 14:06:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA02219 for <linux@engr.sgi.com>; Tue, 16 Sep 1997 14:06:12 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA00062
	for <linux@engr.sgi.com>; Tue, 16 Sep 1997 14:06:10 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id RAA05770 for linux@engr.sgi.com; Tue, 16 Sep 1997 17:01:05 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709162101.RAA05770@neon.ingenia.ca>
Subject: EFS test kernel
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Tue, 16 Sep 1997 17:01:05 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ftp://ftp.linux.sgi.com/pub/test/vmlinux-970916-efs.gz has rudimentary
support for EFS partition mounting, and it lets me do some basic stuff
on my IRIX partition, like list small[*] directories and run binaries.

I've got my IRIX root mounted at /usr/gnemul/irix (the emulation code
requires that location), and have a symlink /lib/rld ->
/usr/gnemul/irix/lib/rld.  I sometimes get problems specifying
executables by explicit path (./ls or /usr/gnemul/irix/bin/ls), but if
I put the current directory in my path and chdir to there, things like
ls and date and wc and uname work just fine.

Please let me know if you get any problems.

[*] small == not requiring indirect extents

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 Ignore the man behind the curtain.                  
#>                                                                     
#> "And then I realized that it never should have worked in the first  
#>  place.  Thus, it would not work again until rewritten." --- Anon.  
