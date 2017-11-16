Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 09:35:03 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:47846
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKPIe5U00VE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 09:34:57 +0100
Received: by mail-pf0-x244.google.com with SMTP id t69so10132846pfg.4;
        Thu, 16 Nov 2017 00:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Em0Yhm0onPFNWZnvQiQp8xG8ifdEBoR+pa17B7X4o1c=;
        b=iU3JL/L0MqEeS2PV3jBZqRF0cv418EcoCcuGJV/FEX1hjvAlBfhPtmP7GIVjKY7Y2o
         xit10rz34d1HISdsVherXEMUfgZ8uqzEssc/eSiUdi8NmvfIFXYVZMfK96StokwXZyar
         hQ9KR9u4/iDUrT1SXHSOOx0YaRVTxsWPcrXQVL49BQ1IjSnGKwS1eI/+IgXpwJoVU11P
         cvaU9R3vGwmH9Iq1NjcYWGbvPEFutb08p+B8x54XIytOM9FnzUKnopYPSlm7Rj0XqNAR
         kxdqAEtMMO2yU6UtvK5oH6sfYLovI+0IDVyYm3ZAq0B2EYglSsph6skZQohZOIUBVjNz
         EIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Em0Yhm0onPFNWZnvQiQp8xG8ifdEBoR+pa17B7X4o1c=;
        b=uW2NgcGNt5OTQDSXYMkeowIFYyzC/BOJf660O6ak/kC8PtzX4zLDkV8tSRQ9bIh+cH
         jxdNtETA4rgHdLOEP+bs2f4aHpHZpUwFQnYklsZ23lUXGN4TKlKdzgLBDLZVfHuIusV8
         7TAUuuK9MJmiewfc2psfJCqhvXudazaSLXn7laBnnM6IfSUdO46O3snTxiHn0h8P8QJ8
         Mm3ZlzE/ngq6pxSgete566j+3a3ovt6YalWKMFoXZFzvDcG2Ru8mK2j6AL25/TtzAPsE
         yaVHrET1mpAEx6QJA+m/ypEgDh+hoDgvGtereGzekMtaEmZQEJs0phTnjPf709JOAhgW
         VKMw==
X-Gm-Message-State: AJaThX6usnlVoInGprRtDoOf0oXfxW6SnMIvEO1aMMtfAAPE1Ub0xfoF
        TDV8AxZJLsIwgPOv/LNb4WwlkQ==
X-Google-Smtp-Source: AGs4zMYGN6udoBZoZ0vm3YHTsffBSvC7Lc6NNEDgXWICedLIJqPeSiMb2F3VgcAv1cAAf15A4g1cmw==
X-Received: by 10.98.196.155 with SMTP id h27mr1016601pfk.137.1510821290755;
        Thu, 16 Nov 2017 00:34:50 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 73sm1875218pfr.145.2017.11.16.00.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 00:34:49 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <James.Hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        YunQiang Su <yunqiang.su@imgtec.com>
Subject: [PATCH 1/2] MIPS: Loongson fix name confict - MEM_RESERVED
Date:   Thu, 16 Nov 2017 16:35:04 +0800
Message-Id: <1510821304-24626-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60972
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
