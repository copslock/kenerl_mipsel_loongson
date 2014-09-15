Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:53:39 +0200 (CEST)
Received: from mail-yk0-f202.google.com ([209.85.160.202]:52588 "EHLO
        mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009014AbaIOXvoDp1hy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:44 +0200
Received: by mail-yk0-f202.google.com with SMTP id q9so484259ykb.1
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udlPWDClrUPWNTotUoBnhT37BBh8Jr9ztDLPtgecZvk=;
        b=Uql3AtP+ahjqRvs3oZy8Q2h+b3ptcD9N22Ws9NenMTW7x8QPzbGzB/bU3RHrQPCQ7k
         +Ne9lFDuJe5x5Yb9315yM0/4UTL0ZbLVCdGgngH+SswmOySQhO7AyXR/Rc7hp5X7tOr+
         zmSlH463Khp77wOkCzZjLT3CoZBEgA3I5Be/GzKqKva+yHcYOmpVuPXp7ZlMiaRpbXov
         drD5NvS9OBqxrZkAYKvrxkYOsDJgLOU7y+X1i+j+lTVAzPkUt4jeDTsxECx3Hv86VGlB
         mEvkBbaa0lmNC7MkGVavYF3Yly7hZOol5bsd5/dpWSj5hY3UuJuOlmAfPQSaXjEKV5On
         4xmg==
X-Gm-Message-State: ALoCoQlyVwLT691NFPKRiYhy5k20nVyeuCB1y6ac8p/qIRvmieIbHKUjXZ/PfJtqlgxHdHZ8W6uz
X-Received: by 10.224.75.198 with SMTP id z6mr17324655qaj.2.1410825096579;
        Mon, 15 Sep 2014 16:51:36 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si631679yhd.1.2014.09.15.16.51.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:36 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Mdj9PTay.1; Mon, 15 Sep 2014 16:51:36 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 48055220984; Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
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
Subject: [PATCH 04/24] MIPS: Set vint handler when mapping CPU interrupts
Date:   Mon, 15 Sep 2014 16:51:07 -0700
Message-Id: <1410825087-5497-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42625
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

When mapping an interrupt in the CPU IRQ domain, set the vint handler
for that interrupt if the CPU uses vectored interrupt handling.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/irq_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index f17bd08..5069acb 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -36,6 +36,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
+#include <asm/setup.h>
 
 static inline void unmask_mips_irq(struct irq_data *d)
 {
@@ -121,6 +122,9 @@ static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 		chip = &mips_cpu_irq_controller;
 	}
 
+	if (cpu_has_vint)
+		set_vi_handler(hw, plat_irq_dispatch);
+
 	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
 
 	return 0;
-- 
2.1.0.rc2.206.gedb03e5
