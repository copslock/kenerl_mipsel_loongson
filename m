Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:58:36 +0200 (CEST)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:59749 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009040AbaIOXvxSH5EQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:53 +0200
Received: by mail-ie0-f202.google.com with SMTP id rl12so745912iec.1
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBIYmU/PV3po/3cbBCMt/jTNha1nx8Jg+3gbO8M2vgc=;
        b=GCk9BnUOy0gpYWy4e/skmctJHyNu1RbO+ICaoik7kLsRe4lgU53VSBWlhzRp2GL5kL
         YjamSpqOrEvGN9q8uitKalqDxDWTn06OgYByVrfOJdyBTzNY2ddh4+ivjAIsHY0X/IS4
         HGUgpXBFHbAr+pSt3cN3gMK/LRcprjSrR8pKE1Z8vyjcoR5LsODMHTwpUtXg9roH17Mf
         UVO9+A6z+YKCrFH7S2zkIUe02SzazlvPTriWNd7vlgbvcslrMdCYEzkKkrJZ4vBFeEe4
         Do5RD9HZur6Gw4LwDZ7ZoF2KSXCC6Ld8sT8xe8Mfij7vMv2Fty7AS1vwjoR1f+ZC/NMH
         65GA==
X-Gm-Message-State: ALoCoQn47oJb11BqPk1aT3WW1ZZ1haEb8+Mx6jtXslVJkWIQi92j0oqZg6JGypHdn8pg5OgVog9F
X-Received: by 10.42.38.15 with SMTP id a15mr6460068ice.30.1410825107494;
        Mon, 15 Sep 2014 16:51:47 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si630012yhb.4.2014.09.15.16.51.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id pSykdCfm.7; Mon, 15 Sep 2014 16:51:47 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 601B6220984; Mon, 15 Sep 2014 16:51:46 -0700 (PDT)
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
Subject: [PATCH 24/24] MIPS: sead3: Use generic plat_irq_dispatch
Date:   Mon, 15 Sep 2014 16:51:27 -0700
Message-Id: <1410825087-5497-25-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42642
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

The generic plat_irq_dispatch provided in irq_cpu.c is sufficient for
dispatching interrupts on SEAD-3 in legacy and vectored interrupt modes.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-sead3/sead3-int.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index cb06cd9..69ae185 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -22,32 +22,11 @@
 
 static unsigned long sead3_config_reg;
 
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-	int irq;
-
-	irq = (fls(pending) - CAUSEB_IP - 1);
-	if (irq >= 0)
-		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
-	else
-		spurious_interrupt();
-}
-
 void __init arch_init_irq(void)
 {
-	int i;
-
-	if (!cpu_has_veic) {
+	if (!cpu_has_veic)
 		mips_cpu_irq_init();
 
-		if (cpu_has_vint) {
-			/* install generic handler */
-			for (i = 0; i < 8; i++)
-				set_vi_handler(i, plat_irq_dispatch);
-		}
-	}
-
 	sead3_config_reg = (unsigned long)ioremap_nocache(SEAD_CONFIG_BASE,
 		SEAD_CONFIG_SIZE);
 	gic_present = (REG32(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
-- 
2.1.0.rc2.206.gedb03e5
