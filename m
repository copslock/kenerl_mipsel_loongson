Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 13:23:39 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:12915
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbVBCNXZ>; Thu, 3 Feb 2005 13:23:25 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13DNN9O009520;
	Thu, 3 Feb 2005 14:23:23 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13DNGpa009519;
	Thu, 3 Feb 2005 14:23:16 +0100
Date:	Thu, 3 Feb 2005 14:23:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Etienne Bauermeister <etienne@openfuel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel compile error - rtc.c
Message-ID: <20050203132316.GC8509@linux-mips.org>
References: <000f01c509cb$c7420190$642aa8c0@of0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c509cb$c7420190$642aa8c0@of0>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 03, 2005 at 10:38:47AM +0200, Etienne Bauermeister wrote:

> CC      drivers/char/rtc.o
> drivers/char/rtc.c: In function `rtc_init':
> drivers/char/rtc.c:955: `r' undeclared (first use in this function)
> drivers/char/rtc.c:955: (Each undeclared identifier is reported only
> once
> drivers/char/rtc.c:955: for each function it appears in.)

Know problem, sorry.

> I understand that the variable 'r' is not declared and this causes the
> error, but I don't know where to declare it or am I completely wrong and
> something else is at fault?  Please provide some help with this.  
>  
> A second question relates to some warnings I got earlier in the
> compilation process stating that some 'variables' (I assume) are
> 'deprecated'.  Is this anything to be concerned about?

It means it's team to update the code to use a newer API before the old,
deprecated one is going to be removed.  Remember, you've been warned :-)

  Ralf
