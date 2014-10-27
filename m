Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 22:39:09 +0100 (CET)
Received: from mail-yh0-f73.google.com ([209.85.213.73]:39397 "EHLO
        mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011467AbaJ0VifEIomh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 22:38:35 +0100
Received: by mail-yh0-f73.google.com with SMTP id f10so317294yha.4
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 14:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5iSMPslfXjDOufBJOIcSWKGXSx1gucOBaCJgFEKtvuE=;
        b=X8+b3t4kVGhbTFiEzXzTahC+FUxT0QUIGxfg41A5iRpoHlG7X2lk3pJkw/Yv7XeUiT
         OSJCBrClZSh5FGbEzgs6c2dtvq0xV3swqxr4OYijBSNlXzfAO5cK0cK6vQnrkuesVmVF
         Yb6CFdGLeKmEgPwV/oR30V3FdwFK3OsYIuckyveOLv0yvWEGEoVdrmevkHszUi+Skrkb
         QqgENaZvh4/McWF8LL8gsN1PWWuTEhuj0jznU7OgtNmK1Ki2um9gsDeP5asE+Z/3SRR9
         gc4Au+lI6L8dw9FEUWaBDOr9NDNuE8Opw5M3F1ralGb98wktkRnRtgY4pFzZCE4MioGy
         ad6w==
X-Gm-Message-State: ALoCoQmrIQyEeqrrt9ZrJOt8QjMzcRiUtXqqWMnkbrxuptnQ19tCbGWlEy/EU1VdS6Z7B28U30tH
X-Received: by 10.236.45.65 with SMTP id o41mr22533193yhb.48.1414445908839;
        Mon, 27 Oct 2014 14:38:28 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l45si700602yha.2.2014.10.27.14.38.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 14:38:28 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id NEqhRwVP.1; Mon, 27 Oct 2014 14:38:28 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 1EBA7220B9D; Mon, 27 Oct 2014 14:38:28 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 3/3] irqchip: mips-gic: Use __raw_{readl,writel} for GIC registers
Date:   Mon, 27 Oct 2014 14:38:24 -0700
Message-Id: <1414445904-4781-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
References: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

No byte swapping is necessary for accessing the GIC registers.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/irqchip/irq-mips-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 61ac482..7ec3c18 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -37,12 +37,12 @@ static void __gic_irq_dispatch(void);
 
 static inline unsigned int gic_read(unsigned int reg)
 {
-	return readl(gic_base + reg);
+	return __raw_readl(gic_base + reg);
 }
 
 static inline void gic_write(unsigned int reg, unsigned int val)
 {
-	writel(val, gic_base + reg);
+	__raw_writel(val, gic_base + reg);
 }
 
 static inline void gic_update_bits(unsigned int reg, unsigned int mask,
-- 
2.1.0.rc2.206.gedb03e5
