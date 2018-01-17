Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:23:57 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:33950
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994687AbeAQWX0Jiy00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:26 +0100
Received: by mail-lf0-x244.google.com with SMTP id k19so3753832lfj.1;
        Wed, 17 Jan 2018 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2M7+z/0EjwG5RRvAAVYNt5qqFya9+AQbqsCksVfWNU=;
        b=kNJ7LKx2V1ZcBUNdI4GmBZNJoBtqHpAJ184PNpNLC7QfFy6EWr0/Bixuwpo/50QMIZ
         zatq0Nb5dvRMIR8EyI2t8rTbSoT8oYsXY9uyJZ0TMZVjSYDS/jbBwWvUUDdmKKKgKBWR
         PcjvI67Am7Ty6Y2xT8CC980FuFnIfszUAB3A6XwEU5OV4pcZ6Jt6qAzUOvlnBCmALN3P
         13SeMOAC2Wk/Qd7DdwTLInFg/gZ+h/Q+OMnPcuy1ohy6lWaFeSgxef8C4b5gUwo29uZC
         pXTkeCREI3ZQUTO2n4gtnVa4cMeo2aCjj8riFAmp5VIzVdwrKViHF+Jkzho/h5bmWn7L
         YKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2M7+z/0EjwG5RRvAAVYNt5qqFya9+AQbqsCksVfWNU=;
        b=etpzWCR16u/emeULjqI7Tc2nL3LhSDLA3LdQptLMC9DaQw25KjUSNwZIxZw+6pDkVq
         hBT2yeW+mnxfVeRTWWwzGWIA/wuxwbBYMp221JCnzZz0LhcizFtt0Ex9b+0hNZNeDrIp
         A1Lxqi/LB3tb82WR3RTKyG1Lzi7xvh9B1w8u05GFJ6b2fdcrjUiBe+1HWJBty09F6Ui+
         /R1G0Rk5O1b4iT9GyaEFqCuem/gDGTskc7CtxAs3ui9hcVMhYPEvP0tkBWz4InFQ4VPc
         SHzHh5XaLhTb1WxkqyxtArVyn4fYktq6Rr5b4xGzPywNca3K+xOihhhETjj30hkYhsRw
         V8aQ==
X-Gm-Message-State: AKwxytfUWegUbyVWNk85nJDj8dAEvgQ/RrXK/hiHMR1TpPekWm6KhQ5U
        YfFAUHW+8N76FGrkPhf6NHz72B86
X-Google-Smtp-Source: ACJfBosY35YkA7+73et8hVhrB4SWZpS6SX9B6kOuoYunBcEowghefAVrFmkO+Y8h933DYP3JNuVI+A==
X-Received: by 10.46.34.67 with SMTP id i64mr1321048lji.108.1516227800378;
        Wed, 17 Jan 2018 14:23:20 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:19 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 01/14] MIPS: memblock: Add RESERVED_NOMAP memory flag
Date:   Thu, 18 Jan 2018 01:22:59 +0300
Message-Id: <20180117222312.14763-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Even if nomap flag is specified the reserved memory declared in dts
isn't really discarded from the buddy allocator in the current code.
We'll fix it by adding the no-map MIPS memory flag. Additionally
lets add the RESERVED_NOMAP memory regions handling to the methods,
which aren't going to be changed in the further patches.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/include/asm/bootinfo.h | 1 +
 arch/mips/kernel/prom.c          | 8 ++++++--
 arch/mips/kernel/setup.c         | 8 ++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index b603804ca..f7be3148a 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -90,6 +90,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
 #define BOOT_MEM_INIT_RAM	4
+#define BOOT_MEM_RESERVED_NOMAP	5
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 0dbcd152a..b123eb827 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -41,7 +41,7 @@ char *mips_get_machine_name(void)
 #ifdef CONFIG_USE_OF
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	return add_memory_region(base, size, BOOT_MEM_RAM);
+	add_memory_region(base, size, BOOT_MEM_RAM);
 }
 
 void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
@@ -52,7 +52,11 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
-	add_memory_region(base, size, BOOT_MEM_RESERVED);
+	if (!nomap)
+		add_memory_region(base, size, BOOT_MEM_RESERVED);
+	else
+		add_memory_region(base, size, BOOT_MEM_RESERVED_NOMAP);
+
 	return 0;
 }
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4020d8f98..76e9e2075 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -172,6 +172,7 @@ bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
 				in_ram = true;
 			break;
 		case BOOT_MEM_RESERVED:
+		case BOOT_MEM_RESERVED_NOMAP:
 			if ((start >= start_ && start < end_) ||
 			    (start < start_ && start + size >= start_))
 				free = false;
@@ -207,6 +208,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_RESERVED:
 			printk(KERN_CONT "(reserved)\n");
 			break;
+		case BOOT_MEM_RESERVED_NOMAP:
+			printk(KERN_CONT "(reserved nomap)\n");
+			break;
 		default:
 			printk(KERN_CONT "type %lu\n", boot_mem_map.map[i].type);
 			break;
@@ -955,9 +969,13 @@ static void __init resource_init(void)
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
+		case BOOT_MEM_RESERVED_NOMAP:
+			res->name = "reserved nomap";
+			break;
 		case BOOT_MEM_RESERVED:
 		default:
 			res->name = "reserved";
+			break;
 		}
 
 		request_resource(&iomem_resource, res);
-- 
2.12.0
