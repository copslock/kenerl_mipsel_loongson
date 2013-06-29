Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:20:31 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44549 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443Ab3F2USYmBmZ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:24 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 6D52A45FC0;
        Sat, 29 Jun 2013 20:18:14 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 07/10] MIPS: bmips: add a helper function for registering smp ops
Date:   Sat, 29 Jun 2013 22:17:49 +0200
Message-Id: <1372537073-27370-8-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Add a helper similar to the generic register_XXX_smp_ops() for bmips.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/bmips.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 8906ac3..1eb4628 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -47,6 +47,7 @@
 #include <linux/cpumask.h>
 #include <asm/cpu-features.h>
 #include <asm/r4kcache.h>
+#include <asm/smp-ops.h>
 
 #define cpu_is_bmips32()	(current_cpu_type() == CPU_BMIPS32)
 #define cpu_is_bmips3300()	(IS_ENABLED(CONFIG_CPU_BMIPS3300) && \
@@ -59,6 +60,18 @@
 				 current_cpu_type() == CPU_BMIPS5000)
 
 extern struct plat_smp_ops bmips_smp_ops;
+
+static inline int register_bmips_smp_ops(void)
+{
+#ifdef CONFIG_CPU_BMIPS
+	register_smp_ops(&bmips_smp_ops);
+
+	return 0;
+#else
+	return -ENODEV;
+#endif
+}
+
 extern char bmips_reset_nmi_vec;
 extern char bmips_reset_nmi_vec_end;
 extern char bmips_smp_movevec;
-- 
1.7.10.4
