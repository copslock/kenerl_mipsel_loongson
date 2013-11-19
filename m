Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 12:12:46 +0100 (CET)
Received: from gerard.telenet-ops.be ([195.130.132.48]:38056 "EHLO
        gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822318Ab3KSLMnZcMdc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Nov 2013 12:12:43 +0100
Received: from ayla.of.borg ([84.193.72.141])
        by gerard.telenet-ops.be with bizsmtp
        id rPCi1m00q32ts5g0HPCirs; Tue, 19 Nov 2013 12:12:42 +0100
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1VijEY-00076j-2S; Tue, 19 Nov 2013 12:12:42 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rob Herring <rob.herring@calxeda.com>
Cc:     devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 7/9] mips: Use NULL as the default DTB
Date:   Tue, 19 Nov 2013 12:12:32 +0100
Message-Id: <1384859554-27268-7-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com>
 <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

early_init_dt_scan() now takes care of falling back to the built-in DTB.

On Netlogic XLP, use initial_boot_params in device_tree_init(), like
the other MIPS sub-platforms do, as xlp_fdt_blob will now be NULL when
using the default built-in DTB.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/prom.c           |    2 +-
 arch/mips/mti-sead3/sead3-setup.c |    2 +-
 arch/mips/netlogic/xlp/dt.c       |    8 +++-----
 arch/mips/ralink/of.c             |    2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 19686c5bc5ed..582f6e4a5f6d 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -71,7 +71,7 @@ void __init plat_mem_setup(void)
 	 * Load the builtin devicetree. This causes the chosen node to be
 	 * parsed resulting in our memory appearing
 	 */
-	__dt_setup_arch(&__dtb_start);
+	__dt_setup_arch(NULL);
 }
 
 void __init device_tree_init(void)
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index 928ba84c8a78..3afec4507ea5 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -25,7 +25,7 @@ void __init plat_mem_setup(void)
 	 * Load the builtin devicetree. This causes the chosen node to be
 	 * parsed resulting in our memory appearing
 	 */
-	__dt_setup_arch(&__dtb_start);
+	__dt_setup_arch(NULL);
 }
 
 void __init device_tree_init(void)
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 87250f378386..e52281b9214d 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -66,7 +66,6 @@ void __init *xlp_dt_init(void *fdtp)
 #endif
 		default:
 			/* Pick a built-in if any, and hope for the best */
-			fdtp = &__dtb_start;
 			break;
 		}
 	}
@@ -83,13 +82,12 @@ void __init xlp_early_init_devtree(void)
 void __init device_tree_init(void)
 {
 	unsigned long base, size;
-	struct boot_param_header *fdtp = xlp_fdt_blob;
 
-	if (!fdtp)
+	if (!initial_boot_params)
 		return;
 
-	base = virt_to_phys(fdtp);
-	size = be32_to_cpu(fdtp->totalsize);
+	base = virt_to_phys(initial_boot_params);
+	size = be32_to_cpu(initial_boot_params->totalsize);
 
 	/* Before we do anything, lets reserve the dt blob */
 	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 615603bd8063..d72a5bc1efc2 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -84,7 +84,7 @@ void __init plat_mem_setup(void)
 	 * Load the builtin devicetree. This causes the chosen node to be
 	 * parsed resulting in our memory appearing
 	 */
-	__dt_setup_arch(&__dtb_start);
+	__dt_setup_arch(NULL);
 
 	if (soc_info.mem_size)
 		add_memory_region(soc_info.mem_base, soc_info.mem_size * SZ_1M,
-- 
1.7.9.5
