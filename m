Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id BAA76900 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Sep 1997 01:53:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA23945 for linux-list; Wed, 24 Sep 1997 01:53:43 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA23935 for <linux@engr.sgi.com>; Wed, 24 Sep 1997 01:53:37 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA27014
	for <linux@engr.sgi.com>; Wed, 24 Sep 1997 01:53:35 -0700
	env-from (ralf@dns.cobaltmicro.com)
Received: (from ralf@localhost)
	by dns.cobaltmicro.com (8.8.5/8.8.5) id AAA20896;
	Wed, 24 Sep 1997 00:15:11 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Message-Id: <199709240715.AAA20896@dns.cobaltmicro.com>
Subject: glibc 2.0.4 bug ...
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, drepper@cygnus.com
Date: Wed, 24 Sep 1997 00:15:10 -0700 (PDT)
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

glibc 2.0.4 contains a fatal bug.  It does not declare a prototype for
the function llseek in unistd.h.  As result GCC will (correctly) truncate
the 64 bit file offset and build erroneous filesystems when building
filesystems of 2GB.  e2fsck will complain about read errors when trying
to read blocks from the 2GB border on.  Actually I wonder why I never saw
a report about that on other mailinglists.

Quickfix: add the following prototype for llseek(2):

  extern loff_t llseek (int fd, loff_t offset, int whence);

  Ralf
