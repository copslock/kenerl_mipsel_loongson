Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA43583 for <linux-archive@neteng.engr.sgi.com>; Sat, 3 Jan 1998 11:01:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA01041 for linux-list; Sat, 3 Jan 1998 11:00:18 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA00979; Sat, 3 Jan 1998 11:00:07 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA11498; Sat, 3 Jan 1998 11:00:05 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id UAA03659;
	Sat, 3 Jan 1998 20:00:03 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA01569;
	Sat, 3 Jan 1998 19:57:05 +0100
Message-ID: <19980103195705.16061@uni-koblenz.de>
Date: Sat, 3 Jan 1998 19:57:05 +0100
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
Cc: Michael Hill <mike@mdhill.interlog.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Please help - need a 4600 no L2 cache kernel asap
References: <9801021008.ZM4428@mdhill.interlog.com> <199801021756.JAA36833@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801021756.JAA36833@oz.engr.sgi.com>; from Ariel Faigon on Fri, Jan 02, 1998 at 09:56:49AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 02, 1998 at 09:56:49AM -0800, Ariel Faigon wrote:

> Important change to the SGI/Linux FTP site:
> 
> I just moved the CVS source tree hierarchy so it can be
> accessed via ftp:
> 
> 	ftp://ftp.linux.sgi.com/cvs/
> 
> There's also a link from the web site to this (software page)
> 	http://www.linux.sgi.com/software.html
> 
> This should enable anyone to compile a good kernel from scratch.
> 
> Whoever has a stable kernel that works on a L2-cache-less 4600
> please share.  I'll gladly give this person ssh access to linus.

I've fixed the problem and a couple cache thingies before xmas.  Will
upload asap.

  Ralf
