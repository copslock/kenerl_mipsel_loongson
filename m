Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA148172 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 10:07:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA04198 for linux-list; Mon, 24 Nov 1997 10:03:21 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA04042 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 10:03:04 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA25937
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 10:03:00 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA18033
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 19:02:58 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id SAA02601;
	Mon, 24 Nov 1997 18:16:32 +0100
Message-ID: <19971124181631.64922@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 18:16:31 +0100
From: ralf@uni-koblenz.de
To: linux-mips@fnet.fr
Cc: ewt@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Libc in CVS
References: <19971124141804.17724@lappi.waldorf-gmbh.de> <Pine.LNX.3.95.971124105430.7590F-100000@lacrosse.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.971124105430.7590F-100000@lacrosse.redhat.com>; from Erik Troan on Mon, Nov 24, 1997 at 10:55:25AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Nov 24, 1997 at 10:55:25AM -0500, Erik Troan wrote:
> On Mon, 24 Nov 1997 ralf@lappi.waldorf-gmbh.de wrote:
> > For rpm the trick is easy, just don't use a static linked binary.
> > Unfortunately the Redhat guys seem to think static binaries are a good
> > idea and install a static rpm by default.  Which it is not, not even
> > without a buggy dynamic linker.
> 
> A static RPM has saved my ass *many* times, and it would irresponsible
> for us not to ship it static.

I'm not arguing against static binaries because we've got a bug in the
libs.

 - static binaries contain syscalls and therefore make it very difficult,
   if not impossible to modify the kernel interfaces.

   The SVID btw., explicitly forbids embedding syscalls into ABI compliant
   binaries.  While SVID compliance is not directly mandatory for Linux,
   binary compatibility issues with IRIX (or Solaris or ...) etc. might
   somewhen enforce modifications to the syscall interface resulting in
   broken static binaries.

 - many static binaries will use dlopen() to load _shared_ libraries under
   certain circumstances.  Rpm is just one of them.  For example try with
   your static rpm

     rm -f /lib/*.so*
     rpm --install ftp://ftp.whitehat.org/libc-2.0.5-.rpm

   Won't work, because you don't have your shared libc and libnss anymore ...
   I admit that this type of desaster recovery was nicer with Linux libc
   which doesn't do the dlopen() thing.

> Glibc ought to be able to generate static binaries. If it can't, it's broken.

Yes, and the bugs have been fixed.

  Ralf
