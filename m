Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA657401 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 14:59:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA22294 for linux-list; Thu, 26 Feb 1998 14:59:21 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA22286; Thu, 26 Feb 1998 14:59:19 -0800
Received: from informatik.uni-koblenz.de ([141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA03623; Thu, 26 Feb 1998 14:59:17 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-29.uni-koblenz.de [141.26.249.29])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA26645;
	Thu, 26 Feb 1998 23:59:15 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA04237;
	Thu, 26 Feb 1998 23:56:17 +0100
Message-ID: <19980226235617.55802@uni-koblenz.de>
Date: Thu, 26 Feb 1998 23:56:17 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Ulf Carlsson <grimsy@varberg.se>, linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <Pine.LNX.3.96.980226120308.3903B-100000@calypso.saturn> <199802261734.JAA25332@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199802261734.JAA25332@fir.engr.sgi.com>; from William J. Earl on Thu, Feb 26, 1998 at 09:34:05AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Feb 26, 1998 at 09:34:05AM -0800, William J. Earl wrote:

> for cache size.  The R4600 and R5000 are also similar, but with
> a very different cache organization from the R4000 and R4400.  Various
> revision of the processors (and more than one revision was shipped
> for each processor) have different errata, so the kernel must work around
> various processor errata according to the processor type and revision.

In case of the R4000 we still have some work to do with respect to the
errata stuff.

> As I understand it, the currently checked-in source must be recompiled
> to provide R4600/R5000 PC and SC versions for Indy, and those versions
> may not be fully tested on all R4000 and R4400 revisions.  In the not
> distant future, a single kernel will likely support all the processors,
> as does the IRIX kernel, but that is more work than just selecting
> the processor type at compile time.

The code in the CVS archive is plain buggy for certain configurations.
Given the number of possible configurations possible everything else but
a single kernel binary would be braindead.  Especially because the price
we have to pay for a single Indy binary isn't that high.

  Ralf
