Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id CAA05954 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 02:30:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA00045 for linux-list; Wed, 14 Jan 1998 02:25:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA00036; Wed, 14 Jan 1998 02:24:51 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA13488; Wed, 14 Jan 1998 02:24:45 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id LAA12540;
	Wed, 14 Jan 1998 11:24:43 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA04678;
	Wed, 14 Jan 1998 11:21:40 +0100
Message-ID: <19980114112140.30899@uni-koblenz.de>
Date: Wed, 14 Jan 1998 11:21:40 +0100
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Cc: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: maybe the clue for the memory/boot loader problem ..
References: <Pine.SGI.3.94.980113220740.5128A-100000@tantrik.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.SGI.3.94.980113220740.5128A-100000@tantrik.engr.sgi.com>; from Shrijeet Mukherjee on Tue, Jan 13, 1998 at 10:10:38PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 13, 1998 at 10:10:38PM -0800, Shrijeet Mukherjee wrote:

> running file on vmlinux and /unix gave me this ..
> 
> vmlinux:  ELF 32-bit LSB
> 
> /unix:  ELF N32 MSB mips-3 executable (not stripped) MIPS - version 1
> 
> I guess this would mean I have a compilation with the wrong byte order ..
> :-( ... so what is the endianess of the indigo ??

Big endian, of course.  Did you just build a kernel for the default
configuration of the source tree?  That's for another machine which I'm
usually using a my guinea test pig ...

  Ralf
