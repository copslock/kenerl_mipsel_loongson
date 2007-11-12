Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2007 22:31:28 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:30399 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578773AbXKLWbU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2007 22:31:20 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IrhoN-0006yJ-00; Mon, 12 Nov 2007 23:31:19 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 578BAC2AD8; Mon, 12 Nov 2007 23:31:04 +0100 (CET)
Date:	Mon, 12 Nov 2007 23:31:04 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: problem with 64bit kernel, BOOT_ELF32 and memory outside CKSEG0
Message-ID: <20071112223104.GA7900@alpha.franken.de>
References: <20071111143302.GA26458@alpha.franken.de> <20071111213127.GA26297@linux-mips.org> <20071112083242.GA6065@alpha.franken.de> <20071112104423.GA27588@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071112104423.GA27588@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Nov 12, 2007 at 10:44:23AM +0000, Ralf Baechle wrote:
> But even if you get that wrong the expected failure mode is different ...

Ralf and me had an debug session on IRC and I finally figured out
what caused the problem: CONFIG_EARLY_PRINTK via prom calls.

I simply used call_o32.S from the decstation part and missed the
fact, that it simply uses the normal kernel stack when calling
firmware. This works quite good until the first kernel thread
gets scheduled, which has a kernel stack via a CAC_BASE address.
So after switching stack the next call to prom_putchar() killed the
machine. Simply disabling EARLY_PRINTK gives me a working 64bit
kernel, which sees the whole 512MB RAM :-)

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
