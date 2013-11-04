Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2013 13:14:38 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:4117 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817664Ab3KDMObo5xI1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Nov 2013 13:14:31 +0100
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 04 Nov 2013 04:13:46 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 4 Nov 2013 04:14:09 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 4 Nov 2013 04:14:09 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 55C8C246A3; Mon, 4
 Nov 2013 04:14:08 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     robherring2@gmail.com, "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH] MIPS: Netlogic: replace early_init_devtree() call
Date:   Mon, 4 Nov 2013 17:51:54 +0530
Message-ID: <1383567714-5164-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20131031154816.GX25884@linux-mips.org>
References: <20131031154816.GX25884@linux-mips.org>
MIME-Version: 1.0
X-WSS-ID: 7E6950F04RS4506895-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The early_init_devtree() API was removed in linux-next for 3.13 with
commit "mips: use early_init_dt_scan". This causes Netlogic XLP compile
to fail:

arch/mips/netlogic/xlp/setup.c:101: undefined reference to `early_init_devtree'

Add xlp_early_init_devtree() which uses the __dt_setup_arch() to
handle early device tree related initialization to fix this.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    1 +
 arch/mips/netlogic/xlp/dt.c                  |   18 ++++++++++++++----
 arch/mips/netlogic/xlp/setup.c               |    2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 17daffb2..470f209 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -69,6 +69,7 @@ void nlm_hal_init(void);
 int xlp_get_dram_map(int n, uint64_t *dram_map);
 
 /* Device tree related */
+void xlp_early_init_devtree(void);
 void *xlp_dt_init(void *fdtp);
 
 static inline int cpu_is_xlpii(void)
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 88df445..8316d54 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -39,8 +39,11 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 
+#include <asm/prom.h>
+
 extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[],
 	__dtb_xlp_fvp_begin[], __dtb_start[];
+static void *xlp_fdt_blob;
 
 void __init *xlp_dt_init(void *fdtp)
 {
@@ -67,19 +70,26 @@ void __init *xlp_dt_init(void *fdtp)
 			break;
 		}
 	}
-	initial_boot_params = fdtp;
+	xlp_fdt_blob = fdtp;
 	return fdtp;
 }
 
+void __init xlp_early_init_devtree(void)
+{
+	__dt_setup_arch(xlp_fdt_blob);
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+}
+
 void __init device_tree_init(void)
 {
 	unsigned long base, size;
+	struct boot_param_header *fdtp = xlp_fdt_blob;
 
-	if (!initial_boot_params)
+	if (!fdtp)
 		return;
 
-	base = virt_to_phys((void *)initial_boot_params);
-	size = be32_to_cpu(initial_boot_params->totalsize);
+	base = virt_to_phys(fdtp);
+	size = be32_to_cpu(fdtp->totalsize);
 
 	/* Before we do anything, lets reserve the dt blob */
 	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 76a7131..6d981bb 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -98,7 +98,7 @@ void __init plat_mem_setup(void)
 	pm_power_off	= nlm_linux_exit;
 
 	/* memory and bootargs from DT */
-	early_init_devtree(initial_boot_params);
+	xlp_early_init_devtree();
 
 	if (boot_mem_map.nr_map == 0) {
 		pr_info("Using DRAM BARs for memory map.\n");
-- 
1.7.9.5
