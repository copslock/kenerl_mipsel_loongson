Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 12:10:02 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:58509 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225297AbUDELJ7>; Mon, 5 Apr 2004 12:09:59 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id C429147C6D; Mon,  5 Apr 2004 13:09:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 675B347831; Mon,  5 Apr 2004 13:09:51 +0200 (CEST)
Date: Mon, 5 Apr 2004 13:09:51 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] swarm-cs4297a: Support little-endian configuration
Message-ID: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 The swarm-cs4297a driver currently works only with a big-endian
configuration -- if run in little-endian one, it floods the console with
an infinite stream of error messages, making the kernel effectively
unusable.

 Here's a fix.  Apart from removing the flood, it actually makes audio
work, at least the output.  Fixes for the input are untested, due to a
lack of a suitable input device, but hopefully they are OK.

 There's one functional difference -- the original code tried to
sign-extend 16-bit samples to 20 bits.  It did it incorrectly and also the
AC'97 spec says to send bits missing from samples as zeros, so I've 
removed that fragment.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-swarm-cs4297a-3
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/drivers/sound/swarm_cs4297a.c linux-mips-2.4.24-pre2-20040116/drivers/sound/swarm_cs4297a.c
--- linux-mips-2.4.24-pre2-20040116.macro/drivers/sound/swarm_cs4297a.c	2003-07-03 02:57:00.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/drivers/sound/swarm_cs4297a.c	2004-04-05 05:48:34.000000000 +0000
@@ -11,6 +11,7 @@
 *            -- adapted from cs4281 PCI driver for cs4297a on
 *               BCM1250 Synchronous Serial interface
 *               (Kip Walker, Broadcom Corp.)
+*      Copyright (C) 2004  Maciej W. Rozycki
 *
 *      This program is free software; you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License as published by
@@ -71,14 +72,16 @@
 #include <linux/ac97_codec.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
 #include <linux/wrapper.h>
-#include <asm/uaccess.h>
+
+#include <asm/byteorder.h>
+#include <asm/dma.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
 
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
@@ -758,7 +761,7 @@ static int serdma_reg_access(struct cs42
 
                 descr = &d->descrtab[swptr];
                 data_p = &d->dma_buf[swptr * 4];
-                *data_p = data;
+		*data_p = cpu_to_be64(data);
                 out64(1, SS_CSR(R_SER_DMA_DSCR_COUNT_TX));
                 CS_DBGOUT(CS_DESCR, 4,
                           printk(KERN_INFO "cs4297a: add_tx  %p (%x -> %x)\n",
@@ -950,7 +953,7 @@ static void cs4297a_update_ptr(struct cs
                         s_ptr = (u32 *)&(d->dma_buf[d->swptr*4]);
                         descr = &d->descrtab[d->swptr];
                         while (diff2--) {
-                                u64 data = *(u64 *)s_ptr;
+				u64 data = be64_to_cpu(*(u64 *)s_ptr);
                                 u64 descr_a;
                                 u16 left, right;
                                 descr_a = descr->descr_a;
@@ -977,10 +980,11 @@ static void cs4297a_update_ptr(struct cs
                                         continue;
                                 }
                                 good_diff++;
-                                left = ((s_ptr[1] & 0xff) << 8) | ((s_ptr[2] >> 24) & 0xff);
-                                right = (s_ptr[2] >> 4) & 0xffff;
-                                *d->sb_hwptr++ = left;
-                                *d->sb_hwptr++ = right;
+				left = ((be32_to_cpu(s_ptr[1]) & 0xff) << 8) |
+				       ((be32_to_cpu(s_ptr[2]) >> 24) & 0xff);
+				right = (be32_to_cpu(s_ptr[2]) >> 4) & 0xffff;
+				*d->sb_hwptr++ = cpu_to_be16(left);
+				*d->sb_hwptr++ = cpu_to_be16(right);
                                 if (d->sb_hwptr == d->sb_end)
                                         d->sb_hwptr = d->sample_buf;
                                 descr++;
@@ -1025,7 +1029,7 @@ static void cs4297a_update_ptr(struct cs
                            here because of an interrupt, so there must
                            be a buffer to process. */
                         do {
-                                data = *data_p;
+				data = be64_to_cpu(*data_p);
                                 if ((descr->descr_a & M_DMA_DSCRA_A_ADDR) != PHYSADDR((long)data_p)) {
                                         printk(KERN_ERR "cs4297a: RX Bad address %d (%llx %lx)\n", d->swptr,
                                                (long long)(descr->descr_a & M_DMA_DSCRA_A_ADDR),
@@ -1804,7 +1808,6 @@ static ssize_t cs4297a_write(struct file
                 u32 *s_tmpl;
                 u32 *t_tmpl;
                 u32 left, right;
-                /* XXXKW check system endian here ... */
                 int swap = (s->prop_dac.fmt == AFMT_S16_LE) || (s->prop_dac.fmt == AFMT_U16_LE);
                 
                 /* XXXXXX this is broken for BLOAT_FACTOR */
@@ -1845,21 +1848,21 @@ static ssize_t cs4297a_write(struct file
 
                 /* XXXKW assuming 16-bit stereo! */
                 do {
-                        t_tmpl[0] = 0x98000000;
-                        left = s_tmpl[0] >> 16;
-                        if (left & 0x8000)
-                                left |= 0xf0000;
-                        right = s_tmpl[0] & 0xffff;
-                        if (right & 0x8000)
-                                right |= 0xf0000;
-                        if (swap) {
-                          t_tmpl[1] = left & 0xff;
-                          t_tmpl[2] = ((left & 0xff00) << 16) | ((right & 0xff) << 12) |
-                              ((right & 0xff00) >> 4);
-                        } else {
-                          t_tmpl[1] = left >> 8;
-                          t_tmpl[2] = ((left & 0xff) << 24) | (right << 4);
-                        }
+			u32 tmp;
+
+			t_tmpl[0] = cpu_to_be32(0x98000000);
+
+			tmp = be32_to_cpu(s_tmpl[0]);
+			left = tmp & 0xffff;
+			right = tmp >> 16;
+			if (swap) {
+				left = swab16(left);
+				right = swab16(right);
+			}
+			t_tmpl[1] = cpu_to_be32(left >> 8);
+			t_tmpl[2] = cpu_to_be32(((left & 0xff) << 24) |
+						(right << 4));
+
                         s_tmpl++;
                         t_tmpl += 8;
                         copy_cnt -= 4;
@@ -1867,7 +1870,8 @@ static ssize_t cs4297a_write(struct file
 
                 /* Mux in any pending read/write accesses */
                 if (s->reg_request) {
-                        *(u64 *)(d->dma_buf + (swptr * 4)) |= s->reg_request;
+			*(u64 *)(d->dma_buf + (swptr * 4)) |=
+				cpu_to_be64(s->reg_request);
                         s->reg_request = 0;
                         wake_up(&s->dma_dac.reg_wait);
                 }
