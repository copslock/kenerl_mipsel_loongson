Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA02309; Wed, 28 May 1997 08:18:17 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA13282 for linux-list; Wed, 28 May 1997 08:17:48 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA13259 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 08:17:44 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA10342 for linux; Wed, 28 May 1997 08:17:44 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199705281517.IAA10342@yon.engr.sgi.com>
Subject: hardware independent hinv
To: linux@yon.engr.sgi.com
Date: Wed, 28 May 1997 08:17:44 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just forwarding since it sounds someone hopes that Linux/MIPS
will some day have a HW independent hinv... - Ariel

----- Forwarded message from Dave Olson -----

>From olson@anchor  Mon May 12 13:50:21 1997
Date: Mon, 12 May 1997 13:50:18 -0700
From: olson@anchor (Dave Olson)
Message-Id: <199705122050.NAA26767@anchor.engr.sgi.com>
To: olson@anchor (Dave Olson), scotth@sgi.com
Subject: Re: missing machfile
Cc: swmgr@swmgr, breyer@swmgr, ariel@cthulhu
References: <199705121525.IAA23143@swmgr.engr.sgi.com>
    <199705121714.KAA23773@anchor.engr.sgi.com>
    <199705121854.LAA18312@anchor.engr.sgi.com>

|  I would assume that hinv is hardware-dependent, because of the
|  mapping issues?  Or is it table driven off of an analogue of the machtab?

Still all compiled in.  Bug/rfe open for years now about making it table
driven.

|  Unfortunately, nothing better is generally available across
|  platforms and releases.

Yes, and that's something that would be nice to fix.  Maybe linux will
do it, and we can copy them.

|  D> Lots, for any non-trivial app.  They don't have to, but often want to.
|  
|  ???  Non-trivial as in "big and powerful", or as in "gets close to
|  the hardware"?  I would argue that emacs and perl both fit the

Both/either.  Not all  big apps, of course.

|  I was looking at the options to uname, specifically "-p".  Based
|  upon the man page, shouldn't `uname -p` return "mips3" instead of
|  "mips" for my IP22?  That is one obvious meaning for:

Yes, but then you break even more of the configure scripts.  Again,
a no-win situation.

|  I was just curious is there was somehow we could make life easier
|  for configure scripts to port software for IRIX...  On the other
|  hand, we generally only get bad comments about /bin/install, and at
|  least we *don't* get comments like:

|  # AIX cpp loses on an empty file, so make sure it contains at least a newline.
Using cpp is a horrible solution...

|  It is hard to add functionality without breaking stuff.

A programmer's lament, if I ever heard one!

Dave Olson, Silicon Graphics   Guru and busybody at large
http://reality.sgi.com/olson   olson@sgi.com

----- End of forwarded message from Dave Olson -----

-- 
Peace, Ariel
