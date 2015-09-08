Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Sep 2015 13:23:33 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37120 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007983AbbIHLXbwSa5F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Sep 2015 13:23:31 +0200
Received: by wicfx3 with SMTP id fx3so111091110wic.0
        for <linux-mips@linux-mips.org>; Tue, 08 Sep 2015 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rxRsHWgb5tZOKn1YqznVMrN7Ge855OGR0a+tjQm0Twc=;
        b=euCf6hcZuaQho1wyalhCP3ajA5FSwoLy1EeqlJ/RGZFHVIOkQXx6dNygugPCJLrf4B
         OjIJ/r3XbWfWjvLF/mQhvDQNnti06UZuFr/4awp/K2sNFHJpijhyxSDmtKox4eGlp0NK
         NdAdcKaDR16kZwMRPcIDFY14vcGfPdAuF5/JpNne+yNv1Y6AbFuS9/jvDonY4tKP7u7l
         Y9f7HjzXn2ff6FcTr5Omh2Vnggf6+IbXC6+2vcVG2SuFb0cWhJGicj3ovgaMqKmg+WJ/
         oiqXSazAbVLOGjmnflu/3LPqjyQKc1uOA8c0XC8DnqJuZxFEw4O42dZFjLd4YfwH2RZ5
         jUfQ==
X-Received: by 10.194.238.202 with SMTP id vm10mr37829463wjc.96.1441711406598;
        Tue, 08 Sep 2015 04:23:26 -0700 (PDT)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_00_007 (p200300874C064B5136E6D7FFFE14BFA6.dip0.t-ipconnect.de. [2003:87:4c06:4b51:36e6:d7ff:fe14:bfa6])
        by smtp.gmail.com with ESMTPSA id gt4sm5233589wib.21.2015.09.08.04.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Sep 2015 04:23:25 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH RFC] MIPS: allow boards to reserve per-device CMA memory
Date:   Tue,  8 Sep 2015 13:23:23 +0200
Message-Id: <1441711403-293318-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.5.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Add a hook which is called before the bootmem allocator is told about
CMA reserved memory, so that boards can register per-device CMA
areas with dma_declare_contiguous().
---
dma_declare_contiguous() doesn't work any other way (initcalls, ...).
Any other suggestions welcome!

The idea is to reserve 64mb in the upper 128mb for the lcd controller,
and 32mb in the lower 128mb for the video decoder.
In the plat_mem_setup() callback the board can set the plat_reserve_mem hook
to a void function which calls dma_declare_contiguous() or other CMA
functions.

Suggestions welcome!


 arch/mips/include/asm/bootinfo.h | 5 +++++
 arch/mips/kernel/setup.c         | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index b603804..1fc1f67 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -132,6 +132,11 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
  */
 extern void plat_mem_setup(void);
 
+/*
+ * optional hook to reserve CMA memory for devices
+ */
+extern void (*plat_reserve_mem)(void);
+
 #ifdef CONFIG_SWIOTLB
 /*
  * Optional platform hook to call swiotlb_setup().
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 35b8316..b55a9f3 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -38,6 +38,8 @@
 #include <asm/smp-ops.h>
 #include <asm/prom.h>
 
+extern void db1300_reserve_mem(void);
+
 struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
 
 EXPORT_SYMBOL(cpu_data);
@@ -71,6 +73,8 @@ char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
 #endif
 
+void (*plat_reserve_mem)(void) __initdata = NULL;
+
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
@@ -678,7 +682,12 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 	paging_init();
 
+	/* allocate default CMA area */
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+	/* allow platforms to reserve CMA memory for devices */
+	if (plat_reserve_mem)
+		plat_reserve_mem();
+	
 	/* Tell bootmem about cma reserved memblock section */
 	for_each_memblock(reserved, reg)
 		if (reg->size != 0)
-- 
2.5.1
