Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 01:57:21 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:14044 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbVBHB5G>; Tue, 8 Feb 2005 01:57:06 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j181puf9027715;
	Tue, 8 Feb 2005 01:51:56 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j181ptZh027714;
	Tue, 8 Feb 2005 01:51:55 GMT
Date:	Tue, 8 Feb 2005 01:51:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	TheNop <TheNop@gmx.net>, linux-mips@linux-mips.org
Subject: Re: Kernel crash on yosemite
Message-ID: <20050208015155.GB15336@linux-mips.org>
References: <4207F163.4010605@gmx.net> <20050208013000.GA6131@linux-mips.org> <42081A2C.5060503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42081A2C.5060503@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 05:47:24PM -0800, Manish Lachwani wrote:

> >recommend you upgrade your kernel.  One problem you're going to encounter
> >with recent kernels is that they only support the Titan 1.2 part which I
> >think are the ones in volume production.
>
> However, adding support for Titan 1.0 and 1.1 in the GE driver should be 
> fairly straight forward.

True, the CVS log should provide reasonable information about that.  What
can't be sanely retrofitted is SMP for < 1.2.

  Ralf
