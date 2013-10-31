Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 16:48:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33158 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823079Ab3JaPsSkAI1y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Oct 2013 16:48:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r9VFmHdb009805;
        Thu, 31 Oct 2013 16:48:17 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r9VFmHD3009804;
        Thu, 31 Oct 2013 16:48:17 +0100
Date:   Thu, 31 Oct 2013 16:48:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Cc:     Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        John Crispin <blogic@openwrt.org>
Subject: Fwd: Re: Build breakage in latest -next
Message-ID: <20131031154816.GX25884@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Comments regarding Rob's build fix below appreciated.

Thanks,

  Ralf

Date: Tue, 29 Oct 2013 17:55:04 -0500
From: Rob Herring <rob.herring@calxeda.com>
Subject: Re: Build breakage in latest -next

On 10/29/2013 04:04 PM, Ralf Baechle wrote:
> nlm_xlp_defconfig fails with:
> 
>   LINK    vmlinux
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
> arch/mips/built-in.o: In function `plat_mem_setup':
> (.init.text+0x5b0): undefined reference to `early_init_devtree'
> make[2]: *** [vmlinux] Error 1
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> make: Leaving directory `/home/ralf/src/linux/obj/nlm_xlp-build'
> 
> It appears this was caused by f75813c0127bbef41ac3152f64a72ba212a5514c
> [mips: use early_init_dt_scan] which removes the early_init_devtree
> function but doesn't the call in arch/mips/netlogic/xlp/setup.c.

I could change this to a call to device_tree_init, but the way it was 
done results in scanning the DT twice. I would like to move the 
device_tree_init call to be earlier instead to avoid this. I think this 
should be functionally equivalent, but could use more eyes on it.

Rob

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c538d6e..f5e5b0a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -602,6 +602,8 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	extern void plat_mem_setup(void);
 
+	device_tree_init();
+
 	/* call board setup routine */
 	plat_mem_setup();
 
@@ -662,7 +664,6 @@ static void __init arch_mem_init(char **cmdline_p)
 				crashk_res.end - crashk_res.start + 1,
 				BOOTMEM_DEFAULT);
 #endif
-	device_tree_init();
 	sparse_init();
 	plat_swiotlb_setup();
 	paging_init();
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 76a7131..e8938b7 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -97,9 +97,6 @@ void __init plat_mem_setup(void)
 	_machine_halt	= nlm_linux_exit;
 	pm_power_off	= nlm_linux_exit;
 
-	/* memory and bootargs from DT */
-	early_init_devtree(initial_boot_params);
-
 	if (boot_mem_map.nr_map == 0) {
 		pr_info("Using DRAM BARs for memory map.\n");
 		xlp_init_mem_from_bars();
