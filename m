Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA1169637 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 19:10:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA11054 for linux-list; Thu, 11 Dec 1997 19:09:10 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA11033 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 19:09:08 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA21955
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 19:09:05 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-09.uni-koblenz.de [141.26.249.9])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA24067
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 04:08:34 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA03326;
	Fri, 12 Dec 1997 02:42:09 +0100
Message-ID: <19971212024209.20676@uni-koblenz.de>
Date: Fri, 12 Dec 1997 02:42:09 +0100
To: karo@artcom.net, mike@mdhill.interlog.com
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Uploads ...
References: <19971208150602.52582@brian.uni-koblenz.de> <ralf@uni-koblenz.de> <9712091934.ZM3116@mdhill.interlog.com> <19971210040210.27443@uni-koblenz.de> <34906346.C1FB7311@artcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <34906346.C1FB7311@artcom.net>; from Benjamin Pannier on Thu, Dec 11, 1997 at 11:03:50PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 11, 1997 at 11:03:50PM +0100, Benjamin Pannier wrote:

> tty01 at 0xbfbd9830 (irq = 21) is Zilog8530
> loop: registered device at major 7
> Got a bus error IRQ, shouldn't ...

Bad, the two register dumps you and Mike mailed don't make very much
sense; the epc register is pointer to completly different routines.
What both reports have in common is that the kernel dies after the
initialisation of the loop device.  The loop driver is actually
``harmless'' as it has no SGI specific code.  The next driver to
be initialized would be the SCSI driver, so the problem is there.
This and the useless epc values might indicate a problem with the
hpc dma.

I wonder if the DMA engine in the HPC might still be active?

I'm going to try to solve the problem by starring at the source.  If
this doesn't help, could you guys please run a special debug kernel
that I'll make for you?

  Ralf
