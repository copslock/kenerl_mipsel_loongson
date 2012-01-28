Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2012 00:12:52 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46856 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903662Ab2A1XMo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jan 2012 00:12:44 +0100
Received: (qmail 17689 invoked from network); 28 Jan 2012 23:12:39 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Jan 2012 23:12:39 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 28 Jan 2012 15:12:39 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Fix duplicate instances of ARCH_SPARSEMEM_ENABLE
Date:   Sat, 28 Jan 2012 15:07:49 -0800
Message-Id: <0736d2becb10905c35eec74f04c63970@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 32320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

"config ARCH_SPARSEMEM_ENABLE" exists in both arch/mips/Kconfig and
arch/mips/cavium-octeon/Kconfig, but the dependencies are not the same.
This results in warnings when a non-Cavium platform tries to select
ARCH_SPARSEMEM_ENABLE:

    $ make lemote2f_defconfig ARCH=mips
    warning: (LEMOTE_FULOONG2E && LEMOTE_MACH2F) selects ARCH_SPARSEMEM_ENABLE which has unmet direct dependencies (CPU_CAVIUM_OCTEON)
    warning: (LEMOTE_FULOONG2E && LEMOTE_MACH2F) selects ARCH_SPARSEMEM_ENABLE which has unmet direct dependencies (CPU_CAVIUM_OCTEON)
    #
    # configuration written to .config
    #

Proposed workaround is to use a Cavium-specific config option which
"select"s the desired options.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/cavium-octeon/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index f9e275a..eda8266 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -82,8 +82,9 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config ARCH_SPARSEMEM_ENABLE
+config CAVIUM_OCTEON_SPARSEMEM_ENABLE
 	def_bool y
+	select ARCH_SPARSEMEM_ENABLE
 	select SPARSEMEM_STATIC
 
 config IOMMU_HELPER
-- 
1.7.6.3
