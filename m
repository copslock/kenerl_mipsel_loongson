Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA02312 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 09:08:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA23805 for linux-list; Wed, 14 Jan 1998 09:08:25 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA23801; Wed, 14 Jan 1998 09:08:24 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA16647; Wed, 14 Jan 1998 09:08:23 -0800
Date: Wed, 14 Jan 1998 09:08:23 -0800
Message-Id: <199801141708.JAA16647@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Cc: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: maybe the clue for the memory/boot loader problem ..
In-Reply-To: <Pine.SGI.3.94.980113220740.5128A-100000@tantrik.engr.sgi.com>
References: <Pine.SGI.3.94.980113220740.5128A-100000@tantrik.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Shrijeet Mukherjee writes:
 > 
 > 
 > running file on vmlinux and /unix gave me this ..
 > 
 > vmlinux:  ELF 32-bit LSB
 > 
 > /unix:  ELF N32 MSB mips-3 executable (not stripped) MIPS - version 1
 > 
 > I guess this would mean I have a compilation with the wrong byte order ..
 > :-( ... so what is the endianess of the indigo ??

      Yes, you do.  Indigo, like all SGI systems, is big-endian ("MSB").  
Among MIPS-based systems, DEC and the ARC MIPS NT systems are the primary
little-endian systems.  All the MIPS ABI-capable systems are big-endian.
(A few, notably the MIPS Magnum and Millenium systems, can be either.)
