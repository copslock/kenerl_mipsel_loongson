Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF2C282C3
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFC020870
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="iV4jwNQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfAVNOL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:14:11 -0500
Received: from forward100o.mail.yandex.net ([37.140.190.180]:34896 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728239AbfAVNOK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 08:14:10 -0500
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 6B2074AC0478;
        Tue, 22 Jan 2019 16:06:41 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback14o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZRjXgVJLmo-6fQehKuL;
        Tue, 22 Jan 2019 16:06:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548162401;
        bh=Enxe7Ra4n9wapkfL2KrruAVJnEZJLRIEeeRogslsjzk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=iV4jwNQq9XB7wxaMyO0KM0XD5zV0dt8JaITnIN9KeSPQ5qaD0SUEHsb8/S7oIC9OQ
         bGSMCtgo7/gFRuKQ+lAUDAY/ShBOWkoHyPV4hzyFJBOx68tAFhyt9qbOyBRyK9rd5P
         +GsUScMHeUBcpkuuiqoX9CRlmQd2bHKAk2mLwCUw=
Authentication-Results: mxback14o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nEDDgaQwiv-6Peq4VsM;
        Tue, 22 Jan 2019 16:06:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     keguang.zhang@gmail.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/6] MIPS: Loongson32: Set load address to 0x80200000
Date:   Tue, 22 Jan 2019 21:04:14 +0800
Message-Id: <20190122130415.3440-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

PMON bootloader on Loongson-1C will use memory between
0x80100000 and 0x80200000 as stack.

Use 0x80100000 as load address may hang the bootloader
during loading.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson32/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index 0db38f64f571..333215593092 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -1,4 +1,4 @@
 cflags-$(CONFIG_CPU_LOONGSON1)		+= -march=mips32r2 -Wa,--trap
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
-load-$(CONFIG_CPU_LOONGSON1)		+= 0xffffffff80100000
+load-$(CONFIG_CPU_LOONGSON1)		+= 0xffffffff80200000
-- 
2.20.1

