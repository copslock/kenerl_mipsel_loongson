Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA01109 for <linux-archive@neteng.engr.sgi.com>; Tue, 14 Oct 1997 16:28:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA06419 for linux-list; Tue, 14 Oct 1997 16:25:02 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA06395 for <linux@engr.sgi.com>; Tue, 14 Oct 1997 16:24:57 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA25161
	for <linux@engr.sgi.com>; Tue, 14 Oct 1997 16:24:55 -0700
	env-from (ralf@mail2.cobaltmicro.com)
Received: from dull.cobaltmicro.com (dull.cobaltmicro.com [209.19.61.35])
	by dns.cobaltmicro.com (8.8.5/8.8.5) with ESMTP id QAA06487;
	Tue, 14 Oct 1997 16:25:55 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Received: (from ralf@localhost)
	by dull.cobaltmicro.com (8.8.5/8.8.5) id QAA32612;
	Tue, 14 Oct 1997 16:22:28 -0700
Message-Id: <199710142322.QAA32612@dull.cobaltmicro.com>
Subject: Ancient files
Date: Tue, 14 Oct 1997 16:22:28 -0700 (PDT)
Content-Type: text
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

from a time long ago many systems probably still have the directory
/usr/include/bsd/ existing on their disk.  I guess most people got
them as a part of the root-0.01.tar.gz package.  That directory contains
a include files that originate from Linux libc which we're not using.
This files are not usefull for anything and may cause problems building
certain software, especially RedHat RPM packages from the tbird/mustang
releases that still pass the option -I/usr/include/bsd to the compiler.
The bug fix is simple:

  rm -rf /usr/include/bsd

You have to remove these packages manually; upgrading the installed
RPMs will not remove these files.

  Ralf
