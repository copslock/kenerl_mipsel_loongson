Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F15C43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020FF20661
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfBXHPF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:15:05 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:59989 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfBXHPF (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 24 Feb 2019 02:15:05 -0500
X-QQ-mid: bizesmtp3t1550992497tulpody1y
Received: from localhost.localdomain (unknown [116.236.177.50])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 24 Feb 2019 15:14:48 +0800 (CST)
X-QQ-SSF: 01400000002000C0EF62B00A0000000
X-QQ-FEAT: DfYGKmo6ysRdarnruOfn1Ek+fdyG8muqnNh6eBhHnMwdWzfPYZTpNbm3Zpbb/
        Nc9BJIOBO3Yq1xKQw8drMuLAzatnKgzzv/qBgUHCT8IbU8OmLLGw7LLqqtc3QkKrFstjRAf
        HEod/nINiKUWZHknEYGmT98mx597St57WmHao+7G3t6do7ReKRIoCAPbz1YoZ1Rmlc01E4D
        q4+8qnZ4urjKMqhaOCVBMz71gwBbXRN38Ow3SrU5+sbLs7DkYWRnoObVlBEUZ1iOemBhXv2
        BllVae3Q5m63duL2sf7BWw71PkhLPUWcYc9Q==
X-QQ-GoodBg: 2
From:   Wang Xuerui <wangxuerui@qiniu.com>
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Belits <alex.belits@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/4] MIPS: simplify definition of TASK_SIZE64
Date:   Sun, 24 Feb 2019 15:13:52 +0800
Message-Id: <20190224071355.14488-2-wangxuerui@qiniu.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20190224071355.14488-1-wangxuerui@qiniu.com>
References: <20190224071355.14488-1-wangxuerui@qiniu.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:qiniu.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

There is a "min" macro in linux/kernel.h, so use it.

Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Alex Belits <alex.belits@cavium.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/processor.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index aca909bd7841..c50cba85d145 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -13,6 +13,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/threads.h>
 
@@ -62,7 +63,7 @@ extern unsigned int vced_count, vcei_count;
  */
 #define TASK_SIZE32	0x7fff8000UL
 #ifdef CONFIG_MIPS_VA_BITS_48
-#define TASK_SIZE64     (0x1UL << ((cpu_data[0].vmbits>48)?48:cpu_data[0].vmbits))
+#define TASK_SIZE64     (0x1UL << min(cpu_data[0].vmbits, 48))
 #else
 #define TASK_SIZE64     0x10000000000UL
 #endif
-- 
2.16.1



