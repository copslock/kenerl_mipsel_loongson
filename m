Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Apr 2010 15:26:44 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:55453 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491923Ab0DRN0k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Apr 2010 15:26:40 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1O3UWC-0008Q1-LX; Sun, 18 Apr 2010 15:26:36 +0200
Date:   Sun, 18 Apr 2010 15:26:36 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     tbm@cyrius.com, linux-mips@linux-mips.org
Subject: mips: enable PATA platform on SWARM and LITTLESUR
Message-ID: <20100418132636.GA32350@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

according to include/asm/sibyte/swarm.h both systems provide a
platform device for the ide controler. Until now the IDE subsystem was
used which is deprecated by now. The same structure can be used with the
PATA driver.
This was tested on SWARM.

Signed-off-by: Sebastian Andrzej Siewior <sebatian@breakpoint.cc>
---
 arch/mips/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 29e8692..98628ec 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -509,6 +509,7 @@ config SIBYTE_SWARM
 	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PATA_PLATFORM
 	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -523,6 +524,7 @@ config SIBYTE_LITTLESUR
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PATA_PLATFORM
 	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
-- 
1.6.6.1
