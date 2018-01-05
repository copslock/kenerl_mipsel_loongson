Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jan 2018 00:14:43 +0100 (CET)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45106 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992956AbeAEXOfeAyFF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jan 2018 00:14:35 +0100
Received: by mail-ot0-f195.google.com with SMTP id o1so5160734oti.12;
        Fri, 05 Jan 2018 15:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LBnnqjf+JYcv7Hs2WO4+gZN9BgoZl7bR2TdhCTKnpE=;
        b=Uie88AGbiOG0ikt2ELE2AW2sVsEmo2dD4awd+ts+6+2a/JupYjh3O8vamRJrN3AujX
         g6eqhVHORJziCk5zlRWw2wjmPE8YDmrIkZz1AoVZLAi4NGSttGQJ1HoerZbEEgWsKQyN
         b0wElRS1x01kYREG/r9KU9yEgeLhNnOFFQsmaBScHh2iMqFfyStfv7D3lgAaD94+lIjA
         Eu4RcUdp04VZ1PntTOyXzQceIlu0Qq3zveEhySqCVRssnjJcoO8kzY8QNMmm/JRudb5w
         LfW2nOmN2Qbo2++dinT1SeWK7R13nNj5saQFKoe9VzTxZLHDdmYLpxUtF+quo3quKrxt
         6CQw==
X-Gm-Message-State: AKwxytdKlIHchEmY/P7h0Sgfb1FBtV/D2m1PIec/5Qci+GRMIoHlZzDz
        +quwzvyeGIGCGvyAorD+CA==
X-Google-Smtp-Source: ACJfBot4dBlQEanOKF/35vVha6sZyaYuGRa5RrvijXKAt7SreVttRNWYoa1ul9N/OEPqbn0Z2fdtoQ==
X-Received: by 10.157.28.141 with SMTP id l13mr2901022ota.174.1515194069456;
        Fri, 05 Jan 2018 15:14:29 -0800 (PST)
Received: from xps15.usacommunications.tv (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.googlemail.com with ESMTPSA id p24sm2824627oie.54.2018.01.05.15.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 15:14:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4/7] mips: remove arch specific early_init_dt_alloc_memory_arch
Date:   Fri,  5 Jan 2018 17:14:21 -0600
Message-Id: <20180105231424.19247-5-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180105231424.19247-1-robh@kernel.org>
References: <20180105231424.19247-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

Now that the DT core code handles bootmem arches, we can remove the MIPS
specific early_init_dt_alloc_memory_arch function.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is dependent on patch 1. Please ack and I'll take or apply after   
4.16-rc1.

 arch/mips/kernel/prom.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 0dbcd152a1a9..89950b7bf536 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -44,11 +44,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	return add_memory_region(base, size, BOOT_MEM_RAM);
 }
 
-void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
-{
-	return __alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS));
-}
-
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
-- 
2.14.1
