Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA06606; Tue, 23 Apr 1996 13:27:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id NAA16317; Tue, 23 Apr 1996 13:26:58 -0700
Received: from yon.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id NAA16308; Tue, 23 Apr 1996 13:26:56 -0700
Received: by yon.engr.sgi.com (950413.SGI.8.6.12/940406.SGI.AUTO)
	for linux id NAA00059; Tue, 23 Apr 1996 13:26:54 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199604232026.NAA00059@yon.engr.sgi.com>
Subject: What target (was David ...)
To: linux@yon.engr.sgi.com
Date: Tue, 23 Apr 1996 13:26:53 -0700 (PDT)
In-Reply-To: <199604231951.MAA01292@titian> from "Mike McDonald" at Apr 23, 96 12:51:24 pm
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike asked (not a dumb Q, BTW):
>
>  A dumb question, what exactly is the purpose of porting Linux to
>SGI/Mips boxes?
>
Looks like there are many opinions. I don't care as long as we
manage to do this port. Whatever we port it to (and the wider the
port is) SGI is going to benefit tremendously. You may read
my Linux pages (http://info.engr/~ariel/linux) to understand why
my personal conviction (and others) is so strong.

Some of the nice things about Linux are:

	1) It can work from RAM (virtual disk),
	    So it follows that it is easily ROMable and
	    embeddable (much more so than IRIX)

	    I have developed embedded apps for several years in my past
	    and I can tell you that my life would have been infinitely
	    easier had I been able to develop in a Linux env.
	    Only the thought of having the same env on the host
	    and the target is revolutionary by itself (and possible!)

	2) It has a small footprint so naturally it is a good candidate
	   for embedded market.

	3) It has a common single source code for 32-bit and 64-bit
	   machines (Alpha). So we shouldn't think of this as an "either/or"
	   proposition.

P.S.
gcc doesn't have support for 64 bit MIPS 27 ISA, I guess, but
nobody is stopping us from using our compilers (as well as gcc
at our convenience).
-- 
Peace, Ariel
