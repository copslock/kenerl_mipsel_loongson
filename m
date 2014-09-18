Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:49:01 +0200 (CEST)
Received: from mail-vc0-f202.google.com ([209.85.220.202]:64327 "EHLO
        mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009161AbaIRVroaPrvI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:44 +0200
Received: by mail-vc0-f202.google.com with SMTP id le20so97161vcb.3
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2T+wSjD72IsYIkJwO1RiNkqEgnm9oyKgMAGH/2d6bIU=;
        b=HxI3XPgdtbzSp2BRPk2zz2SB3gAanXjUdHPmHG0P+SSggMbivk6FkFiJcTR0ZnrzGX
         k/jyh64MXeoNDcTxk8a9vm/WN8Ds3ZPW+uPR8jAAitOcWn2PtHj1V7Re1e8gA1zN6tlV
         2+YFi6vaq0VT4KQIWLqwOxUdrjEXwYmhgkf34SZHOhsBPz2I9VgRZOzKMxSSSbfdGFYe
         VgHQl17txFVX3mmSixgm3/fswy6/DH5h3c0SzIRFAr8UGrks1ibMM1YLQ4AlVcRg6UNk
         bxypOM7yPw3Fy9LcbaixvbFxdkO3D1QkDpSxKIU/xJExbslPZn7RbWpXXBy4XqdXbQqd
         IGrw==
X-Gm-Message-State: ALoCoQnO/P2uyKftODYI9ktI2gTZd4TZggLSbAcTxKfL/jYS6mVqHZWgAYehuG53ZTbO2bFo005O
X-Received: by 10.224.10.199 with SMTP id q7mr6279109qaq.7.1411076858185;
        Thu, 18 Sep 2014 14:47:38 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si2183yho.5.2014.09.18.14.47.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:38 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id P0uuVMGs.1; Thu, 18 Sep 2014 14:47:38 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id EC9CA220B91; Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
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
Subject: [PATCH V2 04/24] MIPS: Set vint handler when mapping CPU interrupts
Date:   Thu, 18 Sep 2014 14:47:10 -0700
Message-Id: <1411076851-28242-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42684
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
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/kernel/irq_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 531b11c..590c2c9 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -36,6 +36,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
+#include <asm/setup.h>
 
 static inline void unmask_mips_irq(struct irq_data *d)
 {
@@ -124,6 +125,9 @@ static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 		chip = &mips_cpu_irq_controller;
 	}
 
+	if (cpu_has_vint)
+		set_vi_handler(hw, plat_irq_dispatch);
+
 	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
 
 	return 0;
-- 
2.1.0.rc2.206.gedb03e5
