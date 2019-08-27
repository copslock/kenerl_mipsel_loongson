Return-Path: <SRS0=TBB5=WX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF6C3A5A3
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2D206BF
	for <linux-mips@archiver.kernel.org>; Tue, 27 Aug 2019 07:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfH0HUQ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:20:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfH0HUQ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 27 Aug 2019 03:20:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 236A512311851B39E630;
        Tue, 27 Aug 2019 15:20:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 15:20:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mips@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] MIPS: Octeon: remove duplicated include from dma-octeon.c
Date:   Tue, 27 Aug 2019 07:23:34 +0000
Message-ID: <20190827072334.96670-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/mips/cavium-octeon/dma-octeon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 72f24a4db099..14ea680d180e 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -16,7 +16,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/memblock.h>
 
 #include <asm/bootinfo.h>
 





