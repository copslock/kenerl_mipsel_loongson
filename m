Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 12:59:50 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:20931 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20030518AbYELL7s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 12:59:48 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JvWh1-0006uq-00; Mon, 12 May 2008 13:59:47 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id CC704DE534; Mon, 12 May 2008 13:58:55 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Better load address for SNI RM
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080512115855.CC704DE534@solo.franken.de>
Date:	Mon, 12 May 2008 13:58:55 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Use better load address for kernel to avoid clashes with PROM/SASH

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---


 arch/mips/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 69648d0..3f3815a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -565,7 +565,7 @@ load-$(CONFIG_BCM47XX)		:= 0xffffffff80001000
 #
 core-$(CONFIG_SNI_RM)		+= arch/mips/sni/
 cflags-$(CONFIG_SNI_RM)		+= -Iinclude/asm-mips/mach-rm
-load-$(CONFIG_SNI_RM)		+= 0xffffffff80600000
+load-$(CONFIG_SNI_RM)		+= 0xffffffff80030000
 all-$(CONFIG_SNI_RM)		:= vmlinux.ecoff
 
 #
