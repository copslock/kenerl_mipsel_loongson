Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA11273; Tue, 27 May 1997 12:49:08 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA09974 for linux-list; Tue, 27 May 1997 12:48:59 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA09964; Tue, 27 May 1997 12:48:58 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA07850; Tue, 27 May 1997 12:48:37 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199705271948.MAA07850@yon.engr.sgi.com>
Subject: Re: strace/truss equiv?
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Tue, 27 May 1997 12:48:37 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199705271919.PAA21206@neon.ingenia.ca> from "Mike Shaver" at May 27, 97 03:19:29 pm
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:OK, I'll bite.
:What's the strace/truss equivalent under IRIX?
:
:I'm trying to figure out why my "dynamically-linked" hello world
:binaries are 115K, and I can't tell where the heck the linker is
:finding the static libs.
:
:Mike
:
As Luc mentioned, you may use 'par' the advantages are that it
has many more features and almost no overhead. One notable
disadvantage however (especially for userland debugging) is that
it uses some special kernel services for async event notifications
so its trace output is asynchronous to the traced process.

I guess you would prefer 'strace' to 'par' (like I do) you may get
a precompiled binary for IRIX at:

	http://reality.sgi.com/ariel/freeware/

Note that this version doesn't support tracing 64-bit binaries.

Thank David Miller for making strace work under 6.x.
-- 
Peace, Ariel
