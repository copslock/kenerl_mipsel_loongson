Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Nov 2002 21:20:58 +0100 (CET)
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10507 "EHLO
	www.linux.org.uk") by linux-mips.org with ESMTP id <S1123954AbSKMUU5>;
	Wed, 13 Nov 2002 21:20:57 +0100
Received: from nat-pool-rdu.redhat.com ([66.187.233.200] helo=pobox.com)
	by www.linux.org.uk with esmtp (Exim 3.33 #5)
	id 18C40I-0003XA-00; Wed, 13 Nov 2002 20:20:50 +0000
Message-ID: <3DD2B402.8040508@pobox.com>
Date: Wed, 13 Nov 2002 15:20:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	tsbogend@alpha.franken.de, linux-net@vger.kernel.org,
	kevink@mips.com
Subject: Re: BUG in the PCNET32 ethernet driver
References: <3DD254F8.14DE20EA@mips.com> <3DD280FB.7070907@pobox.com> <3DD2B128.62DFB392@mips.com>
In-Reply-To: <3DD254F8.14DE20EA@mips.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Carsten Langgaard wrote:

> Jeff Garzik wrote:
>
>
> >Carsten Langgaard wrote:
> >
> >
> >>@@ -1316,13 +1316,13 @@
> >>                  if ((newskb = dev_alloc_skb (PKT_BUF_SZ))) {
> >>                      skb_reserve (newskb, 2);
> >>                      skb = lp->rx_skbuff[entry];
> >>-                     pci_unmap_single(lp->pci_dev, 
> lp->rx_dma_addr[entry], skb->len,
> >>PCI_DMA_FROMDEVICE);
> >>+                     pci_unmap_single(lp->pci_dev, 
> lp->rx_dma_addr[entry], pkt_len +2,
> >>PCI_DMA_FROMDEVICE);
> >>                      skb_put (skb, pkt_len);
> >>                      lp->rx_skbuff[entry] = newskb;
> >
> >Why does this line not reference PKT_BUF_SZ when all the others do?
>
>
> In this case we know the size of the packet and therefore only need to 
> handle that.
> In the other cases we don't know have big the receiving packet is 
> going to be, so we has to
> take care of the whole buffer.



Well, it's a seriously bad idea to pass different values to map and 
unmap steps, because on some platforms you could wind up telling the 
IOMMU or some other allocator that you are allocating N bytes, but 
freeing N-M bytes.  IOW, a leak.

Now that that's been clarified, please fix up the patch and resubmit... 
  with this issue fixed, it looks apply-able.

	Jeff
