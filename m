Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:58:49 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:43320
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994854AbeBBDzV57Fu0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:21 +0100
Received: by mail-lf0-x241.google.com with SMTP id o89so29434947lfg.10;
        Thu, 01 Feb 2018 19:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3YFZQsA6GioPELRkVECBm/dkPa2HLVOgF+uf5PCrLKY=;
        b=U73+TuBm/UB4T2G0YR3QgOHwa73o+S4qy+ZZWWl9F0j/9Jup9vfNX5YR11jE2/whCM
         dX3DLHpx1HBRTKs17E+zl58teEmED5l6rXpzeQqJgbosdbQRKyOgBCkfrw/kLhMNpYOP
         vTZT+nE/+i/n+dZ8lENQybE5sMUYXGd0EhfHb7HrK2uE5Bh8ds+RFWFyVHShJ42E6zSa
         Pgflc1DR4IlNNp88LJExom+7NTI6dKAITMcAt+MpLjsOrBfPX/+lfC4+ldgr+Uu6lDl2
         iQCzaPYhg2Tt/N08jgo3laMwD3YgqBSMOrb6fOQ2fe4LEST8An9oNPMeDHfSxRq+WXLc
         tiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3YFZQsA6GioPELRkVECBm/dkPa2HLVOgF+uf5PCrLKY=;
        b=unENbojXAcM0T2buLX+V1HR11u8ajly0OOc5xjEFQCxQ1o+yXblnVaHLg+i1hntcwv
         dBJ2ZCnZgD28665X4qCh3Cnmv/kCPcCiAgQ96hSXUvkCO39iBoF/3HKTuSfnr8e9YQ4L
         XjNNKk3QmHzaxaOogpkdkTXcQcnSzszIGdYsGnxgqW4LZedoGe5L6CeCrfMsbH9fheFt
         P8BJh2y8JnEMHNMVHi65EJFBcWTzeu5x1Ybjn/Qx3ye6EotyxbVugj2kbQ4GlKGLOD4h
         WCuG/jXE4dIdr5UNYvd9nx4WGfgquXMZ7QN93NFXZl2nvp0gEpZRU1DcFeGQQDvaz7Z0
         64Vg==
X-Gm-Message-State: AKwxytcJZjzNltVW9mpCXupaTVdK+AZxCuwAkwXqtXYz6rGFQ3DvObQZ
        DfG7mTKjXK+eVHufRwSkfVn3Z9Xk
X-Google-Smtp-Source: AH8x227CsG8UaJtqNjezaOwtDnAwgFYFOwQmAZvJwtTWhrw2vJCo4JRMDy/ifr/PmdTu4bk4miTycQ==
X-Received: by 10.46.118.4 with SMTP id r4mr2890558ljc.123.1517543715273;
        Thu, 01 Feb 2018 19:55:15 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:14 -0800 (PST)
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
Subject: [PATCH v2 09/15] MIPS: memblock: Simplify DMA contiguous reservation
Date:   Fri,  2 Feb 2018 06:54:52 +0300
Message-Id: <20180202035458.30456-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62415
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

CMA reserves it areas in the memblock allocator. Since we aren't
using bootmem anymore, the reservations copying should be discarded.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 54302319ce1c..158a52c17e29 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -755,7 +755,7 @@ static void __init request_crashkernel(struct resource *res)
 
 static void __init arch_mem_init(char **cmdline_p)
 {
-	struct memblock_region *reg;
+	struct memblock_region *reg __maybe_unused;
 	extern void plat_mem_setup(void);
 
 	/* call board setup routine */
@@ -846,10 +846,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-	/* Tell bootmem about cma reserved memblock section */
-	for_each_memblock(reserved, reg)
-		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
 }
 
 static void __init resource_init(void)
-- 
2.12.0
