Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA03129; Mon, 16 Jun 1997 22:32:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA10936 for linux-list; Mon, 16 Jun 1997 22:32:41 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA10929 for <linux@cthulhu.engr.sgi.com>; Mon, 16 Jun 1997 22:32:39 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA21266 for <linux@yon.engr.sgi.com>; Mon, 16 Jun 1997 22:32:38 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA10920; Mon, 16 Jun 1997 22:32:37 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA08863; Mon, 16 Jun 1997 22:32:35 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id BAA14916; Tue, 17 Jun 1997 01:31:13 -0400
Date: Tue, 17 Jun 1997 01:31:13 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Larry McVoy <lm@neteng.engr.sgi.com>
cc: Ariel Faigon <ariel@sgi.com>, Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
        linux@yon.engr.sgi.com
Subject: Re: Good news: no more begging for HW 
In-Reply-To: <199706170225.TAA23023@neteng.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.970617004550.28820F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Although I've posted before, I'll fill out the 'form' for reference.
Excuse the verbosity.

On Mon, 16 Jun 1997, Larry McVoy wrote:
> 	who am i?

Professionally, I'm a software engineer for IAC in Boston, MA, where I do
work with large databases.  I've also worked with TimeStep in Ottawa doing
VPN's and IPSEC, and NorTel/BNR doing very quirkly large scale revision
control tools. Lots of Unix and IP experience in this.

But, Linux experience comes from a project called EngSoc, which I started
and maintain almost solely at Carleton University in Ottawa two years ago. 
It provides full Linux access for 1,500 users on 20 machines in under
$8,000US annually. We have done a lot of hardware recovery, and, er,
creative implementations.

I've donated 30 hours a week maintaining and expanding the system for the
last two years, but it's time to move on to something newer, like
SGI-Linux. 

I have a lot of varied experience with Unices (Solaris, SunOS, Linux,
Net/FreeBSD, HPUX, OSx (oooh... SVR3 and BSD, in the same OS), Irix, etc)
and VMS, and the porting that goes along with it. 

So, clearly, I don't have nearly the experience that some people on the
list do with low level kernel authority (eg. Ralf, who must dream in MIPS 
assembler), but I am committed to this project and have been since I first
heard of it.

> 	what will i do w/ the machine?

Mostly, concentrate on userspace applications, although certainly I will
help test and debug kernels, gcc and libc. I'd like to concentrate on
porting all RPM's I can get my hands on, with a concentration on RedHat
4.2.

I'm also interested in getting an X server running smoothly on it, as well
as getting native file system support running well.

So far, my work has been on Mike's bogomips.ingenia.ca, but I can't do
much more without having physical access.

> 	when will it be done?

It depends. I suspect most of the common userland ports can be done over
three months, but there'll be subsequent releases, updates, etc.  I will
be happy when RedHat releases an official Linux/SGI CD.

- Alex
