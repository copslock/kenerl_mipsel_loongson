Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA841879 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Dec 1997 19:07:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA29263 for linux-list; Tue, 9 Dec 1997 19:05:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA29201 for <linux@cthulhu.engr.sgi.com>; Tue, 9 Dec 1997 19:05:49 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA22330
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Dec 1997 19:05:45 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-05.uni-koblenz.de [141.26.249.5])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA01278
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 04:05:17 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA03299;
	Wed, 10 Dec 1997 04:02:10 +0100
Message-ID: <19971210040210.27443@uni-koblenz.de>
Date: Wed, 10 Dec 1997 04:02:10 +0100
To: Michael Hill <mike@mdhill.interlog.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Uploads ...
References: <19971208150602.52582@brian.uni-koblenz.de> <ralf@uni-koblenz.de> <9712091934.ZM3116@mdhill.interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <9712091934.ZM3116@mdhill.interlog.com>; from Michael Hill on Tue, Dec 09, 1997 at 07:34:21PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Dec 09, 1997 at 07:34:21PM -0500, Michael Hill wrote:

> Thanks for the kernel binary.  Unfortunately it quits in the same spot as the
> previous kernel I tried (the R4600 V2.0 problem).  You said you had a stable
> kernel on the SNI RM200.  This time I used the Indy kernel; should I try the
> rm200 kernel?

If your have a RM200 ...

Is it still that bus error message you get?  If so, could you please mail
me the register dump displayed on the screen.

>  If I were to get my Indy back on support would they replace the
> CPU because of this?

No, because that problem can be handled in the OS software and > 2.1.57 do
so.

  Ralf
