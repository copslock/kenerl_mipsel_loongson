Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA258585 for <linux-archive@neteng.engr.sgi.com>; Fri, 2 Jan 1998 07:10:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA12184 for linux-list; Fri, 2 Jan 1998 07:09:12 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA12179 for <linux@cthulhu.engr.sgi.com>; Fri, 2 Jan 1998 07:09:11 -0800
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA08604
	for <linux@cthulhu.engr.sgi.com>; Fri, 2 Jan 1998 07:09:08 -0800
	env-from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA04430 for linux@cthulhu.engr.sgi.com; Fri, 2 Jan 1998 10:08:16 -0500
From: "Michael Hill" <mike@mdhill.interlog.com>
Message-Id: <9801021008.ZM4428@mdhill.interlog.com>
Date: Fri, 2 Jan 1998 10:08:13 -0500
In-Reply-To: "Andrew O'Brien" <andrewo@cse.unsw.edu.au>
        "Re: Please help - need a 4600 no L2 cache kernel asap" (Jan  2,  6:59am)
References: <Pine.SGI.3.95.980102065738.7894L-100000@dizzy.disy.cse.unsw.EDU.AU>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Please help - need a 4600 no L2 cache kernel asap
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf discovered and corrected this in his kernel source after several of us had
problems with his last publicly-available Indy kernel binary (8 December).
 Since then no kernel binary or source has been posted to ftp.linux.sgi.com
(except linux-magnum-971229.tar.gz on 29 December).  Maybe the fix is part of
what Ralf wanted help with before Christmas.

On Dec 21,  5:45pm, Ralf Baechle wrote:
> Subject: Mergeback
> Hi,
>
> can anybody else work a bit on merging things back to Linus for the
> next couple of days?  I wont have very much time :-(
>
>   Ralf
>-- End of excerpt from Ralf Baechle

On Jan 2,  6:59am, Andrew O'Brien wrote:
> Subject: Re: Please help - need a 4600 no L2 cache kernel asap
> On Fri, 2 Jan 1998, Alex deVries wrote:
>
> >
> > On Fri, 2 Jan 1998, Andrew O'Brien wrote:
> > > I need to do some benchmarking on a SGI/Linux platform (an INDY) and I
> > > haven't been able to set up the cross-compilation environment correctly
> > > due to many factors. The benchmarks are needed by mid next week, so this
> > > is a kinda urgent call for help :)
> >
> > Is there any reason the binaries on ftp.linux.sgi.com won't work?
>
> Yep - they were compiled assuming that a L2 cache was present - hence when
> it tries to flush the cache during init, the system hangs horribly.
>
> I wasn't the only one to be hit by this so I'm sure there is a binary
> floating around somewhere :)
>



-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
