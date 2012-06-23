Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:25:52 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53300 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903683Ab2FWFX5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:23:57 +0200
Received: (qmail 25633 invoked from network); 23 Jun 2012 05:23:54 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:54 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:54 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/7] MIPS: BCM63XX: Fix USB IRQ definitions for 6328
Date:   Fri, 22 Jun 2012 22:14:55 -0700
Message-Id: <313fb93d1ee0993cb023e745c92c31e6@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

OHCI/EHCI are in the high (second) word.  Not currently used by any
driver.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 2b59ae4..c0e6333 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -602,8 +602,8 @@ enum bcm63xx_irq {
 #define BCM_6328_ENET0_IRQ		0
 #define BCM_6328_ENET1_IRQ		0
 #define BCM_6328_ENET_PHY_IRQ		(IRQ_INTERNAL_BASE + 12)
-#define BCM_6328_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 9)
-#define BCM_6328_EHCI0_IRQ		(IRQ_INTERNAL_BASE + 10)
+#define BCM_6328_OHCI0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 9)
+#define BCM_6328_EHCI0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 10)
 #define BCM_6328_PCMCIA_IRQ		0
 #define BCM_6328_ENET0_RXDMA_IRQ	0
 #define BCM_6328_ENET0_TXDMA_IRQ	0
-- 
1.7.11.1
