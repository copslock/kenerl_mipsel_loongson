Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 05:18:56 +0200 (CEST)
Received: from p508B5F86.dip.t-dialin.net ([80.139.95.134]:56737 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123891AbSJZDS4>; Sat, 26 Oct 2002 05:18:56 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9Q3IjZ08645;
	Sat, 26 Oct 2002 05:18:45 +0200
Date: Sat, 26 Oct 2002 05:18:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dennis Newbold <dennisn@pe.net>
Cc: linux-mips@linux-mips.org
Subject: Re: GCC generating wrong assembly code?
Message-ID: <20021026051844.B9509@linux-mips.org>
References: <Pine.GSO.3.96.1021025110042.28181A-101000@shell1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021025110042.28181A-101000@shell1>; from dennisn@pe.net on Fri, Oct 25, 2002 at 11:30:36AM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 11:30:36AM -0700, Dennis Newbold wrote:

>      I'm trying to build gcj (GNU Java ahead-of-time compiler) from
> the sources.  It ran for quite awhile, and then on a particular file,
> it got about 20 "Error: branch out of range" errors from the gas
> assembler.  I'm hoping that someone on this list that understands gcc

This is supposedly fixed in the very latest versions.

As a temporary workaround that works for most files enable optimization
-O or even -O2 for those files affected by this problem.  -fno-inline
or -Os may also help - basically everything that reduces the code size.

  Ralf
