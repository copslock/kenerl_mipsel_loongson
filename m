Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA3662316 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 May 1998 11:41:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19517460
	for linux-list;
	Sun, 3 May 1998 11:40:29 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA19826839
	for <linux@engr.sgi.com>;
	Sun, 3 May 1998 11:40:27 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA02027
	for <linux@engr.sgi.com>; Sun, 3 May 1998 11:40:24 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-17.uni-koblenz.de [141.26.249.17])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id UAA19132
	for <linux@engr.sgi.com>; Sun, 3 May 1998 20:40:22 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA05694;
	Sun, 3 May 1998 20:40:01 +0200
Message-ID: <19980503204000.44125@uni-koblenz.de>
Date: Sun, 3 May 1998 20:40:00 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Hanging.
References: <19980502125234.04479@uni-koblenz.de> <Pine.LNX.3.95.980503141144.16809A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980503141144.16809A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, May 03, 1998 at 02:22:27PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, May 03, 1998 at 02:22:27PM -0400, Alex deVries wrote:

> Alright.  My machine had been hung since last night at 9pm, so this is 17
> hours later.  Here's what's on my console, hand typed because I'm not
> bright enough to have a serial console:
> 
> from before:
> zsh: Exception at [<8801800e4>] (80018234)

Which just means that zsh is buggy ...

> after my alt-scroll lock:
> $0 : 00000000 88130000 00000000 8a7863f8
> $4 : 8a786500 8bf5bf48 8a786500 00023ea1
> $8 : 80000000 80000000 881702d0 00000001
> $12: fffffffc 1000fc01 00000000 7ffff8f0
> $16: 8836eaa0 00000b64 00005ebc 00000002
> $20: 0000bf8b 00000001 00000000 9fc56394
> $24: 00000000 0fb6710
> $28: 8bf5a000 8bf5bf38 9fc4be88 8803be90
> epc   : 88034d6c
> Status: 1000fc03
> Cause : 00000400
> 
> The kernel I'm running is 2.1.91, which I got from Ralf in
> ~ralf/vmlinuz.gz or similiar on linus.

I think you got trapped by one of those generic mm bugs in .91.  Will
probably go away once we've upgraded to something newer.

  Ralf
