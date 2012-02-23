Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:03:21 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47243 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903627Ab2BWQCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:02:15 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 1/6] MIPS: lantiq: remove redunant ltq_gpio_request() declaration and add device parameter
Date:   Thu, 23 Feb 2012 17:01:48 +0100
Message-Id: <1330012913-13293-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 32503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

3.2 introduced devm_request_gpio() to allow managed gpios.

The devres api requires a struct device pointer to work. Add a parameter to ltq_gpio_request()
so that managed gpios can work.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |    4 +---
 arch/mips/include/asm/mach-lantiq/lantiq.h         |    4 ++++
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 ---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
index 8ac509a..1a4b836 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -141,9 +141,7 @@ static inline void ltq_sys1_w32_mask(u32 c, u32 s, u32 r)
 	ltq_sys1_w32((ltq_sys1_r32(r) & ~(c)) | (s), r);
 }
 
-/* gpio_request wrapper to help configure the pin */
-extern int  ltq_gpio_request(unsigned int pin, unsigned int mux,
-				unsigned int dir, const char *name);
+/* gpio wrapper to help configure the pin muxing */
 extern int ltq_gpio_mux_set(unsigned int pin, unsigned int mux);
 
 /* to keep the irq code generic we need to define these to 0 as falcon
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index bf05854..d90eef3 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -39,6 +39,10 @@ extern unsigned int ltq_get_soc_type(void);
 /* spinlock all ebu i/o */
 extern spinlock_t ebu_lock;
 
+/* request a non-gpio and set the PIO config */
+extern int ltq_gpio_request(struct device *dev, unsigned int pin,
+		unsigned int mux, unsigned int dir, const char *name);
+
 /* some irq helpers */
 extern void ltq_disable_irq(struct irq_data *data);
 extern void ltq_mask_and_ack_irq(struct irq_data *data);
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 9d0afeb..4213926 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -167,9 +167,6 @@ static inline void ltq_cgu_w32_mask(u32 c, u32 s, u32 r)
 	ltq_cgu_w32((ltq_cgu_r32(r) & ~(c)) | (s), r);
 }
 
-/* request a non-gpio and set the PIO config */
-extern int  ltq_gpio_request(unsigned int pin, unsigned int mux,
-				unsigned int dir, const char *name);
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 extern void ltq_cgu_enable(unsigned int clk);
-- 
1.7.7.1
