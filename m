Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA03981 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 10:46:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA24262 for linux-list; Wed, 14 Jan 1998 10:45:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA24233 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 10:44:56 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA14370
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 10:44:54 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id TAA17346;
	Wed, 14 Jan 1998 19:44:52 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA09084; Wed, 14 Jan 1998 19:44:51 +0100
Message-ID: <19980114194450.12239@uni-koblenz.de>
Date: Wed, 14 Jan 1998 19:44:50 +0100
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: 2.1.72 precompiled with no L2
References: <Pine.LNX.3.95.980114111306.2369C-100000@lager.engsoc.carleton.ca> <Pine.LNX.3.95.980114120233.2369F-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.980114120233.2369F-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jan 14, 1998 at 12:07:15PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 12:07:15PM -0500, Alex deVries wrote:

> ftp://ftp.linux.sgi.com/pub/test/vmlinux-indy-noL2-2.1.72.tar.gz
> is available for your usage and testing.  
> 
> This is for machines with no L2 cache.  I can't test it myself, since my
> machine does have that cache.
> 
> Should L2 cache perhaps be a compiling option? Is it possible for the
> kernel to auto-detect if there's cache or not?

I think I've already posted a dozen times that I've fixed this, I just
don't have the time to clean it up and commit.

  Ralf
