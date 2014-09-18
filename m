Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:48:24 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:54078 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009227AbaIRVrn2VsQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:43 +0200
Received: by mail-ig0-f202.google.com with SMTP id h15so354739igd.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IE3CYDJr7AzbcFFhaJHdxjC1Jc4wNdzqgHFizTE2+Ok=;
        b=i8U6op9LKCCtgNOUcqfG8jmXgft/cpodipG7zDM9IvowtzuF4TN4zivQz5ypP5fuWu
         AfNU88486hCq1ouCiyjGCF7Ti8NREzKI3POTXGtaoxRiqVktEhsb1D9ySWjO1I+KhEEK
         G+/fobgPWLhXgCZ8kzuSDrzEM3IUA8axW0wrhWanpTK5SyYmKiMuLhsaY04OmaW85p2R
         Kwl2r/L09s3kfdJz0RgcEXEBa13+XYKtLziiiOIPA7g6OaWAPXMGgsqLKeyjG9YYHyE7
         mJFe/1hacuP6xKpd0Hy6zjykxCeGiRaUF6HmrchK7cCDHuDybgCH6tYzwJAU4/5S8ylo
         a+Tg==
X-Gm-Message-State: ALoCoQmaRADohFOFZfZbe94Z23AQxrFAOnW5BAkQ4tsoMgUPBOsLYzlls646KbN9Rfpdod9IL770
X-Received: by 10.43.69.18 with SMTP id ya18mr5653774icb.0.1411076857443;
        Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si3539yhe.3.2014.09.18.14.47.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 2JIYppGO.1; Thu, 18 Sep 2014 14:47:37 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0C72E220D1A; Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/24] MIPS: Rename mips_cpu_intc_init() -> mips_cpu_irq_of_init()
Date:   Thu, 18 Sep 2014 14:47:08 -0700
Message-Id: <1411076851-28242-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

mips_cpu_intc_init() is used for DT-based initialization of the CPU
IRQ domain.  Give it a more appropriate name.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 Documentation/devicetree/bindings/mips/cpu_irq.txt | 4 ++--
 arch/mips/include/asm/irq_cpu.h                    | 4 ++--
 arch/mips/kernel/irq_cpu.c                         | 4 ++--
 arch/mips/ralink/irq.c                             | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.txt b/Documentation/devicetree/bindings/mips/cpu_irq.txt
index 13aa4b6..fc149f3 100644
--- a/Documentation/devicetree/bindings/mips/cpu_irq.txt
+++ b/Documentation/devicetree/bindings/mips/cpu_irq.txt
@@ -1,6 +1,6 @@
 MIPS CPU interrupt controller
 
-On MIPS the mips_cpu_intc_init() helper can be used to initialize the 8 CPU
+On MIPS the mips_cpu_irq_of_init() helper can be used to initialize the 8 CPU
 IRQs from a devicetree file and create a irq_domain for IRQ controller.
 
 With the irq_domain in place we can describe how the 8 IRQs are wired to the
@@ -36,7 +36,7 @@ Example devicetree:
 
 Example platform irq.c:
 static struct of_device_id __initdata of_irq_ids[] = {
-	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_intc_init },
+	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_irq_of_init },
 	{ .compatible = "ralink,rt2880-intc", .data = intc_of_init },
 	{},
 };
diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
index 3f11fdb..39a160b 100644
--- a/arch/mips/include/asm/irq_cpu.h
+++ b/arch/mips/include/asm/irq_cpu.h
@@ -19,8 +19,8 @@ extern void rm9k_cpu_irq_init(void);
 
 #ifdef CONFIG_IRQ_DOMAIN
 struct device_node;
-extern int mips_cpu_intc_init(struct device_node *of_node,
-			      struct device_node *parent);
+extern int mips_cpu_irq_of_init(struct device_node *of_node,
+				struct device_node *parent);
 #endif
 
 #endif /* _ASM_IRQ_CPU_H */
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index b097f7d..ca98a9f 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -135,8 +135,8 @@ void __init mips_cpu_irq_init(void)
 	__mips_cpu_irq_init(NULL);
 }
 
-int __init mips_cpu_intc_init(struct device_node *of_node,
-			      struct device_node *parent)
+int __init mips_cpu_irq_of_init(struct device_node *of_node,
+				struct device_node *parent)
 {
 	__mips_cpu_irq_init(of_node);
 	return 0;
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 781b3d1..0495011 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -173,7 +173,7 @@ static int __init intc_of_init(struct device_node *node,
 }
 
 static struct of_device_id __initdata of_irq_ids[] = {
-	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_intc_init },
+	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_irq_of_init },
 	{ .compatible = "ralink,rt2880-intc", .data = intc_of_init },
 	{},
 };
-- 
2.1.0.rc2.206.gedb03e5
