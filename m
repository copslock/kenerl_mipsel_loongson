Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA09067; Wed, 9 Apr 1997 11:47:19 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13568 for linux-list; Wed, 9 Apr 1997 11:46:14 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13442; Wed, 9 Apr 1997 11:45:47 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA21362; Wed, 9 Apr 1997 11:40:47 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199704091840.LAA21362@yon.engr.sgi.com>
Subject: Re: init=/bin/sh and serial devices
To: wje@fir.esd.sgi.com (William J. Earl)
Date: Wed, 9 Apr 1997 11:40:47 -0700 (PDT)
Cc: knobi@munich.sgi.com, alambie@wellington.sgi.com, shaver@neon.ingenia.ca,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199704091831.LAA27695@fir.esd.sgi.com> from "William J. Earl" at Apr 9, 97 11:31:04 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:Martin Knoblauch writes:
:...
: >  this brings up the question: do we already have drivers for
: > the textport? Not to speak of an X-Server? How are we (SGI)
: > going to handle this? As far as I know we never published
: > the hardware dependent parts on the X11 distribution, did we?
:...
:
:    With management authorization, I provided the technical details
:for the graphics hardware (and all the other Indy hardware) to David
:Miller, who I believe got a textport driver working.
:

Also, the agreement we signed with David was that all the Linux work
including those low level drivers will be released under the GPL
i.e. anyone who cares would be able to look at these driver sources.

-- 
Peace, Ariel
