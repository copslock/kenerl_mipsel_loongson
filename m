Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA2692167 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 12:57:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA7050586
	for linux-list;
	Thu, 2 Apr 1998 12:55:21 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA7054593
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 12:55:14 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id MAA23243
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 12:55:05 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id QAA02569; Thu, 2 Apr 1998 16:03:27 -0500
Date: Thu, 2 Apr 1998 16:10:06 -0500
Message-Id: <199804022110.QAA11632@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: kernel panic
In-Reply-To: <19980402223738.08008@uni-koblenz.de>
References: <199804021731.TAA00404@calypso.saturn>
	<199804021855.NAA08562@pluto.npiww.com>
	<19980402204738.29605@uni-koblenz.de>
	<199804021922.OAA09268@pluto.npiww.com>
	<19980402223738.08008@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Thu, Apr 02, 1998 at 02:22:46PM -0500, Dong Liu wrote:
 > 
 > > ralf@uni-koblenz.de writes:
 > >  > 
 > >  > Surprise, the support for the serial console does not compile :-)
 > > 
 > > I know, but look at drivers/char/console.c, you don't need
 > > CONFIG_SERIAL_CONSOLE to be defined, it will always call
 > > rs_cons_hook() if CONFIG_SGI or CONFIG_SUN_SERIAL is set, and
 > > in arch/mips/sgi/setup.c serial_console is set if
 > > prom_getenv("console") returns "d" or "d2".
 > > 
 > > Maybe it should be changed to be use CONFIG_SUN_SERIAL and implement 
 > > function serial_console_init().
 > 
 > For shure not CONFIG_STUN_SERIAL :-)
 > 
Sorry, I meant CONFIG_SERIAL_CONSOLE, victim of emacs' dabbrev-expand :=).

Dong
