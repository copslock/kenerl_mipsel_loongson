Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 21:39:42 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:18135 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023225AbXIKUjd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 21:39:33 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IVCWA-0006EB-00; Tue, 11 Sep 2007 22:39:30 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 32927C337C; Tue, 11 Sep 2007 22:34:57 +0200 (CEST)
Date:	Tue, 11 Sep 2007 22:34:57 +0200
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Message-ID: <20070911203457.GA6590@alpha.franken.de>
References: <200708201704.11529.technoboy85@gmail.com> <20070910080634.GA5857@alpha.franken.de> <20070910090022.GA6085@alpha.franken.de> <200709112154.25234.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709112154.25234.technoboy85@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Sep 11, 2007 at 09:54:24PM +0200, Matteo Croce wrote:
> If you read the ar7.h include file you will find:
> 
> #define AR7_REGS_BASE	0x08610000
> 
> #define AR7_REGS_WDT	(AR7_REGS_BASE + 0x1f00)
> #define UR8_REGS_WDT	(AR7_REGS_BASE + 0x0b00)
> 
> So they are correct

well 7300 is not UR8, but ar7_wdt_get_regs() looks correct.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
