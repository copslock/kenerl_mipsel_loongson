Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 07:39:38 +0100 (BST)
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23688 "EHLO 2ka.mipt.ru")
	by ftp.linux-mips.org with ESMTP id S20022239AbXFOGjf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2007 07:39:35 +0100
Received: from 2ka.mipt.ru (localhost [127.0.0.1])
	by 2ka.mipt.ru (8.13.8/8.13.8) with ESMTP id l5F6cq7D007710;
	Fri, 15 Jun 2007 10:38:54 +0400
Received: (from johnpol@localhost)
	by 2ka.mipt.ru (8.13.8/8.12.1/Submit) id l5F6cqHf007709;
	Fri, 15 Jun 2007 10:38:52 +0400
Date:	Fri, 15 Jun 2007 10:38:52 +0400
From:	Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 12/12] drivers: PMC MSP71xx security engine driver
Message-ID: <20070615063852.GC12796@2ka.mipt.ru>
References: <200706142212.l5EMCrc7024809@pasqua.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200706142212.l5EMCrc7024809@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (2ka.mipt.ru [0.0.0.0]); Fri, 15 Jun 2007 10:38:57 +0400 (MSD)
Return-Path: <johnpol@2ka.mipt.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnpol@2ka.mipt.ru
Precedence: bulk
X-list: linux-mips

Hi Marc.

On Thu, Jun 14, 2007 at 04:12:53PM -0600, Marc St-Jean (stjeanma@pmc-sierra.com) wrote:
> [PATCH 12/12] drivers: PMC MSP71xx security engine driver
> 
> Patch to add an security engien driver for the PMC-Sierra MSP71xx devices.

Does this board have SMP config or can this adapter be found in SMP
systems, since you only protect against interrupts, but not 
simultaneous SMP access to the engine.

And as a minor nit: there is no check for dma_alloc_coherent() return value.

-- 
	Evgeniy Polyakov
