Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7835C282C4
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885AA20879
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="pkFsxeYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfAVNFi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:05:38 -0500
Received: from forward102p.mail.yandex.net ([77.88.28.102]:58248 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728215AbfAVNFh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 08:05:37 -0500
Received: from mxback22g.mail.yandex.net (mxback22g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:322])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 2D3FA1D41B7F;
        Tue, 22 Jan 2019 16:05:35 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback22g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id pGxgvvVMkR-5YdCIRlA;
        Tue, 22 Jan 2019 16:05:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548162335;
        bh=va6ar2RlbpsemIhQu9vlfedfrdFRiZG2GKowMPk/oVg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=pkFsxeYaOjAbglO7sy69YaIDEzegejIfotgffxUoaNH2ieTiGp/e0j5Saj+TeVyhQ
         GULzvW45Nmsytn1/fkToX+RxY5dWDhjd8IHDltRSDwITzuKDfFAXf/ZVxfKdV/F3Ew
         mTcnfvm+8eZrynlZl5XcD5N0Ft8L6ZkBTMa7zgbc=
Authentication-Results: mxback22g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nEDDgaQwiv-5Neq02Cj;
        Tue, 22 Jan 2019 16:05:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     keguang.zhang@gmail.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/6] MIPS: Loongson32: workaround di issue
Date:   Tue, 22 Jan 2019 21:04:11 +0800
Message-Id: <20190122130415.3440-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

GS232 core used in Loongson-1 processors has a bug that
di instruction doesn't save the irqflag immediately.

Workaround by set irqflag in CP0 before di instructions
as same as Loongson-3.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 9d3610be2323..59549d972439 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -41,7 +41,7 @@ static inline unsigned long arch_local_irq_save(void)
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
-#if defined(CONFIG_CPU_LOONGSON3)
+#if defined(CONFIG_CPU_LOONGSON3) || defined (CONFIG_CPU_LOONGSON1)
 	"	mfc0	%[flags], $12					\n"
 	"	di							\n"
 #else
-- 
2.20.1

