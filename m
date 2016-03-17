Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:41:15 +0100 (CET)
Received: from smtpbgau1.qq.com ([54.206.16.166]:41034 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014102AbcCQMlKm3hgI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Mar 2016 13:41:10 +0100
X-QQ-mid: bizesmtp7t1458218414t478t143
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 17 Mar 2016 20:40:09 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK60B00A0000000
X-QQ-FEAT: cbPjiZhc9zmrV5wCSbUvFJ77NhgCb8tLZOP9+QIhsk03uDdD6gZBXx4pSdWUT
        zM9zigTF7Dm8qfqyvZjYp8EJsrB8xnj1cmxEOhHSaYh/qr3uVyqSVlCOoZbPuT/O+oqhpPI
        nFQqsMTBZ36BV8HlVQn1JZf8eBuqLH+RaQPpsnDETKsu1Yv+ywWSx7rTJlRJ65kQkdIsZNy
        fxmwf79nAcwNbUypfmUK7dpSXVqAGXt2VJ4As6dar4U8KZlXbuHMhmzjT4OutxtM9GYXNfS
        XGYAM+LWgA/GQ/2/aXjuZ5uOk=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V3 2/4] MIPS: Loongson-3: Reserve 32MB for RS780E integrated GPU
Date:   Thu, 17 Mar 2016 20:41:05 +0800
Message-Id: <1458218467-12210-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Due to datasheet, reserving 0xff800000~0xffffffff (8MB below 4GB) is
not enough for RS780E integrated GPU's TOM (top of memory) registers
and MSI/MSI-x memory region, so we reserve 0xfe000000~0xffffffff (32MB
below 4GB).

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
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
2.7.0
