Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:59:42 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:43321
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994856AbeBBDzXN3U40 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:23 +0100
Received: by mail-lf0-x241.google.com with SMTP id o89so29435000lfg.10;
        Thu, 01 Feb 2018 19:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lU2w3nYehV0zv+Sv60qr/y3RIklPpAyO9yrdHEVrk08=;
        b=j78FfItVk82PF6wCKUyoAeWgWBVUnGXs5BDvHjnhp8GjsdHnHDPBLMUDkki3y0scuU
         TXYWQWoKOAzdcHhpmapA2r9UHNANZfjaT1sOjFf9gev6EcL8D94VyRwOR/GFTJZpTbwo
         B+PR/EIXoWnxBTSeBzM/wi1Xmkl6+Ti6rnMrtfW47yVihHeHYY7bAgFWtynL7zBVaVRT
         LeonjPVBFei0Q5z3z5uJy7ySxzlwCe7msuUTmUxCoGewLf5bbwmU6DfA82kGa4F9ZOhT
         hsgSCnbBzELK+avym3CB2JvpUiWQFaE8ldUDN4YbhBOzOEat/9JWFI5V14GTEQNhr4sY
         fvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lU2w3nYehV0zv+Sv60qr/y3RIklPpAyO9yrdHEVrk08=;
        b=BXgu6gLZqSbql3Z3dqV0waUKmjKHoy1xVn9NQSYaDMCMRz82m0beXvyYX5MO01Q19Q
         KULnxqTMTvCRtRoXVzEwnWCe7owh2eyF3SnpjBJ+stWSuBAr0gGlq2A7kV+A+pFrGQgZ
         89rfp8ck5OXCnrRPHpBcS5AZzyL5ngd7gcQEpCBr3sjd/eXsoMaBo/Qd5AeauM1i3EfX
         mlHU6Y0kumbb8NFJzMAA/hVPIrIZ26Fe8yGdlZTlZgubIwOw6H1UAvhGSVXRJzrwzsH4
         C3ouRBZZaIrbBA6Yln1+6xMU6CyUbLGhkD7jR6iyq7eo6EdVO5LN9mzb+z+YFfyKx/2i
         KicQ==
X-Gm-Message-State: AKwxytf6C5lsQM3ZXjRHDxe1lVAWSTUHtDV36cKXe6All1hrgvDAZUva
        MWtRGRPjxg236tERLuWQymP4jec/
X-Google-Smtp-Source: AH8x224ff+sexjgCGF2eXy6/Jk5xfMO/xXC8Wiar7bNMIRLkYPTidSGaCqypZUQOE0Ll0GpYYEQ/dA==
X-Received: by 10.46.67.147 with SMTP id z19mr17373611lje.28.1517543716669;
        Thu, 01 Feb 2018 19:55:16 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:16 -0800 (PST)
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
Subject: [PATCH v2 10/15] MIPS: memblock: Allow memblock regions resize
Date:   Fri,  2 Feb 2018 06:54:53 +0300
Message-Id: <20180202035458.30456-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62417
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

When all the main reservations are done the memblock regions
can be dynamically resized. Additionally it would be useful to have
memblock regions dumped on debug at this point.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 158a52c17e29..531a1471a2a4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -846,6 +846,10 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+
+	memblock_allow_resize();
+
+	memblock_dump_all();
 }
 
 static void __init resource_init(void)
-- 
2.12.0
