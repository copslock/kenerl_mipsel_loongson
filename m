Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA680604 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 10:13:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA01396 for linux-list; Wed, 21 Jan 1998 10:09:30 -0800
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA01381; Wed, 21 Jan 1998 10:09:29 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) id KAA03109; Wed, 21 Jan 1998 10:09:26 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199801211809.KAA03109@oz.engr.sgi.com>
Subject: Re: Disk Space
To: LetherGlov@aol.com (LetherGlov)
Date: Wed, 21 Jan 1998 10:09:26 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <6e690e14.34c6079f@aol.com> from "LetherGlov" at Jan 21, 98 09:35:09 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:There seems to be a small problem on the root(/) drive of Linus, as it is 100%
:used. I'm not quite sure what caused this, as a few days ago it was fine, but
:I'd like to be able to pull some sources from the CVS and it woun't let me
:complaining about the space.
:
Yes the root filesystem is very small.  Please use only the /src
and /work partitions to do your work.  There are only three users
who have over 20 Mb each in their home dirs.  I guess I can
delete Larry's stuff since he hasn't logged in in a very long time
Also: anyone knows if Mark Salter is still helping? He has 43Mb...

I also cleaned some old logs /var/adm/{oOLD}* so we are down to 98% before
dealing with user dirs...

-- 
Peace, Ariel
