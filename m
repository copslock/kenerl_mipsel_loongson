Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA16802; Fri, 13 Jun 1997 17:39:37 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA04290 for linux-list; Fri, 13 Jun 1997 17:39:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA04279 for <linux@engr.sgi.com>; Fri, 13 Jun 1997 17:39:16 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA02942
	for <linux@engr.sgi.com>; Fri, 13 Jun 1997 17:39:14 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id BAA16498
	for <linux@engr.sgi.com>; Sat, 14 Jun 1997 01:30:42 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id CAA08292 for linux@engr.sgi.com; Sat, 14 Jun 1997 02:29:45 +0200
Message-Id: <199706140029.CAA08292@kernel.panic.julia.de>
Subject: Kernel load address
To: linux@cthulhu.engr.sgi.com
Date: Sat, 14 Jun 1997 02:29:44 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

on SGI we load the kernel to the address 0x88069000.  See arch/mips/Makefile.
Is there any special reason for that address?

  Ralf
