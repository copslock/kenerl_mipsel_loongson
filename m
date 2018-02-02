Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:55:41 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:36135
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeBBDzKMzLa0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:10 +0100
Received: by mail-lf0-x244.google.com with SMTP id t79so29462342lfe.3;
        Thu, 01 Feb 2018 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlG27HYMwmIrMhIPeGAWGzcitm8COM+vcpBP6m7eSz4=;
        b=jFsbnoXIkKqt8CSps4s8KWpGIlS+m2nqWBB7QjH17tvPKU+WdWFvfczqbf/quE03Uw
         HcfCzp7e77vub5N0AJK7YiizUkiWHL57rS4VxSytS5MwqrCq43hI/MwUw0SZxZ85Veie
         xEGaW7MmYWTOndvLeC25fd2gcyc5ESwm545twCAkPvCXvwRzknAiMScNZVy0O7gucgP7
         Nvog/12NRKEm39+ozzaQ8CYFn/Zp7MwLEEPHSh1tSDNqObJXlgCZRLpROPrZVnmFIXKa
         kI+xLarJ3SY7jLICdT0c8dFp9udV335qQC00ZGYNzjKwInSx60MX6PtRZgxYzSJ0OHEV
         GoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlG27HYMwmIrMhIPeGAWGzcitm8COM+vcpBP6m7eSz4=;
        b=lZiNfxgQgDKzuuWXDjDZiPgUa89tOBiNZRI8b5OQxOawxU/NLqpQAAcrQZ65gvmsNt
         l4fjLcaxMdcwvjy+qwCJEG8vD2ukMFT8qT3JLHARryF1/HlffDKpSaFsvXg3bswxhple
         C9MqT/5Odf1ghLnLfpW9YfUjHhKMcRK32dfFw2GZOq4wXh+zeXC5KALjJ0cTm3V/I0mZ
         u5fmk/zo2a0ewnFYRNNkhKyCyV1gCkFtQq5SZkkdP53p/e0M84TaredNYq6lL0Rl7mMI
         f1Cthio71jXQ9I94WPtgx+33HFnsGgSJQOhkH6Z6SSfG1mjwII0r8QRdxyKpoe1l60/T
         3UlA==
X-Gm-Message-State: AKwxytehZndxOpX65FuJT+dz/o+NGqKIHTK4zB/JmI8v4fdnWJUZluBI
        3dBqibLOf1AyVr3nrs5Bp35mF9Fz
X-Google-Smtp-Source: AH8x224WYVT19Yp4McHdbCsAsTbv8a3F5ZzMARLgIgtQ3Gl0E5MiizOHg3YYasumFha7nPe+D7GhzA==
X-Received: by 10.25.92.13 with SMTP id q13mr22217334lfb.69.1517543704511;
        Thu, 01 Feb 2018 19:55:04 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:03 -0800 (PST)
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
Subject: [PATCH v2 01/15] MIPS: memblock: Add RESERVED_NOMAP memory flag
Date:   Fri,  2 Feb 2018 06:54:44 +0300
Message-Id: <20180202035458.30456-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62408
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
index e26a093bb17a..276618b5319d 100644
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
index 0dbcd152a1a9..b123eb8279cd 100644
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
index 702c678de116..1a4d64410303 100644
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
@@ -955,9 +959,13 @@ static void __init resource_init(void)
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
