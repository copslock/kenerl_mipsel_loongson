Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:20:10 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:34100
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeA0DUCvT80B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:20:02 +0100
Received: by mail-pg0-x242.google.com with SMTP id r19so1379826pgn.1;
        Fri, 26 Jan 2018 19:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+VlLtDGzTzOSbw9NC9vsk1vyDxlC8AEWgbAr1Yj+oM=;
        b=P/4KNaRyaaCTCiZ9h6sp3YdkPiuyTMFoChmAE6p4kRCpX9g7rL7jskJpdO8tV6q5Aw
         iASLks2jvab8zZrdcT/W9sdzOMbTX8TG+wlMXGSXHHWhT6N9kv/2/hNuXqMZ68z+7GP5
         6+O5IK8l/0RtbPp8tLPRudnn/f5KhQxX6x4WqGlv8b8pcKWL4gtj0cXDSFsup0AXSvOT
         ABVs1MGg/rEpU4HN7VTzUJMT8B9aQjYyY61DpRPl13SR6w7cAonX3m81gRMJ79iVFqzJ
         Q1sCkqU8jqgP8sZIIFBZEkuuZc/zX7t/+tIeaaJGhrnk36JJcFLrkdpPVzIZVMq4dqJS
         yk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x+VlLtDGzTzOSbw9NC9vsk1vyDxlC8AEWgbAr1Yj+oM=;
        b=YsS2p6eeb8wOHEzMJMyAi9TN3HWQIDx76F1PA0mjdHK77jZdJDx5q/TfYyGMTtzqxc
         /+q75mE3DnWJFmP22hM4BKUPXOreNBxDrpoON3jAiDs5kvaC2egp4FbGXe+8tVuftBvv
         epXi2fNxxxY3hXDL1BX/Ocuua1d0AG0MdInLPbrnEvw3jinfHPT5LKc7I7cqDtRLxlmo
         j3eE9IUmdGQ3CLRu+HB0FehL1mnl0wCjDgwjnYa9xm222rfuNoLvLfP0X7gU+2i4t2Z5
         rf3I6UDVCQHjkrrom0Ihz/WOxyYe7suWHaa9vQiFeSJo/9pEyS9/Zoy/ZgNSWEK09UOS
         TtCA==
X-Gm-Message-State: AKwxytdjMMS4GJN+RMg+XwFpxNuPPbj6AWl2LDoATsnUeTAFSCGO3V9n
        Mr9F40lFkH+dm2p6mvc3bggvtA==
X-Google-Smtp-Source: AH8x2265fjT9NVeyqYgg5M1GY3/19SFYPmLyI095pUwRNV+MXcI+jongErRRedDL2CT9MMfMujLerA==
X-Received: by 10.98.192.134 with SMTP id g6mr20799833pfk.91.1517023194457;
        Fri, 26 Jan 2018 19:19:54 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id c184sm21448274pfg.57.2018.01.26.19.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:19:53 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 15+" <stable@vger.kernel.org>,
        YunQiang Su <yunqiang.su@imgtec.com>
Subject: [PATCH V2 05/12] MIPS: Loongson fix name confict - MEM_RESERVED
Date:   Sat, 27 Jan 2018 11:20:17 +0800
Message-Id: <1517023217-17479-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62348
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

MEM_RESERVED is used as a value of enum mem_type in include/linux/
edac.h. This will make failure to build for Loongson in some case:
for example with CONFIG_RAS enabled.

So here rename MEM_RESERVED to SYSTEM_RAM_RESERVED in Loongson code.

Cc: <stable@vger.kernel.org> # 3.15+
Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: YunQiang Su <yunqiang.su@imgtec.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/boot_param.h | 2 +-
 arch/mips/loongson64/common/mem.c                  | 2 +-
 arch/mips/loongson64/loongson-3/numa.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 4f69f08..8c286be 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -4,7 +4,7 @@
 
 #define SYSTEM_RAM_LOW		1
 #define SYSTEM_RAM_HIGH		2
-#define MEM_RESERVED		3
+#define SYSTEM_RAM_RESERVED	3
 #define PCI_IO			4
 #define PCI_MEM			5
 #define LOONGSON_CFG_REG	6
diff --git a/arch/mips/loongson64/common/mem.c b/arch/mips/loongson64/common/mem.c
index b01d524..c549e52 100644
--- a/arch/mips/loongson64/common/mem.c
+++ b/arch/mips/loongson64/common/mem.c
@@ -79,7 +79,7 @@ void __init prom_init_memory(void)
 					(u64)loongson_memmap->map[i].mem_size << 20,
 					BOOT_MEM_RAM);
 				break;
-			case MEM_RESERVED:
+			case SYSTEM_RAM_RESERVED:
 				add_memory_region(loongson_memmap->map[i].mem_start,
 					(u64)loongson_memmap->map[i].mem_size << 20,
 					BOOT_MEM_RESERVED);
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index f17ef52..9717106 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -166,7 +166,7 @@ static void __init szmem(unsigned int node)
 			memblock_add_node(PFN_PHYS(start_pfn),
 				PFN_PHYS(end_pfn - start_pfn), node);
 			break;
-		case MEM_RESERVED:
+		case SYSTEM_RAM_RESERVED:
 			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
 				(u32)node_id, mem_type, mem_start, mem_size);
 			add_memory_region((node_id << 44) + mem_start,
-- 
2.7.0
