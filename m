Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:21:15 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:35600
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DVJL8E6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:21:09 +0200
Received: by mail-pf0-x242.google.com with SMTP id j5so2815892pfh.2;
        Fri, 27 Apr 2018 20:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0Htkos8eI5wiZsL3H/N85RKaBDI4NAOb9JNy5mZ4A4=;
        b=MrPs6TiL1xosK1+MYQSRaSoLFt8ZqzKqUFQ1B3Us1TJSlSPQu349Mq6OZvsF20tDz9
         tfxGaiIOJOeoUmUkloruczkl3c39xrINBiG5yoy7BgWzM0WkyBv4GWPv65QczHwThzjZ
         J5BsFAH+edfvA6VhBcwZrn65mcORXoP5LuksY0sXc77eAV7K3jE65lXQD4xFZi06rGXo
         4osXiNdBRYZhY3KV8UfjQVQlrl5ofV18Nv4XEllySip3RUiMbe/Eohg9LUXFOgJS5D/t
         JUXjdpxuvshPBcyRTw5vOYvjofFljl3+zn5wmn1zQxqY7EuUGM1qe0ZqZVWHFrQ5+uOM
         sY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=c0Htkos8eI5wiZsL3H/N85RKaBDI4NAOb9JNy5mZ4A4=;
        b=ejWkMIJgouVbsuiu73/KfFyATq1lMOfHPLo+L0oGoNHFLyKmpOv+eu4Bg8BISZW5yf
         zccdwaP0TrLAQrgiBssvckf5wv6faF/J0PZFix/oo3vyrfMkwyWkCkMuO0AVu6LTzuD8
         gqOIKwpIrWO2eOhLSwNy96gPt3YPjSC/VkIzXeVR30IeFWOyLYb8PedgHn0u0/DeXN77
         BbAHZ9WOs29+7hrqMESBQWTB6gtRyDYCKtm0C4vlpegzfRbWlyIbHgSnCKESEYWUnrQ8
         TI60f+gPW8GBlqT/p5LyYjNOwHRYIXEJ7TBekywU868ymccJ5l3jJ+w4a6TyYbmNaC4s
         7BrQ==
X-Gm-Message-State: ALQs6tD/q+9WdFPdTNXilTwCxtKv8zN6PuN2P9+twcq8BJxQk4B/btd3
        NcLPABq01b93SVMLdk6Xaj/n3g==
X-Google-Smtp-Source: AB8JxZq82Bq7QEmCEXSolE7HzduOsuG8+7OYVrCYxhsz6x6v0hwb/apjEuzu0sfl8buop7bqme1DLg==
X-Received: by 2002:a17:902:a50f:: with SMTP id s15-v6mr4675778plq.175.1524885662906;
        Fri, 27 Apr 2018 20:21:02 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:21:02 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 03/10] MIPS: Loongson-3: Enable Store Fill Buffer at runtime
Date:   Sat, 28 Apr 2018 11:21:27 +0800
Message-Id: <1524885694-18132-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63821
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

New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
(Store Fill Buffer) which can improve the performance of memory access.
Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
the generic kernel has no benefit from SFB (even it is running on a new
Loongson-3 machine). With this patch, we can enable SFB at runtime by
detecting the CPU type (the expense is war_io_reorder_wmb() will always
be a 'sync', which will hurt the performance of old Loongson-3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/io.h                               |  2 +-
 .../mips/include/asm/mach-loongson64/kernel-entry-init.h | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index a7d0b83..78ede49 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -304,7 +304,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #undef __IS_KSEG1
 }
 
-#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
+#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_CPU_LOONGSON3)
 #define war_io_reorder_wmb()		wmb()
 #else
 #define war_io_reorder_wmb()		barrier()
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 3127391..cbac603 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
 #define __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
 
+#include <asm/cpu.h>
+
 /*
  * Override macros used in arch/mips/kernel/head.S.
  */
@@ -26,12 +28,15 @@
 	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
 	mtc0	t0, CP0_PAGEGRAIN
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
+	mfc0	t0, CP0_PRID
+	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
 	mtc0	t0, CP0_CONFIG6
-#endif
+1:
 	_ehb
 	.set	pop
 #endif
@@ -52,12 +57,15 @@
 	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
 	mtc0	t0, CP0_PAGEGRAIN
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
+	mfc0	t0, CP0_PRID
+	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
 	mtc0	t0, CP0_CONFIG6
-#endif
+1:
 	_ehb
 	.set	pop
 #endif
-- 
2.7.0
