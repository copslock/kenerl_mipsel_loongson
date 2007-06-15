Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 20:40:15 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:35715 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022619AbXFOTkN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 20:40:13 +0100
Received: (qmail 23055 invoked by uid 101); 15 Jun 2007 19:39:05 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 15 Jun 2007 19:39:05 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5FJcc1s010447;
	Fri, 15 Jun 2007 12:38:38 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW6VDP>; Fri, 15 Jun 2007 12:38:38 -0700
Message-ID: <4672EAB5.3000903@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>, davem@davemloft.net,
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 12/12] drivers: PMC MSP71xx security engine driver
Date:	Fri, 15 Jun 2007 12:38:29 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 15 Jun 2007 19:38:29.0661 (UTC) FILETIME=[C016C4D0:01C7AF84]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="koi8-r"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Evgeniy Polyakov wrote:
> Hi Marc.
> 
> On Thu, Jun 14, 2007 at 04:12:53PM -0600, Marc St-Jean 
> (stjeanma@pmc-sierra.com) wrote:
>  > [PATCH 12/12] drivers: PMC MSP71xx security engine driver
>  >
>  > Patch to add an security engien driver for the PMC-Sierra MSP71xx 
> devices.
> 
> Does this board have SMP config or can this adapter be found in SMP
> systems, since you only protect against interrupts, but not
> simultaneous SMP access to the engine.

It has been uni-processing only but SMP support is planned soon.

> 
> And as a minor nit: there is no check for dma_alloc_coherent() return 
> value.

I will look into it.

Thanks,
Marc
