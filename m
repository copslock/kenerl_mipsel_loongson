Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA11152; Mon, 10 Jun 1996 17:13:53 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA10445 for linux-list; Tue, 11 Jun 1996 00:13:41 GMT
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA10419 for <linux@cthulhu.engr.sgi.com>; Mon, 10 Jun 1996 17:13:38 -0700
Received: by soyuz.wellington.sgi.com (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	for linux@cthulhu.engr.sgi.com id MAA03444; Tue, 11 Jun 1996 12:13:36 +1200
From: alambie@wellington.sgi.com (Alistair Lambie)
Message-Id: <199606110013.MAA03444@soyuz.wellington.sgi.com>
Subject: Is this a silly idea?
To: linux@cthulhu.engr.sgi.com
Date: Tue, 11 Jun 1996 12:13:36 +1200 (NZT)
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Folks,

I guess a lot of people will have both Linux and that other operating system
on there machines for various reasons.  One thing that I know I would find
useful is to be able to have a filesystem that could be accessed from 
whichever OS you had loaded (eg. for putting mail and other common things on).

I'm not sure what the best way to attack this would be, but my guess is that
we need to put the common filesystem in Irix, as I would pick that it would
be difficult to get the buyin to port one of our filesystems to Linux.

Several questions:

1. Is this sensible (or is there already a way of doing this)?

2. If it is sensible, what should we do (type of fs etc)?

3. Does anyone know how easy this is (I'm not sure whether I'm brave enough!)?

Just a thought....

Alistair

PS - I get 61.64 Bogomips on a 100MHz R4600PC
