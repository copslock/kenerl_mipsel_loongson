Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA02473 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Jan 1998 22:15:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA26863 for linux-list; Tue, 13 Jan 1998 22:10:41 -0800
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [192.26.72.25]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA26859 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 22:10:39 -0800
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id WAA05040 for <linux@cthulhu>; Tue, 13 Jan 1998 22:10:38 -0800 (PST)
Date: Tue, 13 Jan 1998 22:10:38 -0800 (PST)
From: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
To: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: maybe the clue for the memory/boot loader problem ..
Message-ID: <Pine.SGI.3.94.980113220740.5128A-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



running file on vmlinux and /unix gave me this ..

vmlinux:  ELF 32-bit LSB

/unix:  ELF N32 MSB mips-3 executable (not stripped) MIPS - version 1

I guess this would mean I have a compilation with the wrong byte order ..
:-( ... so what is the endianess of the indigo ??
