Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33H5Bb09194
	for linux-mips-outgoing; Tue, 3 Apr 2001 10:05:11 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33H59M09188
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 10:05:09 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0CD887F8; Tue,  3 Apr 2001 19:05:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 05E43F035; Tue,  3 Apr 2001 19:04:58 +0200 (CEST)
Date: Tue, 3 Apr 2001 19:04:58 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Re: sgiwd93 multiple disk problem
Message-ID: <20010403190458.C4135@paradigm.rfc822.org>
References: <20010403174749.B4135@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403174749.B4135@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Apr 03, 2001 at 05:47:49PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 05:47:49PM +0200, Florian Lohoff wrote:
> Hi,
> i guess Ryan Murray has stumbled over the multiple disk problem
> on one of my machines again - I would like to fix that bug if i am able to.

While staring at it - Duplicate cache-inv in driver init

--- drivers/scsi/sgiwd93.c	2001/03/26 00:38:20	1.27
+++ drivers/scsi/sgiwd93.c	2001/04/03 17:03:12
@@ -329,7 +333,6 @@
 			hdata1 = (struct WD33C93_hostdata *)sgiwd93_host1->hostdata;
 			hdata1->no_sync = 0;
 			hdata1->dma_bounce_buffer = (uchar *) (KSEG1ADDR(buf));
-			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 	
 			if (request_irq(SGI_WD93_1_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host1)) {
 				printk(KERN_WARNING "sgiwd93: Could not allocate irq %d (for host1).\n", SGI_WD93_1_IRQ);


Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
