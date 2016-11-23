Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:45:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12664 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993032AbcKWNoFId3xG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2DCFA436D0FEE;
        Wed, 23 Nov 2016 13:43:56 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:43:59 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 04/10] MIPS: use early_init_fdt_reserve_self to protect DTB location
Date:   Wed, 23 Nov 2016 14:43:46 +0100
Message-ID: <1479908632-30392-5-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

early_init_fdt_reserve_self is used to tell the boot memory allocator
that a memory is occupied by the DTB, so add it in the MIPS init code to
ensure information about the DTB is added to the boot memory array.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/prom.c  | 7 +++++++
 arch/mips/kernel/setup.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 5fcec30..0dbcd15 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -49,6 +49,13 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 	return __alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS));
 }
 
+int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
+					phys_addr_t size, bool nomap)
+{
+	add_memory_region(base, size, BOOT_MEM_RESERVED);
+	return 0;
+}
+
 void __init __dt_setup_arch(void *bph)
 {
 	if (!early_init_dt_scan(bph))
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 64b38d4..c22f0fd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -27,6 +27,7 @@
 #include <linux/device.h>
 #include <linux/dma-contiguous.h>
 #include <linux/decompress/generic.h>
+#include <linux/of_fdt.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -832,6 +833,9 @@ static void __init arch_mem_init(char **cmdline_p)
 		print_memory_map();
 	}
 
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+
 	bootmem_init();
 #ifdef CONFIG_PROC_VMCORE
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
-- 
2.7.4
