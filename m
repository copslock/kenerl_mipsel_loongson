Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id VAA525570 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 21:30:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA12685 for linux-list; Tue, 6 Jan 1998 21:29:38 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA12678; Tue, 6 Jan 1998 21:29:36 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA10269; Tue, 6 Jan 1998 21:29:34 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-28.uni-koblenz.de [141.26.249.28])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id GAA14368;
	Wed, 7 Jan 1998 06:29:32 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id GAA06114;
	Wed, 7 Jan 1998 06:26:08 +0100
Message-ID: <19980107062608.35785@uni-koblenz.de>
Date: Wed, 7 Jan 1998 06:26:08 +0100
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: ok CVS question ..
References: <Pine.SGI.3.94.980106174118.16801A-100000@tantrik.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.SGI.3.94.980106174118.16801A-100000@tantrik.engr.sgi.com>; from Shrijeet Mukherjee on Tue, Jan 06, 1998 at 05:42:16PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 06, 1998 at 05:42:16PM -0800, Shrijeet Mukherjee wrote:

> could someone point out, how to make a copy of the CVS tree from
> linus.linux.sgi.com from a machine that has ssh access ..
> 
> looks like the other source trees that I am using are not really working
> ..

setenv CVS_RSH ssh
cvs -d <account>@linus.linux.sgi.com:/src/cvs co -P

  Ralf
