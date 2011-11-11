Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 07:42:27 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46092 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903954Ab1KKGlL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 07:41:11 +0100
Received: (qmail 16048 invoked from network); 11 Nov 2011 06:41:00 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Nov 2011 06:41:00 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 10 Nov 2011 22:41:00 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 4/8] MIPS: BMIPS: Add set/clear CP0 macros for BMIPS
 operations
Date:   Thu, 10 Nov 2011 22:30:27 -0800
Message-Id: <56fb136dfef3a4c5a2b0e9faff6634a1@localhost>
In-Reply-To: <5f9666eb295ce196b2a9688afab07dea@localhost>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10045

Several BMIPS-specific CP0 registers are used for SMP boot and other
operations.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mipsregs.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 2ea7b81..7f87d82 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1106,7 +1106,7 @@ do {									\
 #define read_c0_brcm_reset()		__read_32bit_c0_register($22, 5)
 #define write_c0_brcm_reset(val)	__write_32bit_c0_register($22, 5, val)
 
-/* BMIPS4380 */
+/* BMIPS43xx */
 #define read_c0_brcm_cmt_intr()		__read_32bit_c0_register($22, 1)
 #define write_c0_brcm_cmt_intr(val)	__write_32bit_c0_register($22, 1, val)
 
@@ -1667,6 +1667,13 @@ __BUILD_SET_C0(config)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
+__BUILD_SET_C0(brcm_config_0)
+__BUILD_SET_C0(brcm_bus_pll)
+__BUILD_SET_C0(brcm_reset)
+__BUILD_SET_C0(brcm_cmt_intr)
+__BUILD_SET_C0(brcm_cmt_ctrl)
+__BUILD_SET_C0(brcm_config)
+__BUILD_SET_C0(brcm_mode)
 
 #endif /* !__ASSEMBLY__ */
 
-- 
1.7.6.3
