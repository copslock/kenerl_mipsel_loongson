Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA25775; Mon, 29 Apr 1996 17:07:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id RAA20673; Mon, 29 Apr 1996 17:06:56 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id RAA20665; Mon, 29 Apr 1996 17:06:55 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA25770 for <linux@neteng.engr.sgi.com>; Mon, 29 Apr 1996 17:06:54 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@neteng.engr.sgi.com> id RAA20661; Mon, 29 Apr 1996 17:06:53 -0700
Received: from relay.redhat.com by sgi.sgi.com via SMTP (950405.SGI.8.6.12/910110.SGI)
	for <linux@neteng.engr.sgi.com> id RAA22314; Mon, 29 Apr 1996 17:06:51 -0700
Received: (qmail-queue invoked from smtpd); 30 Apr 1996 00:08:48 -0000
Received: from redhat.com (199.183.24.1)
  by relay.redhat.com with SMTP; 30 Apr 1996 00:08:47 -0000
Received: (from ewt@localhost) by redhat.com (8.7.4/8.7.3) id UAA03823; Mon, 29 Apr 1996 20:06:49 -0400
Date: Mon, 29 Apr 1996 20:06:49 -0400 (EDT)
From: Erik Troan <ewt@redhat.com>
To: Larry McVoy <lm@neteng.engr.sgi.com>
cc: linux@neteng.engr.sgi.com
Subject: Re: scope of this mailing list
In-Reply-To: <199604292327.QAA18469@neteng.engr.sgi.com>
Message-ID: <Pine.LNX.3.91.960429200526.3781C-100000@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 29 Apr 1996, Larry McVoy wrote:

> to get a Linux/MIPs distribution.  Furthermore, givem that Linux/MIPs
> will run IRIX elf binaries, we might be able to merge the Freeware and
> Linux/MIPs efforts - they have a lot of overlap.  Something to think 
> about.

This raises a good question - what is the relationship between the SGI port,
a port to Digital MIPS/TurboChannel machines, and the MIPS/PC port (that
works on MIPS machines with PCI/EISA buses)? Will they all be the same
endian? Should binarises be comaptible? What about sources such as libc
and the kernel syscall interface?

Erik

-------------------------------------------------------------------------------
   Always hoped that I'd be an apostle. Knew that I would make it if I tried.
     Then when we retire we can write the gospels so they'll all talk about
         us when we die. - "The Last Supper" from Jesus Christ Superstar
|   Erik Troan   =   http://sunsite.unc.edu/ewt/   =   ewt@sunsite.unc.edu    |
