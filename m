Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id DAA142451 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 03:16:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA29230 for linux-list; Mon, 12 Jan 1998 03:11:24 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA29224 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 03:11:22 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA02880
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 03:11:06 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA23995
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 12:11:03 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id JAA01223;
	Mon, 12 Jan 1998 09:58:05 +0100
Message-ID: <19980112095804.26411@uni-koblenz.de>
Date: Mon, 12 Jan 1998 09:58:04 +0100
To: "K." <conradp@cse.unsw.edu.au>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: crtbegin.o, crtend.o
References: <Pine.GSO.3.95.980112161052.11350F-100000@l4-00.orchestra.cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.GSO.3.95.980112161052.11350F-100000@l4-00.orchestra.cse.unsw.EDU.AU>; from K. on Mon, Jan 12, 1998 at 04:23:37PM +1100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 12, 1998 at 04:23:37PM +1100, K. wrote:

> um... can anyone point out where these files can be obtained? In our
> recent install, (Indy R4600) made from the root-be-0.01 root filesystem
> with the recent binutils-2.8.1-2, they are missing. We hacked out dummy
> object files (crtbegin has a __main() which calls main() and crtend is
> empty) and we can successfully compile simple programs; but before we turn
> our attention to compiling nastier pieces of code we would like to check
> that we have not tainted our /usr/lib :)

Upgrade your system with all the rpm packages.  root-0.01 was my first
collection of Indy executables and basically_every_ ELF file has bugs in
it ...

  Ralf
