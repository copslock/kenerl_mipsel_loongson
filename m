Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA395255 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Jan 1998 10:06:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA28680 for linux-list; Mon, 5 Jan 1998 10:03:36 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA28623 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 10:03:27 -0800
Received: from mail.cobaltmicro.com ([209.19.61.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA20913
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 10:03:20 -0800
	env-from (tim@caddyshack.cobaltmicro.com)
Received: from caddyshack.cobaltmicro.com (caddyshack.cobaltmicro.com [209.19.61.17])
	by mail.cobaltmicro.com (8.8.7/8.8.7) with SMTP id KAA18532;
	Mon, 5 Jan 1998 10:10:53 -0800
Date: Mon, 5 Jan 1998 10:10:02 -0800 (PST)
From: Timothy Stonis <tim@caddyshack.cobaltmicro.com>
To: linux-mips@fnet.fr
cc: linux@cthulhu.engr.sgi.com
Subject: Re: gcc -shared ... -lc ?
In-Reply-To: <19980105184510.65220@alpha.franken.de>
Message-ID: <Pine.LNX.3.96.980105100903.21775A-100000@caddyshack.cobaltmicro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


 This is a bug in binutils. I think it is fixed in version 2.8.1. Ralf is
more familiar with the problem.

_Tim

On Mon, 5 Jan 1998, Thomas Bogendoerfer wrote:

> Hi,
> 
> while compiling redhat 5.0 rpms, I've found something very strange, when
> building shared libraries. Some of the built shared libs are very big and
> a nm on them shows, that the whole libc (I guess so) is included.  Binaries
> inked against these library just dump core. The built line for these shared 
> libs always ends with a -lc. Now I'm wondering wether this is a ld bug or
> just a user error. What's really weird is the following patch from one
> of the redhat rpms:
> 
> --- termcap-2.0.8/Makefile.ewt  Tue Jul  8 11:08:00 1997
> +++ termcap-2.0.8/Makefile      Tue Jul  8 11:08:12 1997
> @@ -41,7 +41,7 @@
>  
>  $(SHARED_LIB): $(OBJS)
>         cd pic; \
> -       $(CC) -shared -o ../$@ -Wl,-soname,$(SONAME_SHARED_LIB) $(OBJS)
> +       $(CC) -shared -o ../$@ -Wl,-soname,$(SONAME_SHARED_LIB) $(OBJS) -lc
>  
>  pic:
>         -if [ ! -d pic ]; then mkdir pic; fi
> 
> So it looks like the ld for alpha and i386 don't include the whole libc
> when linked with the comand line above. Any hints ?
> 
> Thomas.
> 
> -- 
> See, you not only have to be a good coder to create a system like Linux,
> you have to be a sneaky bastard too ;-)
>                    [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
> 
