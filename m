Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DJbFA17826
	for linux-mips-outgoing; Mon, 13 Aug 2001 12:37:15 -0700
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DJbCj17823
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 12:37:12 -0700
Received: (qmail 11216 invoked from network); 13 Aug 2001 19:37:10 -0000
Received: from idahub2000.i-data.com (HELO idanshub) (172.16.1.8)
  by firewall.i-data.com with SMTP; 13 Aug 2001 19:37:10 -0000
Received: from eicon.com ([172.16.2.227])
          by idanshub (Lotus Domino Release 5.0.8)
          with ESMTP id 2001081321393657:4124 ;
          Mon, 13 Aug 2001 21:39:36 +0200 
Message-ID: <3B782CB0.AA24C7C8@eicon.com>
Date: Mon, 13 Aug 2001 21:38:24 +0200
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Barry Wu <wqb123@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: mips ide disk dma problem
References: <20010813130729.37581.qmail@web13908.mail.yahoo.com>
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 13-08-2001 21:39:37,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 13-08-2001
 21:39:38,
	Serialize complete at 13-08-2001 21:39:38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Barry Wu wrote:
> I meet problems about mips ide disk. I find dma mode
> is different from other platform. We have to use
> dma_cache_wback_inv and vtonocache functions to work
> under DMA mode, I read pcnet32 ethernet driver,
> it works like that. I do not know if I have to support
> ide disk dma, what I have to do?

Some MIPS'ification is needed to handle the caches.
You can try the patch below to drivers/block/ide-dma.c.

I don't know about your IDE controller (our board have 
a CMD PCI-648), but it may need some special handling also.

-Tommy


--- ide-dma.c.old	Tue Aug 31 09:46:14 1999
+++ ide-dma.c	Mon Aug 13 20:51:57 2001
@@ -176,6 +176,13 @@
 #endif
 	unsigned int count = 0;
 
+#if defined(__mips__)
+	/* MIPS: We access the dmatable through uncached addresses, so that it
+	 * will be read correctly by the controller. The alternative is to flush
+	 * the appropriate range at the end of this procedure.
+	 */
+	table = (unsigned int *)vtonocache(table);
+#endif
 	do {
 		/*
 		 * Determine addr and size of next buffer area.  We assume that
@@ -197,6 +204,10 @@
 				size += bh->b_size;
 			}
 		}
+#if defined(__mips__)
+		/* MIPS: We need to flush the cache */
+		dma_cache_wback_inv(bus_to_virt(addr), size);
+#endif
 		/*
 		 * Fill in the dma table, without crossing any 64kB boundaries.
 		 * Most hardware requires 16-bit alignment of all blocks,
@@ -401,6 +412,10 @@
 		dmatable += (PRD_ENTRIES * PRD_BYTES);
 		leftover -= (PRD_ENTRIES * PRD_BYTES);
 		hwif->dmaproc = &ide_dmaproc;
+#if defined(__mips__)
+		/* Make sure no part of the dmatable is in the cache */
+		dma_cache_wback_inv(hwif->dmatable, PRD_ENTRIES * PRD_BYTES);
+#endif
 
 		if (hwif->chipset != ide_trm290) {
 			byte dma_stat = inb(dma_base+2);
@@ -430,6 +445,9 @@
 		}
 	}
 	if (dma_base) {
+#if defined(__mips__)
+		dma_base = KSEG1ADDR(dma_base);
+#endif
 		if (extra) /* PDC20246 & HPT343 */
 			request_region(dma_base+16, extra, name);
 		dma_base += hwif->channel ? 8 : 0;
