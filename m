Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC7C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C239205C9
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976278;
	bh=nVAzZgs0SNtkJ2cIjRFA7VbheMUnrpNUxfIMlOmwMPI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D1GY5cnK/CQJDpjr3qtcZVZtM32FiseMcQUzsXZg/+C8QxT/VIcsRPvyNEavzhabd
	 uzuk5RqXYFKrcCn60bGaxSMoiSD9pi6QiBRyNNOB71ifjPexS5y6ULRqQ601P3J8mA
	 4JCC/uDXA13TAzAvhKKaKcfPL6fz+hJC2LH2NXMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfAHTfi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732281AbfAHTfh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 8 Jan 2019 14:35:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC9620645;
        Tue,  8 Jan 2019 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976136;
        bh=nVAzZgs0SNtkJ2cIjRFA7VbheMUnrpNUxfIMlOmwMPI=;
        h=From:To:Cc:Subject:Date:From;
        b=CaUw9Mdz9fWbaq6zr89HPeBYiKVXStVwRDr+VKDo1SH4fX/P6Sx2ILNzGf2hccWOY
         uTs5XaxXGjRt6/q+gwrm3+2ikat3I00Q6HgM5l2WZ8a4AJrvt+sSNdz4V2HH6MCIOo
         dR6awomwLqP90un3lxjt4YsTp87TdXV91eB6QqgE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 01/19] MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur
Date:   Tue,  8 Jan 2019 14:35:13 -0500
Message-Id: <20190108193534.124555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: "Maciej W. Rozycki" <macro@linux-mips.org>

[ Upstream commit e4849aff1e169b86c561738daf8ff020e9de1011 ]

The Broadcom SiByte BCM1250, BCM1125, and BCM1125H SOCs have an onchip
DRAM controller that supports memory amounts of up to 16GiB, and due to
how the address decoder has been wired in the SOC any memory beyond 1GiB
is actually mapped starting from 4GiB physical up, that is beyond the
32-bit addressable limit[1].  Consequently if the maximum amount of
memory has been installed, then it will span up to 19GiB.

Many of the evaluation boards we support that are based on one of these
SOCs have their memory soldered and the amount present fits in the
32-bit address range.  The BCM91250A SWARM board however has actual DIMM
slots and accepts, depending on the peripherals revision of the SOC, up
to 4GiB or 8GiB of memory in commercially available JEDEC modules[2].
I believe this is also the case with the BCM91250C2 LittleSur board.
This means that up to either 3GiB or 7GiB of memory requires 64-bit
addressing to access.

I believe the BCM91480B BigSur board, which has the BCM1480 SOC instead,
accepts at least as much memory, although I have no documentation or
actual hardware available to verify that.

Both systems have PCI slots installed for use by any PCI option boards,
including ones that only support 32-bit addressing (additionally the
32-bit PCI host bridge of the BCM1250, BCM1125, and BCM1125H SOCs limits
addressing to 32-bits), and there is no IOMMU available.  Therefore for
PCI DMA to work in the presence of memory beyond enable swiotlb for the
affected systems.

All the other SOC onchip DMA devices use 40-bit addressing and therefore
can address the whole memory, so only enable swiotlb if PCI support and
support for DMA beyond 4GiB have been both enabled in the configuration
of the kernel.

This shows up as follows:

Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
Board type: SiByte BCM91250A (SWARM)
Determined physical RAM map:
 memory: 000000000fe7fe00 @ 0000000000000000 (usable)
 memory: 000000001ffffe00 @ 0000000080000000 (usable)
 memory: 000000000ffffe00 @ 00000000c0000000 (usable)
 memory: 0000000087fffe00 @ 0000000100000000 (usable)
software IO TLB: mapped [mem 0xcbffc000-0xcfffc000] (64MB)

in the bootstrap log and removes failures like these:

defxx 0000:02:00.0: dma_direct_map_page: overflow 0x0000000185bc6080+4608 of device mask ffffffff bus mask 0
fddi0: Receive buffer allocation failed
fddi0: Adapter open failed!
IP-Config: Failed to open fddi0
defxx 0000:09:08.0: dma_direct_map_page: overflow 0x0000000185bc6080+4608 of device mask ffffffff bus mask 0
fddi1: Receive buffer allocation failed
fddi1: Adapter open failed!
IP-Config: Failed to open fddi1

when memory beyond 4GiB is handed out to devices that can only do 32-bit
addressing.

This updates commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need
DMA32.").

References:

[1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R,
    Broadcom Corporation, 21 Oct 2002, Section 3: "System Overview",
    "Memory Map", pp. 34-38

[2] "BCM91250A User Manual", Revision 91250A-UM100-R, Broadcom
    Corporation, 18 May 2004, Section 3: "Physical Description",
    "Supported DRAM", p. 23

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
[paul.burton@mips.com: Remove GPL text from dma.c; SPDX tag covers it]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Patchwork: https://patchwork.linux-mips.org/patch/21108/
References: cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need DMA32.")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig                |  3 +++
 arch/mips/sibyte/common/Makefile |  1 +
 arch/mips/sibyte/common/dma.c    | 14 ++++++++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/mips/sibyte/common/dma.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9536ef912f59..077ae203e8f9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -627,6 +627,7 @@ config SIBYTE_SWARM
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ZONE_DMA32 if 64BIT
+	select SWIOTLB if ARCH_DMA_ADDR_T_64BIT && PCI
 
 config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
@@ -649,6 +650,7 @@ config SIBYTE_SENTOSA
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SWIOTLB if ARCH_DMA_ADDR_T_64BIT && PCI
 
 config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
@@ -662,6 +664,7 @@ config SIBYTE_BIGSUR
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ZONE_DMA32 if 64BIT
+	select SWIOTLB if ARCH_DMA_ADDR_T_64BIT && PCI
 
 config SNI_RM
 	bool "SNI RM200/300/400"
diff --git a/arch/mips/sibyte/common/Makefile b/arch/mips/sibyte/common/Makefile
index b3d6bf23a662..3ef3fb658136 100644
--- a/arch/mips/sibyte/common/Makefile
+++ b/arch/mips/sibyte/common/Makefile
@@ -1,4 +1,5 @@
 obj-y := cfe.o
+obj-$(CONFIG_SWIOTLB)			+= dma.o
 obj-$(CONFIG_SIBYTE_BUS_WATCHER)	+= bus_watcher.o
 obj-$(CONFIG_SIBYTE_CFE_CONSOLE)	+= cfe_console.o
 obj-$(CONFIG_SIBYTE_TBPROF)		+= sb_tbprof.o
diff --git a/arch/mips/sibyte/common/dma.c b/arch/mips/sibyte/common/dma.c
new file mode 100644
index 000000000000..eb47a94f3583
--- /dev/null
+++ b/arch/mips/sibyte/common/dma.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *	DMA support for Broadcom SiByte platforms.
+ *
+ *	Copyright (c) 2018  Maciej W. Rozycki
+ */
+
+#include <linux/swiotlb.h>
+#include <asm/bootinfo.h>
+
+void __init plat_swiotlb_setup(void)
+{
+	swiotlb_init(1);
+}
-- 
2.19.1

