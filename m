Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:50:12 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35916 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024612AbcCAAsex85b8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:34 +0100
Received: by mail-pa0-f66.google.com with SMTP id a7so8101938pax.3;
        Mon, 29 Feb 2016 16:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3wzFWg67ansCHzuX5mhDvGo/vtvLp0r2OZLH+B40fA=;
        b=b/FWUbcOshe3tawfAWHWsEoY+JTcLZgz2jsW8ZaM6ezlt3D1a0JtF5T6v2CVZqNmXm
         HAFrfTy/1IgK4opB9qT8fYfV+xFECDUPJmojy9USypTveEFyTHTzVb04fxmkIIAlD9Ss
         wK4he6mnMeLzqirMRiFSOyYGb9RKeOO82hux10m2wbMgRYlLNiGD3NLJszBj/4J5PRZq
         oolKFlG1syPMhuPPmNl8ON5w8djCoeJzGHyVzNCxBOnLlVzll4cStD2n2JWpaiDfOCyA
         HAT/6Cre/Mixjc/H5BigUZX0BQ7rT44hX80q7x+ey+iZCR9qZnUmc2tV1YDT1qnBpqhc
         XQxw==
X-Gm-Message-State: AD7BkJLEKt8Zj1AdPUp1/m6nwykiC93tIeS/inK/mAV2PA438lfwV9szRrtO8tpy1dzOzw==
X-Received: by 10.66.163.40 with SMTP id yf8mr25778159pab.148.1456793309263;
        Mon, 29 Feb 2016 16:48:29 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:28 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 7/8] MIPS: Loongson-1A: Enable SPARSEMEN and HIGHMEM
Date:   Tue,  1 Mar 2016 08:48:15 +0800
Message-Id: <1456793296-17120-8-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/sparsemem.h   | 6 +++++-
 arch/mips/loongson32/Kconfig        | 1 +
 arch/mips/loongson32/common/setup.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
index b1071c1..f73e671 100644
--- a/arch/mips/include/asm/sparsemem.h
+++ b/arch/mips/include/asm/sparsemem.h
@@ -11,7 +11,11 @@
 #else
 # define SECTION_SIZE_BITS	28
 #endif
-#define MAX_PHYSMEM_BITS	48
+#ifdef CONFIG_64BIT
+# define MAX_PHYSMEM_BITS	48
+#else
+# define MAX_PHYSMEM_BITS	36
+#endif
 
 #endif /* CONFIG_SPARSEMEM */
 #endif /* _MIPS_SPARSEMEM_H */
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 741867c..5a96672 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -11,6 +11,7 @@ config LOONGSON1_LS1A
 	bool "Loongson LS1A board"
 	select CEVT_R4K
 	select CSRC_R4K
+	select ARCH_SPARSEMEM_ENABLE
 	select SYS_HAS_CPU_LOONGSON1A
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 87d21c9..d764fae 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -48,7 +48,8 @@ void __init plat_mem_setup(void)
 		.orig_video_points	= 16,
 	};
 #endif
-	add_memory_region(0x20000000, 0x30000000, BOOT_MEM_RESERVED);
+	if (highmemsize > 0)
+		add_memory_region(0x50000000, highmemsize << 20, BOOT_MEM_RAM);
 #endif
 }
 
-- 
1.9.1
