Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 07:28:43 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:57751 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022286AbXIUG2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 07:28:33 +0100
Received: (qmail 3741 invoked by uid 101); 21 Sep 2007 06:27:25 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 21 Sep 2007 06:27:25 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l8L6RObe029158;
	Thu, 20 Sep 2007 23:27:24 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <RF20V8QD>; Thu, 20 Sep 2007 23:27:24 -0700
Message-ID: <340C71CD25A7EB49BFA81AE8C839266757076E@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Sagar Borikar <Sagar_Borikar@pmc-sierra.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>,
	Steve Graham <stgraham2000@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: RE: O2 RM7000 Issues
Date:	Thu, 20 Sep 2007 23:27:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <Sagar_Borikar@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Sagar_Borikar@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


rm7k_wait_irqoff patch doesn't seem to improve the things for illegal instructions for E9k core.
But many customers have reported that they do get illegal instruction when ﻿ICACHE_REFILLS_WORKAROUND_WAR is not enabled.

Thanks
Sagar



-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
Sent: Tuesday, September 18, 2007 2:23 PM
To: Steve Graham
Cc: linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues

On Mon, Sep 17, 2007 at 04:04:52PM -0700, Steve Graham wrote:

> I am having a similar problem where complicated bash scripts on boot 
> randomly throw SIGILL.  I am running on a PMC MSP8510 platform - E9000 
> core.  I have applied the patch to "war.h" mentioned in this thread 
> and that did greatly reduce the number of occurences of this problem 
> but has not fixed it.  I was getting at least 2 illegal instructions 
> every boot and now I can boot without any problems about 90% of the time.
> 
> Does the patch you mention below apply to the E9000 core as well?

Not to my knowledge - but I'm lacking any halfwayrecent errata information for the RM9000 series, maybe somebody from PMC can jump in?

  Ralf
