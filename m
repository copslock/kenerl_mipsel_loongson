Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39Mtpj20107
	for linux-mips-outgoing; Mon, 9 Apr 2001 15:55:51 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39MtkM20103;
	Mon, 9 Apr 2001 15:55:47 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 66D1D7D9; Tue, 10 Apr 2001 00:55:45 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 04559F385; Tue, 10 Apr 2001 00:55:28 +0200 (CEST)
Date: Tue, 10 Apr 2001 00:55:28 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com, rmurray@cyberhqz.com
Subject: Re: sgiwd93 multiple disk problem
Message-ID: <20010410005528.I22835@paradigm.rfc822.org>
References: <20010403174749.B4135@paradigm.rfc822.org> <013801c0bc58$7abe2700$0deca8c0@Ulysses> <20010409213632.B22835@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010409213632.B22835@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Apr 09, 2001 at 09:36:32PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ok - more info

1. The bug only happens when accessing 2 disks/devices on the SAME controller
2. The bug is in stopping the HPC DMA to early.
3. Stopping the DMA to early happens only on reads.


If applying this patch on the driver 

Index: drivers/scsi/sgiwd93.c
===================================================================
RCS file: /cvs/linux/drivers/scsi/sgiwd93.c,v
retrieving revision 1.27
diff -u -r1.27 sgiwd93.c
--- drivers/scsi/sgiwd93.c	2001/03/26 00:38:20	1.27
+++ drivers/scsi/sgiwd93.c	2001/04/09 22:12:10
@@ -183,6 +187,10 @@
 	printk("dma_stop: status<%d> ", status);
 #endif
 
+	if (hregs->ctrl & HPC3_SCTRL_ACTIVE)
+		printk("DMA still active dir %d bresid %d\n",
+			hdata->dma_dir,
+			SCpnt->SCp.buffers_residual);
 	/* First stop the HPC and flush it's FIFO. */
 	if(hdata->dma_dir) {
 		hregs->ctrl |= HPC3_SCTRL_FLUSH;


I get this output on the console which means files/data
got corrupted.

---------------schnipp---------------------
DMA still active dir 1 bresid 6
DMA still active dir 1 bresid 1
DMA still active dir 1 bresid 3
DMA still active dir 1 bresid 1
DMA still active dir 1 bresid 0
DMA still active dir 1 bresid 0
DMA still active dir 1 bresid 0
DMA still active dir 1 bresid 2
DMA still active dir 1 bresid 0
DMA still active dir 1 bresid 2
---------------schnapp---------------------

This might also be the cause why metadata has never been corrupted.
Metadata are mostly not read in large chunks which get unchecked
dumped to disk again.

One suspicion i had was around the modification of the wd33 registers in
the sgi driver (Its the only driver to do so) which based on the thesis
that on the wd33 driver we act on the current scatter_gather item
and subtract the total length - But this is simply wrong.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
