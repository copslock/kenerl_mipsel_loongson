Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA1204886 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 15:38:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA15289 for linux-list; Fri, 12 Dec 1997 15:32:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15175; Fri, 12 Dec 1997 15:32:10 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA18259; Fri, 12 Dec 1997 15:32:07 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-17.uni-koblenz.de [141.26.249.17])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA12862;
	Sat, 13 Dec 1997 00:31:35 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA05776;
	Sat, 13 Dec 1997 00:28:22 +0100
Message-ID: <19971213002821.23958@uni-koblenz.de>
Date: Sat, 13 Dec 1997 00:28:21 +0100
To: Andi Kleen <ak@muc.de>
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: SPECweb for linux?
References: <199712121915.LAA21845@fir.engr.sgi.com> <k267ou5nxk.fsf@zero.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <k267ou5nxk.fsf@zero.aec.at>; from Andi Kleen on Fri, Dec 12, 1997 at 09:03:35PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Dec 12, 1997 at 09:03:35PM +0100, Andi Kleen wrote:

> "William J. Earl" <wje@fir.engr.sgi.com> writes:
> 
> >      Are there any SPECweb results for linux on one box or another? 
> 
> If you run it with the current sgilinux the results will probably be
> very bad. The current network code has some performance problems (and
> bugs) that will be fixed.

Btw, I recently reported 900kb/s over the wire for the Indy.  That was
measured using ftping huge files.  Most people prefer the numbers from
ttcp which where around 1038kb/s for an R5000 Indy.

>                           The network code in 2.0 (especially 2.0.30
> and up) is very fast though. That version unfortunately doesn't run
> on SGI (yet?).

I actually did complete the port of 2.0.30 as part of a commercial
project.  Not to the Indy, but that wouldn't be too difficult.  A certain
well known (Hi :-) personality from the Linux comunity is now continuing
that work.

  Ralf
