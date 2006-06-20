Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 17:16:35 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:27539 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133792AbWFTQQX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Jun 2006 17:16:23 +0100
Received: (qmail 18696 invoked by uid 101); 20 Jun 2006 16:16:11 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 20 Jun 2006 16:16:11 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5KGG5Os023067;
	Tue, 20 Jun 2006 09:16:10 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7F90A>; Tue, 20 Jun 2006 09:16:05 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D531D2D4@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: RE: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Date:	Tue, 20 Jun 2006 09:15:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Ralf and Roman, 

> 
> The Titan driver (the version on linux-mips.org and any other 
> version I've
> seen) are pretty broken and remarkably ugly pieces of code.  
> The authors of the Basler eXcite platform have contributed 
> their driver and I hope it will show up upstream soon.  Afaik 
> it has not been tested with any of PMC's eval boards but the 
> necessary changes should not be hard.

I would request that you take a look at our current GE driver (msp85x0_ge.c) for the Sequoia platform and send us your feedback.  This is currently available on our ftp site ftp.pmc-sierra.com under /pub/linux/2.6.12/linux-2.6.12-rc3_L002.tar.gz.  The driver has been completely re-written and we welcome any feedback on the same.

The patches that have been generated for fixes that were made after this release are available under /pub/linux/2.6.12/patches-2.6.12-rc3_L002.  

We are in the process of generating a patch for the Sequoia platform (for the MSP85x0) to be submitted to Linux/MIPS.  Note that we will be having a separate GE driver for the MSP85x0, while the old Titan GE driver (titan_ge.c) would support the Titan (RM912x) chip on the Yosemite platform.  FYI, the MSP85x0 is the new name for the RM915x device.

-Raj
