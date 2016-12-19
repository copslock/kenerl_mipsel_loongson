Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:15:16 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33121 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993098AbcLSCITIgKkK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:19 +0100
Received: by mail-lf0-f68.google.com with SMTP id y21so6157136lfa.0;
        Sun, 18 Dec 2016 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Z/LmrbpJCN0uUQnc2N5mjFkAzHAMQU/E4467qJgViA=;
        b=g7CexHP1tC3y9mSktsh0UeptHS1uQHnc4mNr/bVT7hqazWojdM8u8C9lSDA+VGJf3p
         QvIRY2lsCflMX0XBmGUqdy2r0kqMsSb0k6zpDUrXwNnkyF7WLUUkRsbjRcnMyTEfYiFz
         TMGmLZ9ljtMRN/7Y58RVsRxQMRS4rzzEJn9H72zu1OqM08H+ZGdx5xeG7JbL6hB98+sf
         jk6Mp7EaMQKa9TL7MwqcC+4OolZSOEKtxdlmYwKxwhjwXtu4xp7rb2bRmSbLfJ0UnYJD
         gNTDPA+fUkzVdbbrZI7Q9tKQHayBxA72fj8hZjnnogQx8NHtht1K4AlhpCcnT1EJJlk8
         EPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Z/LmrbpJCN0uUQnc2N5mjFkAzHAMQU/E4467qJgViA=;
        b=qAgBbCHbI8luOHpBg3nc6z/Iq91xsZ9JKU6OaDAB4eiFvEVR+5cWkrDieCdPfrbx85
         DCFtz92zvJ3E6z8DQLf+S/cEZx5/YJVPZUkaPyOjdZITViStTn0HgXdEO9weUFcFjcjy
         bIpcp+IL7HvsgrOXe5Q0WdcQQkBz+Bgp2TnRCZs5lpIc4EGAtXTWWFh8EuvGfutBlOGb
         7p1Vc/hV7yjsFMyMPHKUx0cBl6S0WaYrBtGik5qfLL1jsdp47u0YcwAgNMHpQW61R6B0
         7zx6fCX2Pv1qNROB0cPbAwWwq3b6snh4cNLIrFuatQCPmtuJXaXbMyUoRuUkcCk///VX
         oAgA==
X-Gm-Message-State: AKaTC03cNSEmTuFp1eJozPRB7+lvHLee+TORUeNkjsUTNJSGZ1+EcUd4mmINW/zfBWKeSA==
X-Received: by 10.25.74.85 with SMTP id x82mr4049914lfa.154.1482113292460;
        Sun, 18 Dec 2016 18:08:12 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:12 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 18/21] MIPS memblock: Slightly improve buddy allocator init method
Date:   Mon, 19 Dec 2016 05:07:43 +0300
Message-Id: <1482113266-13207-19-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56080
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

Just add some minor changes into buddy allocator initialization.
After all the alterations it shall work just fine from now.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 98680fb..13a032f 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -7,6 +7,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2016 T-Platforms. All Rights Reserved.
  */
 #include <linux/bug.h>
 #include <linux/init.h>
@@ -462,22 +463,36 @@ static inline void mem_init_free_highmem(void)
 #endif
 }
 
+/*
+ * Let buddy allocator run
+ */
 void __init mem_init(void)
 {
+	/* Setup maximum number of pages of memory map array */
 #ifdef CONFIG_HIGHMEM
 #ifdef CONFIG_DISCONTIGMEM
 #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
 #endif
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+	set_max_mapnr(highend_pfn);
 #else
-	max_mapnr = max_low_pfn;
+	set_max_mapnr(max_low_pfn);
 #endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
+	/* Highmem starts right after lowmem */
+	high_memory = __va(PFN_PHYS(max_low_pfn));
 
+	/* Initialize speculative access registers - MAAR */
 	maar_init();
+
+	/* Free low memory registered within memblock allocator */
 	free_all_bootmem();
-	setup_zero_pages();	/* Setup zeroed pages.  */
+
+	/* Allocate zeroed pages */
+	setup_zero_pages();
+
+	/* Free highmemory registered in memblocks */
 	mem_init_free_highmem();
+
+	/* Print out memory areas statistics */
 	mem_init_print_info(NULL);
 
 #ifdef CONFIG_64BIT
-- 
2.6.6
