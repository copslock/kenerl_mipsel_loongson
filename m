Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 12:38:08 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:43229
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZLiCQ0ZxK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 12:38:02 +0100
Received: by mail-wr0-x243.google.com with SMTP id w68so21972440wrc.10;
        Tue, 26 Dec 2017 03:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEMdNd/CM/cg/SQ8zowbFcGBsiLUxksJF8urFYAzkKo=;
        b=Ub5K8Kg6dbzn2zYz1fS1OrsDnsI1Ip1lQZYxVTQcCpvj3g7kO5VQJg3O7EyQ5yRhfz
         JekONaEYZRfrKgMAiXysJXS6bu/Xocq8nRRhAvwMXU42mXY0SGwAGyla407Fabw1/Oll
         OXwEyRdww9VxVSr+ulewdtBVE75VIHSKlo6T36PD9saWGpnyZ8ElJHRBW1AqWbyb7yM6
         7Kq0I/YaCnxjNnwyjngfY0kLFMXQOj61QGVVRIMDlx74synt/j5yrhn+xbVWdkeOAKWN
         o0BR+u9UBrTgDfIB8klMDsbQ1y0TpCDeWLYpsIuJenSemYth3diJOetGoI/O+y2/ePe9
         bDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iEMdNd/CM/cg/SQ8zowbFcGBsiLUxksJF8urFYAzkKo=;
        b=MA7pg+EWEJYyVJN5TUazoMkz0p45KLUZq9M4SyJ5rH5PMr6Xwn3LZE67TfAUTh/qgT
         XDqImUsFQUPwsE33QHN+pClDA1Ep1B2nKlbFj8IGIcZsa4d7r5dWK9py4uNXew1bRmdF
         9y43OJMCSmBh/FPRbLcEmK+7LnC6bgyBLNRG+lG5FcILLY0zXsxLPJA1Lfur42E8/UDS
         fm6V/RN1ZAmU4YO5Hj2afonU+ZVNQPj4tIs2Csv/KlYrE6Tsl0FjsOAAjK3et39a4NGd
         uckvkOqHSb0I0PBzUbapcH+pwd8tBWoI1Eqg1Zw/eltyBuYFdNpCn9chWwDxx768/xS0
         NCvA==
X-Gm-Message-State: AKGB3mIMtyXwspV/J71Cgn9nz8n2m0BhBaNakyjz62L9eRwD4RkDWJ+I
        ytORmvadT1rHuff3nU00XZI=
X-Google-Smtp-Source: ACJfBotNirvLRKEEp3hjKRDvDkR5dLzZkABxfFfFogvMbdP1r3wmjB6D43KdpULgeKLtcLNLdCrwww==
X-Received: by 10.223.177.198 with SMTP id r6mr17289569wra.253.1514288276506;
        Tue, 26 Dec 2017 03:37:56 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id g84sm8178813wmf.26.2017.12.26.03.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 03:37:55 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9CE1D10C1B2E; Tue, 26 Dec 2017 12:37:54 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        David Daney <david.daney@cavium.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: add declaration for function `memory_region_available`
Date:   Tue, 26 Dec 2017 12:37:13 +0100
Message-Id: <20171226113717.15074-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Fix non-fatal warning:

arch/mips/kernel/setup.c:158:13: warning: no previous prototype for ‘memory_region_available’ [-Wmissing-prototypes]
 bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
             ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/include/asm/bootinfo.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093bb17a..32e3c9a2c5a0 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -108,6 +108,7 @@ extern struct boot_mem_map boot_mem_map;
 
 extern void add_memory_region(phys_addr_t start, phys_addr_t size, long type);
 extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,  phys_addr_t sz_max);
+extern bool memory_region_available(phys_addr_t start, phys_addr_t size);
 
 extern void prom_init(void);
 extern void prom_free_prom_memory(void);
-- 
2.11.0
