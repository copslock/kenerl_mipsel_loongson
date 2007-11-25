Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 22:18:16 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:57059 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20035418AbXKYWSI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2007 22:18:08 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IwPng-00072C-00; Sun, 25 Nov 2007 23:18:04 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1E21DC2241; Sun, 25 Nov 2007 23:17:17 +0100 (CET)
Date:	Sun, 25 Nov 2007 23:17:17 +0100
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	tbm@cyrius.com, linux-mips@linux-mips.org,
	manoj.ekbote@broadcom.com, mark.e.mason@broadcom.com
Subject: Re: BigSur: garbled characters during boot
Message-ID: <20071125221717.GA11406@alpha.franken.de>
References: <20071125124842.GA32479@deprecation.cyrius.com> <20071125.222803.25909189.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071125.222803.25909189.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Nov 25, 2007 at 10:28:03PM +0900, Atsushi Nemoto wrote:
> Do you enable EARLY_PRINTK?  If so, this might be the console-handover
> issue.  On the handover, "console handover: boot ..." message will be
> printed both early console and new console.  If they were same device,
> drivers might be confused.

it will not be printed on both consoles, but while early console is
active the real console driver does things to the serial chip,
which might confuse the early console driver/prom.

> IIRC Maciej have tried to fix this issue a while ago on LKML.

this didn't work out for ip22zilog, so I digged through the mess. I
solved the problem by setting up the chip in one go. Before there
was some chip setup during probing, which killed prom_putchar().

Thomas

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
