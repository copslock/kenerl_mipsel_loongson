Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:16:06 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33125 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993107AbcLSCIT6kcsK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:19 +0100
Received: by mail-lf0-f68.google.com with SMTP id y21so6157166lfa.0;
        Sun, 18 Dec 2016 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lIF3ALMBpp1hN06CGMMd8ZqOdBENLOJY6D6oNIdOpS8=;
        b=htQEU8hqSl6qDfqhYcfv93QwIgTYrpSG7dlMePTGYUzLa/hafltS61XuqhLLyOT5qK
         GQOYjfnWc3VoF07DpdpQ6F9YJSYdODvwhD/qEPqD/STmnCcxniQ1loaSUFrp6IRvBE2W
         LecvyJQH4iTO5+ADR3l1di4qVQPBAXQxXg9alRbarotZxtOO69/rkDEkZtlzpaNX+lNZ
         7lC8D/9bKBdlBvtBO4q9wTOqobYK6SV5k+IKISrYVNHwuf5dSHS72hbNR4U1HvAJab1Q
         vwyfGAkSAE1qzuol+rKtteUL+Sy503aD5RQXqUbb2DNtLU5ths9EirdoHNbfyV/ILw1/
         VueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lIF3ALMBpp1hN06CGMMd8ZqOdBENLOJY6D6oNIdOpS8=;
        b=S6a/db0AFKGbQ9760Dm4oB7g5/XsthVUNuTR2KDy0gCWOFYyDpHYDjti+gKrUJr4RK
         UCzt6Z4r/zMhOIAn2Sakk6HAGMqbbQGrpmpJOI/lAqEl7vo8RkdEmV5iQ0zLVDWLhQGQ
         nuOHlW7fwFCqfclI0X9egEUR8ZUv4C96lObCqsPVTOjKQPxHOAdsqF7673HOohbb02H9
         A7SyoP6ym2sCwLMCznEVCaSSfsiH36HxhYalxdZ0pBmXO133GIXQwkhP3k33ve46to4t
         9W8tRy3pjTMVSAVe+rhPJJMHM3Ze4DMUYP/ahsA3RrVqZeawXQSEdPHjV5yGK+0KmmpJ
         eEFA==
X-Gm-Message-State: AIkVDXIkTQX0r5FxDpowQa5xLdS94uMTb3AoOc+9U5GOm1s8gV2euFaRcjwTaTlgXprf3Q==
X-Received: by 10.46.32.7 with SMTP id g7mr5793213ljg.35.1482113294535;
        Sun, 18 Dec 2016 18:08:14 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:14 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 20/21] MIPS memblock: Add free low memory test method call
Date:   Mon, 19 Dec 2016 05:07:45 +0300
Message-Id: <1482113266-13207-21-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56082
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

Right after all the necessary reservations are done, free memory
regions can be tested if it is activated with "memtest" parameter.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 35e7ba8..ccc0e96 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -452,6 +452,12 @@ void maar_init(void)
 
 void __init paging_init(void)
 {
+	/*
+	 * Test low memory registered within memblock. The method shall test
+	 * valid and free memory only
+	 */
+	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
+
 	/* Initialize page tables */
 	pagetable_init();
 
-- 
2.6.6
