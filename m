Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:35:29 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:38549 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008131AbaIERaviMTwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:51 +0200
Received: by mail-pa0-f73.google.com with SMTP id kx10so3528236pab.2
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xWUYNnr2R1Q6CoH0LqHFCT5+4l0bBmTLMpaXR7yv6Ms=;
        b=RaeJHUzPmLes4l/q6rJLTqA1CkzyNU075RUi3iosqplBjTDizHxZTkYrEqv2qhhepn
         ouFnG051xU+xAlYZtWkbCBqvs7ET7uiWZxPyWxO7L9RWVfe0SYCgKEcC8cRn7gbfytr3
         BfrgcUFBlMYNsaUDah20nSBaNwaGe/dB3zmH43qlwC7GeukaRFIjrXevunjhEq546jOg
         Z9rM4WxMuLYJnLDJOL5v1MxIH2H/LmS2rxcabEoAEM4JSXqD42tm14f6MustSCQwiX/D
         XCNIOy8GqvomJEX538X5T/8ku4rBHfXorhgJ6WTX202n3wBX4TbypJeMWB7gDPF2kQv6
         w4iA==
X-Gm-Message-State: ALoCoQkCNekDPCx2tW6hk1hqH6ioinz+X0MWBonzg3lFPxkuVSoAdE85AIIi6020cIQIMtaSBVdq
X-Received: by 10.66.66.196 with SMTP id h4mr7410873pat.18.1409938240719;
        Fri, 05 Sep 2014 10:30:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n24si2843yha.6.2014.09.05.10.30.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:40 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 85BCD5A427D;
        Fri,  5 Sep 2014 10:30:40 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 4AF682209EA; Fri,  5 Sep 2014 10:30:40 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/16] MIPS: GIC: Use local interrupts for timer
Date:   Fri,  5 Sep 2014 10:30:17 -0700
Message-Id: <1409938218-9026-16-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42446
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

Instead of using GIC interrupt 0 for the timer (which was not even
handled correctly by the GIC irqchip code and could conflict with an
actual external interrupt), use the designated local interrupt for
the GIC timer.

Also, since the timer is a per-CPU interrupt, initialize it with
setup_percpu_irq() and enable it with enable_percpu_irq() instead
of using direct register writes.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v1.
---
 arch/mips/kernel/cevt-gic.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
index 6093716..cae72a4 100644
--- a/arch/mips/kernel/cevt-gic.c
+++ b/arch/mips/kernel/cevt-gic.c
@@ -68,7 +68,7 @@ int gic_clockevent_init(void)
 	if (!cpu_has_counter || !gic_frequency)
 		return -ENXIO;
 
-	irq = MIPS_GIC_IRQ_BASE;
+	irq = MIPS_GIC_LOCAL_IRQ_BASE + GIC_LOCAL_INTR_COMPARE;
 
 	cd = &per_cpu(gic_clockevent_device, cpu);
 
@@ -91,15 +91,13 @@ int gic_clockevent_init(void)
 
 	clockevents_register_device(cd);
 
-	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_MAP), 0x80000002);
-	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), GIC_VPE_SMASK_CMP_MSK);
+	if (!gic_timer_irq_installed) {
+		setup_percpu_irq(irq, &gic_compare_irqaction);
+		irq_set_handler(irq, handle_percpu_irq);
+		gic_timer_irq_installed = 1;
+	}
 
-	if (gic_timer_irq_installed)
-		return 0;
+	enable_percpu_irq(irq, 0);
 
-	gic_timer_irq_installed = 1;
-
-	setup_irq(irq, &gic_compare_irqaction);
-	irq_set_handler(irq, handle_percpu_irq);
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
