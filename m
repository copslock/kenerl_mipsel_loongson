Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 20:09:34 +0200 (CEST)
Received: from mail-wr1-x441.google.com ([IPv6:2a00:1450:4864:20::441]:40750
        "EHLO mail-wr1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993964AbeIYSJBVGvYH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 20:09:01 +0200
Received: by mail-wr1-x441.google.com with SMTP id y8-v6so20684987wrh.7;
        Tue, 25 Sep 2018 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qpq8xhJhRVyPIhybIrRVbsiL98w7WDObH988kQk9jIk=;
        b=lyH5kQl0MtYSQ0e0ZZ+Aw+pOZoJ05xEGN105fykxTjUCsXt905xiZczKKpj0eTnj0i
         fl8DyIDY6xwMIj7ThYO523uNwUskC4HcfyZL3Qee58dw70MEHj4p+zFM/0PmYIS29kEC
         78/oUC948cBKaA99QqyEt3QOy7VKw6xWXE1xzeH6zMfuRaYMv5arvoYJJJmwgeloHjCl
         a/r3Jl4itW9o3modo6t6Ca67XaP47Wzr6AptZ4eq2Vh/w80b8s+UH95r1YkQqGTihTqo
         VFNUvPhQazUwnd/cAZfTreFSVw9KiJgiK66fdV1oQMhvjP7gyM0gdtHZUslPIFdUzNuj
         jt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qpq8xhJhRVyPIhybIrRVbsiL98w7WDObH988kQk9jIk=;
        b=AKiCJijbx2arEQ9t7T+XKOYGv4gzvpsaPOd43OubYwxDun72DESJ2HAZpgopQnlBG1
         oehiqlwDAzllktCYd/+GFruqci+o60sCHP8QZb7kJlGaX1EXH7wtSsbnmpSmljPtPIdX
         ok3NaxSzcBBF9z0khCT03Mg/6ls8SYehed3LQ3iTVTl7kA2ikawdItQIjfJKLUM0yAj7
         LARXP/Bb4CpEySQCl5YqPBuemCh7eauNbCv+rl8bsPBWvr/2kgcqehFojnzdHEVgplT8
         wJXidw2J970Q6Wa48b0ULB/iSumRV/OT0xeZVM5qzxldJNuTO9xppWH4PPOf/fMdAwAM
         kMUw==
X-Gm-Message-State: ABuFfohfsbQ9Lo9SoZGEtJTLfK5CDPUbyS2WJ9dk0xEA5zhnjpLbo3eW
        1LreW2TMFlQvs8PhUzQx1weWxt5MayI=
X-Google-Smtp-Source: ACcGV60Nm85mSWG4aFlMQvgbwX8t5k+k0mnEmFmvSAP6BqtZK1gAkzpqSKHfCHw0nuP/X9CwgD9NqA==
X-Received: by 2002:adf:ac13:: with SMTP id v19-v6mr2077035wrc.135.1537898935836;
        Tue, 25 Sep 2018 11:08:55 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:55 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Octeon: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
Date:   Tue, 25 Sep 2018 21:08:25 +0300
Message-Id: <20180925180825.24659-5-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

The ELF appended dtb can be accessed now via 'fw_passed_dtb'.

Since raw appended dtb is accessed via that variable too,
this now effectively allows to boot with CONFIG_MIPS_RAW_APPENDED_DTB=y
on Octeon.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/cavium-octeon/setup.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..3c26054ce72b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1156,7 +1156,6 @@ void __init prom_free_prom_memory(void)
 void __init octeon_fill_mac_addresses(void);
 int octeon_prune_device_tree(void);
 
-extern const char __appended_dtb;
 extern const char __dtb_octeon_3xxx_begin;
 extern const char __dtb_octeon_68xx_begin;
 void __init device_tree_init(void)
@@ -1165,15 +1164,12 @@ void __init device_tree_init(void)
 	bool do_prune;
 	bool fill_mac;
 
-#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
-	if (!fdt_check_header(&__appended_dtb)) {
-		fdt = &__appended_dtb;
+	if (fw_passed_dtb) {
+		fdt = (void *)fw_passed_dtb;
 		do_prune = false;
 		fill_mac = true;
 		pr_info("Using appended Device Tree.\n");
-	} else
-#endif
-	if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
+	} else if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
 		fdt = phys_to_virt(octeon_bootinfo->fdt_addr);
 		if (fdt_check_header(fdt))
 			panic("Corrupt Device Tree passed to kernel.");
-- 
2.19.0
