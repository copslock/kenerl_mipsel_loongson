Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 23:43:55 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:46591 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225254AbVEEWnl>; Thu, 5 May 2005 23:43:41 +0100
Received: (qmail 13206 invoked by uid 101); 5 May 2005 22:43:34 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 5 May 2005 22:43:34 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j45MhXew014790;
	Thu, 5 May 2005 15:43:33 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JGC9BTGB>; Thu, 5 May 2005 15:43:33 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259024380C7@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	"'linux-pcmcia@lists.infradead.org'" 
	<linux-pcmcia@lists.infradead.org>
Subject: pcmcia-cs package for linux-mips 2.6.10?
Date:	Thu, 5 May 2005 15:43:31 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



I have downloaded pcmcia-cs package v3.2.8 [David Hinds] from sourceforge.
The  Configure file doesnt have anything for MIPS. I tweaked Configure
and config.mk step-by-step and could get cardmgr/ to compile but wasnt
successful with clients/

Is there any patch for MIPS? linux-mips 2.6.10 to be specific? Can you point
me to its porting to MIPS?

Thanks,
Kiran
