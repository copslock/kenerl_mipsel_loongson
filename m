Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jan 2018 00:21:37 +0100 (CET)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39982 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993124AbeAEXVHpRwmF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jan 2018 00:21:07 +0100
Received: by mail-ot0-f195.google.com with SMTP id d10so5168271oti.7;
        Fri, 05 Jan 2018 15:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LBnnqjf+JYcv7Hs2WO4+gZN9BgoZl7bR2TdhCTKnpE=;
        b=L/3u6PS+/1MrV0Xe903LZ9MVLjwOdg91cPuXzMKe6BBy50/GhQv5XtKmObHhZYMMkb
         1+LBwoRPQiJKZzms/V/DMwzLxK1KYTw4JMkylpMiwcgED1eBxO+a2x7Ixixjy1eNKk4m
         xQz+lQ95/vNJd42JDfnD2mzahZ/7mjPakjphzem8fZyyf5cB5N1bmy3A1LUMcsHtdePT
         d+uM+g3/HaW0b578wHb7at8DWD+ZZCuCcNIsQFPKJWiStXFxMEMEnuWg59zkPf5i9wc7
         4qUZGM0gvd4vberHHSN7Kz5QLnQgMjf5YUYdlNUPQb0QIjXp1yMMl8eKPKnaqvcWjD4m
         mScA==
X-Gm-Message-State: AKwxytcfLtG6SmGEwnSxLWrGkyTj/Bgg2jPdQdGzmw3GTaYjP/rSlgp5
        DCkZqVlW7Vnds3oet/IhCv20D4I=
X-Google-Smtp-Source: ACJfBoub2oYONhmcISfKvWCa8i6o+RN/ogsIyNMs6zhj3EJOVUywZAWCLdAHI8huvcYcHDT0wOIMNA==
X-Received: by 10.157.21.48 with SMTP id u45mr2212472otf.382.1515194461923;
        Fri, 05 Jan 2018 15:21:01 -0800 (PST)
Received: from xps15.usacommunications.tv (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.googlemail.com with ESMTPSA id u1sm1969998otc.3.2018.01.05.15.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 15:21:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4/7] mips: remove arch specific early_init_dt_alloc_memory_arch
Date:   Fri,  5 Jan 2018 17:20:51 -0600
Message-Id: <20180105232054.27394-5-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180105232054.27394-1-robh@kernel.org>
References: <20180105232054.27394-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61945
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
