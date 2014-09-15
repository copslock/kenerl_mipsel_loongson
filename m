Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:52:18 +0200 (CEST)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:54342 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008999AbaIOXvmKFrs9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:42 +0200
Received: by mail-ie0-f202.google.com with SMTP id rl12so746111iec.3
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oaThMYBHDpkxOUqs2reXcrM/Z27lCnfvpgsGRDcklgU=;
        b=Dfw5z74m5zcb3fQLaz0rZEV2ixOdyn1tcZK9aFp0+M9MmVfl7WYY79XA3YtY9qvUb6
         S/5oZ/I3vdwTlWMVXDCeOVVchVqC1xqIWyXt35BkUB9VsClpMZAFbl/NcGn/rMC0Cruz
         OEw6KcQj/j++2dBKvnzv0o1+9iVhw0CGetQS8R9yM9dgpq8CadYEYTQ6Lbrp2+COptEB
         +pAwJ4up+djeO6jy34Xa+1xyB6CBaAQQFA26QXcuJbwwabHkUOhUm5rLmq8llBli8ffF
         ETbmZA6eVVlLdfi0wG1LKfg4uvtL6IuKidyrMo5a5cZB0UskrJhxmlrb1M30H1lFqRbn
         2PlQ==
X-Gm-Message-State: ALoCoQkpYGi5LQqnEmNWcQkm5Ccx6ikhEB3G5JsQRwpsbW3Tt+9qvw3M36xKstSKeuqGmvwdjCKK
X-Received: by 10.182.29.10 with SMTP id f10mr17014395obh.23.1410825095391;
        Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si627493yhm.7.2014.09.15.16.51.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id pSykdCfm.1; Mon, 15 Sep 2014 16:51:35 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id F2A9E220868; Mon, 15 Sep 2014 16:51:33 -0700 (PDT)
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
Subject: [PATCH 02/24] MIPS: Rename mips_cpu_intc_init() -> mips_cpu_irq_of_init()
Date:   Mon, 15 Sep 2014 16:51:05 -0700
Message-Id: <1410825087-5497-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42620
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
