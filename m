Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:05:26 +0200 (CEST)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:50683 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011963AbaJTTEPq9vqS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:15 +0200
Received: by mail-qg0-f73.google.com with SMTP id i50so472262qgf.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J65CDg5tSzBtoqQ5B3Crte4t8pbyUxNxVOV8gqCDpd4=;
        b=HvZof1D9dsX/wQXFEqRU28Z2Ndu3gW3pcMI7Hbbh2tVYXFdDCv9e1zqnB0mD6iN3TN
         o1Zw/DtlU8hG2jg4efL0CxaGq6nrPcKTZsjtW8yCpWkxXShjk7+oK2Z3PK88ylJP7C2+
         1qKixA+j6r+G4ooVZatpw69Ljde7SG7J1WYvgZFyVayrlsQkaSy+IZyjNl9NDiLxdCH+
         EStc9p9CGYcy6xGkW28goKi4qFb7BgV8UtGciS6ePWIV6tqDNjyYIR6VteVzkIupWr9X
         Nq1O/353AHNofAuvAWv63zloJERz5ZnKJYBQf8I6ZjgFWgYkha1PxLgo2ZiwZSnI+lNc
         aYWw==
X-Gm-Message-State: ALoCoQlpDg9qeiBIAFmIzVoX+d4cS3hsD1i1ogKBU/fj/e/m3Jw98b62MC0v69pnEsCpAU7Cmezh
X-Received: by 10.236.29.74 with SMTP id h50mr18581027yha.8.1413831849862;
        Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si437666yhd.1.2014.10.20.12.04.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:09 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id LUNvf60n.1; Mon, 20 Oct 2014 12:04:09 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C9066220B02; Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
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
Subject: [PATCH 04/19] MIPS: Malta: Stop using GIC REG macros
Date:   Mon, 20 Oct 2014 12:03:51 -0700
Message-Id: <1413831846-32100-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43363
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
 arch/mips/mti-malta/malta-int.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index bcab0b1..864d482 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -37,7 +37,7 @@
 #include <asm/setup.h>
 #include <asm/rtlx.h>
 
-static unsigned long _msc01_biu_base;
+static void __iomem *_msc01_biu_base;
 
 static DEFINE_RAW_SPINLOCK(mips_irq_lock);
 
@@ -293,10 +293,9 @@ void __init arch_init_irq(void)
 		gic_present = 1;
 	} else {
 		if (mips_revision_sconid == MIPS_REVISION_SCON_ROCIT) {
-			_msc01_biu_base = (unsigned long)
-					ioremap_nocache(MSC01_BIU_REG_BASE,
+			_msc01_biu_base = ioremap_nocache(MSC01_BIU_REG_BASE,
 						MSC01_BIU_ADDRSPACE_SZ);
-			gic_present = (REG(_msc01_biu_base, MSC01_SC_CFG) &
+			gic_present = (readl(_msc01_biu_base + MSC01_SC_CFG_OFS) &
 					MSC01_SC_CFG_GICPRES_MSK) >>
 					MSC01_SC_CFG_GICPRES_SHF;
 		}
@@ -336,9 +335,9 @@ void __init arch_init_irq(void)
 			 MIPS_GIC_IRQ_BASE);
 		if (!mips_cm_present()) {
 			/* Enable the GIC */
-			i = REG(_msc01_biu_base, MSC01_SC_CFG);
-			REG(_msc01_biu_base, MSC01_SC_CFG) =
-				(i | (0x1 << MSC01_SC_CFG_GICENA_SHF));
+			i = readl(_msc01_biu_base + MSC01_SC_CFG_OFS);
+			writel(i | (0x1 << MSC01_SC_CFG_GICENA_SHF),
+				 _msc01_biu_base + MSC01_SC_CFG_OFS);
 			pr_debug("GIC Enabled\n");
 		}
 		i8259_irq = MIPS_GIC_IRQ_BASE + GIC_INT_I8259A;
-- 
2.1.0.rc2.206.gedb03e5
