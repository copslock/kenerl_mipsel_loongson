Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA09116; Fri, 13 Jun 1997 10:51:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA09497 for linux-list; Fri, 13 Jun 1997 10:50:50 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA09482 for <linux@cthulhu.engr.sgi.com>; Fri, 13 Jun 1997 10:50:44 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA09670; Fri, 13 Jun 1997 10:50:28 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199706131750.KAA09670@yon.engr.sgi.com>
Subject: Re: gcc for Irix.
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Fri, 13 Jun 1997 10:50:28 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199706131654.JAA28555@fir.engr.sgi.com> from "William J. Earl" at Jun 13, 97 09:54:57 am
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:Miguel de Icaza writes:
:...
: >    I am running into a little problem.  The binary gcc that is
: > available on the free software collection is for Irix 5.3 and the
: > include files that are packaged with it are not quite ok for Irix 6.2
:...
:
:      In what way do the 5.3 include files cause problems?
:

[Note: I'm taking care of Miguel in private email]

The headers that come with gcc are:

	1) Only a very small subset of the full set of headers
	   which were preprocessed by gcc 'fix_header' utility.

	2) Correspond to the OS version on which gcc was built
	   which may be incompatible in subtle ways with the
	   runtime libraries on a later OS version.

Since Miguel's Indy is (apparently) a 6.2 IRIX, possibly
without all the necessary header patches, and the gcc he
is trying was built on 5.3, I can see why he has header
problems.

Anyway, don't worry. This is being taken care of.
-- 
Peace, Ariel
