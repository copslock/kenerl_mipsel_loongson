Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2702704 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 14:38:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA6948775
	for linux-list;
	Thu, 2 Apr 1998 14:36:50 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA5775975;
	Thu, 2 Apr 1998 14:36:47 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA07246; Thu, 2 Apr 1998 14:36:44 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA09737;
	Fri, 3 Apr 1998 00:36:42 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA02151;
	Fri, 3 Apr 1998 00:36:23 +0200
Message-ID: <19980403003623.50122@uni-koblenz.de>
Date: Fri, 3 Apr 1998 00:36:23 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
References: <19980402225314.63238@uni-koblenz.de> <199804022141.NAA01565@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804022141.NAA01565@fir.engr.sgi.com>; from William J. Earl on Thu, Apr 02, 1998 at 01:41:02PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 02, 1998 at 01:41:02PM -0800, William J. Earl wrote:

>  > Another way to finally eleminate the virtual coherency problem from
>  > KSEG0's landscape would be to actually use 8 pages as an array of
>  > empty_zero_pages[], so we would be able to map one wherever we want
>  > such that we never run into virtual coherency trouble.
> 
>       For an always-zero page, this is the best solution.  At a small
> cost in memory, you get far less overhead.

Indeed, 16ns on a 250Mhz machine for every exception that goes via the
general exception vector _plus_ the actual vce / vci handling, that sucks.
I just wonder why those exceptions have been implemented at all?

They may help somewhat in debugging operating systems, but in our situation
they're nervragging by their mere existance.

  Ralf
