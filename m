Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA26346; Mon, 1 Jul 1996 11:04:41 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA10735 for linux-list; Mon, 1 Jul 1996 18:03:04 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA10717 for <linux@cthulhu.engr.sgi.com>; Mon, 1 Jul 1996 11:03:03 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id LAA26269; Mon, 1 Jul 1996 11:03:02 -0700
Message-Id: <199607011803.LAA26269@neteng.engr.sgi.com>
To: dm@sgi.com
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: linux@cthulhu.engr.sgi.com
Subject: Re: wheee, irix binaries... 
Date: Mon, 01 Jul 1996 11:03:02 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

: For those who are wondering, sproc() shouldn't even be that hard
: believe it or not, in fact I am told someone out there in linux land
: has already written the kernel code for preliminary support.

Linus already has something called "clone" which is quite similar to
sproc().  Somebody did the arg swizlling so that most sproced stuff
works.  
