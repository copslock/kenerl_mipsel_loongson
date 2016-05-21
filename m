Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:01:30 +0200 (CEST)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34078 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029225AbcEUMAVD20TI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:21 +0200
Received: by mail-lf0-f66.google.com with SMTP id 65so23983lfq.1;
        Sat, 21 May 2016 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=z+kcuBBPDBTgyHdvh3/8i3wo0UWZDJa7hz3X9nm4r/Q=;
        b=0ykf1QHJCfR3tzediAewuyC0JCp140gY9I50ApHO3bNL45v6GOxEe4UkTdKCwWgfUB
         R9SA/JDzmlDtIsbQd/vwBLYN6v8VJaLgMqWbT0HOCiqYPy7JqyYM+F8HbLsl+XczCseM
         QkDrhwyKSJK/EDP9VfPNnxAGaK0/iyLbi8HKLco2DKLAdebfizNqPtOINv6d70hR2qFu
         JYH5sZjtXy/1kqmVDAuOu7WjMjXHIsncWCpmx/W45Do8ER1WgNDBHvYFH9t6K3RZzt72
         /CwZwX/OAWAUomvhQN0DSWgZbRz6LLjCyy7Hvscr7g549mioPdjAFA/0GwovDv8FolNc
         saTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=z+kcuBBPDBTgyHdvh3/8i3wo0UWZDJa7hz3X9nm4r/Q=;
        b=KNdDlvWXsIKAF9NXwBfvzVsrL5LUs7m2KuHObzjpko1P1J4pJAD/pnewqXexRpDqMw
         J1nbBb8nZu02qL5BdJyidOgi5xVAVKMha41arEm2f9YO5xEqkmhFS+y9eKDbZY9F6JrN
         mkn/Xl9BjHsweZI0IgQZv5ZF1c+yHLJWMx+RJRR+YFynDbkX1eSKThC5K3ixBdVZFBA4
         t3z4T+vY7DY//muJQ3VkPbx0sdkmOJB0II+1d/YaCJi/NaB1+pxp4BxeUkxhl1JYuuZA
         /yHJxTjA5ZEMV3s43xYbV9je9t954VR8Hbj6XUJE77eowjMUqozg1o5PalDVqRqJfaVV
         /yQg==
X-Gm-Message-State: AOPr4FV26Z9/lTkFL+oOr+BCyoeuflrAOs8ELAXtaanTMZgrvW2GWr11IEBCw5gkOJfMkg==
X-Received: by 10.25.42.147 with SMTP id q141mr2712003lfq.94.1463832015746;
        Sat, 21 May 2016 05:00:15 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id o75sm2192380lfi.9.2016.05.21.05.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:14 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0184/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:11 +0200
Message-Id: <20160521120011.9446-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53582
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
 arch/mips/include/asm/mach-ip27/dma-coherence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index 1daa644..04d8620 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -64,7 +64,7 @@ static inline void plat_post_dma_flush(struct device *dev)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-	return 1;		/* IP27 non-cohernet mode is unsupported */
+	return 1;		/* IP27 non-coherent mode is unsupported */
 }
 
 #endif /* __ASM_MACH_IP27_DMA_COHERENCE_H */
-- 
2.8.2.534.g1f66975
