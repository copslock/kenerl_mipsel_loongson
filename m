Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA19886; Fri, 6 Jun 1997 11:46:15 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA24983 for linux-list; Fri, 6 Jun 1997 11:46:04 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA24952 for <linux@cthulhu.engr.sgi.com>; Fri, 6 Jun 1997 11:46:00 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA17967 for <linux@yon.engr.sgi.com>; Fri, 6 Jun 1997 11:45:33 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA24816; Fri, 6 Jun 1997 11:45:30 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA15789; Fri, 6 Jun 1997 11:45:23 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id TAA19881;
	Fri, 6 Jun 1997 19:38:34 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id UAA18495; Fri, 6 Jun 1997 20:36:49 +0200
Message-Id: <199706061836.UAA18495@kernel.panic.julia.de>
Subject: Re: Merge back of the MIPS sources
To: mende@piecomputer.engr.sgi.com (Bob Mende Pie)
Date: Fri, 6 Jun 1997 20:36:48 +0200 (MET DST)
Cc: ralf@Julia.DE, ariel@sgi.com, linux@yon.engr.sgi.com
In-Reply-To: <199706061807.LAA01554@piecomputer.engr.sgi.com> from "Bob Mende Pie" at Jun 6, 97 11:07:29 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>    Have you verified that the newest code still works on the other MIPS
> based systems?   Also, is it possible to have (linux) binary compatability
> between a mips Magnum or Millennium and an Indy?

By principle there is no problem to feed these machines even with IRIX
binaries.  Right now the port to these machines assumes that it is running
on the machine configured to little endian mode but porting to big endian
should be easy.

>    There is a 50Mhz Millennium over here that we might be able to use as a
> test system.

The support for these machines is currently not complete yet.  We don't
yet have SCSI driver which should be easy to write because the machine
also uses the same NCR53C94 / FAS213 SCSI chip as the Sparc port already
does.

In fact I'd be very happy if someone would take care of these machines.
By supporting the Millenium we'd also have most of the support for the
Olivetti M700 (mostly an OEM Magnum), Acer PICA, certain machines based
on a Toshiba chipset and at least partially the NEC RISCstation series.

>                             /Bob...                    mailto:mende@sgi.com
>                       http://reality.sgi.com/mende/          KF6EID

73 de Ralf
