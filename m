Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Nov 2002 21:09:16 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:32191 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123954AbSKMUJQ>;
	Wed, 13 Nov 2002 21:09:16 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gADK8tNf012690;
	Wed, 13 Nov 2002 12:08:55 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA12791;
	Wed, 13 Nov 2002 12:08:47 -0800 (PST)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gADK8jb20525;
	Wed, 13 Nov 2002 21:08:45 +0100 (MET)
Message-ID: <3DD2B128.62DFB392@mips.com>
Date: Wed, 13 Nov 2002 21:08:08 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	tsbogend@alpha.franken.de, linux-net@vger.kernel.org,
	kevink@mips.com
Subject: Re: BUG in the PCNET32 ethernet driver
References: <3DD254F8.14DE20EA@mips.com> <3DD280FB.7070907@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Jeff Garzik wrote:

> Carsten Langgaard wrote:
>
> > @@ -1316,13 +1316,13 @@
> >                   if ((newskb = dev_alloc_skb (PKT_BUF_SZ))) {
> >                       skb_reserve (newskb, 2);
> >                       skb = lp->rx_skbuff[entry];
> > -                     pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry], skb->len,
> > PCI_DMA_FROMDEVICE);
> > +                     pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry], pkt_len +2,
> > PCI_DMA_FROMDEVICE);
> >                       skb_put (skb, pkt_len);
> >                       lp->rx_skbuff[entry] = newskb;
>
> Why does this line not reference PKT_BUF_SZ when all the others do?

In this case we know the size of the packet and therefore only need to handle that.
In the other cases we don't know have big the receiving packet is going to be, so we has to
take care of the whole buffer.

/Carsten
