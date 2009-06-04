Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 23:23:08 +0100 (WEST)
Received: from elvis.franken.de ([193.175.24.41]:41665 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022631AbZFDWXB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 23:23:01 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1MCLKq-0002c6-00; Fri, 05 Jun 2009 00:22:56 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 690BBC35B7; Fri,  5 Jun 2009 00:20:20 +0200 (CEST)
Date:	Fri, 5 Jun 2009 00:20:20 +0200
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Message-ID: <20090604222020.GA14843@alpha.franken.de>
References: <200906041622.47591.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906041622.47591.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> We discussed that in private, there are a couple of things
> to fix in order to get 8250 working properly with TI AR7 HW.
> If you can still merge that bit, this would ease future work, thanks !

I still have a tree here, which works without any changes to the 8250
serial driver on a TNETD7300 device.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
