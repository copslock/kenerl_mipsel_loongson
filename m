Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA134035 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 10:29:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id KAA1248196 for linux-list; Fri, 6 Mar 1998 10:29:03 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA1255637 for <linux@engr.sgi.com>; Fri, 6 Mar 1998 10:29:00 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id KAA16472
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 10:28:55 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-18.uni-koblenz.de [141.26.249.18])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA11794
	for <linux@engr.sgi.com>; Fri, 6 Mar 1998 19:28:52 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA24907;
	Fri, 6 Mar 1998 19:25:14 +0100
Message-ID: <19980306192514.14435@uni-koblenz.de>
Date: Fri, 6 Mar 1998 19:25:14 +0100
To: Trevor Schroeder <tschroed@cheetah.wsc.edu>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: xntp
References: <19980306174605.00092@uni-koblenz.de> <Pine.ULT.3.96.980306110037.5679B-100000@cheetah.wsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.ULT.3.96.980306110037.5679B-100000@cheetah.wsc.edu>; from Trevor Schroeder on Fri, Mar 06, 1998 at 11:01:32AM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 06, 1998 at 11:01:32AM -0600, Trevor Schroeder wrote:

> > Don't run xntpd; there is some bug in the MIPS stuff which locks the
> > machine, only the usual kernel hotkeys are still working.  I don't
> > know why or if all platforms are affected.  The crash happend on a
> > RM200.  The time code is ripe for a complete overhaul anyway ...
> 
> Do tell, what exactly is this bug?  I'm using xntpd on a number of non-MIPS
> Linux hosts here and I'd like to verify that it's not going to be a problem.

I appears as if a syscall never terminates or so.  xntpd just hangs in 'R'
(running) state in the process table.  This happens immediately after
starting xntpd from the command line.  For now I assume this to be a MIPS
only bug - Ulrich Windl posted some NTP4 related patches and that's about
everything I heared in the last time related to NTP bugs.  So don't worry,
I'm going to fix it next week - there is something non-MIPSish on my to-do
list that is more urgent ...

On the other side xntpd builds right out of the box for Linux/MIPS and that's
already good news, given the complexity of the thing and how difficult it
builds for IRIX.

  Ralf
