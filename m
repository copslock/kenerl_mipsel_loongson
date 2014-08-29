Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:16:30 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:53324 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007390AbaH2WOyQVwNa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:54 +0200
Received: by mail-pd0-f201.google.com with SMTP id g10so355607pdj.2
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzdRWH2KB09x34jkLCEiKtfb7OuW7a9DnMeorOllAl0=;
        b=NU55v26nlAtPOV4Y+6eORg9CSmj6KYJIFSSSgCqTI7rbUCxPSQDgVi8UgSARgHZu2I
         Bia69/IHr6uzaIEQl1OUQC5mVLA9NdpIIS3vV6aCj7GJp+ULsSMV9KC3BM2Z7khhOOJL
         xPphmUOsERCzsQC1wT52ciC8EiEO72Riap/0tLCTeHJyIy9V6O3R+HrHXk7gXwBe8NJD
         hzm1Q013mhlB3k1V3sbWS7CK9n22K2WKfD85OfCJJHK2nYkYEh3O9hfdn8uCDGIEWyGY
         HWO+jC5olSYmVlCDgl63zCppLAs0GOW1cE24qzrw2H8u4qnixSmre0hHXcJGAL4+rkeu
         svDA==
X-Gm-Message-State: ALoCoQlN3LsBLNTS6HJo/TYZZ5dxrr6/DrIQjZwCSqNI6URJKS1F9x63ba+6D1kH52ABOcVJcdgl
X-Received: by 10.68.222.194 with SMTP id qo2mr7412495pbc.6.1409350487970;
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j25si1523yhb.0.2014.08.29.15.14.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1E85F5A43C2;
        Fri, 29 Aug 2014 15:14:43 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D3F8E221060; Fri, 29 Aug 2014 15:14:42 -0700 (PDT)
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
Subject: [PATCH 02/12] MIPS: Set vint handler when mapping CPU interrupts
Date:   Fri, 29 Aug 2014 15:14:29 -0700
Message-Id: <1409350479-19108-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42329
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
