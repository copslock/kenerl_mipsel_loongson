Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA910118 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Sep 1997 19:54:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA04333 for linux-list; Wed, 3 Sep 1997 19:53:50 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA04326; Wed, 3 Sep 1997 19:53:48 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA24709; Wed, 3 Sep 1997 19:53:47 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199709040253.TAA24709@oz.engr.sgi.com>
Subject: Re: Linux/SGI
To: ratfink@xtra.co.nz (Brendan Black)
Date: Wed, 3 Sep 1997 19:53:47 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <340DF260.5D60941F@xtra.co.nz> from "Brendan Black" at Sep 4, 97 11:27:28 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:Hi
:
:we don't have a spare Indy to play with, but have a
:spare Challenge S (single processor R5000) 
:
:I was wondering if you thing this machine is possible, it would be 
:used with a serial console (no X), for testing ;)
:-- 

If you feel up to the challenge, sure, please go ahead.

There may be a few assumptions in the current code which detects
the newport graphics console that this testing may uncover. If 
you can fix this so it won't be Indy dependent, we win one more
possible platform !

Moreover, since a challenge-S doesn't have graphics anyway
Linux which is fast and compact may even outperform IRIX
on some benchmarks.

I would suggest that:

1) You join the mailing list:
	To: majordomo@engr.sgi.com
	Body: subscribe linux your@preferred.email.address
   if you have questions, ask...

2) If you have Challenge-S patches, e-mail them to the list
   and we can check that they didn't break anything and
   merge them into the source tree.

-- 
Peace, Ariel
