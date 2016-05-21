Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:05:29 +0200 (CEST)
Received: from mail-lb0-f193.google.com ([209.85.217.193]:33537 "EHLO
        mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032476AbcEUMBxYMbPI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:53 +0200
Received: by mail-lb0-f193.google.com with SMTP id u2so694131lbo.0;
        Sat, 21 May 2016 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6vmsRIgGii5OdL7FRFO2L/Bht6KRuz4H8US0bsAf27A=;
        b=jitRk/hMUpdqyRicFVH5hgafZhMmJ+OgA4U2rqXo9sCgNuqkT7LfyLi4km1boSkGlD
         N2BU6Sr/8V0Hi/lDYq0vPWtrviRla/jaI6pIYik4Wz/ac6l+MKBE20AUjSZ1zNHYhFkC
         7gT50dcey3djs6muKkFrsWLFlj/u1mPnL5He2p0fGwjDM+Y6JB7LWtulilyubv7412Pj
         +v7nE+06NFotF9wc/LKju+6l1qSTFYxghMr3Ra4KFOpBZ+Ir+4nl0h2ArB0bN5OfRp6a
         Hm4MSHsWx7wfUN9FgSb9C5oyiiwGWH7tUbwkUWvHWYpOh/0b8zSChIiJGDrmXIk8qBPI
         feQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6vmsRIgGii5OdL7FRFO2L/Bht6KRuz4H8US0bsAf27A=;
        b=BHkMKgjNlzv3dcLElZtHrIEnhkTjq7LFyy7KdIU9xeIJMbdtU0i9JjAAwJXjX+sOaq
         UFsJc3ctgNicq6Xv6qrisoVJChx/wo4010AYHSuYlJutvyC8imU/Z8oJkKZjtlvIKtOj
         7lTaXk/HNHMs5URNLv1ODuwZN7VRRzL+2/aAGLhmo/NmQw/ay0Z/GRqmr2CpRTe6t0Of
         W2Trd5piR4Bu9YYLFvt8d2UhZFjqvtWdXJgSgo7pcWCLKDBtYlyqD9VwkxBVjRHwRsPD
         YufSgFEHPbkEk8k7qWA8kpsSojM2pzwKYvhnlbXG7DlAe8/KwPbKYTiCbFPxjm6i/wG/
         Bfjg==
X-Gm-Message-State: AOPr4FXGt3zsWyl4hfHPPkiIK/0Pg1QTfDs7SzRYFaiIIuJdKxqEkry7cCYFvhzYHy8iiQ==
X-Received: by 10.112.27.233 with SMTP id w9mr2703073lbg.86.1463832108088;
        Sat, 21 May 2016 05:01:48 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id z1sm4100563lbw.2.2016.05.21.05.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:47 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, chenhc@lemote.com,
        viresh.kumar@linaro.org, linux-mips@linux-mips.org
Subject: [PATCH 0196/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:44 +0200
Message-Id: <20160521120144.10145-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/loongson64/loongson-3/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
index a2631a5..249039a 100644
--- a/arch/mips/loongson64/loongson-3/hpet.c
+++ b/arch/mips/loongson64/loongson-3/hpet.c
@@ -212,7 +212,7 @@ static void hpet_setup(void)
 	/* set hpet base address */
 	smbus_write(SMBUS_PCI_REGB4, HPET_ADDR);
 
-	/* enable decodeing of access to HPET MMIO*/
+	/* enable decoding of access to HPET MMIO*/
 	smbus_enable(SMBUS_PCI_REG40, (1 << 28));
 
 	/* HPET irq enable */
-- 
2.8.2.534.g1f66975
