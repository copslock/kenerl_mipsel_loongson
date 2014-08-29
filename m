Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:17:36 +0200 (CEST)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:38190 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007488AbaH2WOzWXBIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:55 +0200
Received: by mail-ie0-f201.google.com with SMTP id tr6so634818ieb.2
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PZN+KZaR4f9TRZO+XCjbEVMvr2dlL+UF2uK2LFDyrE=;
        b=XWAYy0b4vKI1zyk1V3FnzZbph3oobB6RvGnRxfFVc2PMrD5GbAnioZnNeurvU5AWzG
         53OMwnyjXo0kNoi5GDc9LlfF5SmyLKadE16x0SYntXuR+bWq400w4QrGv+o+rbVjCOvn
         pguednYxKIMXlVds8QArwShw7ghm5oajvJHvSHIXLPaIshqpsE7hFQh++FG8ObecUujN
         tEpfXIibLnTKdc9AYVVgbKSClUaWIsCBVXBTU7wCovZxzs1R9HXcMh1KVFD4IvYIemaJ
         LvowUyNEVuy1ifclQZ60WnTawYMfqXjQIrS/DvPNTV+Ijf0GG4r9GHPixwuhDl0jVOkN
         HjFA==
X-Gm-Message-State: ALoCoQnd/Ak/EdC+mYF3DJRL3woXEs49umZGu+vtLupchh0pmwLIpIg3fI0ITGf0Qs/rF2upGlXf
X-Received: by 10.50.136.194 with SMTP id qc2mr3667295igb.7.1409350489604;
        Fri, 29 Aug 2014 15:14:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c77si200yha.5.2014.08.29.15.14.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:49 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 491AD31C515;
        Fri, 29 Aug 2014 15:14:49 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0C38F221060; Fri, 29 Aug 2014 15:14:49 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] MIPS: GIC: Use local interrupts for timer
Date:   Fri, 29 Aug 2014 15:14:38 -0700
Message-Id: <1409350479-19108-12-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42333
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
