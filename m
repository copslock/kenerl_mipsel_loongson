Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 20:35:21 +0100 (BST)
Received: from p508B5E19.dip.t-dialin.net ([IPv6:::ffff:80.139.94.25]:19303
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226156AbUGFTfR>; Tue, 6 Jul 2004 20:35:17 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i66JZF3d010806;
	Tue, 6 Jul 2004 21:35:15 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i66JZAjO010805;
	Tue, 6 Jul 2004 21:35:10 +0200
Date: Tue, 6 Jul 2004 21:35:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Kunze <thomas.kunze@xmail.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux on SNI RM300E ?
Message-ID: <20040706193510.GA10125@linux-mips.org>
References: <1089101540.40ea5ee467311@www.x-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089101540.40ea5ee467311@www.x-mail.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 06, 2004 at 01:12:20AM -0800, Thomas Kunze wrote:

> i've tried to install Debian Woody MIPS on my SNI RM300E but i can't get
> it work.

I support the RM200C in the little endian configuration and I'm probably the
only user of Linux on an RM machine at all.  Afaik no little endian systems
have been shipped since SNI and Microsoft axed NT for MIPS making my
configuration extremly rare and I've not been able to obtain the big endian
firmware for the system - which is showing signs of upcoming hardware death
so whenever that happens I won't be able to support the SNI [1] code anymore.
Just to make life a little bit more misserable I only have hardware
documentation on the RM200/300 C (possibly D, would have to check) series
so I have not idea to what degree the architecture differs the RM300.

Conversion of the existing code to work on a big endian RM200/300C would
be easy to do though and I can help whoever wants to try ...

  Ralf

[1] RM hardware dumped in front of my door accepted ;-)
