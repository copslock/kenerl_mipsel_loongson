Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:05:09 +0200 (CEST)
Received: from mail-qg0-f74.google.com ([209.85.192.74]:55879 "EHLO
        mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011961AbaJTTEPm15Zc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:15 +0200
Received: by mail-qg0-f74.google.com with SMTP id q108so472369qgd.1
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=km6SS0jDgJpDXqTbDG294Ko0ckCd3Ihj6MLGwVC/EAY=;
        b=RRw9B8T8XISUrU8M1Hu8ED5U68xWf2YdDyxTA8gz8lFIjqA3R/cmy29V5AyLKiSVwt
         zvnS86VVMkmsStxNxY8powW3QnyzvgMndnaMyJpEtjNevf93SnfWljvdCTLH3bZGRihO
         iY7rsJQE9SbTF1klu6i1LWlh896L5Xxgclj7p9/Ki0r6t0f1W7m7ovDITrt3lN1qQ/Ru
         uO6ofi7wFRhuVa1/imSq9gEjdgAfYnhx+JayiEUkG3Rc2cX9Kbek1l4CbJ8RpgB/vVRp
         Ovn9CcjV3TAZpxLoM1Kmj86hP46b8KJ1PzWRTl4h6jdtjykt3U9GFlOKrqe9fOvBYgx4
         UHhg==
X-Gm-Message-State: ALoCoQnf/iyYmwKaJTfCiAniniaYA6higMxmzEdtx0LRXe9a9zoO3OJlDDySJwfXsH1nivTXODw+
X-Received: by 10.236.66.102 with SMTP id g66mr19067046yhd.3.1413831849550;
        Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si435927yho.5.2014.10.20.12.04.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ezN2XdvX.1; Mon, 20 Oct 2014 12:04:09 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 56ED6221134; Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
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
Subject: [PATCH 03/19] MIPS: sead3: Stop using GIC REG macros
Date:   Mon, 20 Oct 2014 12:03:50 -0700
Message-Id: <1413831846-32100-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43362
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

Stop using the REG macros from gic.h and instead use proper iomem
accessors.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-sead3/sead3-int.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index 69ae185..995c401 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -20,16 +20,15 @@
 #define SEAD_CONFIG_BASE		0x1b100110
 #define SEAD_CONFIG_SIZE		4
 
-static unsigned long sead3_config_reg;
+static void __iomem *sead3_config_reg;
 
 void __init arch_init_irq(void)
 {
 	if (!cpu_has_veic)
 		mips_cpu_irq_init();
 
-	sead3_config_reg = (unsigned long)ioremap_nocache(SEAD_CONFIG_BASE,
-		SEAD_CONFIG_SIZE);
-	gic_present = (REG32(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
+	sead3_config_reg = ioremap_nocache(SEAD_CONFIG_BASE, SEAD_CONFIG_SIZE);
+	gic_present = (readl(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
 		SEAD_CONFIG_GIC_PRESENT_SHF;
 	pr_info("GIC: %spresent\n", (gic_present) ? "" : "not ");
 	pr_info("EIC: %s\n",
-- 
2.1.0.rc2.206.gedb03e5
