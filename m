Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TEgvnC014819
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 07:42:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TEgv1t014818
	for linux-mips-outgoing; Wed, 29 May 2002 07:42:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TEgpnC014815
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 07:42:52 -0700
Received: from [192.168.2.2] (IDENT:root@earth.ayrnetworks.com [10.1.1.24])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g4TEi3o12883;
	Wed, 29 May 2002 07:44:03 -0700
Mime-Version: 1.0
X-Sender: kph@192.168.2.1
Message-Id: <a05100301b91a980d0a14@[192.168.2.2]>
In-Reply-To: <3CF4B1A1.3000607@murphy.dk>
References: <3CF4B1A1.3000607@murphy.dk>
Date: Wed, 29 May 2002 07:43:52 -0700
To: Brian Murphy <brian@murphy.dk>, linux-mips <linux-mips@oss.sgi.com>
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: Re: pcnet32.c bug?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Yes, this fix is correct... I made the same patch locally... sorry we 
haven't submited it yet... turns out we've dropeed this one from our 
own latest sources; thanks for the reminder. :-)

Note that there is another problem with cache line invalidation and 
the use of pci_dma_sync_single(), where one can get stale entries in 
the cache when the buffer is next re-used for DMA.

My co-worker Will Jhun <mailto:wjhun@ayrnetworks.com> just sent 
e-mail on the subject of problems with the cache invalidation 
routines last Saturday, with Message-ID: 
<20020525131806.A4073@ayrnetworks.com>

Kevin

At 12:46 PM +0200 5/29/02, Brian Murphy wrote:
>If I don't apply the following patch to pcnet32.c then the network connection
>on my vr5000 box is extremely jerky. It also seems quite sensible to have a
>dma sync operation here.
>
>any comments?
>
>/Brian
>
>
>--- drivers/net/pcnet32.c	19 Mar 2002 16:40:55 -0000	1.1.1.1.2.1.2.6
>+++ drivers/net/pcnet32.c	29 May 2002 09:57:33 -0000	1.13.4.2
>@@ -1343,6 +1351,10 @@
>  		if (!rx_in_place) {
>  		    skb_reserve(skb,2); /* 16 byte align */
>  		    skb_put(skb,pkt_len);	/* Make room */
>+                    pci_dma_sync_single(lp->pci_dev,
>+				    lp->rx_skbuff[entry]->tail,
>+				    pkt_len,
>+				    PCI_DMA_FROMDEVICE);
>  		    eth_copy_and_sum(skb,
>  				     (unsigned char 
>*)(lp->rx_skbuff[entry]->tail),
>  				     pkt_len,0);


-- 
