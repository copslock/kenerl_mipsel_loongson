Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA154789 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Feb 1998 22:00:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA04682 for linux-list; Wed, 11 Feb 1998 21:54:34 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA04668 for <linux@cthulhu.engr.sgi.com>; Wed, 11 Feb 1998 21:54:28 -0800
Received: from dm.cobaltmicro.com (dm.cobaltmicro.com [209.133.34.35]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA16355
	for <linux@cthulhu.engr.sgi.com>; Wed, 11 Feb 1998 21:54:27 -0800
	env-from (davem@dm.cobaltmicro.com)
Received: (from davem@localhost)
	by dm.cobaltmicro.com (8.8.7/8.8.7) id VAA23879;
	Wed, 11 Feb 1998 21:50:12 -0800
Date: Wed, 11 Feb 1998 21:50:12 -0800
Message-Id: <199802120550.VAA23879@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: ralf@uni-koblenz.de
CC: linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
In-reply-to: <19980212055648.54198@uni-koblenz.de> (ralf@uni-koblenz.de)
Subject: Re: TLB entries > 4kb
References:  <19980212055648.54198@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: ralf@uni-koblenz.de
   Date: Thu, 12 Feb 1998 05:56:48 +0100

   Has anybody ever looked into implementing that?  What architectures
   besides MIPS could take advantage of such a feature?

We already use it on Sparc64 for mmap()'ing the frame buffers, we
could easily extend it to work for mmap()'s of real memory.  Check out
arch/sparc64/mm/generic.c in the vger CVS tree for details.

Later,
David S. Miller
davem@dm.cobaltmicro.com
