Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 19:58:24 +0200 (CEST)
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34334 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025889AbcDDR5tz6l3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 19:57:49 +0200
Received: by mail-pf0-f177.google.com with SMTP id c20so40262914pfc.1;
        Mon, 04 Apr 2016 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2FSkrf75TKvPqzExMIgAXLGpXfi4Pabl4TbdpWyczTU=;
        b=nTfWK2XSNmQZZ4Cw+d0YG7ui4dfF/AuiH/UqZxUGsCAxOFCeTTJKXT5/ML29bEPJhX
         gs9b0jY5aMyKgo6jZix8HzOn8AiLVAVZwPp+Pzs/VE+FoqJxsZyWcKDxYwK26Nw9ci98
         /xoneHWPgA3NrY70B9JJd1RTSfA9Bsmtq7FnHp4vRo40rJLpmKWHc+ZR7NoJcEGYmaZ0
         wQS/bVQMAxwDEZ0tVKl99iGZ+sZocTBxN0breMPf/mIsZ9QsCsLiOlAJ6P3KQFuCiSCf
         BPkIg2F87yN+bwcmXISzUfRm/Se8rzCqWZMvsxLLyKopDgHUBCRGCgbsVFdIYGw2Du2s
         /P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2FSkrf75TKvPqzExMIgAXLGpXfi4Pabl4TbdpWyczTU=;
        b=jNMsr/v4B2Z1e5r18nGpWiJX+GkSTz+c0tqTv1ecqjzHfV6uH8EYtJhCNJ8jX19AHb
         7/++NHAfkIme/pfSzCiMP5soEaClVBemj7ZenWu0R4w8W8wKKLvOaFHI7eK8fansm1rH
         hid/EnijX2ImKQd9QnTgWQqxxhuD7ZbKNL/w8oy1f3qGrD0Gm1P9654DcNTq32Vn0pzV
         3hsm8x79flVvLE9r8alaKAHNx3G2/CAjBKh4bhtl8qjfNrcK7NWs/h8e2vYapu12pqyL
         SHE9Ua91Fb2cZhP6UUJ6+QNj57VqpTlXer3rX2bI3MmFfDOKQlhmOVQInT6hN6hlouyP
         OFCQ==
X-Gm-Message-State: AD7BkJL8tVN774+mW9d0NpUrVO77z1oYMQ5rniwzhEi6xJYirYD3F48f+jzC+EkgwhYImg==
X-Received: by 10.98.69.75 with SMTP id s72mr23581471pfa.66.1459792664208;
        Mon, 04 Apr 2016 10:57:44 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 20sm40948752pfj.80.2016.04.04.10.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 10:57:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 2/5] MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
Date:   Mon,  4 Apr 2016 10:55:35 -0700
Message-Id: <1459792538-19854-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
References: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52879
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
 arch/mips/mm/c-r4k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 15ee3d94688e..eb1588206a6a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1311,6 +1311,8 @@ static void probe_pcache(void)
 
 	case CPU_BMIPS5000:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		/* Cache aliases are handled in hardware; allow HIGHMEM */
+		c->dcache.flags &= ~MIPS_CACHE_ALIASES;
 		break;
 
 	case CPU_LOONGSON2:
@@ -1750,8 +1752,6 @@ void r4k_cache_init(void)
 		flush_icache_range = (void *)b5k_instruction_hazard;
 		local_flush_icache_range = (void *)b5k_instruction_hazard;
 
-		/* Cache aliases are handled in hardware; allow HIGHMEM */
-		current_cpu_data.dcache.flags &= ~MIPS_CACHE_ALIASES;
 
 		/* Optimization: an L2 flush implicitly flushes the L1 */
 		current_cpu_data.options |= MIPS_CPU_INCLUSIVE_CACHES;
-- 
2.1.0
