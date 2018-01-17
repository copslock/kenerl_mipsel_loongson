Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:24:45 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:33951
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeAQWX2pxBhK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:28 +0100
Received: by mail-lf0-x244.google.com with SMTP id k19so3753952lfj.1;
        Wed, 17 Jan 2018 14:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EM5WBQSdvNARQ0W1G58JbrRkzcTWMVVuI+l+ysgt3U8=;
        b=ZW1D+mX5zxjBkE2SFH+Q/FdLN4zYI3ROxjDxD68/Jmy5iKXratux9HLIytF3bYMPri
         ZpgBnwyu18Q+m2n+nZ3S9ozwKOldYdz6EwbplSwhyfANcys5VeKeiUyk6IaIAd3iq4GB
         U4yZfDeAnqYU/iQbXuJ+/BH1L9s+YzJJFhOq+SkEaykyqvFZHOf7Hu1ak+pOpfT5WzVH
         dy7+q5czdD5WqaZGoKIx5gCnZ3PbNyG7vg/hmuE4Qdf2JiCJE0SnaqhtveomfskUJ6g9
         7ZxcaTlXgZ9eFQU41Aq5SNfzpwXNGW8ra/bIxl7KA/Ar3TL6orI3a/6aVQ647jyrfZJW
         HgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EM5WBQSdvNARQ0W1G58JbrRkzcTWMVVuI+l+ysgt3U8=;
        b=tby3W2sLbIA5oGG7q4XrMbV0l3NWPBNHHqGZhPej2UYI1/f829oZ2K2C/utD2VyLvX
         h8STw1Ux5iKs7ioDERBMD2ocraS0XMrXihgVwQ9KVFDMqMU9jIh7NURt0GaBCPYrbArJ
         Bzrh9fzsVeBS/MOSrxGj2B0A1BS1GuPiv3iJeNi0EywI+oKPQtMBbfD0jbAISbN2txI+
         xqZZrQvMtONKYfuU/QYMPxk5Y9tVjURR5xyb+hrE2mWiDExHZP6qdT1noK90e3IiJN3V
         Y4kgTOrBEEmZwiRofVSbak/yH+tcC+aLLbHEFwspC2KGidja6nROHq4Z6tveDOzRMtHr
         TLVQ==
X-Gm-Message-State: AKwxyteX6QwOmjXWaBLjQ/wAOCsu+jWDzudMcL03SGQm8IYJ4dIwTtbS
        2nlaUgrkF6/CuQ2Va4JXGpeANZQA
X-Google-Smtp-Source: ACJfBouCm1hx1SKe2yHaW3HBUTwSWyutkwcE8ek7lCTWkpTS8V9RV/24BtjVDl+1uIfSjiOgOuVFWg==
X-Received: by 10.46.62.7 with SMTP id l7mr9606320lja.25.1516227803054;
        Wed, 17 Jan 2018 14:23:23 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:22 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 03/14] MIPS: memblock: Reserve initrd memory in memblock
Date:   Thu, 18 Jan 2018 01:23:01 +0300
Message-Id: <20180117222312.14763-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

There is no reserve_bootmem() method in the nobootmem interface,
so we need to replace it with memblock-specific one.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 0d21c9e04..1b8246e6c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -330,7 +330,7 @@ static void __init finalize_initrd(void)
 
 	maybe_bswap_initrd();
 
-	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
+	memblock_reserve(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
-- 
2.12.0
