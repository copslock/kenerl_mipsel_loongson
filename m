Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 17:55:03 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:25043 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20038405AbYHZQzB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 17:55:01 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id F28FE32097B;
	Tue, 26 Aug 2008 16:55:01 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 26 Aug 2008 16:55:01 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Aug 2008 09:54:49 -0700
Message-ID: <48B43557.7070505@avtrex.com>
Date:	Tue, 26 Aug 2008 09:54:47 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	"Kok, Auke" <auke-jan.h.kok@intel.com>
Cc:	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [E1000-devel] [PATCH] e100: Add missing dma sync for proper operation
 with non-coherent caches.
References: <48B3A8D0.2040108@avtrex.com> <48B43346.2030600@intel.com>
In-Reply-To: <48B43346.2030600@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2008 16:54:49.0028 (UTC) FILETIME=[73779840:01C9079C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Kok, Auke wrote:
> David Daney wrote:
>> I am running the e100 driver on a MIPS 4KEc system (32 bit mips with
>> non-coherent DMA).  There was a problem where received packets would
>> get 'stuck' for several seconds at a time and then be released all at
>> once.
>>
>> The cause was that if an interrupt were received when no RX packets
>> were available, the status for the receive buffer would be stuck in
>> the cache, so when the next interrupt arrived the old status value was
>> read (indicating no packets available) instead of the new value.
>>
>> The fix is to call pci_dma_sync_single_for_device on the RX if the
>> packet is not available to invalidate the cache so that at the next
>> interrupt valid status is returned.
>>
>> The driver currently calls pci_dma_sync_single_for_cpu before reading
>> the status, and this is indeed needed for cases like the R10000 CPU
>> where the cache can be polluted by speculative execution, but for most
>> machines it is a nop.
>>
>> The patch was tested on 2.6.17-rc4 on a MIPS 4KEc.
> 
> 
> lol, that's a bit old :)
> 

It was a typo.  The real version is 2.6.27-rc4 (aka the HEAD).

The bug is present on the HEAD.  Sorry for the confusion.

David Daney.



> A LOT of work has gone into 2.6.26+'s version of e100 that addresses specifically
> non-coherent DMA machines, including a patch that looks very close to what you
> write below here.
> 
> can you test the latest git tree and see if you still need (a modified or updated
> version) of your patch?
> 
> I know for sure that the guys maintaining e100 do not have anything close to your
> system, so they can't test that.
> 
> Cheers,
> 
> Auke
> 
>> Signed-off-by: David Daney <ddaney@avtrex.com>
>> ---
>>  drivers/net/e100.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/net/e100.c b/drivers/net/e100.c
>> index 19d32a2..fb8d551 100644
>> --- a/drivers/net/e100.c
>> +++ b/drivers/net/e100.c
>> @@ -1840,6 +1840,11 @@ static int e100_rx_indicate(struct nic *nic, struct rx *rx,
>>  
>>  			if (readb(&nic->csr->scb.status) & rus_no_res)
>>  				nic->ru_running = RU_SUSPENDED;
>> +		/* We are done looking at the buffer.  Prepare it for
>> +		 * more DMA.  */
>> +		pci_dma_sync_single_for_device(nic->pdev, rx->dma_addr,
>> +					       sizeof(struct rfd),
>> +					       PCI_DMA_FROMDEVICE);
>>  		return -ENODATA;
>>  	}
>>  
> 
