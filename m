Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA342942; Fri, 22 Aug 1997 14:17:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA00265 for linux-list; Fri, 22 Aug 1997 14:15:59 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA00212 for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 14:15:53 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA12044
	for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 14:15:48 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id RAA18541; Fri, 22 Aug 1997 17:15:11 -0400
Date: Fri, 22 Aug 1997 17:15:11 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Kernel compile errors...
In-Reply-To: <199708221549.KAA17711@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970822171154.1607C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 22 Aug 1997, Miguel de Icaza wrote:

> > I just checked out the latest kernel, and I get the following errors when
> > I try to compile. Uh, what am I doing wrong?  I'm afraid MIPS assembler is
> > above me.
> 
> Strange, I have been using the gcc and binutils packages put together
> by Ralf for a long time, it is not the stock gcc/binutils, probably
> this is your problem?

I don't think so.  The ones I'm using are those from Ralf as well.  I will
double check to make sure.

Mike is having this problem on his machine too, I believe.

What I want to do is add in initrd support so that I can try out my new
boot image.

- Alex
