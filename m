Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:57:08 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:41090
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994846AbeBBDzQxRew0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:16 +0100
Received: by mail-lf0-x244.google.com with SMTP id f136so29434460lff.8;
        Thu, 01 Feb 2018 19:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4T822ZZmQ+EmmT3oOcrw8cWfGXb3ryq63lVTfFBzVH4=;
        b=WIfCnFc2dTYQSvg8bcWGGQsOPO/v4T/qzk19Cn8FGqlLI/1a23V1Nn1D3I15kvYBMl
         8iczTm04Z04Dr/1rU0ikzxCCbwDao3XUulmlb66s7Ybspy+xVoJoMCJGf8ueDh1WWOP8
         WDWkpvY8+4wafhbzXrXbzGU4PEdJx6gynavhV6uAN6Y7vAnstoCM+V7AQsH9Yp9TkdpP
         sFvK4npScoWSWClqbh07yB3D80yBJzPxVrgFgz1k3m5xWnm0cVa7v0fKF2KM8J+2ezgJ
         SlP+sLL6jB5Aeuh278shr8rGdyjAK+UTolDkd2dAVcaUScDfvO5ftRl4td62rGgf1mor
         0GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4T822ZZmQ+EmmT3oOcrw8cWfGXb3ryq63lVTfFBzVH4=;
        b=eReTOenVrZeJEEkiNaUO0Ku0Dq9Kcemppp6G0kJyoVfwNdhdBkY4wkcrIb0ZZoc1kU
         b/CuKUz4W82kLJaZtOLG497LsBgR1r6DG+j9PKSHzIP9e/nknrs+PpQOz6ez+P3x2sYV
         e1qvujaaWrRR/EWLGwXopvEPrs1C/HK+lpdFWQZwkZ0vEFK/Sl02ipWZ4j4x+P1N5lyV
         j4rtxSMhyuwgs+yToFUHzGxs+x5B71rhXR6TIHTrPMWePxenaXIdGP+8KKYsqa54FR+1
         eCw9V+wOK0vLQXLcBGPFEtlO0FDV53ySg2E5WLts1ZsHeOTzxYbNdYjhtgqQ/+Pe3N9V
         zEqA==
X-Gm-Message-State: AKwxyte/eQgfqY/anwRofobzbCy95re865s65hmjnC1p4lJJVOon6Vdl
        y8PN36W+4SUP/m58COa8q/Hn3KEK
X-Google-Smtp-Source: AH8x224A3n1jcAS5KmVhcRUSYx0YYqPGhhmt8nK3Fynn9g0t/yVPPstyC6uqoKxsZVo8i2MU2YWuug==
X-Received: by 10.46.117.29 with SMTP id q29mr19137666ljc.65.1517543709867;
        Thu, 01 Feb 2018 19:55:09 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:09 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] MIPS: KASLR: Drop relocatable fixup from reservation_init
Date:   Fri,  2 Feb 2018 06:54:48 +0300
Message-Id: <20180202035458.30456-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62411
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

From: Matt Redfearn <matt.redfearn@mips.com>

A recent change ("MIPS: memblock: Discard bootmem initialization")
removed the reservation of all memory below the kernel's _end symbol in
bootmem. This makes the call to free_bootmem unnecessary, since the
memory region is no longer marked reserved.

Additionally, ("MIPS: memblock: Print out kernel virtual mem
layout") added a display of the kernel's virtual memory layout, so
printing the relocation information at this point is redundant.

Remove this section of code.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---
 arch/mips/kernel/setup.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b5fcacf71b3f..cf3674977170 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -528,29 +528,6 @@ static void __init bootmem_init(void)
 		memory_present(0, start, end);
 	}
 
-#ifdef CONFIG_RELOCATABLE
-	/*
-	 * The kernel reserves all memory below its _end symbol as bootmem,
-	 * but the kernel may now be at a much higher address. The memory
-	 * between the original and new locations may be returned to the system.
-	 */
-	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
-		unsigned long offset;
-		extern void show_kernel_relocation(const char *level);
-
-		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
-		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
-
-#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
-		/*
-		 * This information is necessary when debugging the kernel
-		 * But is a security vulnerability otherwise!
-		 */
-		show_kernel_relocation(KERN_INFO);
-#endif
-	}
-#endif
-
 	/*
 	 * Reserve initrd memory if needed.
 	 */
-- 
2.12.0
