Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id DAA13695 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 03:00:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA02442 for linux-list; Sat, 10 Jan 1998 02:59:15 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA02438 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 02:59:14 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA26722
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 02:59:13 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id LAA04123;
	Sat, 10 Jan 1998 11:59:09 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id LAA06580; Sat, 10 Jan 1998 11:59:08 +0100
Message-ID: <19980110115907.55998@thoma.uni-koblenz.de>
Date: Sat, 10 Jan 1998 11:59:07 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Emmanuel Mogenet <mgix@nothingreal.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 RPMs for SGI...
References: <01bd1d66$153f46a0$060200c0@ghoul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <01bd1d66$153f46a0$060200c0@ghoul>; from Emmanuel Mogenet on Fri, Jan 09, 1998 at 05:21:31PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 09, 1998 at 05:21:31PM -0800, Emmanuel Mogenet wrote:
> 
> 
> >For example, 'su' takes up 4.5MB.  This seems like an awful lot to me,
> >compared to the Intel equivalent of 1MB. I know the binaries are going to
> >be larger because of the RISC thing, but really that large?
> >
> >Is this normal?
> 
> 
> Here, on the stuff we're working on, we experience that a DLL compiled
> with visual C++ in full optimization mode is on average 2.5 times smaller
> than the exact same code compiled into a DSO under IRIX 6.2 with compiler
> at -O3 -n32 -mips3.

Note that SGI's compiler seems to be more trimmed for speed and may
sometimes do massive loopunrolling etc. while the M$ compilers tend to
produce relativly compact code.

> I don't know about gcc under IRIX, but I've never seen a factor of 4 pop up
> before.

Duh...  regarding my last post - though Alex was refering to the in memory
size.  If his Linux executables are really that big might be producing
static linked ones or containing debug info.

  Ralf
