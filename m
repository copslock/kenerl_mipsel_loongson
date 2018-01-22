Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 17:35:45 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:54496 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991068AbeAVQfiHYwaH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2018 17:35:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 22 Jan 2018 16:35:26 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 22 Jan 2018 08:35:02 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH] MIPS: KASLR: Drop relocatable fixup from reservation_init
Date:   Mon, 22 Jan 2018 16:33:31 +0000
Message-ID: <1516638811-24880-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1516638909-321457-30083-1530-4
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189240
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

A recent change ("MIPS: memblock: Discard bootmem initialization")
removed the reservation of all memory below the kernel's _end symbol in
bootmem. This makes the call to free_bootmem unnecessary, since the
memory region is no longer marked reserved.

Additionally, ("MIPS: memblock: Print out kernel virtual mem
layout") added a display of the kernel's virtual memory layout, so
printing the relocation information at this point is redundant.

Remove this section of code.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

This patch (or a derivative of it) tidies up some of the bootmem init code
when CONFIG_RELOCATABLE is active during the switch to memblock - please
can you include in the series?

Thanks,
Matt
---
 arch/mips/kernel/setup.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 99bfaa6b9279..a0eac8160750 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -536,29 +536,6 @@ static void __init reservation_init(void)
 		}
 	}
 
-#ifdef CONFIG_RELOCATABLE
-	/*
-	 * The kernel reserves all memory below its _end symbol as bootmem,
-	 * but the kernel may now be at a much higher address. The memory
-	 * between the original and new locations may be returned to the system.
-	 */
-	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
-		unsigned long offset;
-		extern void show_kernel_relocation(const char *level);
-
-		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
-		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
-
-#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
-		/*
-		 * This information is necessary when debugging the kernel
-		 * But is a security vulnerability otherwise!
-		 */
-		show_kernel_relocation(KERN_INFO);
-#endif
-	}
-#endif
-
 	/*
 	 * Reserve initrd memory if needed.
 	 */
-- 
2.7.4
