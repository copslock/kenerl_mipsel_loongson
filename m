Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA1084951 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 07:57:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA19148 for linux-list; Thu, 11 Dec 1997 07:56:47 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA19132 for <linux@engr.sgi.com>; Thu, 11 Dec 1997 07:56:43 -0800
Received: from comsoon.login.net ([192.219.254.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA14430
	for <linux@engr.sgi.com>; Thu, 11 Dec 1997 07:56:40 -0800
	env-from (jalonso@linguini.kaydara.com)
Received: (uucp@localhost) by comsoon.login.net (8.6.12/8.6.5) with UUCP id KAA08392; Thu, 11 Dec 1997 10:12:33 -0500
Received: from capellini-ii (capellini.kaydara.com [192.0.2.25]) by linguini.kaydara.com (950413.SGI.8.6.12/8.6.9) with SMTP id KAA26651; Thu, 11 Dec 1997 10:07:45 -0500
Message-ID: <348FFDBF.EE8@kaydara.com>
Date: Thu, 11 Dec 1997 09:50:39 -0500
From: Joe Alonso <jalonso@kaydara.com>
Reply-To: jalonso@kaydara.com
Organization: Kaydara
X-Mailer: Mozilla 3.0 (Win95; I)
MIME-Version: 1.0
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, ewt@redhat.com,
        linux-mips@vger.rutgers.edu
Subject: Re: Announce: New uploads
References: <19971210151448.23359@thoma.uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Pardon my ignorance, but...
I have a couple of questions;  
is there a how-to document that outlines how to load linux on an sgi?
is the Indigo Elan (r4000) supported?

I'm not sure how to initialize a loading of linux on the sgi.
Here's what I've assumed:
- bring over the src's to the sgi
- compile a basic system (under irix)
- copy over the original irix kernel with the new linux kernel
- re-boot

The begging questions:
The FS are not compatible, therefore a new mkfs has to be done on the
(root) partitions.
This just doesn't "sound" right to me. 
What am I overlooking?

ja


Ralf Baechle wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> 
> Hi all,
> 
> ok, here are the toys I promised to upload to ftp.linux.sgi.com:
> 
>  - tons of srpms some of which have been modified compared to RedHat's
>    original versions for the ``Mustang'' release and  big endian binaries.
>  - tarballs of libc binaries.
>  - srpms and both big and little endian binaries of an updated binutils
>    package.
>  - a tarball with big endian binaries of XFree 3.3.1.
>  - kernel binaries for the Indy and RM200.  The RM200 kernel has the support
>    for a couple of other little endian machines in it but I didn't test.
> 
> All in all this is around 350mb.
> 
> Have fun leeching,
> 
>   Ralf
>
