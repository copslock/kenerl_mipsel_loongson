Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id DAA13584 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 03:00:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA01755 for linux-list; Sat, 10 Jan 1998 02:54:34 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA01727 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 02:54:24 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA26242
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 02:54:22 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id LAA04026;
	Sat, 10 Jan 1998 11:54:21 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id LAA06572; Sat, 10 Jan 1998 11:54:19 +0100
Message-ID: <19980110115418.15445@thoma.uni-koblenz.de>
Date: Sat, 10 Jan 1998 11:54:18 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 RPMs for SGI...
References: <34B6836E.1F366317@detroit.sgi.com> <Pine.LNX.3.95.980109192020.14617A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.980109192020.14617A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, Jan 09, 1998 at 07:25:50PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 09, 1998 at 07:25:50PM -0500, Alex deVries wrote:

> I had a closer look at it, and indeed, all the memory is accounted for.
> But, what I'm totally unused to is things taking up so much.  I've got
> 64MB in there now (although it's detected as 60248kB, it's missing 4MB).

The 60248kb is what the ARC firmware returns as free memory.

> Now I've got just the bare bones required to do anything productive:
> bdflush, inetd and a couple of shells.  There goes half my memory.
> 
> For example, 'su' takes up 4.5MB.  This seems like an awful lot to me,
> compared to the Intel equivalent of 1MB. I know the binaries are going to
> be larger because of the RISC thing, but really that large?
> 
> Is this normal?

It think the way these numbers are being computed is broken for MIPS.
MIPS executables are rougly 50-70% bigger than i386 ones; the size of the
data in executables and memory should be comparable.

  Ralf
