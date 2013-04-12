Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:33:45 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55491 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826581Ab3DLHcEnPA0r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:32:04 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 05/16] MIPS: ralink: add RT3352 usb register defines
Date:   Fri, 12 Apr 2013 09:27:32 +0200
Message-Id: <1365751663-5725-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36088
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

Add a few missing defines that are needed to make USB work on the RT3352
and RT5350.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/rt305x.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index 4e62cef..80cda8a 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -144,4 +144,17 @@ static inline int soc_is_rt5350(void)
 #define RT305X_GPIO_MODE_SDRAM		BIT(8)
 #define RT305X_GPIO_MODE_RGMII		BIT(9)
 
+#define RT3352_SYSC_REG_SYSCFG0		0x010
+#define RT3352_SYSC_REG_SYSCFG1         0x014
+#define RT3352_SYSC_REG_CLKCFG1         0x030
+#define RT3352_SYSC_REG_RSTCTRL         0x034
+#define RT3352_SYSC_REG_USB_PS          0x05c
+
+#define RT3352_CLKCFG0_XTAL_SEL		BIT(20)
+#define RT3352_CLKCFG1_UPHY0_CLK_EN	BIT(18)
+#define RT3352_CLKCFG1_UPHY1_CLK_EN	BIT(20)
+#define RT3352_RSTCTRL_UHST		BIT(22)
+#define RT3352_RSTCTRL_UDEV		BIT(25)
+#define RT3352_SYSCFG1_USB0_HOST_MODE	BIT(10)
+
 #endif
-- 
1.7.10.4
