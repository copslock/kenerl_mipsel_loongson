Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id MAA1192265 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 12:07:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA28509 for linux-list; Fri, 12 Dec 1997 12:03:55 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA28461 for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 12:03:47 -0800
Received: from zero.aec.at (zero.aec.at [193.170.192.102]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id MAA20750
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 12:03:44 -0800
	env-from (andi@zero.aec.at)
Received: (qmail 23626 invoked by uid 573); 12 Dec 1997 20:03:36 -0000
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: SPECweb for linux?
References: <199712121915.LAA21845@fir.engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: 12 Dec 1997 21:03:35 +0100
In-Reply-To: "William J. Earl"'s message of Fri, 12 Dec 1997 11:15:38 -0800
Message-ID: <k267ou5nxk.fsf@zero.aec.at>
X-Mailer: Gnus v5.4.41/Emacs 19.34
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

"William J. Earl" <wje@fir.engr.sgi.com> writes:

>      Are there any SPECweb results for linux on one box or another? 

If you run it with the current sgilinux the results will probably be
very bad. The current network code has some performance problems (and
bugs) that will be fixed. The network code in 2.0 (especially 2.0.30
and up) is very fast though. That version unfortunately doesn't run
on SGI (yet?).

-Andi
