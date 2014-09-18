Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:55:10 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:50144 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009161AbaIRVyOxCKKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:54:14 +0200
Received: by mail-pa0-f74.google.com with SMTP id lj1so502819pab.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ky4TlE3PKi3tD7VZVPmwF7ltn7Gk9JR7EWL1xbCbZho=;
        b=QOv3C1NpBh7Mdk+LWulw8nRHQNk6mdjU4thmXzMkO1BPrgsZrJcaUTBDhI1vrIhlCR
         C+XjgNe/zToDyVcM6OhNWPG8gFiI48stCv2v4c4GMwBViGl/sFKyhQBgrd4Ux5bveYIu
         VC8lMUPUFBaztnLftFz14nrKcXcfPJpwWxUMM5x1lC9m5ukKuqWiEErkoPhupfv3cWiB
         uUdhmLXysX2jrhhdO/YsEI0l0Mi0RjS3k3h0V8e3287/Md+rY9pRWF6VwOldDcJIzlrK
         Dt3wuKIqySBWoJT6NHpK63HZdKzReDa2Oy5OL/VJSot6R1QV25R8L8AY+oioivjaTZUN
         +9vw==
X-Gm-Message-State: ALoCoQllIWszjAltVx8DOr34ZD3TIqSSyiwyKswtkrq3b4pIQjTRseTseK0KEyMEir9A8xmvIA31
X-Received: by 10.68.204.97 with SMTP id kx1mr6681463pbc.7.1411077249455;
        Thu, 18 Sep 2014 14:54:09 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si1931yhm.7.2014.09.18.14.54.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:54:09 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 2KAtvZBw.1; Thu, 18 Sep 2014 14:54:09 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id AB093220B91; Thu, 18 Sep 2014 14:47:49 -0700 (PDT)
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
Subject: [PATCH V2 24/24] MIPS: sead3: Use generic plat_irq_dispatch
Date:   Thu, 18 Sep 2014 14:47:30 -0700
Message-Id: <1411076851-28242-25-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42704
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
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
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
