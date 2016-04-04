Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 19:58:09 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34899 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025794AbcDDR5tZCkjW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 19:57:49 +0200
Received: by mail-pa0-f47.google.com with SMTP id td3so148220300pab.2;
        Mon, 04 Apr 2016 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcGb/TLbIUEdZCTOZa3j7yc/mYfmR89p3TEBxcooqUg=;
        b=TeWRo/DyUM+GZ7BaZDV2hSQgEo9x+ZKiqw2pwtXBo158awwAhiQJwQEchYZRidh+va
         XMG86jpK3NAhUBayYKKWa/ZusuJik4oT/30zCW5yQupG8fJaNEgB4+/2/UZgiPwChWkz
         2Bp5B7JwjK1yD/jN2/4675oXZL0fBMw0NOJYcsFVWSYB2E4SjYUW0sV0vmwUljLdqxUx
         28XntgDrlJBZOzF/mY5O806hQTW8Janid4/d+zv4oEuCsNIJkdQmeROLtUoLI1h9M4r8
         JEwsH7AKmVaHS0sDrnSj3+KE+STMuuWED1+crQ/99Wp7NKXckih50VgdJ3l+X1N433C0
         1J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JcGb/TLbIUEdZCTOZa3j7yc/mYfmR89p3TEBxcooqUg=;
        b=LkQBd10t1gEZIL2PD3BHCFHRnqCVsYB0dW/Z/hKulu6V7brtPRzd7jmETSnd0Bsl6k
         ojdOqKZ/20MhHCcnk6mHHsOmp6zWqxuBpt581BnQ33sMkRrXcyHnvia4v6Gg9BQk0HC3
         +x40O2V9YxoU6DxvD27jsRxHbsjFt4Te9GgMndl20tf6oxr6aPCzjy+HWbIBF30m+2XL
         qepDBs+MgeP8VuRVApxezhr7B+EIh6U7f20PSj5rxtRCDOp2bwrPASoHsEN5AuSveEb1
         mz3B+73EOnWFSksqAHwj2R23ptkRO4iYeWv4ifl8pYuxD324fUUm7D65019R4nkiEQrS
         fBLQ==
X-Gm-Message-State: AD7BkJLXv2v2tnQ6+29KYcA7WzbTPpgIMB11shh1SpsQ2UBGgFfGajeQyEda920SL0HlPA==
X-Received: by 10.66.190.131 with SMTP id gq3mr54625843pac.42.1459792663396;
        Mon, 04 Apr 2016 10:57:43 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 20sm40948752pfj.80.2016.04.04.10.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 10:57:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 1/5] MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
Date:   Mon,  4 Apr 2016 10:55:34 -0700
Message-Id: <1459792538-19854-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
References: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

BMIPS5000 and BMIPS52000 processors have their I-cache filling from the
D-cache. Since BMIPS_GENERIC does not provide (yet) a
cpu-feature-overrides.h file, this was not set anywhere, so make sure
the R4K cache detection takes care of that.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 141161a01e04..15ee3d94688e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1309,6 +1309,10 @@ static void probe_pcache(void)
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 
+	case CPU_BMIPS5000:
+		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		break;
+
 	case CPU_LOONGSON2:
 		/*
 		 * LOONGSON2 has 4 way icache, but when using indexed cache op,
-- 
2.1.0
