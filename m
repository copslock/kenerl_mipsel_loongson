Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA20653; Sat, 1 Jun 1996 20:36:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA22246 for linux-list; Sun, 2 Jun 1996 03:36:25 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA22241 for <linux@cthulhu.engr.sgi.com>; Sat, 1 Jun 1996 20:36:23 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA24950; Sat, 1 Jun 1996 20:35:48 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199606020335.UAA24950@yon.engr.sgi.com>
Subject: Re: progress, finally...
To: dm@neteng.engr.sgi.com (David S. Miller)
Date: Sat, 1 Jun 1996 20:35:47 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199606020212.TAA15557@neteng.engr.sgi.com> from "David S. Miller" at Jun 1, 96 07:12:02 pm
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David,

This is very impressive progress. Thanks for the update!

I understand you have the prom pointers. A few that _may_
be relevant are in:

	http://info.engr.sgi.com/~ariel/linux/port.html

This doc was put together in a rush, any suggestions, requests
for additions etc. would be welcome.

>
>
>Ok, I have a complete compilation environment that seems to work quite
>well.
>
>All the tools are GNU, I have gcc/ld/as/etc. setups which can create
>either big or little endian kernels in either ELF or ECOFF format.
>The target format is that used by the existing Linux/MIPS people.
>
>These tools have been linking kernels for two days, I finally got a
>big endian kernel that sash would eat and it went fine until it tried
>to look for DECstation devices as that is one of the only machine
>types the existing Linux/MIPS kernels support (splat!). ;-)
>
>For now I'm going to hack the ARC prom code and the SCSI driver in
>parallel and see how far I can get it booting, more to come.
>
>Later,
>David S. Miller
>dm@sgi.com
>


-- 
Peace, Ariel
