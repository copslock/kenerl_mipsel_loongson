Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id QAA56467 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 16:49:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA20404 for linux-list; Fri, 27 Feb 1998 16:48:31 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA20399 for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 16:48:29 -0800
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA07699
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Feb 1998 16:48:25 -0800
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.7/8.8.7) id SAA08090;
	Fri, 27 Feb 1998 18:47:59 -0600
Date: Fri, 27 Feb 1998 18:47:59 -0600
Message-Id: <199802280047.SAA08090@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: grimsy@varberg.se, ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.980227191414.20111D-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Fri, 27 Feb 1998 19:17:28 -0500 (EST))
Subject: Re: installation problem.
X-Mexico: Este es un pais de orates, un pais amateur.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > Is it possible to use MIPS/Linux yet, or is it too buggy? How much of the
> > X code is done? Are any of the SGI special devices, such as the cool
> 
> Miguel?  What's up with X exactly?  Are you short on hw specs?

No.  I am short on time.

I am rushing for a beta release of the gnome desktop thingie and until
then I am pretty busy.

For those who do not know: gnome is a user-friendly desktop that aims
at easing the usage of Unix computers.

Gnome provides a user friendly desktop, and aims at providing a
component framework for building large applications (components
modeled pretty much after microsoft's active-x, but we are using CORBA
for gluing stuff together instead of COM).  For more information
check: http://www.gnome.org and feel free to contribute to the
effort. 

Back to the X server: here is the status: the X server starts up on my
machine very happilly, but crashes the kernel sometime when clients
connect.  Not all clients crash the kernel, just some of them (if you
run an xterm or emacs you will crash the kernel). 

These are remote applications, so it is a fault in the Xserver support
in the kernel.  This happens in graphics mode, so if the kernel is
printing out a nice panic message, it never reaches the screen. 

What should be done to debug this is: inside panic() we need to
restore text mode manually (trivial to figure out from the sources,
there is some routine there) and figure out where the crash happened. 

Now, what might make debugging this a pain is that you require the
an Indy that is configured just like mine :-), as when I was doing the
X server code, I rushed to hardcode the inventory return code to
whatever my machine had, so you better have a newport that supports
24-bpp or you need to change the inventory bits (or better yet, fix
the inventory code) :-).

Getting the X server to run is trivial: just strace your X server in
IRIX and copy all of the files that are refereced by the X server.

Then create the special files in /dev with the major/minors that are
documented in the kernel and voila!

best gnoming wishes, 
Miguel.
