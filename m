Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA08180; Fri, 19 Apr 1996 17:22:44 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id RAA15342; Fri, 19 Apr 1996 17:22:38 -0700
Received: from yon.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id RAA15337; Fri, 19 Apr 1996 17:22:37 -0700
Received: by yon.engr.sgi.com (950413.SGI.8.6.12/940406.SGI.AUTO)
	for linux id RAA24414; Fri, 19 Apr 1996 17:22:35 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199604200022.RAA24414@yon.engr.sgi.com>
Subject: MIPS port kickoff meeting
To: linux@yon.engr.sgi.com
Date: Fri, 19 Apr 1996 17:22:35 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi LinuxMIPSies,

This is becoming real. Please mark your calendars.

We have Jamaica in B10U, which holds 12 people, from 4-5pm
on Wednesday April 24th.

I know it may conflict with someone's schedule but p l e a s e
try your best to show up.

THE MEETING HAS ONE MAIN GOAL:

	To ensure that when David Miller lands at SGI he wastes
	zero time on ramping up.  We can do a lot until he comes.

The idea Jim Barton, Larry and I had is:
	1) Office + two Indys (connected via a serial line to support
	   gdb remote protocol) already waiting, phone, email etc.
	2) Development tools installed
	3) The latest linux sources on the machine. After trying to
	   compile them and see how smoothly this goes.
	4) This may require the most work:
	   A 99% stripped down IRIX or set-top box thing that is
	   basically only the device drivers to boot and do:
		"hello console"
		"hello network"
		"hello disk"
		"hello keyboard"
		"hello console graphics"

	Given all this, David can boot Linux in a few days I guess :-)


Agenda:
	1) Quick round table: introduce everyone
	2) Sort out some details:
		Are we going for a 64-bit kernel?
		What MIPS instruction set should we support
		[e.g. 3K is important for the embedded market]
		What dev tools should we use?
		elf/coff stabs/dwarf gcc/cc etc. etc.
	4) Suggest more ways to accelerate David Miller's ramp up
	5) List action items
	6) Get volunteers for help on the above

Lastly, since David's Acceptance is final.  I think it is time
to put David himself on this mailing list too, he certainly has
some ideas on how to help us help him.

-- 
Peace, Ariel
