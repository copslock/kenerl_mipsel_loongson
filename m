Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Nov 2002 21:47:03 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:11456 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123954AbSKMUrC>;
	Wed, 13 Nov 2002 21:47:02 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gADKkoNf012858;
	Wed, 13 Nov 2002 12:46:51 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA14450;
	Wed, 13 Nov 2002 12:46:50 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gADKkob22973;
	Wed, 13 Nov 2002 21:46:50 +0100 (MET)
Message-ID: <3DD2BA39.E1457D67@mips.com>
Date: Wed, 13 Nov 2002 21:46:50 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	tsbogend@alpha.franken.de, linux-net@vger.kernel.org,
	kevink@mips.com
Subject: Re: BUG in the PCNET32 ethernet driver
References: <3DD254F8.14DE20EA@mips.com> <3DD280FB.7070907@pobox.com> <3DD2B128.62DFB392@mips.com> <3DD2B402.8040508@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------F6D4B5191D51956889E84897"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------F6D4B5191D51956889E84897
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> Carsten Langgaard wrote:
>
> > Jeff Garzik wrote:
> >
> >
> > >Carsten Langgaard wrote:
> > >
> > >
> > >>@@ -1316,13 +1316,13 @@
> > >>                  if ((newskb = dev_alloc_skb (PKT_BUF_SZ))) {
> > >>                      skb_reserve (newskb, 2);
> > >>                      skb = lp->rx_skbuff[entry];
> > >>-                     pci_unmap_single(lp->pci_dev,
> > lp->rx_dma_addr[entry], skb->len,
> > >>PCI_DMA_FROMDEVICE);
> > >>+                     pci_unmap_single(lp->pci_dev,
> > lp->rx_dma_addr[entry], pkt_len +2,
> > >>PCI_DMA_FROMDEVICE);
> > >>                      skb_put (skb, pkt_len);
> > >>                      lp->rx_skbuff[entry] = newskb;
> > >
> > >Why does this line not reference PKT_BUF_SZ when all the others do?
> >
> >
> > In this case we know the size of the packet and therefore only need to
> > handle that.
> > In the other cases we don't know have big the receiving packet is
> > going to be, so we has to
> > take care of the whole buffer.
>
> Well, it's a seriously bad idea to pass different values to map and
> unmap steps, because on some platforms you could wind up telling the
> IOMMU or some other allocator that you are allocating N bytes, but
> freeing N-M bytes.  IOW, a leak.

Ok, fine.
There is actually another place in the code that also need a fix then.


>
> Now that that's been clarified, please fix up the patch and resubmit...
>   with this issue fixed, it looks apply-able.
>

I have made the change and attached a new patch.

>
>         Jeff

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------F6D4B5191D51956889E84897
Content-Type: text/plain; charset=iso-8859-15;
 name="pcnet32.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32.2.patch"

Index: drivers/net/pcnet32.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/pcnet32.c,v
retrieving revision 1.33.2.3
diff -u -r1.33.2.3 pcnet32.c
--- drivers/net/pcnet32.c	6 Oct 2002 20:49:43 -0000	1.33.2.3
+++ drivers/net/pcnet32.c	13 Nov 2002 20:38:39 -0000
@@ -981,7 +981,7 @@
 	    }
 	    skb_reserve (rx_skbuff, 2);
 	}
-        lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, rx_skbuff->len, PCI_DMA_FROMDEVICE);
+        lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 	lp->rx_ring[i].base = (u32)le32_to_cpu(lp->rx_dma_addr[i]);
 	lp->rx_ring[i].buf_length = le16_to_cpu(-PKT_BUF_SZ);
 	lp->rx_ring[i].status = le16_to_cpu(0x8000);
@@ -1316,13 +1316,13 @@
 		    if ((newskb = dev_alloc_skb (PKT_BUF_SZ))) {
 			skb_reserve (newskb, 2);
 			skb = lp->rx_skbuff[entry];
-			pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry], skb->len, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry], PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 			skb_put (skb, pkt_len);
 			lp->rx_skbuff[entry] = newskb;
 			newskb->dev = dev;
                         lp->rx_dma_addr[entry] = 
 				pci_map_single(lp->pci_dev, newskb->tail,
-					newskb->len, PCI_DMA_FROMDEVICE);
+					PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 			lp->rx_ring[entry].base = le32_to_cpu(lp->rx_dma_addr[entry]);
 			rx_in_place = 1;
 		    } else
@@ -1349,13 +1349,10 @@
 		if (!rx_in_place) {
 		    skb_reserve(skb,2); /* 16 byte align */
 		    skb_put(skb,pkt_len);	/* Make room */
-                    pci_dma_sync_single(lp->pci_dev, 
-				    lp->rx_dma_addr[entry],
-				    pkt_len,
-				    PCI_DMA_FROMDEVICE);
 		    eth_copy_and_sum(skb,
 				     (unsigned char *)(lp->rx_skbuff[entry]->tail),
 				     pkt_len,0);
+		    lp->rx_dma_addr[entry] = pci_map_single(lp->pci_dev, lp->rx_skbuff[entry]->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 		}
 		lp->stats.rx_bytes += skb->len;
 		skb->protocol=eth_type_trans(skb,dev);
@@ -1406,7 +1403,7 @@
     for (i = 0; i < RX_RING_SIZE; i++) {
 	lp->rx_ring[i].status = 0;			    
 	if (lp->rx_skbuff[i]) {
-            pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], lp->rx_skbuff[i]->len, PCI_DMA_FROMDEVICE);
+            pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 	    dev_kfree_skb(lp->rx_skbuff[i]);
         }
 	lp->rx_skbuff[i] = NULL;

--------------F6D4B5191D51956889E84897--
