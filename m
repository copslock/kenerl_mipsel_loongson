Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA3673758 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 May 1998 11:24:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA18408566
	for linux-list;
	Sun, 3 May 1998 11:22:36 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA19854875
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 3 May 1998 11:22:33 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA29347
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 May 1998 11:22:32 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA17010;
	Sun, 3 May 1998 14:22:27 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 3 May 1998 14:22:27 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Hanging.
In-Reply-To: <19980502125234.04479@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980503141144.16809A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, 2 May 1998 ralf@uni-koblenz.de wrote:
> If they keyboard is still working, try pressing <ALT>+<Scroll Lock>.  This
> should print a register dump.  That dump might end up in the syslog
> depending from your setup.  Does the keyboard still work (try toggling
> the caps lock led with caps lock)?  If you get such a register dump, could
> you please send it to me?

Alright.  My machine had been hung since last night at 9pm, so this is 17
hours later.  Here's what's on my console, hand typed because I'm not
bright enough to have a serial console:

from before:
zsh: Exception at [<8801800e4>] (80018234)

after my alt-scroll lock:
$0 : 00000000 88130000 00000000 8a7863f8
$4 : 8a786500 8bf5bf48 8a786500 00023ea1
$8 : 80000000 80000000 881702d0 00000001
$12: fffffffc 1000fc01 00000000 7ffff8f0
$16: 8836eaa0 00000b64 00005ebc 00000002
$20: 0000bf8b 00000001 00000000 9fc56394
$24: 00000000 0fb6710
$28: 8bf5a000 8bf5bf38 9fc4be88 8803be90
epc   : 88034d6c
Status: 1000fc03
Cause : 00000400

The kernel I'm running is 2.1.91, which I got from Ralf in
~ralf/vmlinuz.gz or similiar on linus.

- Alex
