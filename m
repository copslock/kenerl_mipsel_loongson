Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2692022 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 13:20:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA6610272
	for linux-list;
	Thu, 2 Apr 1998 13:18:59 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA7044132
	for <linux@engr.sgi.com>;
	Thu, 2 Apr 1998 13:18:53 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA03166
	for <linux@engr.sgi.com>; Thu, 2 Apr 1998 13:18:51 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA05510
	for <linux@engr.sgi.com>; Thu, 2 Apr 1998 22:53:51 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA01731;
	Thu, 2 Apr 1998 22:53:15 +0200
Message-ID: <19980402225314.63238@uni-koblenz.de>
Date: Thu, 2 Apr 1998 22:53:14 +0200
To: linux@cthulhu.engr.sgi.com
Subject: VCE exceptions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I think I know why we're catching VCE exceptions even though we try to
avoid them at any price - the reason spells ``empty_zero_page''.  This
page is filled with zeros and is being mapped to arbitrary addresses
at the same time.  Arbitrary addresses means also bits 14:12 of the
virtual address may be different, welcome VCED.  This also means that
at least sane code should never cause VCEI exceptions.  The text of
the panic message ``should not happend'' is therefore wrong as well ...

Whatever, the fact that the hardware causes VCE exceptions which don't
help us at all forces us to handle them somehow.  How handy, they'll
fit quite well in the revamped interface for board caches :-)

Another way to finally eleminate the virtual coherency problem from
KSEG0's landscape would be to actually use 8 pages as an array of
empty_zero_pages[], so we would be able to map one wherever we want
such that we never run into virtual coherency trouble.

  Ralf
