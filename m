Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA09777; Wed, 28 May 1997 19:27:22 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA03351 for linux-list; Wed, 28 May 1997 19:26:43 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA03332 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 19:26:40 -0700
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [130.62.52.47]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA13198 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 19:26:39 -0700
Received: (from olson@localhost) by anchor.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA03967; Wed, 28 May 1997 19:26:37 -0700
Date: Wed, 28 May 1997 19:26:37 -0700
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199705290226.TAA03967@anchor.engr.sgi.com>
To: lm@neteng.engr.sgi.com (Larry McVoy), Mike Shaver <shaver@neon.ingenia.ca>
Subject: Re: hardware independent hinv
Cc: breyer@swmgr.engr.sgi.com, swmgr@swmgr.engr.sgi.com, scotth@sgi.com,
        linux@yon.engr.sgi.com, ariel@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The info definitely isn't in /proc on irix.

Doesn't dmesg have the problem on linux that it has on Sun systems; that is,
it only works until enough kernel printfs have happened that the circular
buffer wraps?

Dave Olson, Silicon Graphics   Guru and busybody at large
http://reality.sgi.com/olson   olson@sgi.com
