Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 10:03:49 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:22661 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022706AbXIJJDl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2007 10:03:41 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IUf8B-0001Mv-00; Mon, 10 Sep 2007 11:00:31 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 08085C2B64; Mon, 10 Sep 2007 11:00:23 +0200 (CEST)
Date:	Mon, 10 Sep 2007 11:00:23 +0200
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	Matteo Croce <technoboy85@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Message-ID: <20070910090022.GA6085@alpha.franken.de>
References: <200708201704.11529.technoboy85@gmail.com> <20070909084752.GB2654@infomag.infomag.iguana.be> <200709092019.43471.technoboy85@gmail.com> <200709092027.32119.florian.fainelli@telecomint.eu> <20070910080634.GA5857@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070910080634.GA5857@alpha.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Sep 10, 2007 at 10:06:34AM +0200, Thomas Bogendoerfer wrote:
> On Sun, Sep 09, 2007 at 08:27:29PM +0200, Florian Fainelli wrote:
> > The thing is that the different TNETD versions : 7100, 7200 and 7300 should 
> > not have the same watchdog handling.
> 
> you just need to use the right address, 7100/7200 have a different
> address where the watchdog is (0x18611F00) than the 7300 (0x18610B00).
> Usage of the watchdog is the same.
> 

got the addresses wrong, they are 0x08611f00 and 0x08610b00 (both physical
addresses).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
