Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:58:21 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:32867
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994852AbeBBDzSZ6iR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:18 +0100
Received: by mail-lf0-x243.google.com with SMTP id t139so29463441lff.0;
        Thu, 01 Feb 2018 19:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+NQJlS4hcQxkkwrnbKPaiD9+u8Tv9sM4QEVl9ruxHc=;
        b=UFJwrhv/hHeV/Qx5Iv49reGFZVyjKughBZBMZVw0of5H5qhLODZnmRwjEqa1YSFdco
         pIVZRRNazNfia2o2u0g+uNOUzY0dt6R8IZ5T46KejRZ/Arix7q8IpGZBCg7rCs/ectif
         l+PF5NWjQHr+BVkT/9Mj/HqdYjo8ZdqlymEHSut/4aNYT2qo4toj4Tkw7kskstCDWEsP
         6+xU+OfA3r4V9qtaPATVSr4UU9m4ZfXpEFDHrOrEru8XdfVIztQ3heGVPx31cKItBb4p
         nOIKIZu5uZ/ygLt3IHQJ6nNO2Bk6haLc32Kmnr03ByaTe3CYISZfhzptfLi4Sg0wJeXw
         86ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+NQJlS4hcQxkkwrnbKPaiD9+u8Tv9sM4QEVl9ruxHc=;
        b=ukCO9ltkQXA/0ckPMvCllpw0nWdscizS2xMte94Kf3CLS0sOEtGmdvgTBsDSvVhloI
         3Xri8TcphK0Xxkph6oBHfTLK/V2zSt8StzfkQlC3ccX9F9lDJN8PRe2o3bV9hG3Gvdfc
         TEPXJyiWcZg649R6XCM0CtWeFuevGl3zyEYkhXC5zJqkXyaIULjjSGXobgYvhkTWKrWl
         ZkA1Yh+hLjvTFAh5nvERsb97utForidfLz6ldgCKX8Dk0OCN8lvKkDriaEfcX8pLmM1+
         ZjLFZOCEyJPsr8HwmIVmq5pcCwxxp9bhr+rAi4EuBI0QrCCGPUlb5kad7EjxDEkCqx6W
         +cJA==
X-Gm-Message-State: AKwxytcQW+v2WsoKYdVJRLw+6/MLicSZZ4llFUZJG1zNelmUc4Un7Iub
        6/Uozc3ciJC5Hb5I+ZFDD+vRy0SZ
X-Google-Smtp-Source: AH8x2260bfSTbYaLvJxSZZlCbdYLPDXPdE/ntuXFzXOeAcxSEtC1Ee/IuzIDihKzq1KyLwqz7TuEBw==
X-Received: by 10.46.23.84 with SMTP id l81mr14679684lje.146.1517543712647;
        Thu, 01 Feb 2018 19:55:12 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:11 -0800 (PST)
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
Subject: [PATCH v2 07/15] MIPS: memblock: Reserve kdump/crash regions in memblock
Date:   Fri,  2 Feb 2018 06:54:50 +0300
Message-Id: <20180202035458.30456-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62414
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

Kdump/crashkernel memory regions should be reserved in the
memblock allocator so they wouldn't be occupied by any further
allocations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 72853e94c2c7..b2a5b89ae6b2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -826,17 +826,15 @@ static void __init arch_mem_init(char **cmdline_p)
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
 		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
 		       setup_elfcorehdr, setup_elfcorehdr_size);
-		reserve_bootmem(setup_elfcorehdr, setup_elfcorehdr_size,
-				BOOTMEM_DEFAULT);
+		memblock_reserve(setup_elfcorehdr, setup_elfcorehdr_size);
 	}
 #endif
 
 	mips_parse_crashkernel();
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end)
-		reserve_bootmem(crashk_res.start,
-				crashk_res.end - crashk_res.start + 1,
-				BOOTMEM_DEFAULT);
+		memblock_reserve(crashk_res.start,
+				 crashk_res.end - crashk_res.start + 1);
 #endif
 	device_tree_init();
 	sparse_init();
-- 
2.12.0
