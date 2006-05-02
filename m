Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 19:02:31 +0100 (BST)
Received: from bes.recconet.de ([212.227.59.164]:36588 "EHLO bes.recconet.de")
	by ftp.linux-mips.org with ESMTP id S8133932AbWEBSCV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 19:02:21 +0100
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.1/8.13.1/Recconet-2005031001) with ESMTP id k42I2CmC017086;
	Tue, 2 May 2006 20:02:12 +0200
Received: from seneca.recco.de (seneca.recco.de [172.16.135.97])
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-2005061101) with ESMTP id k42I1L9K002924;
	Tue, 2 May 2006 20:01:21 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by seneca.recco.de (8.13.6/8.13.4/Seneca.Reccoware-2005061801) with ESMTP id k42I26uR015708;
	Tue, 2 May 2006 20:02:11 +0200
Subject: Re: Au1200 MMC/SD problem
From:	Wolfgang Ocker <weo@reccoware.de>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060502144314.GI22167@cosmic.amd.com>
References: <1146548770.1597.43.camel@seneca.recco.de>
	 <20060502144314.GI22167@cosmic.amd.com>
Content-Type: text/plain
Organization: Reccoware Systems
Date:	Tue, 02 May 2006 20:02:06 +0200
Message-Id: <1146592926.11188.12.camel@seneca.recco.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <weo@reccoware.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weo@reccoware.de
Precedence: bulk
X-list: linux-mips

On Tue, 2006-05-02 at 08:43 -0600, Jordan Crouse wrote:
> On 02/05/06 07:46 +0200, Wolfgang Ocker wrote:
> > [ timeout during cmd 9 ]

> Ok - so the reasons for cmd->error to be MMC_ERR_TIMEOUT are:
>   * invalid return from dma_map_sg in au1xmmc_prepare_data 
>   * general error from the DBDMA engine
>   * one of SD_STATUS_RAT sent when the IRQ fires

The last one. In au1xmmc_irq() the status register is read with the
SD_STATUS_RAT bit set.

> So to narrow it down - check the return value of au1xmmc_prepare_data
> in au1xmmc_request.  Then, see if RAT is ever set in au1xmmc_irq.   This
> will help narrow down the problem.  

au1xmmc_prepare_data doesn't return any error.

> Also, the usual general questions:
> What SD card are you using?  How big is it?  Is it a v1.01 or a v1.1 card?

1. Canon, 16 MB, got this one with a Canon camera.
2. Labeled by Hama, 1 GB, but I don't know the real manufacturer.

I can operate the cards on my Linux-Laptop. Is there a way to determine
the manufacturer and version directly from the card?

Thanks,
Wolfgang
