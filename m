Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 14:09:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:16893 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023130AbYG2NIy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 14:08:54 +0100
Received: from localhost (p7108-ipad203funabasi.chiba.ocn.ne.jp [222.146.86.108])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 403A5A9FC; Tue, 29 Jul 2008 22:08:49 +0900 (JST)
Date:	Tue, 29 Jul 2008 22:10:47 +0900 (JST)
Message-Id: <20080729.221047.79299051.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] txx9: Kill unused txx927.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

include/asm-mips/txx9/txx927.h is no longer used.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied on top of my txx9 patch series and mips-kgdb patches.

 include/asm-mips/txx9/tx3927.h |    2 -
 include/asm-mips/txx9/txx927.h |  121 ----------------------------------------
 2 files changed, 0 insertions(+), 123 deletions(-)
 delete mode 100644 include/asm-mips/txx9/txx927.h

diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index 14e0636..587deb9 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -8,8 +8,6 @@
 #ifndef __ASM_TXX9_TX3927_H
 #define __ASM_TXX9_TX3927_H
 
-#include <asm/txx9/txx927.h>
-
 #define TX3927_REG_BASE	0xfffe0000UL
 #define TX3927_REG_SIZE	0x00010000
 #define TX3927_SDRAMC_REG	(TX3927_REG_BASE + 0x8000)
diff --git a/include/asm-mips/txx9/txx927.h b/include/asm-mips/txx9/txx927.h
deleted file mode 100644
index 97dd7ad..0000000
--- a/include/asm-mips/txx9/txx927.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Common definitions for TX3927/TX4927
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000 Toshiba Corporation
- */
-#ifndef __ASM_TXX9_TXX927_H
-#define __ASM_TXX9_TXX927_H
-
-struct txx927_sio_reg {
-	volatile unsigned long lcr;
-	volatile unsigned long dicr;
-	volatile unsigned long disr;
-	volatile unsigned long cisr;
-	volatile unsigned long fcr;
-	volatile unsigned long flcr;
-	volatile unsigned long bgr;
-	volatile unsigned long tfifo;
-	volatile unsigned long rfifo;
-};
-
-/*
- * SIO
- */
-/* SILCR : Line Control */
-#define TXx927_SILCR_SCS_MASK	0x00000060
-#define TXx927_SILCR_SCS_IMCLK	0x00000000
-#define TXx927_SILCR_SCS_IMCLK_BG	0x00000020
-#define TXx927_SILCR_SCS_SCLK	0x00000040
-#define TXx927_SILCR_SCS_SCLK_BG	0x00000060
-#define TXx927_SILCR_UEPS	0x00000010
-#define TXx927_SILCR_UPEN	0x00000008
-#define TXx927_SILCR_USBL_MASK	0x00000004
-#define TXx927_SILCR_USBL_1BIT	0x00000004
-#define TXx927_SILCR_USBL_2BIT	0x00000000
-#define TXx927_SILCR_UMODE_MASK	0x00000003
-#define TXx927_SILCR_UMODE_8BIT	0x00000000
-#define TXx927_SILCR_UMODE_7BIT	0x00000001
-
-/* SIDICR : DMA/Int. Control */
-#define TXx927_SIDICR_TDE	0x00008000
-#define TXx927_SIDICR_RDE	0x00004000
-#define TXx927_SIDICR_TIE	0x00002000
-#define TXx927_SIDICR_RIE	0x00001000
-#define TXx927_SIDICR_SPIE	0x00000800
-#define TXx927_SIDICR_CTSAC	0x00000600
-#define TXx927_SIDICR_STIE_MASK	0x0000003f
-#define TXx927_SIDICR_STIE_OERS		0x00000020
-#define TXx927_SIDICR_STIE_CTSS		0x00000010
-#define TXx927_SIDICR_STIE_RBRKD	0x00000008
-#define TXx927_SIDICR_STIE_TRDY		0x00000004
-#define TXx927_SIDICR_STIE_TXALS	0x00000002
-#define TXx927_SIDICR_STIE_UBRKD	0x00000001
-
-/* SIDISR : DMA/Int. Status */
-#define TXx927_SIDISR_UBRK	0x00008000
-#define TXx927_SIDISR_UVALID	0x00004000
-#define TXx927_SIDISR_UFER	0x00002000
-#define TXx927_SIDISR_UPER	0x00001000
-#define TXx927_SIDISR_UOER	0x00000800
-#define TXx927_SIDISR_ERI	0x00000400
-#define TXx927_SIDISR_TOUT	0x00000200
-#define TXx927_SIDISR_TDIS	0x00000100
-#define TXx927_SIDISR_RDIS	0x00000080
-#define TXx927_SIDISR_STIS	0x00000040
-#define TXx927_SIDISR_RFDN_MASK	0x0000001f
-
-/* SICISR : Change Int. Status */
-#define TXx927_SICISR_OERS	0x00000020
-#define TXx927_SICISR_CTSS	0x00000010
-#define TXx927_SICISR_RBRKD	0x00000008
-#define TXx927_SICISR_TRDY	0x00000004
-#define TXx927_SICISR_TXALS	0x00000002
-#define TXx927_SICISR_UBRKD	0x00000001
-
-/* SIFCR : FIFO Control */
-#define TXx927_SIFCR_SWRST	0x00008000
-#define TXx927_SIFCR_RDIL_MASK	0x00000180
-#define TXx927_SIFCR_RDIL_1	0x00000000
-#define TXx927_SIFCR_RDIL_4	0x00000080
-#define TXx927_SIFCR_RDIL_8	0x00000100
-#define TXx927_SIFCR_RDIL_12	0x00000180
-#define TXx927_SIFCR_RDIL_MAX	0x00000180
-#define TXx927_SIFCR_TDIL_MASK	0x00000018
-#define TXx927_SIFCR_TDIL_MASK	0x00000018
-#define TXx927_SIFCR_TDIL_1	0x00000000
-#define TXx927_SIFCR_TDIL_4	0x00000001
-#define TXx927_SIFCR_TDIL_8	0x00000010
-#define TXx927_SIFCR_TDIL_MAX	0x00000010
-#define TXx927_SIFCR_TFRST	0x00000004
-#define TXx927_SIFCR_RFRST	0x00000002
-#define TXx927_SIFCR_FRSTE	0x00000001
-#define TXx927_SIO_TX_FIFO	8
-#define TXx927_SIO_RX_FIFO	16
-
-/* SIFLCR : Flow Control */
-#define TXx927_SIFLCR_RCS	0x00001000
-#define TXx927_SIFLCR_TES	0x00000800
-#define TXx927_SIFLCR_RTSSC	0x00000200
-#define TXx927_SIFLCR_RSDE	0x00000100
-#define TXx927_SIFLCR_TSDE	0x00000080
-#define TXx927_SIFLCR_RTSTL_MASK	0x0000001e
-#define TXx927_SIFLCR_RTSTL_MAX	0x0000001e
-#define TXx927_SIFLCR_TBRK	0x00000001
-
-/* SIBGR : Baudrate Control */
-#define TXx927_SIBGR_BCLK_MASK	0x00000300
-#define TXx927_SIBGR_BCLK_T0	0x00000000
-#define TXx927_SIBGR_BCLK_T2	0x00000100
-#define TXx927_SIBGR_BCLK_T4	0x00000200
-#define TXx927_SIBGR_BCLK_T6	0x00000300
-#define TXx927_SIBGR_BRD_MASK	0x000000ff
-
-/*
- * PIO
- */
-
-#endif /* __ASM_TXX9_TXX927_H */
-- 
1.5.5.5
