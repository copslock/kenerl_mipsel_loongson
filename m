Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TAjgnC003367
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 03:45:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TAjg5O003366
	for linux-mips-outgoing; Wed, 29 May 2002 03:45:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TAjanC003361
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 03:45:36 -0700
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.2/8.12.2/Debian -5) with ESMTP id g4TAkvtS006767
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 12:46:57 +0200
Message-ID: <3CF4B1A1.3000607@murphy.dk>
Date: Wed, 29 May 2002 12:46:57 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: pcnet32.c bug?
Content-Type: multipart/mixed;
 boundary="------------070203020806000606040209"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------070203020806000606040209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If I don't apply the following patch to pcnet32.c then the network 
connection
on my vr5000 box is extremely jerky. It also seems quite sensible to have a
dma sync operation here.

any comments?

/Brian

--------------070203020806000606040209
Content-Type: text/plain;
 name="pcnet32.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32.diff"

--- drivers/net/pcnet32.c	19 Mar 2002 16:40:55 -0000	1.1.1.1.2.1.2.6
+++ drivers/net/pcnet32.c	29 May 2002 09:57:33 -0000	1.13.4.2
@@ -1343,6 +1351,10 @@
 		if (!rx_in_place) {
 		    skb_reserve(skb,2); /* 16 byte align */
 		    skb_put(skb,pkt_len);	/* Make room */
+                    pci_dma_sync_single(lp->pci_dev, 
+				    lp->rx_skbuff[entry]->tail, 
+				    pkt_len,
+				    PCI_DMA_FROMDEVICE);
 		    eth_copy_and_sum(skb,
 				     (unsigned char *)(lp->rx_skbuff[entry]->tail),
 				     pkt_len,0);

--------------070203020806000606040209--
