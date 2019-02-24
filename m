Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0CC43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A963520661
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfBXHPR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:15:17 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:42384 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfBXHPR (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 02:15:17 -0500
X-QQ-mid: bizesmtp3t1550992510tkbwgufxk
Received: from localhost.localdomain (unknown [116.236.177.50])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 24 Feb 2019 15:15:08 +0800 (CST)
X-QQ-SSF: 01400000002000C0EG82B00A0000000
X-QQ-FEAT: JeZkV8SsDPkiP1CqcxwKdSj1fH9ZSMJaS53/BboKXhwgZYcCnIIhf2iAp1/r3
        J9kxYmFT7bVMGobnAOtIxxFDH3s893nJOmbQvCLG31Dkg3d7997UCys+x83c101W4Mf31BW
        HNHpWotdY6yGDBeSXD0H5/WG9ycfr4/C3kb3rvdGDzZxMSmmBBMALNbFhyOHW4ny9x+4+4M
        rffWlAh5GG7muz7B+uoxOWm9kydGHljo2cXFwkml3dexe55zvJpzugODcyqMj8gMgoiZPTK
        5BP8jkJiHju8w8cs/yrOUGPEnX6ATC4/2LDQ==
X-QQ-GoodBg: 2
From:   Wang Xuerui <wangxuerui@qiniu.com>
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Belits <alex.belits@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4/4] MIPS: support 47-bit userland VM space
Date:   Sun, 24 Feb 2019 15:13:55 +0800
Message-Id: <20190224071355.14488-5-wangxuerui@qiniu.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20190224071355.14488-1-wangxuerui@qiniu.com>
References: <20190224071355.14488-1-wangxuerui@qiniu.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:qiniu.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The infrastructure is now ready, so just add the necessary Kconfig
logic. The equivalent logic has been tested on Loongson 3A2000 and
3A3000 for more than 2 years, no breakage so far.

Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
Tested-by: Wang Xuerui <wangxuerui@qiniu.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Alex Belits <alex.belits@cavium.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a1ab9e7924a0..104de85ef6ed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2171,6 +2171,31 @@ config MIPS_VA_BITS_DEFAULT
 
 	  If unsure, say Y.
 
+config MIPS_VA_BITS_47
+	bool "47 bits virtual memory"
+	depends on 64BIT
+	select MIPS_LARGE_VA
+	help
+	  This is a temporary option to support 47 bits of application virtual
+	  memory, as is the case with x86_64.
+
+	  Some applications and libraries assume the userland address space is
+	  47-bit or less, due to the prevalence of x86_64 platforms where this
+	  restriction is present.  Hence, turning on 48-bit userland addresses
+	  may cause these applications to stop working.  For example,
+	  SpiderMonkey re-uses the higher 17 bits of pointers as tags, which
+	  breaks GJS and thus whole GNOME if 48-bit is enabled.  This option
+	  retains compatibility with those (broken for now) apps, while
+	  providing larger address space to userland.
+
+	  However, the option is only here as a stop-gap measure; the
+	  applications should be fixed to not depend on unused bits in
+	  pointers, as those bits will eventually become unavailable.  Also
+	  note that the caveats of 48-bit virtual memory also apply, because
+	  the implementation is shared.
+
+	  If unsure, say N.
+
 config MIPS_VA_BITS_48
 	bool "48 bits virtual memory"
 	depends on 64BIT
@@ -2193,6 +2218,7 @@ config MIPS_LARGE_VA
 
 config MIPS_VA_BITS
 	int
+	default 47 if MIPS_VA_BITS_47
 	default 48 if MIPS_VA_BITS_48
 	default 40
 
-- 
2.16.1



