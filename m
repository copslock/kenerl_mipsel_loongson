Return-Path: <SRS0=63qb=WN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD0DC3A59F
	for <linux-mips@archiver.kernel.org>; Sat, 17 Aug 2019 07:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74D21744
	for <linux-mips@archiver.kernel.org>; Sat, 17 Aug 2019 07:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIsKwk6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfHQHhY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:37:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfHQHhY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 17 Aug 2019 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LOFsaDUHf3oSjRMXw5gFEkv6KPkdmKdXRuV5c2KcYvA=; b=gIsKwk6n+bCIQONuEURySg1qEX
        ECAOChzlESqAv5fGqazply96L9cdHcfpjjyx3dZORFWGyH/r163KHliR+p8uKnVlrw1Xy2BMA8G9X
        0cqoOJ17bcPN000u+K+Px7KSD/Ub6OrBTZe8IWQtdFrfDnFQNpaD5tpYmrlsCzQ5UU74NQyaqbui3
        y/lkc//xBRDH3DK/rT40/ks+TNCetrO7vqLVpHCUq9AbEHtayN2fgzVTsQnDn9UAJ+Rl9RuxKiH2Y
        gEtfWLhhRLmBzFl1Mc5c4/9wE9NlK5KoRV8cwLKy8KTyLYK7Wmrp38l48fwI+NSqTssdqhQu/Udno
        spOWXvLA==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytH6-0006ut-0w; Sat, 17 Aug 2019 07:37:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/26] mtd/maps/pxa2xx: use ioremap_cache insted of ioremap_cached
Date:   Sat, 17 Aug 2019 09:32:28 +0200
Message-Id: <20190817073253.27819-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

pxa2xx-flash is the only user of ioremap_cached, which is an alias
for ioremap_cache anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/maps/pxa2xx-flash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index cebb346877a9..7d96758a8f04 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -68,8 +68,7 @@ static int pxa2xx_flash_probe(struct platform_device *pdev)
 		       info->map.name);
 		return -ENOMEM;
 	}
-	info->map.cached =
-		ioremap_cached(info->map.phys, info->map.size);
+	info->map.cached = ioremap_cache(info->map.phys, info->map.size);
 	if (!info->map.cached)
 		printk(KERN_WARNING "Failed to ioremap cached %s\n",
 		       info->map.name);
-- 
2.20.1

