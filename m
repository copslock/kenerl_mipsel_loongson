Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 15:29:01 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:40096 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28639633AbYCRP27 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 15:28:59 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JbdkI-00013A-00; Tue, 18 Mar 2008 16:28:58 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 0E87EC27B4; Tue, 18 Mar 2008 16:28:40 +0100 (CET)
Date:	Tue, 18 Mar 2008 16:28:39 +0100
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Message-ID: <20080318152839.GA7765@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de> <200803161645.06364.technoboy85@gmail.com> <20080318133015.GA7239@alpha.franken.de> <20080318140133.3d41fd87@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080318140133.3d41fd87@core>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Mar 18, 2008 at 02:01:33PM +0000, Alan Cox wrote:
> > Is there a good reason, why we don't check for BOTH_EMPTY in
> > serial8250_console_putchar() ? To match the 2.6.10 behaviour we
> 
> A very good one - we have at least 1 byte of FIFO and the serial-ethernet
> magic console devices also use that fifo emptying entirely to deduce when
> to send a new packet.

ok, now I understand.

> > would need that and this would fix the AR7 case without any
> > special handling.
> 
> If the AR7 is an 8250 why does it need special handling? and indeed why
> does serial work on it except for console - or does that fail too.

well TI calls it a 16550A and I still wonder about the reported
problems. Looks like I need to dig a little bit deeper...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
