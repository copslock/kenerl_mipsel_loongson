Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Nov 2002 14:35:07 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:26552 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123923AbSKMNfG>;
	Wed, 13 Nov 2002 14:35:06 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gADDYoNf010995;
	Wed, 13 Nov 2002 05:34:50 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA26010;
	Wed, 13 Nov 2002 05:34:49 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gADDYmb21456;
	Wed, 13 Nov 2002 14:34:48 +0100 (MET)
Message-ID: <3DD254F8.14DE20EA@mips.com>
Date: Wed, 13 Nov 2002 14:34:48 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	tsbogend@alpha.franken.de, linux-net@vger.kernel.org,
	kevink@mips.com
Subject: BUG in the PCNET32 ethernet driver
Content-Type: multipart/mixed;
 boundary="------------BB5442445461BE92A539EC42"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------BB5442445461BE92A539EC42
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I finally found the problem that caused a lot of problem with an
ethernet throughput test, that we have been running.
It turned out the problem is related to a bug in the PCNET32 driver,
when you are running it on a system that doesn't support hardware
coherency.

The problem is the way the AMD ethernet driver is using the PCI DMA
mapping routines.
When the driver releases a receive DMA buffer to the controller for
later DMA transfer it call the PCI DMA flushing routine as it should,
but it calls it with a length equal to 0. The driver is assuming that
the length field in the buffer structure is equal to the actual length
of the buffer, but this field is first updated when we are receiving the
packet (and call the skb_put function).

I have attached a patch, that solve this problem.
Please note that the patch is against Ralf Baechle latest linux_2_4
tree.

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------BB5442445461BE92A539EC42
Content-Type: text/plain; charset=iso-8859-15;
 name="pcnet32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32.patch"

Index: drivers/net/pcnet32.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/pcnet32.c,v
retrieving revision 1.33.2.3
diff -u -r1.33.2.3 pcnet32.c
--- drivers/net/pcnet32.c	6 Oct 2002 20:49:43 -0000	1.33.2.3
+++ drivers/net/pcnet32.c	13 Nov 2002 13:32:09 -0000
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
+			pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry], pkt_len +2, PCI_DMA_FROMDEVICE);
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

--------------BB5442445461BE92A539EC42--
