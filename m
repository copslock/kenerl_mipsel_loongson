Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:24:50 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57291 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861029AbaGCNXMciP2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:23:12 +0200
Received: by mail-wg0-f52.google.com with SMTP id b13so227828wgh.35
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tFBUvR3Dh8148Y+XOOERpEmxvm6GIlZdEfcEFC6guo=;
        b=X+62cnlATgFMrZ5aGa5/DxqzjmN0jz2CFtcs89vFMVuN3b8DNElA/ArxbL+fCvWBfY
         S5xDy7ig8E9rn9aUJ80IFR9Ma6VXrzQp0t034bHfs3q1LGDpkZK9EKrPuH9qREyS8gHa
         XR1yD/FbnMh75119TkxvZGa5JlVrjrN/G1iZ7UkO8YT0Zp3psE6VQtb0hwhaWlUsJSKF
         fSy4S/6gRtOe6YFYvZgHAETjqqCoQVTfDWwSDTU02d0kvcBPBzrsLrdMtC1YAENhOTSx
         xKadNhMPz105cxwB3vc5bxE8nfwZh4zXX1Sk0kHJM0R1Vo2bugtTepHPKyy6gTccdRJI
         n1uQ==
X-Received: by 10.180.94.5 with SMTP id cy5mr10699498wib.11.1404393785422;
        Thu, 03 Jul 2014 06:23:05 -0700 (PDT)
Received: from localhost.localdomain (p57A34891.dip0.t-ipconnect.de. [87.163.72.145])
        by mx.google.com with ESMTPSA id ev9sm67079017wic.24.2014.07.03.06.23.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jul 2014 06:23:04 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2 04/11] MIPS: Alchemy: usb: use clk framework
Date:   Thu,  3 Jul 2014 15:22:35 +0200
Message-Id: <1404393762-858019-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Add use of the common clock framework to set and enable the 48MHz
clock source for the onchip OHCI and UDC blocks.

Tested on a DB1500.  (Au1200 and Au1300 use an external 48MHz crystal).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: taken from initial patch #2

 arch/mips/alchemy/common/usb.c | 47 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/common/usb.c b/arch/mips/alchemy/common/usb.c
index d193dbe..297805a 100644
--- a/arch/mips/alchemy/common/usb.c
+++ b/arch/mips/alchemy/common/usb.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -387,10 +388,25 @@ static inline void au1200_usb_init(void)
 	udelay(1000);
 }
 
-static inline void au1000_usb_init(unsigned long rb, int reg)
+static inline int au1000_usb_init(unsigned long rb, int reg)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(rb + reg);
 	unsigned long r = __raw_readl(base);
+	struct clk *c;
+
+	/* 48MHz check. Don't init if no one can provide it */
+	c = clk_get(NULL, "usbh_clk");
+	if (IS_ERR(c))
+		return -ENODEV;
+	if (clk_round_rate(c, 48000000) != 48000000) {
+		clk_put(c);
+		return -ENODEV;
+	}
+	if (clk_set_rate(c, 48000000)) {
+		clk_put(c);
+		return -ENODEV;
+	}
+	clk_put(c);
 
 #if defined(__BIG_ENDIAN)
 	r |= USBHEN_BE;
@@ -400,6 +416,8 @@ static inline void au1000_usb_init(unsigned long rb, int reg)
 	__raw_writel(r, base);
 	wmb();
 	udelay(1000);
+
+	return 0;
 }
 
 
@@ -407,8 +425,15 @@ static inline void __au1xx0_ohci_control(int enable, unsigned long rb, int creg)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(rb);
 	unsigned long r = __raw_readl(base + creg);
+	struct clk *c = clk_get(NULL, "usbh_clk");
+
+	if (IS_ERR(c))
+		return;
 
 	if (enable) {
+		if (clk_prepare_enable(c))
+			goto out;
+
 		__raw_writel(r | USBHEN_CE, base + creg);
 		wmb();
 		udelay(1000);
@@ -423,7 +448,10 @@ static inline void __au1xx0_ohci_control(int enable, unsigned long rb, int creg)
 	} else {
 		__raw_writel(r & ~(USBHEN_CE | USBHEN_E), base + creg);
 		wmb();
+		clk_disable_unprepare(c);
 	}
+out:
+	clk_put(c);
 }
 
 static inline int au1000_usb_control(int block, int enable, unsigned long rb,
@@ -457,11 +485,11 @@ int alchemy_usb_control(int block, int enable)
 	case ALCHEMY_CPU_AU1500:
 	case ALCHEMY_CPU_AU1100:
 		ret = au1000_usb_control(block, enable,
-				AU1000_USB_OHCI_PHYS_ADDR, AU1000_OHCICFG);
+			AU1000_USB_OHCI_PHYS_ADDR, AU1000_OHCICFG);
 		break;
 	case ALCHEMY_CPU_AU1550:
 		ret = au1000_usb_control(block, enable,
-				AU1550_USB_OHCI_PHYS_ADDR, AU1550_OHCICFG);
+			AU1550_USB_OHCI_PHYS_ADDR, AU1550_OHCICFG);
 		break;
 	case ALCHEMY_CPU_AU1200:
 		ret = au1200_usb_control(block, enable);
@@ -569,14 +597,18 @@ static struct syscore_ops alchemy_usb_pm_ops = {
 
 static int __init alchemy_usb_init(void)
 {
+	int ret = 0;
+
 	switch (alchemy_get_cputype()) {
 	case ALCHEMY_CPU_AU1000:
 	case ALCHEMY_CPU_AU1500:
 	case ALCHEMY_CPU_AU1100:
-		au1000_usb_init(AU1000_USB_OHCI_PHYS_ADDR, AU1000_OHCICFG);
+		ret = au1000_usb_init(AU1000_USB_OHCI_PHYS_ADDR,
+				      AU1000_OHCICFG);
 		break;
 	case ALCHEMY_CPU_AU1550:
-		au1000_usb_init(AU1550_USB_OHCI_PHYS_ADDR, AU1550_OHCICFG);
+		ret = au1000_usb_init(AU1550_USB_OHCI_PHYS_ADDR,
+				      AU1550_OHCICFG);
 		break;
 	case ALCHEMY_CPU_AU1200:
 		au1200_usb_init();
@@ -586,8 +618,9 @@ static int __init alchemy_usb_init(void)
 		break;
 	}
 
-	register_syscore_ops(&alchemy_usb_pm_ops);
+	if (!ret)
+		register_syscore_ops(&alchemy_usb_pm_ops);
 
-	return 0;
+	return ret;
 }
 arch_initcall(alchemy_usb_init);
-- 
2.0.0
