Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 16:16:05 +0000 (GMT)
Received: from web203.biz.mail.re2.yahoo.com ([IPv6:::ffff:68.142.224.165]:30338
	"HELO web203.biz.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225395AbVBXQPv>; Thu, 24 Feb 2005 16:15:51 +0000
Message-ID: <20050224161542.74749.qmail@web203.biz.mail.re2.yahoo.com>
Received: from [63.194.214.47] by web203.biz.mail.re2.yahoo.com via HTTP; Thu, 24 Feb 2005 08:15:41 PST
Date:	Thu, 24 Feb 2005 08:15:41 -0800 (PST)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: Re: Big Endian au1550
To:	JP Foster <jp.foster@exterity.co.uk>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1109239495.8389.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



> Great, but I still can't get a running kernel from
> cvs mips-linux for
> a DB1550 board. Is it perhaps the toolchain? I'm
> using gcc-3.4.1 perhaps that is too recent.

Either that or something broke recently. I'll boot a
kernel tonight to make sure it still ok. 

> Tried mipsel last night and got the same result as
> big end so I suspect
> it may be my compiler/binutils combination. Is there
> are recommended
> toolchain for mips. Should I go build gcc-2.95 and
> binutils 2.12 ?

2.95 is too old. We're using 3.3.3 and binutils 2.15.
We're working on making a toolkit available soon, or
you can try ELDK3.0.

Pete
