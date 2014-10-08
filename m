Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:08:56 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53908
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010969AbaJIPIGESxgd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:06 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 03/10] MIPS: ralink: add rt_sysc_m32 helper
Date:   Thu,  9 Oct 2014 01:52:58 +0200
Message-Id: <1412812385-64820-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

We already have a read and write wrapper. This adds the missing mask wrapper.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/ralink_regs.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/ralink_regs.h b/arch/mips/include/asm/mach-ralink/ralink_regs.h
index 5a508f9..bd93014 100644
--- a/arch/mips/include/asm/mach-ralink/ralink_regs.h
+++ b/arch/mips/include/asm/mach-ralink/ralink_regs.h
@@ -26,6 +26,13 @@ static inline u32 rt_sysc_r32(unsigned reg)
 	return __raw_readl(rt_sysc_membase + reg);
 }
 
+static inline void rt_sysc_m32(u32 clr, u32 set, unsigned reg)
+{
+	u32 val = rt_sysc_r32(reg) & ~clr;
+
+	__raw_writel(val | set, rt_sysc_membase + reg);
+}
+
 static inline void rt_memc_w32(u32 val, unsigned reg)
 {
 	__raw_writel(val, rt_memc_membase + reg);
-- 
1.7.10.4
