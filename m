Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:48:25 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042429AbcFEVmnSO0Dp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:43 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DDB93951;
        Sun,  5 Jun 2016 21:42:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <sjhill@realitydiluted.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 13/99] MIPS: Loongson-3: Reserve 32MB for RS780E integrated GPU
Date:   Sun,  5 Jun 2016 14:40:46 -0700
Message-Id: <20160605213904.254286506@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/loongson-3/numa.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -213,10 +213,10 @@ static void __init node_mem_init(unsigne
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
