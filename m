Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 14:04:10 +0100 (BST)
Received: from p508B5B34.dip.t-dialin.net ([IPv6:::ffff:80.139.91.52]:28625
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224821AbTGVNEB>; Tue, 22 Jul 2003 14:04:01 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6MD40DB015481;
	Tue, 22 Jul 2003 15:04:00 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6MD40HM015480;
	Tue, 22 Jul 2003 15:04:00 +0200
Date: Tue, 22 Jul 2003 15:04:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: David Kesselring <dkesselr@mmc.atmel.com>,
	linux-mips@linux-mips.org
Subject: Re: 64bit Sead build
Message-ID: <20030722130400.GD12449@linux-mips.org>
References: <20030721233649.GA6900@linux-mips.org> <Pine.GSO.4.44.0307220836390.16466-100000@ares.mmc.atmel.com> <16157.13036.787738.445030@gladsmuir.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16157.13036.787738.445030@gladsmuir.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 01:49:48PM +0100, Dominic Sweetman wrote:

> > Thanks for the info. I'm trying to build 64bit sead so that it can
> > be a basis for a port to our own chip with a MIPS 5kf core.
> 
> Interesting.  It's good to know people are looking at the 64-bit
> ports.

The general problem I'm observing is nobody wants to be the first through
the minefield of building a commercial product based on a 64-bit kernel
though for many applications it seems to be a much saner solution than
a 32-bit kernel.

My use is atypical but I'm running a 64-bit kernel SMP / ccNUMA kernel
since years without major problems so we're 90% through and I'd like to
know about the missing 10% ...

  Ralf
