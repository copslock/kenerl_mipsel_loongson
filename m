Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Apr 2003 15:50:41 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:7348
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225236AbTD0Oug>; Sun, 27 Apr 2003 15:50:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 962262BC32; Sun, 27 Apr 2003 16:50:33 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 28849-09;
 Sun, 27 Apr 2003 16:50:32 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb54d0.pool.mediaWays.net [217.187.84.208])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 15DD02BC31; Sun, 27 Apr 2003 16:50:32 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 5ED451735D; Sun, 27 Apr 2003 16:47:30 +0200 (CEST)
Date: Sun, 27 Apr 2003 16:47:30 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH]: asm-mips/sgi/mc.h register padding broken
Message-ID: <20030427144730.GB24352@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,
the register layout of the IP22s mc is missing some paddings which
results in some nice bus error exceptions. Please apply this patch
against 2.4. and 2.5:

diff -u -p -r1.1.2.1 mc.h
--- include/asm-mips/sgi/mc.h	19 Mar 2003 04:23:22 -0000	1.1.2.1
+++ include/asm-mips/sgi/mc.h	27 Apr 2003 14:41:36 -0000
@@ -153,7 +153,7 @@ struct sgimc_regs {
 	volatile u32 elock;		/* Locks EISA from GIO accesses */
 
 	/* GIO dma control registers. */
-	u32 _unused22[14];
+	u32 _unused22[15];
 	volatile u32 gio_dma_trans;	/* DMA mask to translation GIO addrs */
 	u32 _unused23;
 	volatile u32 gio_dma_sbits;	/* DMA GIO addr substitution bits */
@@ -163,7 +163,7 @@ struct sgimc_regs {
 	volatile u32 dma_ctrl;		/* Main DMA control reg */
 
 	/* DMA TLB entry 0 */
-	u32 _unused26;
+	u32 _unused26[5];
 	volatile u32 dtlb_hi0;
 	u32 _unused27;
 	volatile u32 dtlb_lo0;

Regards,
 -- Guido
