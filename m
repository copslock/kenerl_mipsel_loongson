Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:12:34 +0100 (BST)
Received: from [IPv6:::ffff:216.208.38.107] ([IPv6:::ffff:216.208.38.107]:25730
	"EHLO OTTLS.pngxnet.com") by linux-mips.org with ESMTP
	id <S8225282AbVGVNMT>; Fri, 22 Jul 2005 14:12:19 +0100
Received: from bacchus.net.dhis.org ([10.255.255.134])
	by OTTLS.pngxnet.com (8.12.4/8.12.4) with ESMTP id j6MDEIBM004270
	for <linux-mips@linux-mips.org>; Fri, 22 Jul 2005 09:14:18 -0400
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6MDEI1Y029782;
	Fri, 22 Jul 2005 09:14:18 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6MDEHMn029781;
	Fri, 22 Jul 2005 09:14:17 -0400
Date:	Fri, 22 Jul 2005 09:14:17 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alex Gonzalez <linux-mips@packetvision.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Going over 512M of memory
Message-ID: <20050722131417.GA29581@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org> <20050722043057.GA3803@linux-mips.org> <1122023087.30605.3.camel@euskadi.packetvision>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122023087.30605.3.camel@euskadi.packetvision>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 22, 2005 at 10:04:47AM +0100, Alex Gonzalez wrote:

> Our target experienced a kernel panic at startup when trying to access
> memory above 512MB.
> 
> Reading the list archives I found this thread with a proposed patch:
> 
> http://www.linux-mips.org/archives/linux-mips/2005-02/msg00115.html
> 
> After applying the patch our target boots OK and appears to be able to
> access the whole memory range without problems.
> 
> Any idea why this patch didn't make it to the repository? Is it safe?

It is - but according to Ibrahim's posting that you're pointing to it
didn't solve his problem.

What CPU are you using, btw?

  Ralf
