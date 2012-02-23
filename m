Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:05:32 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47351 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903641Ab2BWQDc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:32 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 02/14] MIPS: lantiq: helper functions for SoC detection
Date:   Thu, 23 Feb 2012 17:03:01 +0100
Message-Id: <1330012993-13510-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add additional functions for runtime soc detection. We need these for the
serial driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |   16 ++++++++++++++--
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
index 1a4b836..fd7f9fd 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -149,8 +149,20 @@ extern int ltq_gpio_mux_set(unsigned int pin, unsigned int mux);
 #define LTQ_EIU_BASE_ADDR	0
 #define LTQ_EBU_PCC_ISTAT	0
 
-#define ltq_is_ar9()	0
-#define ltq_is_vr9()	0
+static inline int ltq_is_ar9(void)
+{
+	return 0;
+}
+
+static inline int ltq_is_vr9(void)
+{
+	return 0;
+}
+
+static inline int ltq_is_falcon(void)
+{
+	return 1;
+}
 
 #endif /* CONFIG_SOC_FALCON */
 #endif /* _LTQ_XWAY_H__ */
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 4213926..1b60181 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -186,5 +186,10 @@ static inline int ltq_is_vr9(void)
 	return (ltq_get_soc_type() == SOC_TYPE_VR9);
 }
 
+static inline int ltq_is_falcon(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SOC_TYPE_XWAY */
 #endif /* _LTQ_XWAY_H__ */
-- 
1.7.7.1
