Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 21:20:09 +0000 (GMT)
Received: from p508B7C50.dip.t-dialin.net ([IPv6:::ffff:80.139.124.80]:49943
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225331AbUCZVUI>; Fri, 26 Mar 2004 21:20:08 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2QLK6oM005907;
	Fri, 26 Mar 2004 22:20:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2QLK1Ol005906;
	Fri, 26 Mar 2004 22:20:01 +0100
Date: Fri, 26 Mar 2004 22:20:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: lachwani@pmc-sierra.com, linux-mips@linux-mips.org
Subject: Re: titan ethernet driver
Message-ID: <20040326212001.GA4927@linux-mips.org>
References: <200403261512.06502.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403261512.06502.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 26, 2004 at 03:12:06PM +0100, Thomas Koeller wrote:

> I am trying to use your titan ethernet driver. I
> found that I could not compile it for a 2.6.4
> kernel, because it uses 2.4 kernel APIs. When
> fixing that I found that the code contains
> obvious errors; it does not even compile unchanged.
> This makes me a bit uneasy. Would you mind
> commenting on the state of this driver? Are there
> any newer sources than those contained in CVS at
> linux-mips.org?

I'm going to fix Yosemite / Titan support in 2.6 asap - as soon as I get
the board which should be somewhen next week.

  Ralf
