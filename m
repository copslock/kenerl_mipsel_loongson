Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 18:08:20 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:7581 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133474AbWFTRIK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Jun 2006 18:08:10 +0100
Received: (qmail 2664 invoked by uid 101); 20 Jun 2006 17:08:03 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 20 Jun 2006 17:08:03 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5KH82j4022376;
	Tue, 20 Jun 2006 10:08:02 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7GB25>; Tue, 20 Jun 2006 10:08:02 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D531D2F8@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Roman Mashak <mrv@corecom.co.kr>, linux-mips@linux-mips.org
Subject: RE: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Date:	Tue, 20 Jun 2006 10:07:59 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

> Unless my memory is wrong Seqoia and Yosemite have the same 
> ethernet controller, so why two drivers?

They have similar, but not the same ethernet controller and they are different enough to qualify having separate drivers.  We found that maintaining both of them with #ifdef's all over the code, was simply not the right way to go about.

-Raj
