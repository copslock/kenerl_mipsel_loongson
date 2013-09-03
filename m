Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 14:13:35 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50772 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827357Ab3ICMDBla0z8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Sep 2013 14:03:01 +0200
Received: by mail-pb0-f53.google.com with SMTP id up15so5904734pbc.12
        for <multiple recipients>; Tue, 03 Sep 2013 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Vn5qezUdr68etgvYkDceepBoJjCclo/Bt03z4reR5nk=;
        b=bOIb1AEQ01n+mfv0etmAFiA19gQhkVoU+4ZYA2SdBhx7zvDoGVhEqI/+gmwhJo5lBQ
         x6OWC40gsE0tCQqJZhL40PfCGdvis6a7HPcEYk3rUbz5107nMyb6HHi6faSSAfZdnsZi
         Nferykhnf1hbQqO99VKgzda+icsVtLQnXS7dbxLaXSRX0r6Rw+LTK4Bf9Zx0jNq9AhCh
         yxZkO/OzejJFWRcrOuPZVTWgkMvO7+86wvqUrKgWrtTBaizMV9CUESEJzNCQItiAzutl
         73v1bOC8lSAqJmqdBkUw97KbFkYMrIPaXsz3mn3siKKgh1O4J6xk/7rG+Ad86wVs8MvE
         pzgw==
X-Received: by 10.68.219.33 with SMTP id pl1mr8279084pbc.147.1378209764568;
        Tue, 03 Sep 2013 05:02:44 -0700 (PDT)
Received: from localhost.localdomain ([115.111.18.195])
        by mx.google.com with ESMTPSA id bt1sm22079672pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 05:02:43 -0700 (PDT)
From:   Jerin Jacob <jerinjacobk@gmail.com>
To:     ralf@linux-mips.org
Cc:     Jerin Jacob <jerinjacobk@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DMA: Fix BUG due to smp_processor_id() in preemptible code
Date:   Tue,  3 Sep 2013 17:31:54 +0530
Message-Id: <1378209714-29372-1-git-send-email-jerinjacobk@gmail.com>
X-Mailer: git-send-email 1.7.6.5
Return-Path: <jerinjacobk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerinjacobk@gmail.com
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

The use of current_cpu_type() in cpu_is_noncoherent_r10000() is not preemption-safe.
Use boot_cpu_type() instead to make it preemption-safe.

<log>
/ # insmod mtd_readtest.ko dev=4
mtd_readtest: MTD device: 4
mtd_readtest: MTD device size 996671488, eraseblock size 524288, page size 4096, count of eraseblocks 1901, pages per eraseblock 128, OOB size 224
mtd_readtest: scanning for bad eraseblocks
mtd_readtest: scanned 1901 eraseblocks, 0 are bad
mtd_readtest: testing page read
BUG: using smp_processor_id() in preemptible [00000000] code: insmod/99
caller is mips_dma_sync_single_for_cpu+0x2c/0x128
CPU: 2 PID: 99 Comm: insmod Not tainted 3.10.4 #67
Stack : 00000006 69735f63 00000000 00000000 00000000 00000000 808273d6 00000032
          80820000 00000002 8d700000 8de48fa0 00000000 00000000 00000000 00000000
          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
          00000000 00000000 00000000 8d6afb00 8d6afb24 80721f24 807b9927 8012c130
          80820000 80721f24 00000002 00000063 8de48fa0 8082333c 807b98e6 8d6afaa0
          ...
Call Trace:
[<80109984>] show_stack+0x64/0x7c
[<80666230>] dump_stack+0x20/0x2c
[<803a2210>] debug_smp_processor_id+0xe0/0xf0
[<801116f0>] mips_dma_sync_single_for_cpu+0x2c/0x128
[<8043456c>] nand_plat_read_page+0x16c/0x234
[<8042fad4>] nand_do_read_ops+0x194/0x480
[<804301dc>] nand_read+0x50/0x7c
[<804261c8>] part_read+0x70/0xc0
[<804231dc>] mtd_read+0x80/0xe4
[<c0431354>] init_module+0x354/0x6f8 [mtd_readtest]
[<8010057c>] do_one_initcall+0x140/0x1a4
[<80176d7c>] load_module+0x1b5c/0x2258
[<8017752c>] SyS_init_module+0xb4/0xec
[<8010f3fc>] stack_done+0x20/0x44

BUG: using smp_processor_id() in preemptible [00000000] code: insmod/99
</log>

Signed-off-by: Jerin Jacob <jerinjacobk@gmail.com>
---
 arch/mips/mm/dma-default.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index aaccf1c..2f26835 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -58,8 +58,8 @@ static inline struct page *dma_addr_to_page(struct device *dev,
 static inline int cpu_is_noncoherent_r10000(struct device *dev)
 {
 	return !plat_device_is_coherent(dev) &&
-	       (current_cpu_type() == CPU_R10000 ||
-	       current_cpu_type() == CPU_R12000);
+	       (boot_cpu_type() == CPU_R10000 ||
+	       boot_cpu_type() == CPU_R12000);
 }
 
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
-- 
1.7.6.5
