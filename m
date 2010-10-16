Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 23:44:20 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:52809 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491181Ab0JPVoF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 23:44:05 +0200
Received: (qmail 12186 invoked from network); 16 Oct 2010 21:44:02 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Oct 2010 21:44:02 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Oct 2010 14:44:02 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] MIPS: Add BMIPS processor types to Kconfig
Date:   Sat, 16 Oct 2010 14:22:31 -0700
Message-Id: <adc90cbb99148b1f3a1e880caba50fa4@localhost>
In-Reply-To: <17ebecce124618ddf83ec6fe8e526f93@localhost>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Add processor feature definitions for BMIPS3300, BMIPS4350, BMIPS4380,
and BMIPS5000.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5526faa..1403926 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1332,6 +1332,57 @@ config CPU_CAVIUM_OCTEON
 	  can have up to 16 Mips64v2 cores and 8 integrated gigabit ethernets.
 	  Full details can be found at http://www.caviumnetworks.com.
 
+config CPU_BMIPS3300
+	bool "BMIPS3300"
+	depends on SYS_HAS_CPU_BMIPS3300
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select WEAK_ORDERING
+	help
+	  Broadcom BMIPS3300 processors.
+
+config CPU_BMIPS4350
+	bool "BMIPS4350"
+	depends on SYS_HAS_CPU_BMIPS4350
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_HOTPLUG_CPU
+	select WEAK_ORDERING
+	help
+	  Broadcom BMIPS4350 processors.
+
+config CPU_BMIPS4380
+	bool "BMIPS4380"
+	depends on SYS_HAS_CPU_BMIPS4380
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_HOTPLUG_CPU
+	select WEAK_ORDERING
+	help
+	  Broadcom BMIPS4380 processors.
+
+config CPU_BMIPS5000
+	bool "BMIPS5000"
+	depends on SYS_HAS_CPU_BMIPS5000
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_HOTPLUG_CPU
+	select WEAK_ORDERING
+	help
+	  Broadcom BMIPS5000 processors.
+
 endchoice
 
 if CPU_LOONGSON2F
@@ -1450,6 +1501,18 @@ config SYS_HAS_CPU_SB1
 config SYS_HAS_CPU_CAVIUM_OCTEON
 	bool
 
+config SYS_HAS_CPU_BMIPS3300
+	bool
+
+config SYS_HAS_CPU_BMIPS4350
+	bool
+
+config SYS_HAS_CPU_BMIPS4380
+	bool
+
+config SYS_HAS_CPU_BMIPS5000
+	bool
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
-- 
1.7.0.4
