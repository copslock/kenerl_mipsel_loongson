Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA1118601 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Sep 1997 22:01:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA28977 for linux-list; Thu, 4 Sep 1997 22:01:14 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA28961 for <linux@engr.sgi.com>; Thu, 4 Sep 1997 22:01:12 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA19131
	for <linux@engr.sgi.com>; Thu, 4 Sep 1997 22:01:11 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id AAA16971 for linux@engr.sgi.com; Fri, 5 Sep 1997 00:58:04 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709050458.AAA16971@neon.ingenia.ca>
Subject: Kernel for local disk stuff
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Fri, 5 Sep 1997 00:58:04 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ftp://ftp.linux.sgi.com/pub/test/vmlinux-950905.gz works for me for
mounting local disk as root.

Getting a local disk set up is still a minor nightmare, because
there's no simple boot image yet (though Alex is working on it), and
because heavy ethernet traffic occasionally generates bus errors that
lock up the box.  I'm going to take a look at what causes those
tomorrow, hopefully.

(I'm also going to reinstall IRIX on the primary disk.  mke2fs
can really wreck IRIX's day. =) )

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
