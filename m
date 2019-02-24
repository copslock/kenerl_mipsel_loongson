Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63325C43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3060720661
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfBXHPL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:15:11 -0500
Received: from smtpbg202.qq.com ([184.105.206.29]:60537 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbfBXHPK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 02:15:10 -0500
X-QQ-mid: bizesmtp3t1550992507txx3g4rbu
Received: from localhost.localdomain (unknown [116.236.177.50])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 24 Feb 2019 15:15:05 +0800 (CST)
X-QQ-SSF: 01400000002000C0EG82B00A0000000
X-QQ-FEAT: 92FxZ2TPvnd29DML+O608EXmytofcWCyLdLE6qSbHeMaU8KYSnEZcvEJlaizi
        lqUA2OCAqkND+tB6NrCjo5ZnKyzeG7TcYLNzoxn3hgWPUREacru/bN9yFSAhhjjWLtLnCDr
        Ji6Btf6mk+C7RexpFVOHh19aNA3fKKQCjOJnfVpCet0ieYLMdXWADUX/B5Cd7gu1ZRFZwzd
        nWLBVAT7JpkCvXRZ9K/H3JXjCqFu2X32AW8l3KAu3HHAt3L3QeOHuesKfY6s/wLdDg9UnPn
        G3kiRkwyYc7borL0Ukz70JqCw=
X-QQ-GoodBg: 2
From:   Wang Xuerui <wangxuerui@qiniu.com>
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Belits <alex.belits@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/4] MIPS: define virtual address size in Kconfig
Date:   Sun, 24 Feb 2019 15:13:54 +0800
Message-Id: <20190224071355.14488-4-wangxuerui@qiniu.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20190224071355.14488-1-wangxuerui@qiniu.com>
References: <20190224071355.14488-1-wangxuerui@qiniu.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:qiniu.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

To ease addition of new VA sizes, punt the constant in processor.h
to Kconfig.

Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Alex Belits <alex.belits@cavium.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig                 | 5 +++++
 arch/mips/include/asm/processor.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b0068a1e1e33..a1ab9e7924a0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2191,6 +2191,11 @@ endchoice
 config MIPS_LARGE_VA
 	bool
 
+config MIPS_VA_BITS
+	int
+	default 48 if MIPS_VA_BITS_48
+	default 40
+
 choice
 	prompt "Kernel page size"
 	default PAGE_SIZE_4KB
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 226cf46cc89c..9119e9a44d9c 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -63,7 +63,7 @@ extern unsigned int vced_count, vcei_count;
  */
 #define TASK_SIZE32	0x7fff8000UL
 #ifdef CONFIG_MIPS_LARGE_VA
-#define TASK_SIZE64     (0x1UL << min(cpu_data[0].vmbits, 48))
+#define TASK_SIZE64     (0x1UL << min(cpu_data[0].vmbits, CONFIG_MIPS_VA_BITS))
 #else
 #define TASK_SIZE64     0x10000000000UL
 #endif
-- 
2.16.1



