Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 17:46:23 +0100 (BST)
Received: from mga14.intel.com ([143.182.124.37]:37544 "EHLO mga14.intel.com")
	by ftp.linux-mips.org with ESMTP id S20030822AbYHZQqV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 17:46:21 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 26 Aug 2008 09:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.32,271,1217833200"; 
   d="scan'208";a="37741823"
Received: from azsmsx333.amr.corp.intel.com ([10.2.121.77])
  by azsmga001.ch.intel.com with ESMTP; 26 Aug 2008 09:45:59 -0700
Received: from ahkok-mobl.jf.intel.com ([134.134.19.85]) by azsmsx333.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Aug 2008 09:45:59 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ahkok-mobl.jf.intel.com (Postfix) with ESMTP id A4B324088C;
	Tue, 26 Aug 2008 09:45:58 -0700 (PDT)
Message-ID: <48B43346.2030600@intel.com>
Date:	Tue, 26 Aug 2008 09:45:58 -0700
From:	"Kok, Auke" <auke-jan.h.kok@intel.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080626)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [E1000-devel] [PATCH] e100: Add missing dma sync for proper operation
 with non-coherent caches.
References: <48B3A8D0.2040108@avtrex.com>
In-Reply-To: <48B3A8D0.2040108@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2008 16:45:59.0559 (UTC) FILETIME=[37E10970:01C9079B]
Return-Path: <auke-jan.h.kok@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: auke-jan.h.kok@intel.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I am running the e100 driver on a MIPS 4KEc system (32 bit mips with
> non-coherent DMA).  There was a problem where received packets would
> get 'stuck' for several seconds at a time and then be released all at
> once.
> 
> The cause was that if an interrupt were received when no RX packets
> were available, the status for the receive buffer would be stuck in
> the cache, so when the next interrupt arrived the old status value was
> read (indicating no packets available) instead of the new value.
> 
> The fix is to call pci_dma_sync_single_for_device on the RX if the
> packet is not available to invalidate the cache so that at the next
> interrupt valid status is returned.
> 
> The driver currently calls pci_dma_sync_single_for_cpu before reading
> the status, and this is indeed needed for cases like the R10000 CPU
> where the cache can be polluted by speculative execution, but for most
> machines it is a nop.
> 
> The patch was tested on 2.6.17-rc4 on a MIPS 4KEc.


lol, that's a bit old :)

A LOT of work has gone into 2.6.26+'s version of e100 that addresses specifically
non-coherent DMA machines, including a patch that looks very close to what you
write below here.

can you test the latest git tree and see if you still need (a modified or updated
version) of your patch?

I know for sure that the guys maintaining e100 do not have anything close to your
system, so they can't test that.

Cheers,

Auke

> 
> Signed-off-by: David Daney <ddaney@avtrex.com>
> ---
>  drivers/net/e100.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/e100.c b/drivers/net/e100.c
> index 19d32a2..fb8d551 100644
> --- a/drivers/net/e100.c
> +++ b/drivers/net/e100.c
> @@ -1840,6 +1840,11 @@ static int e100_rx_indicate(struct nic *nic, struct rx *rx,
>  
>  			if (readb(&nic->csr->scb.status) & rus_no_res)
>  				nic->ru_running = RU_SUSPENDED;
> +		/* We are done looking at the buffer.  Prepare it for
> +		 * more DMA.  */
> +		pci_dma_sync_single_for_device(nic->pdev, rx->dma_addr,
> +					       sizeof(struct rfd),
> +					       PCI_DMA_FROMDEVICE);
>  		return -ENODATA;
>  	}
>  
