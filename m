Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA414319 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Jan 1998 13:15:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA00335 for linux-list; Mon, 5 Jan 1998 13:12:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA00323 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 13:12:37 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA01965
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 13:12:35 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA18590
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 22:12:29 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA02836;
	Mon, 5 Jan 1998 22:09:19 +0100
Message-ID: <19980105220916.59435@uni-koblenz.de>
Date: Mon, 5 Jan 1998 22:09:16 +0100
To: linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: gcc -shared ... -lc ?
References: <19980105184510.65220@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <19980105184510.65220@alpha.franken.de>; from Thomas Bogendoerfer on Mon, Jan 05, 1998 at 06:45:10PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 05, 1998 at 06:45:10PM +0100, Thomas Bogendoerfer wrote:

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

The code of libtermcap.so contains dependencies of the libc version it
was compiled with, that's why it has to be linked against libc.  Most
old libraries were not linked against libc.  This became a problem
when with the introduction of libc6 the case of having multiple
libc linked into a program had to be handled.  For example:

  vi
  |--> libtermcap.so.2
       |--> libc.so.6
  |--> libc.so.5

The of course only work right when libtermcap has been linked against
libc.

> So it looks like the ld for alpha and i386 don't include the whole libc
> when linked with the comand line above. Any hints ?

This is a binutils 2.7 bug.  Upgrading to 2.8.1 solves the problem.

  Ralf
