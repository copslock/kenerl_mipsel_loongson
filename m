Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Aug 2008 23:20:46 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:7881
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20026644AbYHCWUh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Aug 2008 23:20:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m73MKT8u015055;
	Sun, 3 Aug 2008 23:20:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m73MKRnx015054;
	Sun, 3 Aug 2008 23:20:27 +0100
Date:	Sun, 3 Aug 2008 23:20:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	a.zummo@towertech.it
Subject: Re: [PATCH] DS1286: new RTC driver
Message-ID: <20080803222027.GA14674@linux-mips.org>
References: <20080803174137.AF8071DA6F4@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080803174137.AF8071DA6F4@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 03, 2008 at 07:41:37PM +0200, Thomas Bogendoerfer wrote:

> This driver replaces the broken DS1286 driver in drivers/char and
> gives back RTC support for SGI IP22 and IP28 machines.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

I would like to see this driver to go into 2.6.27.  A while ago MIPS has
switched to rtc_class resulting not yet updated platforms such as IP22
to fail to build.

  Ralf
