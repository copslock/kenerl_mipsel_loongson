Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 09:03:21 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:58466 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491152Ab1AYIDS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 09:03:18 +0100
Received: by gxk21 with SMTP id 21so1627094gxk.36
        for <multiple recipients>; Tue, 25 Jan 2011 00:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=RUqaxbYYN+ZJf21utNDoQd9/a+XMBVblvH3y/3e0IFU=;
        b=ZqgJU4qEpmN4EuqewVgJRZuJ+nT28r0P5TsQxgBpLDsooNGhOi5B7SQKki+LbWx0sT
         ngWl7wyBv5VxcAF6u3YSh22P4uX6GrhLY9rMFnFr07C6oaP/3ZY7NfXWLT+0YQjUA9r/
         8NIBWyH1ZfhDaS8VckbOKDbC7FuGX/hAo0YQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cgUSSj0I+nonaNWWDYAxnupjMs0GWaXes9jAZBDHrPgo9AARP8NdhDOQ3ovK9qpUyH
         JVahKXJowTy5L/NWp+nbMh1N1WCWh77BNeqHJJM+SHv5fGNU2oYR5fe8v35xpoM9d5CZ
         AQ/B0vuIQoYv3dlKYaW2ouEa18Kv8Nq5UNjSI=
Received: by 10.150.192.19 with SMTP id p19mr5733120ybf.156.1295942592060;
        Tue, 25 Jan 2011 00:03:12 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id r24sm3589721yba.18.2011.01.25.00.03.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 00:03:11 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH 1/6] set up MSP VPE1 timer.
Date:   Tue, 25 Jan 2011 13:49:21 +0530
Message-Id: <1295943561-20000-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

VPE1 timer will be required for MIPS_MT modes ( VSMP / SMTC ).
This patch will setup will setup VPE1 timer irq.This has been
tested with both SMTC and VSMP

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_time.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 01df84c..b6c2d33 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -36,6 +36,13 @@
 #include <msp_int.h>
 #include <msp_regs.h>
 
+#define get_current_vpe()   \
+	((read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE)
+
+extern struct irqaction c0_compare_irqaction;
+static struct irqaction timer_vpe1;
+static int tim_installed;
+
 void __init plat_time_init(void)
 {
 	char    *endp, *s;
@@ -83,5 +90,11 @@ void __init plat_time_init(void)
 
 unsigned int __cpuinit get_c0_compare_int(void)
 {
-	return MSP_INT_VPE0_TIMER;
+	/* MIPS_MT modes may want timer for second VPE */
+	if ((get_current_vpe()) && !tim_installed) {
+		memcpy(&timer_vpe1, &c0_compare_irqaction, sizeof(timer_vpe1));
+		setup_irq(MSP_INT_VPE1_TIMER, &timer_vpe1);
+		tim_installed++;
+	}
+	return (get_current_vpe() ? MSP_INT_VPE1_TIMER : MSP_INT_VPE0_TIMER);
 }
-- 
1.7.0.4
