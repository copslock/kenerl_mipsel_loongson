Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA08001 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 15:05:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA06353 for linux-list; Wed, 21 Jan 1998 15:01:18 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA06345 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 15:01:17 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA06418
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 15:01:15 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA06847
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 00:01:12 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA05620;
	Wed, 21 Jan 1998 23:41:35 +0100
Message-ID: <19980121234018.13089@uni-koblenz.de>
Date: Wed, 21 Jan 1998 23:40:18 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Statuses...
References: <Pine.LNX.3.95.980121001522.30047E-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980121001522.30047E-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jan 21, 1998 at 12:29:46AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 21, 1998 at 12:29:46AM -0500, Alex deVries wrote:

> Or would that be statii?

Missed your Latin lessons, geh?

> - I started looking at modules and the MIPS kernel, and I've come to the
> conclusion that modutils is just the tip of the iceberg.  Exactly what
> needs to be done to the kernel for this to work?

make config :-)

> - Exactly what is required to get psaux mice working?  It compiled fine
> for me, but doing a "cat /dev/psaux" hung the machine heavily.

I guess Miguel must have fixed the problem when working on X.

  Ralf
