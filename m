Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA108215; Fri, 8 Aug 1997 15:21:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA11228 for linux-list; Fri, 8 Aug 1997 15:21:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA11157; Fri, 8 Aug 1997 15:20:48 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA25572; Fri, 8 Aug 1997 15:20:35 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id AAA02667; Sat, 9 Aug 1997 00:20:22 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708082220.AAA02667@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA15810; Sat, 9 Aug 1997 00:20:18 +0200
Subject: Re: Linux GGI and Linux/SGI
To: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Date: Sat, 9 Aug 1997 00:20:17 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9708081041.ZM971@blammo.engr.sgi.com> from "John Wiederhirn" at Aug 8, 97 10:41:46 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Are there any plans to move (maybe it's already there) the
> SGI version of Linux to a GGI-model design?
> (see http://synergy.foo.net/~ggi/)

Well, we have discussed using GGI.  Last I checkend GGI was still itself
in a state of flux and the last thing I want to do is to open another
battle field.  Technical reasons against GGI was mostly that the original
design was very bloated as far as the kernel is affected.  This has
been improoved somwhat since.

  Ralf
