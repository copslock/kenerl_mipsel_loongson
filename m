Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 19:58:39 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34913 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025906AbcDDR5utp6xW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 19:57:50 +0200
Received: by mail-pa0-f42.google.com with SMTP id td3so148220711pab.2;
        Mon, 04 Apr 2016 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uwZGKlq581aFX4M5Ux+v6Ym5EvKGCCUXnFCS1tLZILI=;
        b=fTHBGd1rpL8ZB/ZPx02g7cB3ayeJ+k7/8laWDTM1Mk6iUOyF8rSywjtwi22xxi8lzv
         ix9feb20v1XVI/9tqzhwmmEmHatsXSAxC0untYvE51Kp63hkRyPGOiH37oOIlRqDvqZQ
         fTqe1MUbjOOeOqJ4T2COHJ7zcDpWCPpBQMunz+19v235AOTc76HXFKkO+Vq7mhDQRqlj
         zFWZAdc2gzBCZfY86dOGOm2CKIP+s/dywiUONSTv0NpD3WBcy9huvk7udfHOQHwoVoFp
         1dfWyJKpjJ4oRYAYqaP6IsKvHc2iEaEqlE/OllYO/d6DQOSmRoxAbs9oOoZTCQLRSmRI
         4/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uwZGKlq581aFX4M5Ux+v6Ym5EvKGCCUXnFCS1tLZILI=;
        b=GYAOsqLi80glQusZjvCrlh3gS1/YpvJzy1XH4dctAgfS6zmccsR8ttHKSTk1JhidIE
         AEn5JMzEuH/HMeCKtCJKgvN0tnaZfcP2fIUJc+ymKI2j4J2+ipTOOj8X7YGjSHmmnCj0
         gayM4PGgQ9Afvhi0jKIy72kyap7rqR1aOcoAv/bA3vLsiaAFf3lmgg29bYhFjvFUDaea
         SIW6SXXCb5d1uZsCJDiZGbT5Sz4d5MDsFn6YkXJxBsj2x62Q454L02l73qxm94LQbyh0
         7GULW0Bp8v/byKgx3c7lB4xaZNo+WilwLFy2jMKkCBPd7kzb+YLN/syCV6DMSBhYYWa+
         LACQ==
X-Gm-Message-State: AD7BkJLi5vLQCy5Zsb97Z+qAbPjEEdj7A8xoRs9dIpj7G9akR7dJ4VaH05monx0C0mLVzg==
X-Received: by 10.66.150.163 with SMTP id uj3mr19369730pab.23.1459792665102;
        Mon, 04 Apr 2016 10:57:45 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 20sm40948752pfj.80.2016.04.04.10.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 10:57:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 3/5] MIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
Date:   Mon,  4 Apr 2016 10:55:36 -0700
Message-Id: <1459792538-19854-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
References: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52880
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

local_r4k___flush_cache_all() is missing a special check for BMIPS5000
processors, we need to blast the S-cache, just like other MTI processors
since we have an inclusive cache. We also need an additional __sync() to
make sure this is completed.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index eb1588206a6a..dda3a6dd34a7 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -447,6 +447,11 @@ static inline void local_r4k___flush_cache_all(void * args)
 		r4k_blast_scache();
 		break;
 
+	case CPU_BMIPS5000:
+		r4k_blast_scache();
+		__sync();
+		break;
+
 	default:
 		r4k_blast_dcache();
 		r4k_blast_icache();
-- 
2.1.0
