Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA02688 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Jan 1998 22:31:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA00072 for linux-list; Tue, 13 Jan 1998 22:29:02 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA00067; Tue, 13 Jan 1998 22:29:00 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA02491; Tue, 13 Jan 1998 22:28:54 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA28085;
	Wed, 14 Jan 1998 01:31:49 -0500
Date: Wed, 14 Jan 1998 01:31:49 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
cc: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: maybe the clue for the memory/boot loader problem ..
In-Reply-To: <Pine.SGI.3.94.980113220740.5128A-100000@tantrik.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.980114012933.10190I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 13 Jan 1998, Shrijeet Mukherjee wrote:
> running file on vmlinux and /unix gave me this ..
> vmlinux:  ELF 32-bit LSB
> /unix:  ELF N32 MSB mips-3 executable (not stripped) MIPS - version 1
> 
> I guess this would mean I have a compilation with the wrong byte order ..
> :-( ... so what is the endianess of the indigo ??

Unless there's something very odd I'm missing, your Indigo will run big
endian binaries only.

(Oh, and I can now compile my own kernels. 2.1.72, anyone?)

- Alex
