Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA92880 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 17:57:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA22760 for linux-list; Mon, 12 Jan 1998 17:53:08 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA22742; Mon, 12 Jan 1998 17:53:07 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA19648; Mon, 12 Jan 1998 17:53:05 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA16041;
	Tue, 13 Jan 1998 02:53:03 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA02573;
	Tue, 13 Jan 1998 02:50:05 +0100
Message-ID: <19980113025004.46983@uni-koblenz.de>
Date: Tue, 13 Jan 1998 02:50:04 +0100
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: The perennial bus error IRQ :-)
References: <199801122130.NAA79891@oz.engr.sgi.com> <199801122148.NAA59443@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801122148.NAA59443@oz.engr.sgi.com>; from Ariel Faigon on Mon, Jan 12, 1998 at 01:48:46PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 12, 1998 at 01:48:46PM -0800, Ariel Faigon wrote:

> :Going over the linux archives I see over 5 emails
> :[deleted]
> 
> Sorry for following up my own message... I realize that
> there can be multiple reasons for this bus error IRQ.
> I just have the feeling some people are hitting bus
> errors that were already fixed just because they are
> using an old precompiled kernel.

I think all the bus errors have been fixed.  I also think I know the
reason for the reported  ``--UNEXPECTED INTERRUPT'' thing on reboot.
Not tested, though, no time ...  Just move the cli() calls in the
functions in arch/mips/sgi/prom/misc.c up before reseting the wd33c93.

  Ralf
