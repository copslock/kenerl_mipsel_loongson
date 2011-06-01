Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2011 21:48:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47073 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491851Ab1FATrd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Jun 2011 21:47:33 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p51JldEN010172;
        Wed, 1 Jun 2011 20:47:39 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p51Jlcuv010171;
        Wed, 1 Jun 2011 20:47:38 +0100
Message-Id: <20110601180611.061710714@duck.linux-mips.net>
User-Agent: quilt/0.48-1
Date:   Wed, 01 Jun 2011 19:05:10 +0100
From:   ralf@linux-mips.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Subject: [patch 14/14] PCSPKR: MIPS: Make config dependencies finer grained.
References: <20110601180456.801265664@duck.linux-mips.net>
Content-Disposition: inline; filename=i8253-make-mips-pcspkr-config-finer-grained.patch
X-archive-position: 30182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1174

Only the Siemens-Nixdorf RM series workstations and the Jazz family
workstations have PC speakers built in; Malta can connect one via the
infamous AMR connector with an AMR sound card or a little creativity.
So we don't want to offer the PC speaker driver on all MIPS systems.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org

 arch/mips/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-mips/arch/mips/Kconfig
===================================================================
--- linux-mips.orig/arch/mips/Kconfig
+++ linux-mips/arch/mips/Kconfig
@@ -5,7 +5,6 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_IRQ_WORK
-	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
@@ -186,6 +185,7 @@ config MACH_JAZZ
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select GENERIC_ISA_DMA
+	select HAVE_PCSPKR_PLATFORM
 	select IRQ_CPU
 	select I8253
 	select I8259
@@ -267,6 +267,7 @@ config MIPS_MALTA
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
+	select HAVE_PCSPKR_PLATFORM
 	select IRQ_CPU
 	select IRQ_GIC
 	select HW_HAS_PCI
@@ -641,6 +642,7 @@ config SNI_RM
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
+	select HAVE_PCSPKR_PLATFORM
 	select HW_HAS_EISA
 	select HW_HAS_PCI
 	select IRQ_CPU
