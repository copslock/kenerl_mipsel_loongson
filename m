Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2677449 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 14:40:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA7096179
	for linux-list;
	Thu, 2 Apr 1998 14:39:12 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA7061898
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 14:39:02 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA08098
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 14:38:58 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA09790
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Apr 1998 00:38:56 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA01858;
	Thu, 2 Apr 1998 23:35:33 +0200
Message-ID: <19980402233532.10932@uni-koblenz.de>
Date: Thu, 2 Apr 1998 23:35:32 +0200
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: serial console
References: <199804021731.TAA00404@calypso.saturn> <199804021855.NAA08562@pluto.npiww.com> <19980402204738.29605@uni-koblenz.de> <199804022006.PAA10227@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804022006.PAA10227@pluto.npiww.com>; from Dong Liu on Thu, Apr 02, 1998 at 03:06:21PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 02, 1998 at 03:06:21PM -0500, Dong Liu wrote:

> Ok, I got a serial cable , connect it, type "nvram console d", now I
> can boot irix from a serial terminal, but for linux, the message
> didn't come out, maybe all the serial parameters are not set right.

Linux doesn't accept the value ``dd'' for the console variable.  If you
try, Linux should complain about the setting and enter the interactive
firmware mode again.  Could you try setting console to either d1 or d2
according to the serial line you're using?

Thanks for testing this; having working serial consoles is on of the
missing parts in supporting the Challenge S.

  Ralf
