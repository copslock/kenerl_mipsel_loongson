Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA12002; Mon, 7 Jul 1997 09:12:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA20151 for linux-list; Mon, 7 Jul 1997 09:12:02 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA20138 for <linux@engr.sgi.com>; Mon, 7 Jul 1997 09:11:58 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA26428
	for <linux@engr.sgi.com>; Mon, 7 Jul 1997 09:11:28 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id SAA28936; Mon, 7 Jul 1997 18:10:27 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707071610.SAA28936@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id SAA26501; Mon, 7 Jul 1997 18:10:25 +0200
Subject: MIPS Distribution status (Was: Status ...)
Date: Mon, 7 Jul 1997 18:10:24 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

Just to a status report about the packages Miguel mentioned.  This is
from memory, so neither complete nor 100% accurate.  I've tried more
than just these ...

 - Programs work, not even tried to packaged into RPMs yet:
    binutils gcc glibc util-linux procps sh-utils MAKEDEV bash

 - Packaging failed but otherwise working:
    apache, ncurses, dev

 - Works as far as tested:
    bison byacc flex make patch texinfo NetKit-A cpio crontabs
    diffutils dialog etcskel file findutils grep gzip ncrompress
    perl rpm textutils less sed initscripts mtools tar adduser
    textutils time fileutils rootfiles

    (Since Perl now builds shrink wrapped and passes almost the entire
    test suite someone could try starting with Debian as well)

 - Didn't try to build RPM package yet:
    NetKit-B tcp_wrapper termcap vim psmisc npasswd sysklogd
    net-tools setup

 - RPM package available but buggy:
    SysvInit statnet

 - Package doesn't build for unknown reasons:
    Emacs getty_ps e2fsprogs bdflush 

Since I'm developping offline I'm a bit lazy about merging other stuff
into my kernel.  With the VFS bug fixes a good couple more of packages
would build and work.

  Ralf
