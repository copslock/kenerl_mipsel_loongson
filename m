Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 16:02:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27068 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025665AbXKAQCc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 16:02:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA1G2AxF020424;
	Thu, 1 Nov 2007 16:02:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA1G2A3r020423;
	Thu, 1 Nov 2007 16:02:10 GMT
Date:	Thu, 1 Nov 2007 16:02:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] JAZZ: disable PIT; cleanup R4030 clockevent
Message-ID: <20071101160210.GA20366@linux-mips.org>
References: <20071101125236.GA16577@alpha.franken.de> <20071101150741.GA8570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071101150741.GA8570@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 03:07:41PM +0000, Ralf Baechle wrote:

> On Thu, Nov 01, 2007 at 01:52:36PM +0100, Thomas Bogendoerfer wrote:
> 
> > PIT doesn't work, disable it completly
> 
> I think this is the explanation:
> 
> include/asm-mips/mach-jazz/timex.h:#define CLOCK_TICK_RATE              100
> 
> while the PIT code actually expects 1193182.
> 
> Turns out that due to a recent Qemu bug which made the probe for the cp0
> compare interrupt fail the Malta code did fall back from the compare timer
> to the i8253 PIT for the clockevent device.  Works perfectly well.

So I just fixed the MIPS part of the CLOCK_TICK_RATE mess which is really
all over the kernel.  I hope this should bring the i2853 to life for you.
Could you test this?  It's pretty much the only hope for Jazz to go tickless
so we should try to get it to work.  Unfortunately there is a locking issue
lurking there as well so I need some feedback if you can get it to work.

  Ralf
