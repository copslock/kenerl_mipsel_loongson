Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA342172 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 19:17:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA12236 for linux-list; Wed, 10 Sep 1997 19:16:51 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA12226 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 19:16:50 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA26791; Wed, 10 Sep 1997 19:16:48 -0700
Date: Wed, 10 Sep 1997 19:16:48 -0700
Message-Id: <199709110216.TAA26791@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: Linux/SGI: MAP_AUTOGROW, F_ALLOCSP
In-Reply-To: <199709110204.VAA25377@athena.nuclecu.unam.mx>
References: <199709110204.VAA25377@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
...
 > 	2. The "this sucks, but it will get into the main
 >            kernel real fast": on irix_mmap () if the MAP_AUTOGROW flag
 >            is set, it will check if the top limit for the mmap is
 >            bigger that the current file size, if it is it does:
 > 	
 > 		o = sys_lseek (fd, offset + len - 1, SEEK_SET);
 > 		sys_write (fd, "", 1);
 > 		sys_lseek (fd, o, SEEK_SET);
 > 
 >      Any ideas, comments?  I am ready to commit approach (2) ;-)
...

     This seems reasonable enough.  This code supports the "shm" shared
memory transport of Xsgi; other process mmap() the file to communicate
with the server.  It is something of a hack (being not particularly secure).
