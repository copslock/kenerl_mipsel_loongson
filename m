Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA22570; Mon, 2 Jun 1997 11:28:06 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA00811 for linux-list; Mon, 2 Jun 1997 11:27:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA00786 for <linux@engr.sgi.com>; Mon, 2 Jun 1997 11:27:40 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA11013
	for <linux@engr.sgi.com>; Mon, 2 Jun 1997 11:27:39 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id OAA12315 for linux@engr.sgi.com; Mon, 2 Jun 1997 14:21:47 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199706021821.OAA12315@neon.ingenia.ca>
Subject: The Plan For Userland(tm)
To: linux@cthulhu.engr.sgi.com
Date: Mon, 2 Jun 1997 14:21:47 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Here's my plan for getting the userland stuff to critical mass:
- kernel and glibc sync'd.  Shouldn't be too hard, once I get the new
kernel from Ralf.  (At the very least, I need the SOCK_{STREAM,DGRAM}
stuff sorted out, and I'd like to figure out a good strategy for
asm/atomic.h.)
- rpm built
- native gcc built as an rpm
- start building rpms natively, and installing them on a fresh
partition

I think the SCSI driver is dodgy (this may be a known problem), and I
need to get glibc installed on neon to ease the configuration issue,
but I think we're well on our way.

I'm _definitely_ going to need more disk space on neon, but I can
steal the ext2 one from bogomips in the short-term.

Oh, BTW:
[shaver@neon shaver]$ telnet bogomips
Trying 205.207.220.72...
Connected to bogomips.ingenia.com.
Escape character is '^]'.

Linux 2.0.12 (bogomips) (ttyp0)


bogomips login: root
Last login: Mon Jun  2 15:29:21 from neon
# ls
205.207.220.72       libexec              tmp
bin                  linux-2.0.12.tar.gz  usr
dev                  linux-2.1.36.tar.gz  var
etc                  proc                 vmlinux
home                 sbin
lib                  static-bin
# exit
Connection closed by foreign host.
[shaver@neon shaver]$ 

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 Ignore the man behind the curtain.                  
#>                                                                     
#> "And then I realized that it never should have worked in the first  
#>  place.  Thus, it would not work again until rewritten." --- Anon.  
