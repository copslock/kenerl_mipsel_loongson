Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA134306 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Sep 1997 11:54:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA10462 for linux-list; Thu, 18 Sep 1997 11:54:03 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA10446 for <linux@engr.sgi.com>; Thu, 18 Sep 1997 11:54:01 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA09726
	for <linux@engr.sgi.com>; Thu, 18 Sep 1997 11:54:00 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id OAA25739 for linux@engr.sgi.com; Thu, 18 Sep 1997 14:48:28 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709181848.OAA25739@neon.ingenia.ca>
Subject: indirect EFS extent question
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Thu, 18 Sep 1997 14:48:28 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I just read the comment in fs/efs_fs.h properly for the first time,
and things are now much clearer.  I think.

So, is _this_ correct?
	/* 
	 * We're indirect, so we need to start looking in the 
	 * indirect extents.
	 *
	 * EFS indirect extents are really doubly indirect:
	 * inode->di_u.di_extents (1st level extents) refers to
	 * contiguous blocks of extents (2nd level extents).  The
	 * block of these 2nd level extents contain direct extents (or
	 * 3rd level extents).  So, for each indirect extent in
	 * di_u.di_extents, we need to get a block of 2nd-level
	 * extents, get a block from one of the 2nd-level extents, and
	 * then check the extents in that final block -- which, at
	 * long last, contains direct extents.
	 */

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
