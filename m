Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jan 2005 00:03:51 +0000 (GMT)
Received: from p3EE07947.dip.t-dialin.net ([IPv6:::ffff:62.224.121.71]:27239
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224948AbVA2ADL>; Sat, 29 Jan 2005 00:03:11 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0T038mL011813;
	Sat, 29 Jan 2005 01:03:08 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0T038IY011812;
	Sat, 29 Jan 2005 01:03:08 +0100
Date:	Sat, 29 Jan 2005 01:03:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhan rongkai <zhanrk@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Why does MIPS/Linux always reserve 32 bytes in the top of each process's kernel stack space
Message-ID: <20050129000308.GB11602@linux-mips.org>
References: <73e62045050127185929c3bdf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e62045050127185929c3bdf7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 28, 2005 at 10:59:26AM +0800, zhan rongkai wrote:

> Why does MIPS/Linux always reserve 32 bytes in the top of each
> process's kernel stack space.

Paranoia.

  Ralf
