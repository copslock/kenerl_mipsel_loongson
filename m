Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 21:48:25 +0100 (BST)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:15684
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225770AbUCaUsY>; Wed, 31 Mar 2004 21:48:24 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id i2VKmGHK004768;
	Wed, 31 Mar 2004 22:48:17 +0200
Message-ID: <406B2E90.5060307@murphy.dk>
Date: Wed, 31 Mar 2004 22:48:16 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
CC: linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com>
In-Reply-To: <4068864D.1020209@realitydiluted.com>
Content-Type: multipart/mixed;
 boundary="------------070906010302050400000805"
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070906010302050400000805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Steven J. Hill wrote:

> Brian Murphy wrote:
>
>> In pcnet32.c where the driver writer sets up her receive buffers 
>> there is this line
>>
>> lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, 
>> rx_skbuff->len, PCI_DMA_FROMDEVICE);
>>
>> the length value turns out to be 0 and crashes the running 
>> process,ifconfig.
>> Is making a map for a buffer of length 0 valid at all? If not what 
>> the hell is going on here.
>>
>> I feel this should say PKT_BUF_SZ instead of rx_skbuff->len which is 
>> the length of skbuff which has been
>> allocated at this point in the code, this is line 986 in todays 
>> checkout.
>>
>> Something is wrong in any case, any pointers?
>>
> Excellent. So my new BUG code detected another bad network driver. 
> Your network

Not sure what you mean. I get the panic "Break instruction in kernel 
code" from do_bp
in traps.c. This seems like a strange "assertion" to me...

Anyway the attached patch fixes my problems, is anyone interested in 
reviewing it?

/Brian

--------------070906010302050400000805
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: pcnet32.c
===================================================================
RCS file: /cvs/linux/drivers/net/pcnet32.c,v
retrieving revision 1.33.2.7
diff -u -r1.33.2.7 pcnet32.c
--- pcnet32.c	17 Nov 2003 01:07:38 -0000	1.33.2.7
+++ pcnet32.c	31 Mar 2004 20:31:01 -0000
@@ -983,7 +983,7 @@
 	}
 
 	if (lp->rx_dma_addr[i] == 0) 
-		lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, rx_skbuff->len, PCI_DMA_FROMDEVICE);
+		lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 	lp->rx_ring[i].base = (u32)le32_to_cpu(lp->rx_dma_addr[i]);
 	lp->rx_ring[i].buf_length = le16_to_cpu(-PKT_BUF_SZ);
 	lp->rx_ring[i].status = le16_to_cpu(0x8000);
@@ -1319,13 +1319,13 @@
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
@@ -1354,7 +1354,7 @@
 		    skb_put(skb,pkt_len);	/* Make room */
                     pci_dma_sync_single(lp->pci_dev, 
 		                        lp->rx_dma_addr[entry],
-		                        pkt_len,
+		                        PKT_BUF_SZ,
 		                        PCI_DMA_FROMDEVICE);
 		    eth_copy_and_sum(skb,
 				     (unsigned char *)(lp->rx_skbuff[entry]->tail),
@@ -1409,7 +1409,7 @@
     for (i = 0; i < RX_RING_SIZE; i++) {
 	lp->rx_ring[i].status = 0;			    
 	if (lp->rx_skbuff[i]) {
-            pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], lp->rx_skbuff[i]->len, PCI_DMA_FROMDEVICE);
+            pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 	    dev_kfree_skb(lp->rx_skbuff[i]);
         }
 	lp->rx_skbuff[i] = NULL;

--------------070906010302050400000805--
