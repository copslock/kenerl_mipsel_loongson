Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2659928 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 13:42:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA7069231
	for linux-list;
	Thu, 2 Apr 1998 13:41:08 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA7002252;
	Thu, 2 Apr 1998 13:41:03 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA01565; Thu, 2 Apr 1998 13:41:02 -0800
Date: Thu, 2 Apr 1998 13:41:02 -0800
Message-Id: <199804022141.NAA01565@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
In-Reply-To: <19980402225314.63238@uni-koblenz.de>
References: <19980402225314.63238@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > I think I know why we're catching VCE exceptions even though we try to
 > avoid them at any price - the reason spells ``empty_zero_page''.  This
 > page is filled with zeros and is being mapped to arbitrary addresses
 > at the same time.  Arbitrary addresses means also bits 14:12 of the
 > virtual address may be different, welcome VCED.  This also means that
 > at least sane code should never cause VCEI exceptions.  The text of
 > the panic message ``should not happend'' is therefore wrong as well ...
 > 
 > Whatever, the fact that the hardware causes VCE exceptions which don't
 > help us at all forces us to handle them somehow.  How handy, they'll
 > fit quite well in the revamped interface for board caches :-)
 > 
 > Another way to finally eleminate the virtual coherency problem from
 > KSEG0's landscape would be to actually use 8 pages as an array of
 > empty_zero_pages[], so we would be able to map one wherever we want
 > such that we never run into virtual coherency trouble.

      For an always-zero page, this is the best solution.  At a small
cost in memory, you get far less overhead.
