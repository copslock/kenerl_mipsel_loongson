Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2004 20:04:49 +0000 (GMT)
Received: from p508B6AA4.dip.t-dialin.net ([IPv6:::ffff:80.139.106.164]:42762
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225529AbUBDUEt>; Wed, 4 Feb 2004 20:04:49 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i14K4Vex020264;
	Wed, 4 Feb 2004 21:04:31 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i14K4N0i020263;
	Wed, 4 Feb 2004 21:04:23 +0100
Date: Wed, 4 Feb 2004 21:04:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: R4600 V1.7 errata
Message-ID: <20040204200423.GA20197@linux-mips.org>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina> <20040201045258.GA4601@linux-mips.org> <20040203113928.GA28340@linux-mips.org> <20040203114252.GA27810@icm.edu.pl> <20040204154801.GB704@icm.edu.pl> <1075910389.1170.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075910389.1170.42.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 04, 2004 at 07:59:49AM -0800, Pete Popov wrote:

> > [...]
> > > I assume it's safe to test it now? I'll build it for my R4600 V2.0 and
> > > report in a while. Stay tuned.
> > 
> > Works now. Thanks, guys.
> 
> The latest cache updates break the Au1x kernel. I don't know yet exactly
> what the problem is, but I tested with a snapshot before and after the
> updates.

The cache updates should specifically only affects systems that explicitly
enable the cache workaround in <asm/war.h>; for any other the compiler
should totally eleminate the workaround from the binary.

Therefore my first guess would be pg-r4k.c.

  Ralf
