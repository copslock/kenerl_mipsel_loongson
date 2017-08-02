Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 17:04:23 +0200 (CEST)
Received: from mail-wr0-x22e.google.com ([IPv6:2a00:1450:400c:c0c::22e]:38668
        "EHLO mail-wr0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994844AbdHBPEPdF6Fk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 17:04:15 +0200
Received: by mail-wr0-x22e.google.com with SMTP id f21so19793819wrf.5
        for <linux-mips@linux-mips.org>; Wed, 02 Aug 2017 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=OTu6tAhZ//K53X7pX28BtQhjr3Yo6R1L53zEwqOpvWM=;
        b=jAyKjpQ4QecJ/nZKJyEDnEF5aOuP1gxE3jLMWXz14BpxgpkgBiVpvrMFGNR9jpN1si
         5eaCqrjcDzraZfcITgG9QrtUwo2wrEZ11xVTKjvHCLFzq24LI2Btj8xvLDU8bqHavwLr
         xKluFvUDZKeUw0Xt2dL5R2oksXyykvcurTQdYGCOu2L04KFvXaNCJ7P0kspYUqnPWFt/
         2j4ZCQUXIWfBKej7ObV28kWf/iz4gS2qdmQtqtCSCnIpOnHJPVbsfzPIRzwZMzXejvgz
         sQBye7V1ik7eT220PCHh9lFq1i15U6vfD9fomt1JGtboi+4X8gvBZWHG3bxUJu6sjHS3
         zVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OTu6tAhZ//K53X7pX28BtQhjr3Yo6R1L53zEwqOpvWM=;
        b=AeJ4G862fZwV6f+C1HDegmjoYALc1oKHg5zy59R5ENLEc0blKPrZVcpskZ/wbZXWTP
         x5UZ2YQOwnoVXFOGhcDbKEO70W814+NOukPHAjRXa79sjZ7XFqJeHt2DeZpGL1R3d3g4
         GK4SPNDflJgLOLlX9/vC3omzZYzUhgv9wbgzi/VApuiY3ohS+B82iw2SLSsCJ0+7Zq0N
         Ipsm7jJ6m0QwWcaRSWmzwSif69C9BegYsn6aU11PTCPuAhxpwh/KCJKXswRK67vPyBqZ
         jtAQiooRqXBhZ4Brd66Xu8dfFRN/ATkCXUTuhOQcoyNmDKZVP1pVijid7m7dbwKfH2ci
         Ut0A==
X-Gm-Message-State: AIVw111yUmjRuvr7z5tMWBLv6XPJXYzLomEQUEkUj3zn53pDvyfubBiy
        FXKccjC7f76I+9lN
X-Received: by 10.223.171.9 with SMTP id q9mr16569308wrc.95.1501686250123;
        Wed, 02 Aug 2017 08:04:10 -0700 (PDT)
Received: from localhost.localdomain ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m78sm3976012wmc.16.2017.08.02.08.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 08:04:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] mips: gitignore: ignore generated .c files
Date:   Wed,  2 Aug 2017 17:04:04 +0200
Message-Id: <20170802150404.10579-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.13.2
Return-Path: <brgl@bgdev.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brgl@bgdev.pl
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

Add ashldi3.c and bswapsi.c to the list of ignored files.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/mips/boot/compressed/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/mips/boot/compressed/.gitignore

diff --git a/arch/mips/boot/compressed/.gitignore b/arch/mips/boot/compressed/.gitignore
new file mode 100644
index 000000000000..ebae133f1d00
--- /dev/null
+++ b/arch/mips/boot/compressed/.gitignore
@@ -0,0 +1,2 @@
+ashldi3.c
+bswapsi.c
-- 
2.13.2
