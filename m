Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 20:48:49 +0100 (BST)
Received: from p508B5F50.dip.t-dialin.net ([IPv6:::ffff:80.139.95.80]:18601
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225477AbTI3Tsp>; Tue, 30 Sep 2003 20:48:45 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8UJmiNK014944;
	Tue, 30 Sep 2003 21:48:44 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8UJmhqr014943;
	Tue, 30 Sep 2003 21:48:43 +0200
Date: Tue, 30 Sep 2003 21:48:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Michael Uhler <uhler@mips.com>
Cc: "Finney, Steve" <Steve.Finney@spirentcom.com>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
Message-ID: <20030930194843.GB12599@linux-mips.org>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com> <20030930160023.GB4231@linux-mips.org> <1064946568.13742.51.camel@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064946568.13742.51.camel@uhler-linux.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 30, 2003 at 11:29:28AM -0700, Michael Uhler wrote:

> > There isn't.
> > 
> > What you want really is a 64-bit kernel.  On a 64-bit kernel even for
> > processes running in 32-bit address spaces (o32, N32) the processor
> > will run with the UX bit enabled.  o32 userspace still lives in the
> > assumption that registers are 32-bit so only those bits will be restored
> > in function calls etc.  N32 (where userspace isn't ready for prime time
> > yet) does guarantee that.  And N64 (userspace similarly not ready for
> > prime time) obviously is fully 64-bit everything.
> 
> I don't think you want to run o32 processes with the UX bit set.  UX not
> only enables 64-bit addressing (which you can, in software, make look
> like 32-bit addressing), it also enables access to the 64-bit opcodes.
> This means that you are going to get unexpected and potentially
> unreproducible results.

Currently the 64-bit kernel is running everything in userspace with UX
enabled, in part that's lazyness, in part it was also made in the hope
optimized libraries for o32 would take advantage of 64-bit computing.

Linux btw. doesn't use the MIPS64 PX flag.  It's only supported on MIPS64
and it we simply didn't consider it's use much of a benefit so far -
something that probably is arguable ...

  Ralf
