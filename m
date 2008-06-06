Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 08:46:03 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:51388 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023148AbYFFHp5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jun 2008 08:45:57 +0100
Received: (qmail 16781 invoked by uid 1000); 6 Jun 2008 09:45:56 +0200
Date:	Fri, 6 Jun 2008 09:45:56 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH 9/9] au1xmmc: Add back PB1200/DB1200 MMC activity LED
	support
Message-ID: <20080606074556.GE16498@roarinelk.homelinux.net>
References: <20080519080339.GA21985@roarinelk.homelinux.net> <20080519080837.GJ21985@roarinelk.homelinux.net> <20080605230803.75c16798@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080605230803.75c16798@mjolnir.drzeus.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Pierre,

On Thu, Jun 05, 2008 at 11:08:03PM +0200, Pierre Ossman wrote:
> On Mon, 19 May 2008 10:08:37 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > From 5747bd6933bb212ab83044fa79adf185d248513f Mon Sep 17 00:00:00 2001
> > From: Manuel Lauss <mlau@msc-ge.com>
> > Date: Sun, 18 May 2008 16:05:56 +0200
> > Subject: [PATCH] au1xmmc: Add back PB1200/DB1200 MMC activity LED support.
> > 
> > Add back PB1200/DB1200 MMC activity LED support just the way
> > it was done in the original driver source.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> You might want to consider using the LED subsystem now that the MMC
> core exports a trigger. Look at my next tree for how sdhci uses it.

I tried that originally. The LED subsystem seems quite complex for something
as simple as turning on a bit in a register. I don't have a DB1200 to test
so I went the safe route and added a simple callback to toggle the LED bit in
the DB1200 FPGA.

I'll try to come up with something over the weekend and then resend the
whole series.

Thanks!
	Manuel Lauss
