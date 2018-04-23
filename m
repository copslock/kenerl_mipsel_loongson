Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 05:50:33 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:33881
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeDWDu0J1vgq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 05:50:26 +0200
Received: by mail-pg0-x242.google.com with SMTP id p10so7430779pgn.1;
        Sun, 22 Apr 2018 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lu4OhWwCKU9BxaQ2oT4wJGfxQCLGkMzek7tNIjqHvOY=;
        b=X3jbJeDikH3Wzw+WCOGQhBAt4hsrJQiVpTNJI+44rHRelperqYit3Hm3ivoIYNBCFo
         kx958lvhMBvP0NVvB+CKHvtwNkzaKOcNNDxdyMAbdq3OqTT7vSGnoqbFv1Gh6RObPGjj
         TVQnDduOuDiOKMNTlNScdpDmnx6D/WkqgOqt+r8V0pjB0gh1oSvasMlB6YUbkNgGV7M2
         J0FNmzU3GBDITcYshXaXNRv/IkpGv8tHj3uJ33bv0vKBXu2J+2n/sj84U71aHYcfFbWg
         JHECuNGWKma1YY39CZ6e0McX3tyPWt66AWHU+cmZl6G6gozAEl8vVeH4ffKpxZNQTtvq
         yK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lu4OhWwCKU9BxaQ2oT4wJGfxQCLGkMzek7tNIjqHvOY=;
        b=fx/+SgH/8YTMPvOu/+orMamnldBAIlslallxm5xbYzj3xao2HBDkVK1FTumbVmMR+0
         YZhKFOCDufcs/Z7MG1+smniB4pi1dDmCP4R+YawmIMjrwtGmSba8M3qV2/G+fI0oC5Uj
         o31hZWADa9e1bWLQhpBRoQ3FlM5AFuaBd6EnjKvmh7t4nNTVUY71gNgPRLStQFgIn0G5
         sgcvPgrHfy916dK4UI7bdDz390HaDd4E5KBJDZvwMN7LLQjsU4wk16I4at2J5aKs9Bnp
         3quc6uTXvSAm+KPMmP1Dac2oRhBBdQhwmzTd1OENGH04EkochPr4NuXmKas/dd/nqukq
         aFMQ==
X-Gm-Message-State: ALQs6tAXt21fpQbAp6KvJBkJ2WKJWddtvjNIlrIaqiTNYOBV80SZ464K
        glrd8E+FJTuXjd7kLYvRgz+0xw==
X-Google-Smtp-Source: AIpwx4+DZvqb1gFFlQaicVWomvfP5nMOglDgbCVpkgxDqNLNxHcsmT2WrrONcsVYhW8AOXi01fGZKg==
X-Received: by 10.101.86.134 with SMTP id v6mr6143818pgs.92.1524455419232;
        Sun, 22 Apr 2018 20:50:19 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id u68sm19859883pfu.167.2018.04.22.20.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Apr 2018 20:50:18 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Sinan Kaya <okaya@codeaurora.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: io: Add barrier after register read in inX()
Date:   Mon, 23 Apr 2018 11:53:20 +0800
Message-Id: <1524455600-30384-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

While a barrier is present in the outX() functions before the register
write, a similar barrier is missing in the inX() functions after the
register read. This could allow memory accesses following inX() to
observe stale data.

This patch is very similar to commit a1cc7034e33d12dc1 ("MIPS: io: Add
barrier after register read in readX()"). Because war_io_reorder_wmb()
is both used by writeX() and outX(), if readX() need a barrier then so
does inX().

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index a7d0b83..cea8ad8 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -414,6 +414,8 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 	__val = *__addr;						\
 	slow;								\
 									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
-- 
2.7.0
