Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UFknnC015088
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 08:46:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UFkn9l015087
	for linux-mips-outgoing; Thu, 30 May 2002 08:46:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UFkbnC015084
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 08:46:38 -0700
Message-Id: <200205301546.g4UFkbnC015084@oss.sgi.com>
Received: (qmail 21731 invoked from network); 30 May 2002 15:39:02 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 30 May 2002 15:39:02 -0000
Date: Thu, 30 May 2002 23:47:26 +0800
From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
To: Kevin Paul Herbert <kph@ayrnetworks.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: pcnet32.c bug?
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g4UFkcnC015085
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
>>--- drivers/net/pcnet32.c	19 Mar 2002 16:40:55 -0000	1.1.1.1.2.1.2.6
>>+++ drivers/net/pcnet32.c	29 May 2002 09:57:33 -0000	1.13.4.2
>>@@ -1343,6 +1351,10 @@
>>  		if (!rx_in_place) {
>>  		    skb_reserve(skb,2); /* 16 byte align */
>>  		    skb_put(skb,pkt_len);	/* Make room */
>>+                    pci_dma_sync_single(lp->pci_dev,
>>+				    lp->rx_skbuff[entry]->tail,
>>+				    pkt_len,
>>+				    PCI_DMA_FROMDEVICE);
>>  		    eth_copy_and_sum(skb,
>>  				     (unsigned char 
>>*)(lp->rx_skbuff[entry]->tail),
>>  				     pkt_len,0);

Because many mips ports do wback_inv for pci_dma_sync_single,how can
this help?
I think it just mean to invalidate cache contents the cpu has for this
buffer,and thus cpu can be sure to read data dmaed to memory by the device
And now we are doing write back,won't that be overwriting the buffer with 
stale data in cache?

so,the problem is,can we use wback_inv instead of inv in pci_dma_sync_single
when the direction is FROMDEVICE? I don't think so,but that would mean many
current drivers are broken...

i guess the fact that current driver are working is because no mips machine
has big enough cache to survive the data to the point of the buffer's reuse.

Correct solution should be something like Will Jhun's proposal? 

that is:
  each transition i.e. (FROM_DEVICE operation)
	pci_map_single()      - device now owns the buffer [invalidate]
	[DMA]
	pci_dma_sync_single() - driver now owns it         [no invalidate]
	[driver touches buffer]
	pci_dma_prep_single() - device owns it once again  [invalidate]
	[DMA] ...

I hope i am totally wrong:)

BTW: i am struggling with eepro100 driver these days,and now i have
got an NAPI version of it running. The rx ring often got messed up
with the old pci_dma_sync_xx logic,before i change it.



>
>Note that there is another problem with cache line invalidation and 
>the use of pci_dma_sync_single(), where one can get stale entries in 
>the cache when the buffer is next re-used for DMA.
>
>My co-worker Will Jhun <mailto:wjhun@ayrnetworks.com> just sent 
>e-mail on the subject of problems with the cache invalidation 
>routines last Saturday, with Message-ID: 
><20020525131806.A4073@ayrnetworks.com>
>
>Kevin




               



>
>
>-- 

= = = = = = = = = = = = = = = = = = = =
			

Best Regards
---------------------------------------
Zhang Fuxin
System Architecture Lab
Institute of Computing Technology
Chinese Academy of Sciences,China
http://www.ict.ac.cn
 
			　　　　　　　　　2002-05-30
