Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:52:34 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:63377 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009004AbaIOXvmSIqGU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:42 +0200
Received: by mail-pa0-f74.google.com with SMTP id lj1so1030264pab.3
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/qAfan1upg1LpxSV1foGM0vgXbaZn1LPstYn7vUbnc=;
        b=S8KA3slsMpyV/EStnFLKgALFGIaYWIYI+ilgxvfeZt0pL/5+kqvaA1OMCd7fvbPakk
         PcTgMmlopnKS6PS/0AXgW2eTm7PnN8FulHAaMdOlKC6Lk4MRltrJKfEKcCveWu3alhyB
         0fSpArLBBlj7RU6DHXjGlVWheQ5IKejIhGTxwQUXAdsAuw55b5tVL8JtcGfoikjTiMIH
         YQPOOQDIFVPfGBI9Ofa0/si6B7NJCHGBrGoGC4RQZH+2VdzFqHFQpQgbufsloWi8wX0B
         kLP5iDaXpkdH7V8Lb50x8yIJrwdnYNnzqHWJfFp6Re/difz5Ys+ZI0KHAtnEVTLvNCgN
         M/tg==
X-Gm-Message-State: ALoCoQlTMiaMFnERoZTi0Md2DhehUrwbvBmDZ6YP9SghZbax4rKwhSKV4ZuYZf2S5VgE08Fh1FQf
X-Received: by 10.66.65.75 with SMTP id v11mr17304665pas.30.1410825095887;
        Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si630571yhe.3.2014.09.15.16.51.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id cogZdeeo.1; Mon, 15 Sep 2014 16:51:35 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 9D59522093F; Mon, 15 Sep 2014 16:51:34 -0700 (PDT)
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
Subject: [PATCH 03/24] MIPS: Provide a generic plat_irq_dispatch
Date:   Mon, 15 Sep 2014 16:51:06 -0700
Message-Id: <1410825087-5497-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42621
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

For platforms which boot with device-tree or have correctly chained
all external interrupt controllers, a generic plat_irq_dispatch() can
be used.  Implement a plat_irq_dispatch() which simply handles all the
pending interrupts as reported by C0_Cause.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/irq_cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index ca98a9f..f17bd08 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -94,6 +94,21 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 	.irq_eoi	= unmask_mips_irq,
 };
 
+asmlinkage void __weak plat_irq_dispatch(void)
+{
+	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int irq;
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	pending >>= CAUSEB_IP;
+	for_each_set_bit(irq, &pending, 8)
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+}
+
 static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 			     irq_hw_number_t hw)
 {
-- 
2.1.0.rc2.206.gedb03e5
