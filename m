Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA184636 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 17:41:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA1397037 for linux-list; Fri, 6 Mar 1998 17:41:14 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA1434652 for <linux@engr.sgi.com>; Fri, 6 Mar 1998 17:41:12 -0800 (PST)
Received: from mung.wayne.esu1.k12.ne.us (cis-2511-a1.wsc.edu [192.150.175.187]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id RAA02833
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 17:41:10 -0800 (PST)
	mail_from (tschroed@cheetah.wsc.edu)
Received: by mung.wayne.esu1.k12.ne.us (5.65/DEC-Ultrix/4.4)
	id AA00887; Fri, 6 Mar 1998 19:40:30 -0600
Other-Stuff: localhost tschroed@cheetah.wsc.edu  tschroed@cheetah.wsc.edu
Date: Fri, 6 Mar 1998 19:40:30 -0600 (CST)
From: Trevor Schroeder <tschroed@cheetah.wsc.edu>
X-Sender: tschroed@mung.wsc.edu
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: xntp
In-Reply-To: <19980306192514.14435@uni-koblenz.de>
Message-Id: <Pine.ULT.3.96.980306193859.28170D-100000@mung.wsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 6 Mar 1998 ralf@uni-koblenz.de wrote:

> I appears as if a syscall never terminates or so.  xntpd just hangs in 'R'
> (running) state in the process table.  This happens immediately after
> starting xntpd from the command line.  For now I assume this to be a MIPS
> only bug - Ulrich Windl posted some NTP4 related patches and that's about
> everything I heared in the last time related to NTP bugs.  So don't worry,
> I'm going to fix it next week - there is something non-MIPSish on my to-do
> list that is more urgent ...

I would agree that it seems to be a MIPS only problem as it's not causing
problems on Linux/x86.
