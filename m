Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 13:48:42 +0100 (BST)
Received: from p508B5B34.dip.t-dialin.net ([IPv6:::ffff:80.139.91.52]:28624
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224821AbTGVMsk>; Tue, 22 Jul 2003 13:48:40 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6MCmdDB015110;
	Tue, 22 Jul 2003 14:48:39 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6MCmdhh015109;
	Tue, 22 Jul 2003 14:48:39 +0200
Date: Tue, 22 Jul 2003 14:48:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: 64bit Sead build
Message-ID: <20030722124838.GB12449@linux-mips.org>
References: <20030721233649.GA6900@linux-mips.org> <Pine.GSO.4.44.0307220836390.16466-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307220836390.16466-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 08:40:30AM -0400, David Kesselring wrote:

> Thanks for the info. I'm trying to build 64bit sead so that it can be a
> basis for a port to our own chip with a MIPS 5kf core. Is one of the other
> supported boards more generic (and thus a better start) than Sead?

We more regularly test on Malta which I also consider a way more
friendly test and development environment than SEAD which is sort of
a bare bone board.

  Ralf
