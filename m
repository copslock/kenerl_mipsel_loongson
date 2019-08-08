Return-Path: <SRS0=OGLP=WE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34CC0650F
	for <linux-mips@archiver.kernel.org>; Thu,  8 Aug 2019 07:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AA4218B8
	for <linux-mips@archiver.kernel.org>; Thu,  8 Aug 2019 07:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="bMVzRhH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfHHH70 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:59:26 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:40708 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731588AbfHHH7Z (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 8 Aug 2019 03:59:25 -0400
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 248DD940B25;
        Thu,  8 Aug 2019 10:51:41 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id DoVwgQ3gDB-pfGaLL86;
        Thu, 08 Aug 2019 10:51:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1565250701;
        bh=xZubcjYlFdlf74xJxF7aDv1FUk3454Da8DuPkW5Zta0=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=bMVzRhH5DosDpvvR8Wg3yJBlLtj4Dv45IrPOr/TyigLD0SlHzwLQGyl5z54f5zDxn
         aITfVfLh9V/ILVBvyPZy1t//uhyJdH3MBYvrbj405UgG0n7aMDzGd9eHxYiGVqsI4d
         RSTPGVbH51wKOAp4emJXysy0WZpwDDsDlWYBWoiM=
Authentication-Results: mxback14j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 03dF3Y2ufp-pPguqT01;
        Thu, 08 Aug 2019 10:51:39 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     paul.burton@mips.com, yasha.che3@gmail.com, aurelien@aurel32.net,
        sfr@canb.auug.org.au, fancer.lancer@gmail.com,
        matt.redfearn@mips.com, chenhc@lemote.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/7] MIPS: malta: Drop prom_free_prom_memory
Date:   Thu,  8 Aug 2019 15:50:10 +0800
Message-Id: <20190808075013.4852-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808075013.4852-1-jiaxun.yang@flygoat.com>
References: <20190808075013.4852-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Current prom_free_prom_memory is freeing maps marked
as BOOT_MEM_ROM_DATA, however, nobody is exactly setting
this type for malta.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/mti-malta/malta-memory.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 868921adef1d..7c25a0a2345c 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -39,17 +39,6 @@ void __init fw_meminit(void)
 
 void __init prom_free_prom_memory(void)
 {
-	unsigned long addr;
-	int i;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
-			continue;
-
-		addr = boot_mem_map.map[i].addr;
-		free_init_pages("YAMON memory",
-				addr, addr + boot_mem_map.map[i].size);
-	}
 }
 
 phys_addr_t mips_cdmm_phys_base(void)
-- 
2.22.0

