Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA512641 for <linux-archive@neteng.engr.sgi.com>; Fri, 24 Oct 1997 14:16:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA03640 for linux-list; Fri, 24 Oct 1997 14:14:19 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA03625 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 14:14:16 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA29378
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 14:14:14 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from ozzy.uni-koblenz.de (946@ozzy.uni-koblenz.de [141.26.5.8]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with ESMTP id XAA11858; Fri, 24 Oct 1997 23:14:11 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710242114.XAA11858@informatik.uni-koblenz.de>
Received: by ozzy.uni-koblenz.de (8.8.5/KO-2.0)
	id XAA04073; Fri, 24 Oct 1997 23:12:30 +0200
Subject: Re: Step by step of my experience
To: mikehill@hgeng.com (Mike Hill)
Date: Fri, 24 Oct 1997 23:12:30 +0200 (MEST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <60222E63C9F4D011915F00A02435011C011A5F@bart.hgeng.com> from "Mike Hill" at Oct 24, 97 01:07:43 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Thus spake Mike Shaver:
> > I'll clean up my current support tomorrow or Friday, and then I'll
> > check it in and coerce Miguel or Ralf into making a new test
> > kernel available. 
> 
> Is it possible to download the latest development work on the kernel,
> for instance what's in the CVS repository?  Or, to quote the FAQ:
> 
> 	14.  Where can I find up-to-the-second releases?

We'll setup anonymous CVS access and a cronjob that will create diffs
between kernel releases such that people can stay uptodate.  Right now
you should go for the testing kernels in /pub/src/kernel/testing/, they
are the newest and most reliable onces released.  I've got tons of
bugfixes but I won't have the time to merge them in the near future ...

  Ralf
