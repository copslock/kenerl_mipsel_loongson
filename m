Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 14:30:16 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:59400 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224991AbVHXN36>; Wed, 24 Aug 2005 14:29:58 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7ODZOWg009120;
	Wed, 24 Aug 2005 14:35:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7ODZO5K009119;
	Wed, 24 Aug 2005 14:35:24 +0100
Date:	Wed, 24 Aug 2005 14:35:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 24K malta
Message-ID: <20050824133524.GA6065@linux-mips.org>
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <430C673E.4070502@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430C673E.4070502@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 24, 2005 at 08:25:34AM -0400, Greg Weeks wrote:

> >I cannot reproduce this problem on 24KEc Malta, sorry.
> > 
> >
> What patch are you using to get current CVS to boot on a malta? I've 
> been disabling prefetch in memcpy, but if you're doing something else I 
> want to try that. About 1 out of 3 "strace ls" either hangs or seg 
> faults on me still.

I've disabled prefetching entirely in arch/mips/Kconfig and I'm using a
24Kc, not a 24KEc, stock gcc 3.4 & binutils 2.16 and it's running quite
nicely for me.

  Ralf
