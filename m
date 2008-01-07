Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 01:20:30 +0000 (GMT)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:19842
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S20028933AbYAGBUU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 01:20:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 0824DC8C183;
	Sun,  6 Jan 2008 17:20:19 -0800 (PST)
Date:	Sun, 06 Jan 2008 17:20:18 -0800 (PST)
Message-Id: <20080106.172018.39803221.davem@davemloft.net>
To:	tsbogend@alpha.franken.de
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, jgarzik@pobox.com
Subject: Re: [PATCH] METH: fix MAC address handling
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20080106113815.GA6140@alpha.franken.de>
References: <20080105224842.78EDCC2EFB@solo.franken.de>
	<20080106.002305.99653155.davem@davemloft.net>
	<20080106113815.GA6140@alpha.franken.de>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Sun, 6 Jan 2008 12:38:16 +0100

> On Sun, Jan 06, 2008 at 12:23:05AM -0800, David Miller wrote:
> > I know that this whole driver is full of assumptions about
> > the endianness of the system this chip is found on, so
> > I'm only interested in if the transformation is equivalent
> > and the driver will keep working properly.
> 
> I've tested the driver and it's still working :-)

Great :)
