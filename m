Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 17:45:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36243 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133474AbWFTQpp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 17:45:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5KGjesV027069;
	Tue, 20 Jun 2006 17:45:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5KGjZJo027066;
	Tue, 20 Jun 2006 17:45:35 +0100
Date:	Tue, 20 Jun 2006 17:45:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Cc:	Roman Mashak <mrv@corecom.co.kr>, linux-mips@linux-mips.org
Subject: Re: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Message-ID: <20060620164535.GA25120@linux-mips.org>
References: <478F19F21671F04298A2116393EEC3D531D2D4@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478F19F21671F04298A2116393EEC3D531D2D4@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 20, 2006 at 09:15:56AM -0700, Raj Palani wrote:

> > The Titan driver (the version on linux-mips.org and any other 
> > version I've
> > seen) are pretty broken and remarkably ugly pieces of code.  
> > The authors of the Basler eXcite platform have contributed 
> > their driver and I hope it will show up upstream soon.  Afaik 
> > it has not been tested with any of PMC's eval boards but the 
> > necessary changes should not be hard.
> 
> I would request that you take a look at our current GE driver (msp85x0_ge.c) for the Sequoia platform and send us your feedback.  This is currently available on our ftp site ftp.pmc-sierra.com under /pub/linux/2.6.12/linux-2.6.12-rc3_L002.tar.gz.  The driver has been completely re-written and we welcome any feedback on the same.
> 
> The patches that have been generated for fixes that were made after this release are available under /pub/linux/2.6.12/patches-2.6.12-rc3_L002.  
> 
> We are in the process of generating a patch for the Sequoia platform (for the MSP85x0) to be submitted to Linux/MIPS.  Note that we will be having a separate GE driver for the MSP85x0, while the old Titan GE driver (titan_ge.c) would support the Titan (RM912x) chip on the Yosemite platform.  FYI, the MSP85x0 is the new name for the RM915x device.

Unless my memory is wrong Seqoia and Yosemite have the same ethernet
controller, so why two drivers?

  Ralf
