Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA09731 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Mar 1998 04:01:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id EAA573033 for linux-list; Wed, 4 Mar 1998 04:01:41 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA561375 for <linux@cthulhu.engr.sgi.com>; Wed, 4 Mar 1998 04:01:39 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980304.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA19754
	for <linux@cthulhu.engr.sgi.com>; Wed, 4 Mar 1998 04:01:30 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-13.uni-koblenz.de [141.26.249.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id NAA01990
	for <linux@cthulhu.engr.sgi.com>; Wed, 4 Mar 1998 13:01:29 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id IAA15428;
	Wed, 4 Mar 1998 08:27:04 +0100
Message-ID: <19980304082704.28878@uni-koblenz.de>
Date: Wed, 4 Mar 1998 08:27:04 +0100
To: Mike Shaver <shaver@netscape.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: xcompiler
References: <34FCF726.3745A1DF@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <34FCF726.3745A1DF@netscape.com>; from Mike Shaver on Tue, Mar 03, 1998 at 10:39:35PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 03, 1998 at 10:39:35PM -0800, Mike Shaver wrote:

> So, what do I use as an xcompiler (i486->Indy)?
> The stuff on linus in ~ftp/pub/crossdev/mips-linux/i486-linux is pretty
> old-looking, and that scares me a bit.

I think it should still be ok.  Most of the changes I made were somehow
related to luserland.  Anyway, if you're paranoid you can install the
binaries of binutils, gcc and libc on your crosscompiler box, then
rebuild all the toys.  This will save you from the pains of bootstrapping.

  Ralf
