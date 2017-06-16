Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 13:03:25 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:33950
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994805AbdFPLDS6eye2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 13:03:18 +0200
Received: by mail-pg0-x243.google.com with SMTP id j186so5570114pge.1;
        Fri, 16 Jun 2017 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KX0MN6WlTzhUNELLNw31bPZI7AcRXIxyPMeWzTmB+zg=;
        b=EGKc+adhiT5XtCYuhhvT1dsysSol0RZxWUEqAUy4YIsseTj4dlwmiUSgrLG0wIgaGa
         gK4Uhfauu2I7YCwlYFeCHCKBv0nDAfIri53Hc/9lNxzBl35cr+e7CZZ95GUpkyPMmU+e
         HcbU26WbAqkZx8yfOsYTWvjPLZqKhXJo/Ga9/iDqsEa22mcoaRaIXpv4iB65Mkon5fq2
         SelyX+p2VIW14Wi8vjzC/eJV/6Iln+u5PcQX80zaStZt2epMsuAorAsXI3isRBc7abBi
         s6QYQP6EjwgOTV7wL3dmRxrEi+b9fADcEGiehoZdn/CVK32abfKJI4i7GK6LB8B5MH4h
         stQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KX0MN6WlTzhUNELLNw31bPZI7AcRXIxyPMeWzTmB+zg=;
        b=nmiiTLVGK5bnWoZ2ToYVpxwfbhMf99o5fvUCr930c94HqXl/Dzi3bjlnlhLe6j/q10
         HZy0fmQhqvs419we5VptVUR2jCSKItvNyuBZil44Npq+DOny8hZlbuel06VhZ4513lt8
         7ib0mmqiLPyYFswuwF572HXr4svm2syF6ho2bEr+u2/DEUIh0koK9CjVLvSdZWv7EiuQ
         DHdCDdD6kHeyRE8XZ7VGu07RTGsB/o7aQOPhEAeBSgEm3TY9p7vqepHg1xzj61t2SnUl
         07aWPwVqglu7kYlmbBONmbMfxnYD0ayn+Z7Ldq5o9RCH9KA2XJONXlXv7ouK/nO814wS
         WojA==
X-Gm-Message-State: AKS2vOynkXhPKwrWOGFxhix4rEbFXdtWHghyUy0TIgLBYSZMAtrZg6/J
        kBxUSFAHYOrxjoXwwDA=
X-Received: by 10.99.44.67 with SMTP id s64mr10768327pgs.111.1497610992596;
        Fri, 16 Jun 2017 04:03:12 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id x6sm3976224pfk.22.2017.06.16.04.03.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 04:03:11 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Fix missing cbr address
Date:   Fri, 16 Jun 2017 20:03:01 +0900
Message-Id: <20170616110301.38103-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.13.1
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Fixes NULL pointer access in BMIPS3300 RAC flush.

Fixes: 738a3f79027b ("MIPS: BMIPS: Add early CPU initialization code")
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 1b070a76fcdd..5e0d87f4958f 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -589,11 +589,11 @@ void __init bmips_cpu_setup(void)
 
 		/* Flush and enable RAC */
 		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-		__raw_writel(cfg | 0x100, BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
 		__raw_readl(cbr + BMIPS_RAC_CONFIG);
 
 		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-		__raw_writel(cfg | 0xf, BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0xf, cbr + BMIPS_RAC_CONFIG);
 		__raw_readl(cbr + BMIPS_RAC_CONFIG);
 
 		cfg = __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
-- 
2.13.1
