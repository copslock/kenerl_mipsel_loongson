Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 13:23:51 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:13581 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225362AbVBWNXf>; Wed, 23 Feb 2005 13:23:35 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1NDHHSk013270;
	Wed, 23 Feb 2005 13:17:17 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1NDHHou013269;
	Wed, 23 Feb 2005 13:17:17 GMT
Date:	Wed, 23 Feb 2005 13:17:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	JP Foster <jp.foster@exterity.co.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
Message-ID: <20050223131717.GB9639@linux-mips.org>
References: <1109157737.16445.6.camel@localhost.localdomain> <000301c5199d$3154ad40$0300a8c0@Exterity.local> <1109160313.16445.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109160313.16445.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2005 at 12:05:13PM +0000, JP Foster wrote:

> Fair enough. Has anyone got big-endian au1xxx working ever?
> I'm reasonably flexible to use mipsel, since this is a new board,
> although all our other products are mipseb.
> 
> Since big doesn't work as far as I can see. This must a regression
> as I'm sure I had built a running kernel a month or two back.
> Currently building a pre-christmas linux-mips snapshot to see if that
> works.
> 
> If that doesn't work I'll just start using a mipsel version as I would
> be wary of using big endian if no one else is.

Plenty of machines are using big endian and can't even be configured to
little endian, so even in case you're hitting a problem it can't be
very significant or even fundamental.

  Ralf
