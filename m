Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:33:25 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:51136 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008221AbaIERalwCDij (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:41 +0200
Received: by mail-pa0-f73.google.com with SMTP id kx10so3494827pab.4
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03wlbmOeBijEGatFeAabYzt9Qsn2Y+SPTAGJQhSrgKY=;
        b=ISEBu6Rqe4KdSeKd6k0K6rdTr1DyKwmTUw/sIQhVBonLJb3J4raJebq9QNVoTKOEAH
         DhvSfRPzVM85pfhxJzxOZvA/qR9/+Hoj7uU2nfY6m4lLR0rWVupZeoMDqwmRqdCSxqBj
         BxXbWuO+PxBp3a5SYzfu8bBR7HgytV76Y0vS5sM1UN+LVZuDxOur42bkB05jL7wlmkV7
         wN1lSlQrNUGc8WPphM0isg9zG5CYHdlnWeWWa9StA8KAVKfSMd2OhPPcYRvpQRB5pZQp
         gPk9BFIx2rVBxIXhMQvmvMJ8kuT0Kq9yAX43cw680YQOYWb1JZAKgb5+53FtzoS3Y3RV
         myxg==
X-Gm-Message-State: ALoCoQmEI22I5D/0DVeNexcbVf72fh4pGgjunc0UTt64ZrbGcbbfMHJilw1gMz1BGk80+DBVLIai
X-Received: by 10.66.168.197 with SMTP id zy5mr7598355pab.7.1409938230366;
        Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c77si506590yha.5.2014.09.05.10.30.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2E6A55A427D;
        Fri,  5 Sep 2014 10:30:30 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id E74F12209EA; Fri,  5 Sep 2014 10:30:29 -0700 (PDT)
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
Subject: [PATCH v2 02/16] MIPS: Set vint handler when mapping CPU interrupts
Date:   Fri,  5 Sep 2014 10:30:04 -0700
Message-Id: <1409938218-9026-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42439
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
No changes from v1.
---
 arch/mips/kernel/irq_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 9cf8459..33a4385 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -36,6 +36,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
+#include <asm/setup.h>
 
 static inline void unmask_mips_irq(struct irq_data *d)
 {
@@ -146,6 +147,9 @@ static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 		chip = &mips_cpu_irq_controller;
 	}
 
+	if (cpu_has_vint)
+		set_vi_handler(hw, plat_irq_dispatch);
+
 	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
 
 	return 0;
-- 
2.1.0.rc2.206.gedb03e5
