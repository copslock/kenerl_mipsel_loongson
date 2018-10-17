Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2018 02:30:10 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:33657
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992960AbeJQAaHG4lne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2018 02:30:07 +0200
Received: by mail-pg1-x543.google.com with SMTP id y18-v6so11650290pge.0;
        Tue, 16 Oct 2018 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CS8dgnIFpYQ7Enn0sLvT3ctTvSkag//XEF+SGM30/ik=;
        b=GVlinzSWZiEM3S2FCu+m0uYJXK7OkBCx15daUCWnyUPwUvCJrNhiDUSpK3UmxwDkjj
         hjg7IMlT9eyIT2sSJvLzKRCLx83tJfFNPXjBeyd6OkTcJ5GRCq6CQBz+a3WteXXOYpaq
         2L60hlgxM/cR9ZVt4cGqPcG67IK5vAIX/w9A9yX6g+qKryNtNnfc2yOnebsQSCO9VzuZ
         Vk2/c+GvQP9EnFw5DY9O2Yt3HrTMZqXr1u+Ilquzf2vEyyJ6HTCcJbL7+v0BLcZVa8PB
         NGDBVIZerJn3yMEaf3kYbILv/eHVFqwAzdooR/1hzLDO7tyxg/W63O46RyQVmagLiywt
         +a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CS8dgnIFpYQ7Enn0sLvT3ctTvSkag//XEF+SGM30/ik=;
        b=mlx0N02x8z5xKCibFgeJtVjOlRXZF/d00y2Oc+RvI/MsYKtOWLekKqaqFFUKxAF6et
         es1+iPUW2fxsgJ6R2a2nwnKM8kQOyKtu8/4dkjTjFtadyxd04mPLzCxwo6rCQQUO+v1M
         gr6tNvEMSofuX6JJumN1yCijZYShWpoOPyqZSPT/BcXNDMvnz5QqccIGcI5kRICiNxOB
         xWbC1PQrThW3Ig/0NiafYlrEJNMbCLXyxIRTbA0Yw/Y3CQgmAkQfJ33MtpbgTde2bPHE
         zdxb+WrDqtx9UeY+6rmYh95nQ5DVh3vrssEnxXMMIKMelqiJk0c4tZfm8Z2YJM7lLBel
         rKYQ==
X-Gm-Message-State: ABuFfojuMhn8TEEsL+SqPiuMIC0/QYGs+R3jReG+sJocnXD61SLC9ulc
        9fxruj/Lfk7ST7hRctTz+KYn7HcpAVM=
X-Google-Smtp-Source: ACcGV60dtj2i0tGJ8pk2bZ9oo5yIt88sAOM33ZNJp6t0dVzqP7SjcxrkwHxY8lsP/j9HRiEGWh5O1A==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr24176850pfj.152.1539736200284;
        Tue, 16 Oct 2018 17:30:00 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id r81-v6sm27121575pfa.110.2018.10.16.17.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 17:29:59 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] cacheinfo: Keep the old value if of_property_read_u32 fails
Date:   Wed, 17 Oct 2018 08:29:53 +0800
Message-Id: <1539736193-27332-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
property_read_u32 instead of get_property,read_number") makes cache
size and number_of_sets be 0 if DT doesn't provide there values. I
think this is unreasonable so make them keep the old values, which is
the same as old kernels.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/base/cacheinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 5d5b598..dd6a685 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -79,8 +79,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->size))
-		this_leaf->size = 0;
+	of_property_read_u32(np, propname, &this_leaf->size);
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
@@ -114,8 +113,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
-		this_leaf->number_of_sets = 0;
+	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)
-- 
2.7.0
