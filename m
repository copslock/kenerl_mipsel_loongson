Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA885124 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Sep 1997 16:38:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA08871 for linux-list; Tue, 30 Sep 1997 16:37:47 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA08859 for <linux@engr.sgi.com>; Tue, 30 Sep 1997 16:37:42 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA00538
	for <linux@engr.sgi.com>; Tue, 30 Sep 1997 16:36:23 -0700
	env-from (ralf@dns.cobaltmicro.com)
Received: (from ralf@localhost)
	by dns.cobaltmicro.com (8.8.5/8.8.5) id QAA22417
	for linux@engr.sgi.com; Tue, 30 Sep 1997 16:36:24 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Message-Id: <199709302336.QAA22417@dns.cobaltmicro.com>
Subject: IRIX ELF docs
To: linux@cthulhu.engr.sgi.com
Date: Tue, 30 Sep 1997 16:36:24 -0700 (PDT)
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

our current linker is producing IRIX flavored ELF binaries, not MIPS
ABI.  We still seem to have some bugs in the dynamic linker and these
are now pretty close to the top on my to do list.  However I've got
not documentation about the IRIX binary format, so I'm pretty much
relying on reverse engineering for fixing them.  Does anybody have
a pointer to documentation or documentation about IRIX ELF flavoured
o32 bit object file format?

  Ralf
