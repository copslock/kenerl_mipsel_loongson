Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA15566; Sat, 1 Jun 1996 19:12:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA12384 for linux-list; Sun, 2 Jun 1996 02:12:04 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA12379 for <linux@cthulhu.engr.sgi.com>; Sat, 1 Jun 1996 19:12:02 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA15557; Sat, 1 Jun 1996 19:12:02 -0700
Date: Sat, 1 Jun 1996 19:12:02 -0700
Message-Id: <199606020212.TAA15557@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: progress, finally...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Ok, I have a complete compilation environment that seems to work quite
well.

All the tools are GNU, I have gcc/ld/as/etc. setups which can create
either big or little endian kernels in either ELF or ECOFF format.
The target format is that used by the existing Linux/MIPS people.

These tools have been linking kernels for two days, I finally got a
big endian kernel that sash would eat and it went fine until it tried
to look for DECstation devices as that is one of the only machine
types the existing Linux/MIPS kernels support (splat!). ;-)

For now I'm going to hack the ARC prom code and the SCSI driver in
parallel and see how far I can get it booting, more to come.

Later,
David S. Miller
dm@sgi.com
