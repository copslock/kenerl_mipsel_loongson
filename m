Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA181130; Sun, 10 Aug 1997 19:55:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA18580 for linux-list; Sun, 10 Aug 1997 19:55:13 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA18573 for <linux@engr.sgi.com>; Sun, 10 Aug 1997 19:55:10 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA10150
	for <linux@engr.sgi.com>; Sun, 10 Aug 1997 19:55:09 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id WAA25855 for linux@engr.sgi.com; Sun, 10 Aug 1997 22:50:36 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708110250.WAA25855@neon.ingenia.ca>
Subject: /dev/usema questions
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Sun, 10 Aug 1997 22:50:35 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Couple of questions I'd like some enlightenment on, as I try to get
/dev/usema{,clone} ready for Miguel's Xcellent Adventure:

- what is us_attach.us_handle for?  Is it some opaque pointer I can
send to userland and get back for all the other ioctls?  Please? =)

- do libc and IRIX really use the minor of the filehandle to identify
the usema `device' it's working with?

- from sys/usioctl.h:
#define UIOCBLOCK       (UIOC|3)        /* block, sync, intr */
#define UIOCNOIBLOCK    (UIOC|5)        /* block, sync, intr */
Should I take UIOCNOIBLOCK to really be "/* block, sync, nointr */"?

- what's the difference between sync/async blocking/unblocking?  I
thought it might be that sync would mean that schedule() happened
immediately, but then I don't think that async blocking makes much
sense.

The us* stuff is pretty cool, I must say.  Someone (<whistles
quietly>) should think about doing it for Linux...

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
