Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f52HA3b17992
	for linux-mips-outgoing; Sat, 2 Jun 2001 10:10:03 -0700
Received: from aeon.tvd.be (aeon.tvd.be [195.162.196.20])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f52HA2h17989
	for <linux-mips@oss.sgi.com>; Sat, 2 Jun 2001 10:10:02 -0700
Received: from callisto.of.borg (cable-195-162-217-46.upc.chello.be [195.162.217.46])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id TAA09916
	for <linux-mips@oss.sgi.com>; Sat, 2 Jun 2001 19:10:00 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id TAA23925
	for <linux-mips@oss.sgi.com>; Sat, 2 Jun 2001 19:07:46 +0200
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date: Sat, 2 Jun 2001 19:07:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: wd33c93 question
Message-ID: <Pine.LNX.4.05.10106021901200.23007-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

	Hi,

Anyone who can explain these changes? Here the MIPS tree differs from Linus'
(and the m68k) tree.

According to the CVS logs, this change entered in revision 1.7 due to a sync
with Linus' tree (which introduced other formatting changes) somewhere in 1998.
In Linus' tree it must have changed afterwards a long time ago (before 2.2.0).

--- linux-2.4.5/drivers/scsi/wd33c93.c	Tue Dec  5 21:43:48 2000
+++ linux-mips/drivers/scsi/wd33c93.c	Mon Mar 26 02:38:20 2001
@@ -614,7 +614,6 @@
                      (is_dir_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
             write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
          else {
-            write_wd33c93_count(regp, cmd->SCp.this_residual);
             write_wd33c93(regp,WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
             hostdata->dma = D_DMA_RUNNING;
             }
@@ -735,7 +734,6 @@
       hostdata->dma_cnt++;
 #endif
       write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
-      write_wd33c93_count(regp,cmd->SCp.this_residual);
 
       if ((hostdata->level2 >= L2_DATA) ||
           (hostdata->level2 == L2_BASIC && cmd->SCp.phase == 0)) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
