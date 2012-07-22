Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 08:56:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55368 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903258Ab2GVG41 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2012 08:56:27 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/5] MIPS: lantiq: add helper to set PCI clock delay
Date:   Sun, 22 Jul 2012 08:55:58 +0200
Message-Id: <1342940161-1421-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
References: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33950
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The PCI core has a register that allows us to set the nanosecond delay of the
PCI clock lane. This patch adds a helper function to allow setting this value.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 +++
 arch/mips/lantiq/xway/sysctrl.c                    |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 6a2df70..0c2d67d 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -87,5 +87,8 @@ extern __iomem void *ltq_cgu_membase;
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 
+/* allow pci driver to set the pci clk delay */
+void ltq_pci_set_delay(u32 delay);
+
 #endif /* CONFIG_SOC_TYPE_XWAY */
 #endif /* _LTQ_XWAY_H__ */
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index befbb76..91bb435 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -41,6 +41,10 @@
 /* power status register */
 #define PWDSR(x) ((x) ? (PMU_PWDSR1) : (PMU_PWDSR))
 
+/* pci delay is 6 bit wide and 18 bit into the register*/
+#define PCI_DLY_MASK    0x3f
+#define PCI_DLY_SHIFT   18
+
 /* clock gates that we can en/disable */
 #define PMU_USB0_P	BIT(0)
 #define PMU_PCI		BIT(4)
@@ -258,6 +262,16 @@ static void clkdev_add_pci(void)
 	clkdev_add(&clk_ext->cl);
 }
 
+/* allow PCI driver to specify the clock delay. This is a 6 bit value */
+void ltq_pci_set_delay(u32 delay)
+{
+	u32 val = ltq_cgu_r32(pcicr);
+
+	val &= ~(PCI_DLY_MASK << PCI_DLY_SHIFT);
+	val |= (delay & PCI_DLY_MASK) << PCI_DLY_SHIFT;
+	ltq_cgu_w32(val, pcicr);
+}
+
 /* xway socs can generate clocks on gpio pins */
 static unsigned long valid_clkout_rates[4][5] = {
 	{CLOCK_32_768K, CLOCK_1_536M, CLOCK_2_5M, CLOCK_12M, 0},
-- 
1.7.9.1
