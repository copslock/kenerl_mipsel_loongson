Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA04588; Thu, 12 Jun 1997 12:02:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA08080 for linux-list; Thu, 12 Jun 1997 12:02:32 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA08065 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Jun 1997 12:02:30 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA06340 for <linux@yon.engr.sgi.com>; Thu, 12 Jun 1997 12:02:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA07871 for <linux@yon.engr.sgi.com>; Thu, 12 Jun 1997 12:02:00 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA13365
	for <linux@yon.engr.sgi.com>; Thu, 12 Jun 1997 12:01:52 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id OAA11965; Thu, 12 Jun 1997 14:59:23 -0400
Date: Thu, 12 Jun 1997 14:59:23 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
cc: linux@yon.engr.sgi.com
Subject: Re: C Compiler on my Indy.
In-Reply-To: <199706121709.MAA01751@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970612145542.32320H-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 12 Jun 1997, Miguel de Icaza wrote:
> 
>    I am trying to populate my machine with GNU programs, and I quickly
> found that I did not have a C compiler.  
> 
>    Anyone have a pointer to where can I get the SGI C compiler, or a
> pre-compiled gcc binary for irix-6.2?

Yup.  Ariel packaged gcc 2.7.3 a few weeks ago.  It and other Irix
programs are on http://www.sgi.com/TasteOfDT/public/freeware2.0/ or
similiar.

>    I am getting Ralf cross-compilers (irix->linux) to start work on
> the libc.

The cross compilers that Mike Shaver has on his i86 Linux box seems to
work pretty much perfectly.  However, I can't for the life of me get a
native compiler for mips-linux.  If anyone has any pointers... 

- Alex
