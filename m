Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id DAA447381 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Jan 1998 03:06:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA15777 for linux-list; Sun, 18 Jan 1998 03:01:53 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA15769 for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 03:01:51 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA28433
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 03:01:50 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA22188
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 12:01:47 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA12357;
	Sun, 18 Jan 1998 11:57:57 +0100
Message-ID: <19980118115757.57699@uni-koblenz.de>
Date: Sun, 18 Jan 1998 11:57:57 +0100
To: "K." <conradp@cse.unsw.edu.au>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: cross-compiling gcc
References: <Pine.GSO.3.95.980118161833.21298K-100000@l4-00.orchestra.cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.GSO.3.95.980118161833.21298K-100000@l4-00.orchestra.cse.unsw.EDU.AU>; from K. on Sun, Jan 18, 1998 at 04:31:05PM +1100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jan 18, 1998 at 04:31:05PM +1100, K. wrote:

> when trying to use the gcc from the crossdev directory to cross-complie
> code that (indirectly) includes <asm/sgidefs.h> , we get the warning: 
> "Please update your GCC to GCC 2.7.2-3 or newer". This happens because the
> symbol _MIPS_ISA is not set - consequently compilation barfs when trying
> to include <asm/atomic.h> as the wrong section of the header file is used.
> 
> Does anyone have a newer version of the cross-compiler, know where we
> can get one or how to make one?

The patches for the newer versions are on ftp.linux.sgi.com.

  Ralf
