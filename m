Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 00:15:37 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:2989 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578102AbYEZXPR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2008 00:15:17 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1K0luO-0001Xr-00; Tue, 27 May 2008 01:15:16 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 14BBCFA1C3; Tue, 27 May 2008 01:15:16 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATH] Better load address for big endian SNI RM
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080526231516.14BBCFA1C3@solo.franken.de>
Date:	Tue, 27 May 2008 01:15:16 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Use better load address for big endian kernels to avoid clashes with PROM/SASH

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 69648d0..1ec8e35 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -565,7 +565,11 @@ load-$(CONFIG_BCM47XX)		:= 0xffffffff80001000
 #
 core-$(CONFIG_SNI_RM)		+= arch/mips/sni/
 cflags-$(CONFIG_SNI_RM)		+= -Iinclude/asm-mips/mach-rm
+ifdef CONFIG_CPU_LITTLE_ENDIAN
 load-$(CONFIG_SNI_RM)		+= 0xffffffff80600000
+else
+load-$(CONFIG_SNI_RM)		+= 0xffffffff80030000
+endif
 all-$(CONFIG_SNI_RM)		:= vmlinux.ecoff
 
 #
