Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 04:49:35 +0100 (CET)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:33044
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991065AbeKJDtc0xqZZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Nov 2018 04:49:32 +0100
Received: by mail-pl1-x644.google.com with SMTP id w22-v6so1806575plk.0;
        Fri, 09 Nov 2018 19:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=T9dN/ncKlBehLDaSNg6/sp1oUy0pl1qmndqjCIK+Km4=;
        b=vfQKFrMQLDpaPrh2WnS2V3pP4gsJ9VPH5JS5UsNmfAlZYUwWlWkyFb9LLPH5Qy4jLw
         Xhzzq5pgDGjjR1qlH8BuuhzgO0/xluo56vwdGoDZMogTW0x1+Drubb0l13xsRDv9/CbC
         yHrNbnvZHkZBGTBUYimNeRAl8KY2kHloshtRHwWGfBI4cWgO8uTyP3wTuxeSg6Xqw98r
         x8Kx0Q57oyrnQXEalnqVZI/vDuHPYsHvcVhXH66bEPvbd0K0JlRbmy43PWK/nehZ50a4
         LVdjk9hs9uybQkT5xPWltFRwyWRGYIRWdeAMYUwGvhf/DHb6Y3yLC5+FiQ8VPrs2tD2r
         jFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=T9dN/ncKlBehLDaSNg6/sp1oUy0pl1qmndqjCIK+Km4=;
        b=m9hfWiwGQLPUTQH65d5hwRAxnL3Rp2kHratQ+Rbj6QmFyiEFQaJsWtVeZh1vZNzNxj
         guw15YZOZxCSrWjBnW4+halzn8xyM5Pw/EIpNRs2rW6wY/Gf87lISQ4h4yLEiLvytOJ9
         C7r5S82t0O3FYyKwMnNNDOTRXuzcoDHPUorVm45WL845d7fj54HUwUqA+j9alW+Rhqqu
         Iv13ZkLxdymsvqQGmNZZZ4a+L9lnz1jVLIirQ++r2Xjo1zM9n/+DsnrraTqk4qwhhn6h
         U2nnJpisF2yfUjggojcB7uq4cbvIYIhYX+4zLHkLDWrE1YxP8sMC6xbmzVnNal5NmKgg
         79FA==
X-Gm-Message-State: AGRZ1gLpfgFcoYwbyoOLsz13UZ3plz8hwj6+NxZiKGUJ2QG37euQ8xUe
        OOmH+TjIkQmGVVFm9elojGvp9VGFAPw=
X-Google-Smtp-Source: AJdET5eBZw8V5Eml737D0qmWPhdLSUHlzp+Fh3NbXUJE8hGe0gltYUTm5xwLJVp3bkZAHkV8h+uFUg==
X-Received: by 2002:a17:902:2d81:: with SMTP id p1-v6mr11200125plb.97.1541821771260;
        Fri, 09 Nov 2018 19:49:31 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id m7-v6sm8115892pgq.59.2018.11.09.19.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 19:49:30 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Let early memblock_alloc*() allocate memories bottom-up
Date:   Sat, 10 Nov 2018 11:50:14 +0800
Message-Id: <1541821814-7738-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67217
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

After switched to NO_BOOTMEM, there are several boot failures. Some of
them have been fixed and some of them haven't. I find that many of them
are because of memory allocations are top-down, while the old behavior
is bottom-up. This patch let early memblock_alloc*() allocate memories
bottom-up to avoid some potential problems.

References: https://patchwork.linux-mips.org/patch/21031/
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/setup.c | 1 +
 arch/mips/kernel/traps.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ea09ed6..8c6c48ed 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -794,6 +794,7 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	/* call board setup routine */
 	plat_mem_setup();
+	memblock_set_bottom_up(true);
 
 	/*
 	 * Make sure all kernel memory is in the maps.  The "UP" and
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b34f9a7..c91097f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2290,10 +2290,8 @@ void __init trap_init(void)
 		unsigned long size = 0x200 + VECTORSPACING*64;
 		phys_addr_t ebase_pa;
 
-		memblock_set_bottom_up(true);
 		ebase = (unsigned long)
 			memblock_alloc_from(size, 1 << fls(size), 0);
-		memblock_set_bottom_up(false);
 
 		/*
 		 * Try to ensure ebase resides in KSeg0 if possible.
@@ -2337,6 +2335,7 @@ void __init trap_init(void)
 	if (board_ebase_setup)
 		board_ebase_setup();
 	per_cpu_trap_init(true);
+	memblock_set_bottom_up(false);
 
 	/*
 	 * Copy the generic exception handlers to their final destination.
-- 
2.7.0
