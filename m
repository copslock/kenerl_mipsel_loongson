Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 01:08:41 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:40596 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20037341AbYHZAIj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 01:08:39 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 393E5320810
	for <linux-mips@linux-mips.org>; Tue, 26 Aug 2008 00:08:46 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Tue, 26 Aug 2008 00:08:46 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 25 Aug 2008 17:08:27 -0700
Message-ID: <48B34979.4090504@avtrex.com>
Date:	Mon, 25 Aug 2008 17:08:25 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: What's up with cpu_is_noncoherent_r10000() ?
References: <48B2DF15.5030903@avtrex.com>
In-Reply-To: <48B2DF15.5030903@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2008 00:08:27.0426 (UTC) FILETIME=[DD3A5020:01C9070F]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I am bringing up the git HEAD on an old ATI Xilleon X226.  This nice 
> system claims to be 4KEc, but for some reason doesn't support mips32r2, 
> but I digress.
> 
> Among its other problems this is a CONFIG_DMA_NONCOHERENT system, so 
> drivers like net/e100.c do not function properly if the cache is not 
> appropriately flushed/invalidated when they are doing DMA.  Fortunately 
> the authors of said driver have used 
> pci_dma_sync_single_for_{cpu,device} in what seems like the appropriate 
>  manner.
> 
> pci_dma_sync_single_for_device() ends up in dma_sync_single_for_device() 
> (in mm/dme-default.c) and is does the cache flush as expected.  The 
> problem is with dma_sync_single_for_cpu() which for some reason only 
> does the cache flush/invalidate  if cpu_is_noncoherent_r10000() returns 
> true (which it does only for R10K CPUs).  When I hack it up so that it 
> returns true unconditionally, e100 starts functioning normally for me. 
> This leads me to think that the cache operation should be done for all 
> CONFIG_DMA_NONCOHERENT systems not just R10K based systems.
> 
> What is the reasoning for only doing the cache operation on  R10K based 
> systems?
> 

OK, Ralf straightened me out on dma_sync_*.  It would appear that 
mm/dme-default.c is correct and drivers/net/e100.c is missing a 
pci_dma_sync_single_for_device().

I am preparing a patch for e100.c

David Daney
