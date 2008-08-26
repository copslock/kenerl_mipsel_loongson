Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 20:24:46 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:2238 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20038724AbYHZTYo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 20:24:44 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D54353209AE;
	Tue, 26 Aug 2008 19:24:46 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 26 Aug 2008 19:24:46 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Aug 2008 12:24:32 -0700
Message-ID: <48B4586F.6030201@avtrex.com>
Date:	Tue, 26 Aug 2008 12:24:31 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	David Acker <dacker@roinet.com>
Cc:	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] e100: Add missing dma sync for proper operation with
 non-coherent caches.
References: <48B3A8D0.2040108@avtrex.com> <48B45065.5050907@roinet.com>
In-Reply-To: <48B45065.5050907@roinet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2008 19:24:32.0157 (UTC) FILETIME=[5DD44CD0:01C907B1]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Acker wrote:
> David Daney wrote:

>> diff --git a/drivers/net/e100.c b/drivers/net/e100.c
>> index 19d32a2..fb8d551 100644
>> --- a/drivers/net/e100.c
>> +++ b/drivers/net/e100.c
>> @@ -1840,6 +1840,11 @@ static int e100_rx_indicate(struct nic *nic, 
>> struct rx *rx,
>>  
>>              if (readb(&nic->csr->scb.status) & rus_no_res)
>>                  nic->ru_running = RU_SUSPENDED;
>> +        /* We are done looking at the buffer.  Prepare it for
>> +         * more DMA.  */
>> +        pci_dma_sync_single_for_device(nic->pdev, rx->dma_addr,
>> +                           sizeof(struct rfd),
>> +                           PCI_DMA_FROMDEVICE);
>>          return -ENODATA;
>>      }
>>  
> Should the call to pci_dma_sync_single_for_device be DMA_TO_DEVICE since 
> we are giving the memory back to the device?

No.  We are giving the memory back to the device, but the direction of 
the data transfer is from the device to memory.

David Daney
