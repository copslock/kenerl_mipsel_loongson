Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 12:00:13 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:54444 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S28576665AbYDQLAK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 12:00:10 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3HAxJhW013035
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2008 03:59:20 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3HAxsMK028752;
	Thu, 17 Apr 2008 11:59:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3HAxr4m028739;
	Thu, 17 Apr 2008 11:59:53 +0100
Date:	Thu, 17 Apr 2008 11:59:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Roel Kluin <12o3l@tiscali.nl>, linux-mips@linux-mips.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6 v2] MIPS: ip27-timer: unsigned irq to evaluate
	allocate_irqno()
Message-ID: <20080417105930.GA28713@linux-mips.org>
References: <480559DC.2060807@tiscali.nl> <20080416091554.GA6026@alpha.franken.de> <480616C6.3080203@tiscali.nl> <20080416222755.GA18832@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080416222755.GA18832@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2008 at 12:27:56AM +0200, Thomas Bogendoerfer wrote:

> On Wed, Apr 16, 2008 at 05:09:58PM +0200, Roel Kluin wrote:
> > Thomas Bogendoerfer wrote:
> > > On Wed, Apr 16, 2008 at 03:43:56AM +0200, Roel Kluin wrote:
> > >> irq is unsigned, cast to signed to evaluate the allocate_irqno() return value,
> >  
> > >> +		if ((int) irq < 0)
> > > 
> > > Why don't you just make irq and rt_timer_irq an int ?
> > 
> > Ok, thanks, It should be right, but I cannot test this (no hardware).
> 
> I've tested it on real hardware.
> 
> Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, applied.

  Ralf
