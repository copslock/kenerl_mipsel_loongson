Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:19:50 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041427AbcFIVSgcMxUE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:18:36 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7LQ-0005H0-8T; Thu, 09 Jun 2016 21:18:28 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7LN-00069y-Ha; Thu, 09 Jun 2016 14:18:25 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <sjhill@realitydiluted.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 074/206] MIPS: Loongson-3: Reserve 32MB for RS780E integrated GPU
Date:   Thu,  9 Jun 2016 14:14:43 -0700
Message-Id: <1465507015-23052-75-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Huacai Chen <chenhc@lemote.com>

commit 3484de7bcbed20ecbf2b8d80671619e7059e2dd7 upstream.

Due to datasheet, reserving 0xff800000~0xffffffff (8MB below 4GB) is
not enough for RS780E integrated GPU's TOM (top of memory) registers
and MSI/MSI-x memory region, so we reserve 0xfe000000~0xffffffff (32MB
below 4GB).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J . Hill <sjhill@realitydiluted.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12889/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/loongson64/loongson-3/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 6f9e010..282c5a8 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -213,10 +213,10 @@ static void __init node_mem_init(unsigned int node)
 		BOOTMEM_DEFAULT);
 
 	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
-		/* Reserve 0xff800000~0xffffffff for RS780E integrated GPU */
+		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
 		reserve_bootmem_node(NODE_DATA(node),
-				(node_addrspace_offset | 0xff800000),
-				8 << 20, BOOTMEM_DEFAULT);
+				(node_addrspace_offset | 0xfe000000),
+				32 << 20, BOOTMEM_DEFAULT);
 	}
 
 	sparse_memory_present_with_active_regions(node);
-- 
2.7.4
