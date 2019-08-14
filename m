Return-Path: <SRS0=kRNa=WK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E425C32750
	for <linux-mips@archiver.kernel.org>; Wed, 14 Aug 2019 02:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4840420842
	for <linux-mips@archiver.kernel.org>; Wed, 14 Aug 2019 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749354;
	bh=+G6YI7uCiWl5NzsZjlF0cb+BjDlIwDypveGYVOUdif8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jL8rFr146AIbdIRtpKYgZcnkZgfecXdF4FTa/mt6LPgEt/bkHrLA3uohWms9hVff+
	 e2BkfP3Dmkwi/fn/4nhuKBlSk5+7OfzAQnokgPfkbMGxbSWyLMZXTjbMhn+vza6M4j
	 o8BQ3WnVGzVn3gfsFnSA9UMtu3Zait8Jwuk1bnfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfHNCSo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbfHNCSm (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 13 Aug 2019 22:18:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253B620842;
        Wed, 14 Aug 2019 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749122;
        bh=+G6YI7uCiWl5NzsZjlF0cb+BjDlIwDypveGYVOUdif8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J47q/8xorcguLssSvFsFPNHAwpieKUW8+Um8JP1FK4gaCcPm6EnM/qpkMVu6jnhDO
         SxQdBGB0PWjBgtaFIV17Dd/tm5nyMz2p8qnAqngMk9c76FK2FKAbGRtD5JQl6w9sMp
         7nRmJuhOAvEjaWyin8aUqMFAYLCI3ZDn8d5OStUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 04/44] mips: fix cacheinfo
Date:   Tue, 13 Aug 2019 22:17:53 -0400
Message-Id: <20190814021834.16662-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021834.16662-1-sashal@kernel.org>
References: <20190814021834.16662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>

[ Upstream commit b8bea8a5e5d942e62203416ab41edecaed4fda02 ]

Because CONFIG_OF defined for MIPS, cacheinfo attempts to fill information
from DT, ignoring data filled by architecture routine. This leads to error
reported

 cacheinfo: Unable to detect cache hierarchy for CPU 0

Way to fix this provided in
commit fac51482577d ("drivers: base: cacheinfo: fix x86 with
 CONFIG_OF enabled")

Utilize same mechanism to report that cacheinfo set by architecture
specific function

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/cacheinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index 97d5239ca47ba..428ef21892039 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -80,6 +80,8 @@ static int __populate_cache_leaves(unsigned int cpu)
 	if (c->tcache.waysize)
 		populate_cache(tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
 
+	this_cpu_ci->cpu_map_populated = true;
+
 	return 0;
 }
 
-- 
2.20.1

