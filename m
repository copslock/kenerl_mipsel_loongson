Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 00:32:30 +0100 (BST)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:9606 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225257AbVEEXcP>; Fri, 6 May 2005 00:32:15 +0100
Received: (qmail 1948 invoked by uid 101); 5 May 2005 23:32:03 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 5 May 2005 23:32:03 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j45NW3jI001058;
	Thu, 5 May 2005 16:32:03 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JGC9B4TB>; Thu, 5 May 2005 16:32:03 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259024380C8@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	"'ppopov@embeddedalley.com'" <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	"'linux-pcmcia@lists.infradead.org'" 
	<linux-pcmcia@lists.infradead.org>
Subject: RE: pcmcia-cs package for linux-mips 2.6.10?
Date:	Thu, 5 May 2005 16:32:02 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

I m trying to build memory_cs.o as a module.
It aint available in kernel. What do i do?

-----Original Message-----
From: Pete Popov [mailto:ppopov@embeddedalley.com]
Sent: Thursday, May 05, 2005 3:47 PM
To: Kiran Thota
Cc: 'linux-mips@linux-mips.org'; 'linux-pcmcia@lists.infradead.org'
Subject: Re: pcmcia-cs package for linux-mips 2.6.10?


On Thu, 2005-05-05 at 15:43 -0700, Kiran Thota wrote:
> 
> I have downloaded pcmcia-cs package v3.2.8 [David Hinds] from sourceforge.
> The  Configure file doesnt have anything for MIPS. I tweaked Configure
> and config.mk step-by-step and could get cardmgr/ to compile but wasnt
> successful with clients/
> 
> Is there any patch for MIPS? linux-mips 2.6.10 to be specific? Can you point
> me to its porting to MIPS?

Use the in-kernel client drivers instead. All you need from the pcmcia-
cs package is the userland utilities.

Pete
