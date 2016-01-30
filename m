Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:18:13 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35502 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009016AbcA3FRkMPuJt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:40 +0100
Received: by mail-pa0-f66.google.com with SMTP id gi1so4521416pac.2;
        Fri, 29 Jan 2016 21:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P0Of7Rf40uVDsG14IWitjqvOKU66D013LqAeGRqYFjQ=;
        b=cb1FtklgJ1CnCDNEy8GqPvdoh4gFseV6obkCm9UU6kAgu0fjP04hIXxWtwXhb8oKiS
         WifszzWHSYG3iwdMJG922cEeXbNH4kT76Oxyn/qmr+5oal5y7owcwPlYrSq4eyDectiD
         v2qvX541mpGcowMi7NGR1mmtgcOnKfEeLaHIfOSWCraJjf1XCiNJBYYEUf+kXpSuFwvH
         vyU4VdkzsN9bo4gnZpr0IezL0DETEng9JNgqDgGzRLwM5HCGAQn+oBPXxziE1mtpMe99
         SpvchGfy3OTdbI/i0FOZ660iY4ku29WQPcGNVMW8DQ8IImJtWtlS+Zu3eEMqMw33kuor
         s+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P0Of7Rf40uVDsG14IWitjqvOKU66D013LqAeGRqYFjQ=;
        b=ikyQmUi9dLM3baJ0QekXLPbyYErVFwcPfATbn7P8zNZ/lNQrK7Lzi63+LC6B6XnkSj
         zljCHEq06pbPYBHW0Pj3c7WWFkn8lYOhFjtKAil17qDikuX0b8/6cRvJfuXeSwGua8Ch
         0AYeguk/bwVyxIB7MaHQVp32bgoHKNU15yAs5FR6A7oUc3B3+s4nn+aVYVEpUJ5mWa85
         5+CwyQt/So66khj0L/M2y9Cc/lKNGLwTIqUbqzpkD0/RVeYs7JKHlMCUqtkgkuUMJARz
         nDe8N/PcIf1oLkrk6+a0FOpg5T2JyzFOcpn2y4u9kx0MNBA0ddzMVmFkJ6KAnX2i70Wc
         bzMA==
X-Gm-Message-State: AG10YOQTY1KMNtHcfDMHA304VMOlPwNp/q3FYK/Qd3KeF7Bzmpf6N+Q1/fjTumjrRZTx0w==
X-Received: by 10.66.218.225 with SMTP id pj1mr18923221pac.40.1454131054527;
        Fri, 29 Jan 2016 21:17:34 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/6] MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
Date:   Fri, 29 Jan 2016 21:17:22 -0800
Message-Id: <1454131046-11124-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51539
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

BMIPS5000 and BMIPS5200 processor have no D cache aliases, and this is
properly handled by the per-CPU override added at the end of
r4k_cache_init(), the problem is that the output of probe_pcache()
disagrees with that, since this is too late:

Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes

With the change moved earlier, we now have a consistent output with the
settings we are intending to have:

Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, no aliases, linesize 32 bytes

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 30459aa..6bf6c6b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1309,6 +1309,8 @@ static void probe_pcache(void)
 
 	case CPU_BMIPS5000:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		/* Cache aliases are handled in hardware; allow HIGHMEM */
+		c->dcache.flags &= ~MIPS_CACHE_ALIASES;
 		break;
 
 	case CPU_LOONGSON2:
@@ -1748,8 +1750,6 @@ void r4k_cache_init(void)
 		flush_icache_range = (void *)b5k_instruction_hazard;
 		local_flush_icache_range = (void *)b5k_instruction_hazard;
 
-		/* Cache aliases are handled in hardware; allow HIGHMEM */
-		current_cpu_data.dcache.flags &= ~MIPS_CACHE_ALIASES;
 
 		/* Optimization: an L2 flush implicitly flushes the L1 */
 		current_cpu_data.options |= MIPS_CPU_INCLUSIVE_CACHES;
-- 
1.7.1
