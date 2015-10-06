Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 18:23:34 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34146 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009658AbbJFQXcemMbN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 18:23:32 +0200
Received: by wicfx3 with SMTP id fx3so174701985wic.1
        for <linux-mips@linux-mips.org>; Tue, 06 Oct 2015 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o2yfR4FBf6T5WFEo/kizdtnzkX88/UXYZhZkOXCGwcc=;
        b=OCs7yN/8zUsvK5BvtO3gmrq2RKUFTTyEm2pj2EAIOJvxbpMhdQlFxdME1Cfyzpd8eZ
         FGsKao1Dww2K7EH1iGerZOJKoPp7biYbgnj3zjB4Dvdrsr8cN1bQVqm7wK2kgKCDo4eO
         NdG7U7FX+2VNduVZ6uOsD7aYNJsBtZkK+u7oOlcwvHOfbea3T+F1O4Je3V6ZufAORK5Q
         xyVnpT0T2UfEahz8FFynsvFsYr+oya9Z5fR/hzYzLqW+pCSATbLx5nyVZYCqwlbRmntB
         ANzSYXzvKaV48wg0/LLLFe1bmWduOzUvKVO3cy9wdkrdNgvHTfT3MKRU9doCgiq3PBmC
         B19A==
X-Received: by 10.180.184.134 with SMTP id eu6mr19726010wic.77.1444148606386;
        Tue, 06 Oct 2015 09:23:26 -0700 (PDT)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_00_007 (p200300874C091B9836E6D7FFFE14BFA6.dip0.t-ipconnect.de. [2003:87:4c09:1b98:36e6:d7ff:fe14:bfa6])
        by smtp.gmail.com with ESMTPSA id he3sm33485381wjc.48.2015.10.06.09.23.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Oct 2015 09:23:25 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/3] MIPS: add hook for platforms to register CMA memory
Date:   Tue,  6 Oct 2015 18:23:21 +0200
Message-Id: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.5.3
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49454
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

Add a hook which is called after MIPS CMA memory reservation
to allow platforms to register device-specific CMA areas.
I'm going to use this for the Au1200/Au1300 framebuffer initially.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested on Db1200/Db1300 and Db1500.  I found that this is the only
place in the initcall-chain where allocating CMA memory for devices
is actually possible on MIPS/Alchemy.

 arch/mips/include/asm/bootinfo.h | 5 +++++
 arch/mips/kernel/setup.c         | 7 +++++++
 2 files changed, 12 insertions(+)

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
index 35b8316..2b56885 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -71,6 +71,8 @@ char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
 #endif
 
+void (*plat_reserve_mem)(void) __initdata = NULL;
+
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
@@ -678,7 +680,12 @@ static void __init arch_mem_init(char **cmdline_p)
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
2.5.3
