Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:24:19 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:43749
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994688AbeAQWX1YD2zC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:27 +0100
Received: by mail-lf0-x242.google.com with SMTP id o89so19872887lfg.10;
        Wed, 17 Jan 2018 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37mp3H8Yx67iAapj8s5cUFrXkBq8B+mYLLWt6ZQCNw4=;
        b=lfpYolJrCaMnUVfDebLnu0ydCazvqmGK8QQ6lwNGHvAoveQjgotDLHeRhr3zk/+NKS
         BDjQkuKoovadtYbxv/pF/Z9ZvuAN93CYgvXCOmPc5jcGus32iB+pd/ENXZ3FUr82XRwL
         R6d8hBaQ/UAk01OgZSJZI8ZEuQC4DmX6knIVQvhtL3wg3rUTdUZjd/C8NeDfgKMwXi3c
         8Z91/5xOG2pwFVfGG6a6mE9qPcwtGs7FP8J9d9M59x15SCUW59D4/8LTS/EfpkrbGZLo
         /6/cYPhxHncv0fOIbvc0y9epkHfYD7YlEUlBS5R1ShSEs/1cSDLDC9W4y/IrL8fwbe+3
         fubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37mp3H8Yx67iAapj8s5cUFrXkBq8B+mYLLWt6ZQCNw4=;
        b=aTrLPpUxU2q7IfpEYX11rCBQ7e9cSFfAiuFC41h0Be6seH5pgTdOZZysCOuG9+SWHA
         6SFtU0/90C2bXF5ucpft8Vo01CSosnutP+PjdqB05PV/LYz7EsfYCN5bNffp091sX2AJ
         29EMsJvvIaGO+SLijRz1djz+M2cFIrf3onVI/UKbU+rZg2Zb0s7tGgOEOTY8Ps1jFVOi
         7G59RHzoFCHUNsHVBOu5eAWSekJNiEMkbZ+ufcaQTq4IpqDygwuts/XorcukqbFC3X4b
         1RfQB+ael4owHMWlswcvjT4si51fg/P3yXPVIVdbjb45drobXhb7LYHgjO0Et5KKjlJ2
         Nbzg==
X-Gm-Message-State: AKwxytfgkoV0lOJgdVA/CASznwJDPR/zxFVC/aGoCrG4/R8vFM6bktUN
        PotGUQyOf69PzIrNcwshEZfVU/ey
X-Google-Smtp-Source: ACJfBosSv4ZNXmUtDibS+EP5tF1wrL6NJcauAJ8tXnxFpo9lSPOBUQHDApSYSR72CqdR5FtHM85SvQ==
X-Received: by 10.46.99.199 with SMTP id s68mr4500835lje.50.1516227801678;
        Wed, 17 Jan 2018 14:23:21 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:21 -0800 (PST)
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
Subject: [PATCH 02/14] MIPS: memblock: Surely map BSS kernel memory section
Date:   Thu, 18 Jan 2018 01:23:00 +0300
Message-Id: <20180117222312.14763-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62213
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

The current MIPS code makes sure the kernel code/data/init
sections are in the maps, but BSS should also be there.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 76e9e2075..0d21c9e04 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
 			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
 			 BOOT_MEM_INIT_RAM);
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
-- 
2.12.0
