Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 23:48:32 +0200 (CEST)
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44392 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993098AbeFSVrYzzMer (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 23:47:24 +0200
Received: by mail-yw0-f196.google.com with SMTP id k18-v6so440373ywm.11;
        Tue, 19 Jun 2018 14:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RXql62/dQvZpkpAbxhcxM+PugjdkCOIwRwB4Nmmg1k=;
        b=kHbeoXUPy5CIZHNW7LwPNMnrJsjwAkpdWIKa+VpM7noOJAofxrGYTnRrk2rb7+We+q
         wWqEVBIxjAPukMxgs87xZKOW6uF9Vk2m9AoO1LADS53eVMeWzLaBP2vk2tEW5H0Ah+ox
         HQvIThekP5J5yBSpoyD/gdzuUhu8TRVnRF0VMiY+epZmba0VJDx4c4TXP4TA/xYBHR2r
         8+Zamd7Z8GIOpWFVLWg2IH3x5K6BB5i4QfsYSCiA4CKF6jf9KpsxB9hBT8ac2/s8xZOt
         EHXxfqZN13un0IX4Hkips+GQmh0Sw5TZb4aBz6oz6Jewsxc4zT7JZRslc88a+BOO3z4M
         JD5w==
X-Gm-Message-State: APt69E2nPd8Dj7Ma1ndYwHJrnYjSz5UhJiWBpAQmzGZ2Hl3C1HdKndQ8
        iU4nJQw7TREp+s8fe41Poby/o1w=
X-Google-Smtp-Source: ADUXVKJZiJ6h2fYXypqCdEj79PpwEojYfikwuP4+wenuiCzgT5xRq77x3ANdUD+ZlWapubFLbvPiTw==
X-Received: by 2002:a81:ad44:: with SMTP id l4-v6mr9285131ywk.68.1529444838893;
        Tue, 19 Jun 2018 14:47:18 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 4/5] MIPS: generic: remove unnecessary of_platform_populate call
Date:   Tue, 19 Jun 2018 15:47:09 -0600
Message-Id: <20180619214710.22066-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64384
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

The DT core will call of_platform_populate, so it is not necessary for
arch specific code to call it unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/generic/init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 5ba6fcc26fa7..07ec08462d70 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #include <asm/bootinfo.h>
 #include <asm/fw/fw.h>
@@ -208,18 +207,6 @@ void __init arch_init_irq(void)
 	irqchip_init();
 }
 
-static int __init publish_devices(void)
-{
-	if (!of_have_populated_dt())
-		panic("Device-tree not present");
-
-	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
-		panic("Failed to populate DT");
-
-	return 0;
-}
-arch_initcall(publish_devices);
-
 void __init prom_free_prom_memory(void)
 {
 }
-- 
2.17.1
