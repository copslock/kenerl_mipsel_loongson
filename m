Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 23:48:50 +0200 (CEST)
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42118 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994560AbeFSVr0mGADr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 23:47:26 +0200
Received: by mail-yw0-f196.google.com with SMTP id t184-v6so443772ywg.9;
        Tue, 19 Jun 2018 14:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1Ng6EJXxwLUZYoApWutVMxtEjDppkRB8dUa9ssSHew=;
        b=qz+hJoUghodDwZkCSYpbnXr4lT1cwW9elQkxAqVLUsm69T/5T+yqympDsu2LxenrtG
         V3SQcR2CoTjWTW6JP1r4V/kYoEHi4OketdXbWRmv1Jt2aJicQso+N9XoDMmqhlGVe14k
         76fQH+JTYNqzql9NRrmD4KPtf1tkwvXTNzPKDsbiV7ndlaKdmkS0kW6wi+d/koy4GReV
         3m2RLHBfEGvK4MhG06PXA9P7ge1dRbu3SgDApOc0X4kEBNujpxypDbdX0l7vInsenOxu
         bxoXt3tedncKcb8VupDoOTPDZvQv+aKPMkksrAWEz9diuSLRw/OQfukmT4W03UrUtMgI
         42aw==
X-Gm-Message-State: APt69E0XDy8nCEOecRuc3ynt5dqgPuJeEKaiWggTCvrhmi6kpMarygaX
        KJsxM0kW208Fv07pC4xZ2wvJ+CE=
X-Google-Smtp-Source: ADUXVKIbzIEOSqM3qo0OkHJcwHsQLszyG0v2gtaxnWQRGraiX54Z7ZCVBdVyIkn44hTS6liLyhuTqw==
X-Received: by 2002:a81:6541:: with SMTP id z62-v6mr8755428ywb.160.1529444840548;
        Tue, 19 Jun 2018 14:47:20 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 5/5] MIPS: lantiq: remove unnecessary of_platform_default_populate call
Date:   Tue, 19 Jun 2018 15:47:10 -0600
Message-Id: <20180619214710.22066-6-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64385
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

The DT core will call of_platform_default_populate, so it is not necessary
for arch specific code to call it unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/lantiq/prom.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 9ff7ccde9de0..d984bd5c2ec5 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -9,7 +9,6 @@
 #include <linux/export.h>
 #include <linux/clk.h>
 #include <linux/bootmem.h>
-#include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
@@ -114,10 +113,3 @@ void __init prom_init(void)
 		panic("failed to register_vsmp_smp_ops()");
 #endif
 }
-
-int __init plat_of_setup(void)
-{
-	return of_platform_default_populate(NULL, NULL, NULL);
-}
-
-arch_initcall(plat_of_setup);
-- 
2.17.1
