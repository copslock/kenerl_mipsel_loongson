Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA799469 for <linux-archive@neteng.engr.sgi.com>; Tue, 24 Mar 1998 08:04:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA3088856
	for linux-list;
	Tue, 24 Mar 1998 08:03:26 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA3119765
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 24 Mar 1998 08:03:24 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA16269
	for <linux@cthulhu.engr.sgi.com>; Tue, 24 Mar 1998 08:03:22 -0800 (PST)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id RAA26766;
	Tue, 24 Mar 1998 17:03:13 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id RAA27600; Tue, 24 Mar 1998 17:03:10 +0100
Message-ID: <19980324170310.02192@uni-koblenz.de>
Date: Tue, 24 Mar 1998 17:03:10 +0100
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grimsy@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: More fixes
References: <19980323225125.14671@uni-koblenz.de> <Pine.LNX.3.96.980324160922.650B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.980324160922.650B-100000@calypso.saturn>; from Ulf Carlsson on Tue, Mar 24, 1998 at 04:09:37PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 24, 1998 at 04:09:37PM +0100, Ulf Carlsson wrote:

> On Mon, 23 Mar 1998 ralf@uni-koblenz.de wrote:
> 
> > I fixed the old reboot problem.  The cause were three lines of code
> > that should have been removed ages ago.  Now the second level cache
> > is being disabled on reboot as it is supposed to.
> 
> Any fixes for the R4000SC yet?

Already in.  If it still isn't working, please tell me.  Maybe someone
can borrow me a R4000SC / R4400SC module ...

  Ralf
