Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA1138156 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 19:15:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA12389 for linux-list; Thu, 11 Dec 1997 19:15:33 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA12374; Thu, 11 Dec 1997 19:15:31 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA27978; Thu, 11 Dec 1997 19:15:22 -0800
Date: Thu, 11 Dec 1997 19:15:22 -0800
Message-Id: <199712120315.TAA27978@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indy crash during bootup
In-Reply-To: <19971212033448.01867@uni-koblenz.de>
References: <19971208150602.52582@brian.uni-koblenz.de>
	<ralf@uni-koblenz.de>
	<9712091934.ZM3116@mdhill.interlog.com>
	<19971210040210.27443@uni-koblenz.de>
	<9712110612.ZM1219@mdhill.interlog.com>
	<19971212033448.01867@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > William: would an attempt to manipulate the R4600 second level cache on
 > a Indy without such a cache result in a bus error interrupt?
...
     Yes.  The memory address of the cache controller will not exist.  Avoid
referencing it when the cache is not configured.  If the kernel is not
reading the cache configuration from the CPU module EEPROM, then it should
test for the existence of the cache controller by referencing it within
some sort of exception trap which returns control gracefully with an error
indication if a bus error occurs.  Note that you might get a bus error exception
(on a read) rather than a bus error interrupt (on a write).
