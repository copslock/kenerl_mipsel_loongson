Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 19:50:23 +0100 (BST)
Received: from static-72-92-88-10.phlapa.fios.verizon.net ([72.92.88.10]:64213
	"EHLO smtp.roinet.com") by ftp.linux-mips.org with ESMTP
	id S20038474AbYHZSuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 19:50:21 +0100
Received: (qmail 10984 invoked from network); 26 Aug 2008 18:50:13 -0000
Received: from unknown (HELO ?192.168.1.40?) (dacker@192.168.1.40)
  by smtp.roinet.com with ESMTPA; 26 Aug 2008 18:50:13 -0000
Message-ID: <48B45065.5050907@roinet.com>
Date:	Tue, 26 Aug 2008 14:50:13 -0400
From:	David Acker <dacker@roinet.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] e100: Add missing dma sync for proper operation with
 non-coherent caches.
References: <48B3A8D0.2040108@avtrex.com>
In-Reply-To: <48B3A8D0.2040108@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dacker@roinet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dacker@roinet.com
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
Should the call to pci_dma_sync_single_for_device be DMA_TO_DEVICE since 
we are giving the memory back to the device?
-ack
