Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id DAA15918; Tue, 8 Jul 1997 03:19:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA14226 for linux-list; Tue, 8 Jul 1997 03:18:39 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA14221 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Jul 1997 03:18:36 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA06747
	for <linux@cthulhu.engr.sgi.com>; Tue, 8 Jul 1997 03:17:48 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id MAA21226; Tue, 8 Jul 1997 12:17:16 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707081017.MAA21226@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id MAA00606; Tue, 8 Jul 1997 12:17:13 +0200
Subject: Re: MIPS Distribution status (Was: Status ...)
To: davem@jenolan.rutgers.edu (David S. Miller)
Date: Tue, 8 Jul 1997 12:17:11 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199707071619.MAA20927@jenolan.caipgeneral> from "David S. Miller" at Jul 7, 97 12:19:28 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Emacs should build strictly out of the box in an of itself, I know
> because I specifically sent RMS patches for linux-mips support the
> moment I got it working last summer with GLIBC.  (I even then logged
> in to the gnu project machines and made sure those changes made it
> into his tree ;-)
> 
> If it isn't compiling at all, tell me how it is failing.

Ok, I took a look at it.  The Emacs 19.34b does not contain the least
bit of support for mips{el}-linux, so no wonder why it doesn't build.
Can you send me your patches?  I assume RMS won't like it if we take
the Emacs snapshot from the FSF ...

Thanks,

  Ralf
