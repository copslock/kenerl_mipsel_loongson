Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA2678624 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 12:39:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA7049301
	for linux-list;
	Thu, 2 Apr 1998 12:38:07 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA6874113
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 12:38:05 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA17580
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 12:37:59 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA04953
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 22:37:57 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA01721;
	Thu, 2 Apr 1998 22:37:39 +0200
Message-ID: <19980402223738.08008@uni-koblenz.de>
Date: Thu, 2 Apr 1998 22:37:38 +0200
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: kernel panic
References: <199804021731.TAA00404@calypso.saturn> <199804021855.NAA08562@pluto.npiww.com> <19980402204738.29605@uni-koblenz.de> <199804021922.OAA09268@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804021922.OAA09268@pluto.npiww.com>; from Dong Liu on Thu, Apr 02, 1998 at 02:22:46PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 02, 1998 at 02:22:46PM -0500, Dong Liu wrote:

> ralf@uni-koblenz.de writes:
>  > 
>  > Surprise, the support for the serial console does not compile :-)
> 
> I know, but look at drivers/char/console.c, you don't need
> CONFIG_SERIAL_CONSOLE to be defined, it will always call
> rs_cons_hook() if CONFIG_SGI or CONFIG_SUN_SERIAL is set, and
> in arch/mips/sgi/setup.c serial_console is set if
> prom_getenv("console") returns "d" or "d2".
> 
> Maybe it should be changed to be use CONFIG_SUN_SERIAL and implement 
> function serial_console_init().

For shure not CONFIG_STUN_SERIAL :-)

  Ralf
