Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:04:52 +0200 (CEST)
Received: from mail-vc0-f201.google.com ([209.85.220.201]:37995 "EHLO
        mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011959AbaJTTEPPQ12t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:15 +0200
Received: by mail-vc0-f201.google.com with SMTP id hq11so471932vcb.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ial1PaDsmF/gawCzR/JtYp6HvLkKfJCgE9NxYyQNDEA=;
        b=Mqc92tJu7SSCO2ckrWlR0j8WRkg38SXQJvCmtQMUcRpGQ4uBAHexCOreO/xFQ9ReTu
         r/zVYq5oWosafsCLWMTfQrN4Mh6egpigG6cCMnQwt2FQsDmZLhDGPuuwY85s02vOAfb3
         eMSrhz9e2ahRwgtYHiCqkkcQeZSPU51KWHvQeOEB/fyRafiuOZDuSR6cjF0QIklVrx4i
         c+pQkrD1GzG9UiXVVifsysoHYRAaqFvjkdudPFwRv1UFPehMk9/JKouDkyT5Oj5Fb6Ks
         O/8v8w+sSRJpSrzaluelRIPmsCIIiqpusZsWCKryia91LSS4WqvHEHrY/rvK7Q/Ef7M+
         cNog==
X-Gm-Message-State: ALoCoQlelHczsfnmqCSnrh06zd6xyenyBC1aOJOqjs3Q4pi13jWw00cRqKKX7xLuvFycR2O+lSdj
X-Received: by 10.236.61.69 with SMTP id v45mr2432462yhc.57.1413831848966;
        Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si435338yho.7.2014.10.20.12.04.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id tx5VoEtW.1; Mon, 20 Oct 2014 12:04:08 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D2DBE220D57; Mon, 20 Oct 2014 12:04:07 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] irqchip: mips-gic: Export function to read counter width
Date:   Mon, 20 Oct 2014 12:03:49 -0700
Message-Id: <1413831846-32100-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43361
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

Export the function gic_get_count_width to read the width of
the GIC global counter from GIC_SH_CONFIG.  Update the GIC
clocksource driver to use this new function.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/gic.h    |  1 +
 arch/mips/kernel/csrc-gic.c    |  9 +--------
 drivers/irqchip/irq-mips-gic.c | 11 +++++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 727b7bf..c88e1fa 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -370,6 +370,7 @@ extern void gic_init(unsigned long gic_base_addr,
 	unsigned int irqbase);
 extern void gic_clocksource_init(unsigned int);
 extern cycle_t gic_read_count(void);
+extern unsigned int gic_get_count_width(void);
 extern cycle_t gic_read_compare(void);
 extern void gic_write_compare(cycle_t cnt);
 extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
diff --git a/arch/mips/kernel/csrc-gic.c b/arch/mips/kernel/csrc-gic.c
index e026209..ab615c6 100644
--- a/arch/mips/kernel/csrc-gic.c
+++ b/arch/mips/kernel/csrc-gic.c
@@ -23,15 +23,8 @@ static struct clocksource gic_clocksource = {
 
 void __init gic_clocksource_init(unsigned int frequency)
 {
-	unsigned int config, bits;
-
-	/* Calculate the clocksource mask. */
-	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), config);
-	bits = 32 + ((config & GIC_SH_CONFIG_COUNTBITS_MSK) >>
-		(GIC_SH_CONFIG_COUNTBITS_SHF - 2));
-
 	/* Set clocksource mask. */
-	gic_clocksource.mask = CLOCKSOURCE_MASK(bits);
+	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
 
 	/* Calculate a somewhat reasonable rating value. */
 	gic_clocksource.rating = 200 + frequency / 10000000;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 02c7d2a..83dde6f 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -63,6 +63,17 @@ cycle_t gic_read_count(void)
 	return (((cycle_t) hi) << 32) + lo;
 }
 
+unsigned int gic_get_count_width(void)
+{
+	unsigned int bits, config;
+
+	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), config);
+	bits = 32 + 4 * ((config & GIC_SH_CONFIG_COUNTBITS_MSK) >>
+			 GIC_SH_CONFIG_COUNTBITS_SHF);
+
+	return bits;
+}
+
 void gic_write_compare(cycle_t cnt)
 {
 	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI),
-- 
2.1.0.rc2.206.gedb03e5
