Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 14:44:57 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:38752
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992993AbdHMMoud0CwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 14:44:50 +0200
Received: by mail-pg0-x241.google.com with SMTP id 123so6614573pga.5
        for <linux-mips@linux-mips.org>; Sun, 13 Aug 2017 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=m4f8i4cRa2PckJ7cddJToF68QjxiXvEpz+oXzWca2Pg=;
        b=TiemjIneIXo1sEUAvzwRe9cuNtotWGkdQjC/+ujHQltMeSdSftSPP6kaDNtHADBS+Y
         aq/eXLBlkvuBmiRQTdkMppGKC7djnDDLyKNSex/7utotHO5gfYJsgJ7ta+tNsm+JRuux
         ezAiaw0qBP6/lWST4zY5nD8MC/reKV+v6WZlAnSV0xNOEwbyGiUafHqtUWbY9WOcltIE
         H8K4ldq+tyfKluxUrBV9Us2ma556Hq3TcrG97AQexXfyjGp4MyNPunxh4hfQwcJB7rSY
         xNLhrUe9R5xbXctvI7I0fgji+q5wpotUe4GKbXvXrZlc3WJIElDIzOohozCStRx76LoV
         8qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=m4f8i4cRa2PckJ7cddJToF68QjxiXvEpz+oXzWca2Pg=;
        b=DlyzqLZy8mAOWMKMJhUcAtJhb7JFJwmB7NygMhAwj6od2Z2wNSkNJs030lqrtNiA4m
         vtYVus1uRJdck1Ai6keFwtYBhteFin4nTKSyxJm3NhJucxnu+TucYkE2EOGjSmWTE2oH
         sX7SR5xtKQdWy7aRdHWa9jhN4qiCaHIBG+UE9j44f7PQmAi0HT0Gml+BELF0DzU3DI88
         AriwF9GBVb3A3RBx76q1kYRkdy1wiBH9UIMuZ/cuYbIqUvv9JN43bHNbXTZTuZ2TWsVG
         YY+tOTvCt/j0S5QhEyGgQs4lT63pwbxuCeJ0SjpYYkhTZiZaxaNXwEXHlmQ21ri4XEEj
         B8IA==
X-Gm-Message-State: AHYfb5h9P7ycpzRNZicaokGNwbHBbmgcUMaJ664Uk3bctV8giyMeLTi1
        hzOJFmy6qMYDD2jUZac=
X-Received: by 10.84.216.76 with SMTP id f12mr24142108plj.219.1502628284304;
        Sun, 13 Aug 2017 05:44:44 -0700 (PDT)
Received: from localhost ([2001:250:218:3698:197c:9ad4:86ff:7ab1])
        by smtp.gmail.com with ESMTPSA id j71sm10097698pfj.44.2017.08.13.05.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Aug 2017 05:44:43 -0700 (PDT)
From:   YunQiang Su <syq@debian.org>
To:     linux-mips@linux-mips.org
Cc:     YunQiang Su <yunqiang.su@imgtec.com>
Subject: [PATCH] MIPS: Loongson fix name confict - MEM_RESERVED
Date:   Sun, 13 Aug 2017 20:44:35 +0800
Message-Id: <20170813124435.24684-1-syq@debian.org>
X-Mailer: git-send-email 2.14.1
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: syq@debian.org
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

From: YunQiang Su <yunqiang.su@imgtec.com>

MEM_RESERVED is used as a value of enum mem_type in
include/linux/edac.h.
This will make failure to build for Loongson in some case:
for example with CONFIG_RAS enabled.

So here rename MEM_RESERVED to LOONGSON_MEM_RESERVED in Loongson code.
---
 arch/mips/include/asm/mach-loongson64/boot_param.h | 2 +-
 arch/mips/loongson64/common/mem.c                  | 2 +-
 arch/mips/loongson64/loongson-3/numa.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 9f9bb9c53785..595a949e5f47 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -3,7 +3,7 @@
 
 #define SYSTEM_RAM_LOW		1
 #define SYSTEM_RAM_HIGH		2
-#define MEM_RESERVED		3
+#define LOONGSON_MEM_RESERVED		3
 #define PCI_IO			4
 #define PCI_MEM			5
 #define LOONGSON_CFG_REG	6
diff --git a/arch/mips/loongson64/common/mem.c b/arch/mips/loongson64/common/mem.c
index b01d52473da8..6c97dbe2cb85 100644
--- a/arch/mips/loongson64/common/mem.c
+++ b/arch/mips/loongson64/common/mem.c
@@ -79,7 +79,7 @@ void __init prom_init_memory(void)
 					(u64)loongson_memmap->map[i].mem_size << 20,
 					BOOT_MEM_RAM);
 				break;
-			case MEM_RESERVED:
+			case LOONGSON_MEM_RESERVED:
 				add_memory_region(loongson_memmap->map[i].mem_start,
 					(u64)loongson_memmap->map[i].mem_size << 20,
 					BOOT_MEM_RESERVED);
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index f17ef520799a..3ceb401f7691 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -166,7 +166,7 @@ static void __init szmem(unsigned int node)
 			memblock_add_node(PFN_PHYS(start_pfn),
 				PFN_PHYS(end_pfn - start_pfn), node);
 			break;
-		case MEM_RESERVED:
+		case LOONGSON_MEM_RESERVED:
 			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
 				(u32)node_id, mem_type, mem_start, mem_size);
 			add_memory_region((node_id << 44) + mem_start,
-- 
2.14.1
