Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Mar 2008 10:42:07 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:4004 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28591578AbYCOKmE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 15 Mar 2008 10:42:04 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JaTpx-0004g3-00; Sat, 15 Mar 2008 11:42:01 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id A5B81C235E; Sat, 15 Mar 2008 11:40:09 +0100 (CET)
Date:	Sat, 15 Mar 2008 11:40:09 +0100
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Message-ID: <20080315104009.GA6533@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803130138.55582.technoboy85@gmail.com> <20080313084526.GA6012@alpha.franken.de> <200803141646.09645.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803141646.09645.technoboy85@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 14, 2008 at 04:46:09PM +0100, Matteo Croce wrote:
> This is a bit better

is it possible to try without the serial changes first ?

Use 

       uart_port[0].type = PORT_16550A;

in arch/mips/ar7/platform.c.

Does it work ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
