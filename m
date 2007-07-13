Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 13:22:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42719 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023607AbXGMMWT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jul 2007 13:22:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6DC25k2016200;
	Fri, 13 Jul 2007 13:02:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6DC25g2016199;
	Fri, 13 Jul 2007 13:02:05 +0100
Date:	Fri, 13 Jul 2007 13:02:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org
Subject: Re: Alchemy driver sediments to be deleted?
Message-ID: <20070713120205.GA15331@linux-mips.org>
References: <20070712180445.GA22748@linux-mips.org> <200707131006.02010.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707131006.02010.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 10:05:58AM +0200, Florian Fainelli wrote:

> You can safely remove the au1000_gpio file because au1000 will now use the 
> generic GPIO implementation.

As expected.

> Instead of removing the touchscreen driver, I would move it to 
> drivers/input/touchscreen for now. There is probably some work to do to make 
> the ads7846 driver be usable with au1000.

Drivers/input requires a rewrite of the driver for the input subsystem and
the old driver is broken and apparently unused.

So I'll remove both.

  Ralf
